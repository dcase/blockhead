class AddSeoProfileIdToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :seo_profile_id, :integer
  end

  def self.down
    remove_column :pages, :seo_profile_id
  end
end
