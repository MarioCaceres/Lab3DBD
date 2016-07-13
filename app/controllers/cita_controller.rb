class CitaController < ApplicationController

	before_filter :authenticate_rol!

  	def ver_citas

  		@citas = Rol.citas_por_rut(14970293)

  		@centros = Database.obtener_centros()
  		@especialidades = Database.obtener_especialidades()
  		@medicos = Database.obtener_medicos()

  		@registrar_culiao= Rol.registrar_paciente(current_rol.run,current_rol.comuna,'1961-06-16',current_rol.sexo,current_rol.direccion,current_rol.num,current_rol.email,current_rol.prevision,1,current_rol.nombre,current_rol.apellidop,current_rol.apellidom,current_rol.run_dig_ver)

  	end

  	def borrarCita
  		id = params[:id]
  		@borrarcita = Database.borrar_cita(id)
  		redirect_to '/ver_citas'
  	end

end
