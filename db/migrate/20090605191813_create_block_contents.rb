class CreateBlockContents < ActiveRecord::Migration
  def self.up
    create_table :block_contents do |t|
      t.integer :block_id
      t.integer :content_id

      t.timestamps
    end
  end

  def self.down
    drop_table :block_contents
  end
end
