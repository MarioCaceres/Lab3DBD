class AddColumns2ToRols < ActiveRecord::Migration
  def change
  	
    add_column :rols, :fecha_nacimiento, :datetime
    add_column :rols, :nombre_rol, :string
  end
end
