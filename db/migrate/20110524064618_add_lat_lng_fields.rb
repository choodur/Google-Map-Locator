class AddLatLngFields < ActiveRecord::Migration
  def self.up
    add_column :places, :latitude, :float
    add_column :places, :longitude, :float
  end

  def self.down
    remove_column :places, :longitude
    remove_column :places, :latitutde
  end
end
