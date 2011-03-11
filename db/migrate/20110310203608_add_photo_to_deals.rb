class AddPhotoToDeals < ActiveRecord::Migration
  def self.up
    add_column :deals, :photo, :string
    add_column :deals, :dealtype, :string
  end

  def self.down
    remove_column :deals, :photo
    remove_column :deals, :dealtype
  end
end
