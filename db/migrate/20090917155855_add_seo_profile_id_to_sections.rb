class AddSeoProfileIdToSections < ActiveRecord::Migration
  def self.up
    add_column :sections, :seo_profile_id, :integer
  end

  def self.down
    remove_column :sections, :seo_profile_id
  end
end
