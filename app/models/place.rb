class Place < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  validates :latitude, :presence => true, :numericality => true
  validates :longitude, :presence => true, :numericality => true
  
  #before_create :set_status
  
  scope :approved, where(["status = ?", 'approved'])
  scope :suggested, where(["status = ?", 'suggested'])
  
  #def set_status
  # self.status = admin_signed_in? ? 'approved' : 'suggested'
  #end
end
