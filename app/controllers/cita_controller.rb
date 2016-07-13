class CitaController < ApplicationController
	before_filter :authenticate_rol!
  def ver_citas
  	@citas = Rol.citas_por_rut(current_rol.run)

  	#@registrar_culiao= Rol.registrar_paciente("11223344",'Cerrillos','1961-06-16',"1","calle_Falsa",'666',"fake_mail@usach.cl","banmedica","4","nombre_falso","apellidop_p","apellidom_p","5")
    
  end
end
