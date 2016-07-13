class Database < ActiveRecord::Base
	
	def self.obtener_centros()
		sql = "SELECT * FROM centro_de_salud"
		resultado = connection.execute(sql)
		return resultado
	end

	def self.obtener_especialidades()
		sql = "SELECT * FROM especialidad"
		resultado = connection.execute(sql)
		return resultado
	end

	def self.obtener_medicos()
		sql = "SELECT p.id_persona, p.nombre_persona, p.apellidop_persona, p.apellidom_persona FROM medico m, persona p WHERE m.id_persona = p.id_persona"
		resultado = connection.execute(sql)
		return resultado
	end

	def self.obtener_comunas()
		sql = "SELECT * FROM comuna"
		resultado = connection.execute(sql)
		return resultado
	end
	
end
