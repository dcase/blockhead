class CreatePartials < ActiveRecord::Migration
  def self.up
    create_table :partials do |t|
      t.string :name
      t.string :controller
      t.string :locals_hash

      t.timestamps
    end
  end

  def self.down
    drop_table :partials
  end
end
