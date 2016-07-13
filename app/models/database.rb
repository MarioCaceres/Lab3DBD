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
		sql = "SELECT * FROM medico"
		resultado = connection.execute(sql)
		return resultado
	end

end
