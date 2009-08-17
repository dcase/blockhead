class CreateCopyTexts < ActiveRecord::Migration
  def self.up
    create_table :copy_texts do |t|
      t.text :output

      t.timestamps
    end
  end

  def self.down
    drop_table :copy_texts
  end
end
