class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :short_name
      t.string :long_name
      t.integer :section_id
      t.integer :position
      t.boolean :published

      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
