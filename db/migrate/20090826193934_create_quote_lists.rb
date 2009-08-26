class CreateQuoteLists < ActiveRecord::Migration
  def self.up
    create_table :quote_lists do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :quote_lists
  end
end
