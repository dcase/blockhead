class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :title
      t.datetime :publish_on
      t.text :body
      t.integer :blog_id
      t.string :author

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
