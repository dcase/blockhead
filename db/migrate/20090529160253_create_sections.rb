class CreateSections < ActiveRecord::Migration
  def self.up
    create_table :sections do |t|
      t.string :short_name
      t.string :long_name
      t.integer :position
      t.integer :parent_id
      t.boolean :published

      t.timestamps
    end
  end

  def self.down
    drop_table :sections
  end
end
