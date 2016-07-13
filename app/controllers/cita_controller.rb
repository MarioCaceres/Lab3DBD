class CitaController < ApplicationController

	before_filter :authenticate_rol!

  	def ver_citas

  		@citas = Rol.citas_por_rut(current_rol.run)

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

    def agendar
      @agendar = Database.agendar_hora(current_rol.run,params[:hora],params[:fecha],params[:rut_m])
      #@agendar Database.agendar_cita(params[:rut],params[:box],params[:hora_inicio],params[:fecha],params[:rutMedico])
      redirect_to '/ver_citas'
    end

    def create
    	id_centro = params[:cita][:centro]
    	if params[:commit] == "Buscar Horas Especialidad"
    		id_especialidad = params[:cita][:especialidad]
    		redirect_to :controller => 'cita', :action => 'tomar_cita_esp', :idc => id_centro, :id_esp => id_especialidad

    	else
    		id_especialista = params[:cita][:especialista]
    		redirect_to :controller => 'cita', :action => 'tomar_cita_med', :idc => id_centro, :id_med => id_especialista
    	end
    end

    def tomar_cita_esp
    	id_centro = params[:idc]
    	id_especialidad = params[:id_esp]
    	@citas2 = Database.citas_disponibles_especialidad(id_centro,id_especialidad)
    	#idcentro = params[:centro]
    	#puts idcentro.to_s()
      #@disponibles = Database.citas_por_esp(id_centro,especialidad)
    end
    def tomar_cita_med
    	id_centro = params[:idc]
    	id_especialista = params[:id_med]
    	@citas3 = Database.citas_disponibles_medico(id_centro,id_especialista)
      #@disponibles = Database.citas_por_med(id_ventro,id_medico)
    end

end
