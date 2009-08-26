class CreateQuotes < ActiveRecord::Migration
  def self.up
    create_table :quotes do |t|
      t.string :title
      t.text :output
      t.string :attributed_to
      t.integer :quote_list_id
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :quotes
  end
end
