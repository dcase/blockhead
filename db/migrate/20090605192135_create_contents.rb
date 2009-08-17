class CreateContents < ActiveRecord::Migration
  def self.up
    create_table :contents do |t|
      t.integer :contentable_id
      t.string :contentable_type

      t.timestamps
    end
  end

  def self.down
    drop_table :contents
  end
end
