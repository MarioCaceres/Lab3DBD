class CitaController < ApplicationController
	before_filter :authenticate_rol!
  def ver_citas
  	@citas = Rol.citas_por_rut(current_rol.run)
  end
end
