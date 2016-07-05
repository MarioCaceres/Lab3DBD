class AddColumnsToRols < ActiveRecord::Migration
  def changee
    add_column :rols, :run, :integer
    add_column :rols, :run_dig_ver, :integer
    add_column :rols, :nombre, :string
    add_column :rols, :apellidop, :string
    add_column :rols, :apellidom, :string
  end
end
