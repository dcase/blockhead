class RemoveLocalsHashFromPartials < ActiveRecord::Migration
  def self.up
    remove_column :partials, :locals_hash
  end

  def self.down
    add_column :partials, :locals_hash, :string
  end
end
