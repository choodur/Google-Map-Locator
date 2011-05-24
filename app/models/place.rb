class Place < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  
  before_create :set_status
  
  def set_status
    self.status = 'approved'
  end
end
