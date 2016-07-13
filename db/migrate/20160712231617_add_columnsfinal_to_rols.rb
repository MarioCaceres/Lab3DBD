class AddColumnsfinalToRols < ActiveRecord::Migration
  def change
    add_column :rols, :prevision, :string
    add_column :rols, :sexo, :integer
    add_column :rols, :direccion, :string
    add_column :rols, :num, :integer
    add_column :rols, :depto, :integer
    add_column :rols, :comuna, :integer
    add_column :rols, :telefono, :integer
 end
end
