class CreateSeoProfiles < ActiveRecord::Migration
  def self.up
    create_table :seo_profiles do |t|
      t.string :name
      t.string :title
      t.text :keywords
      t.text :description
      t.string :h1
      t.string :h2

      t.timestamps
    end
  end

  def self.down
    drop_table :seo_profiles
  end
end
