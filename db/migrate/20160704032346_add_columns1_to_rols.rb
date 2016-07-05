class AddColumns1ToRols < ActiveRecord::Migration
  def change
  	
    add_column :rols, :fecha_nacimiento, :datetime
  end
end
