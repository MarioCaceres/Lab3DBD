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

	def self.borrar_cita(id)
		sql = "DELETE FROM cita c WHERE c.id_cita = #{id}"
		resultado = connection.execute(sql)
	end

	def self.citas_disponibles_especialidad(id_centro,id_especialidad)

    sql="select P.nombre_persona,P.apellidop_persona,P.apellidom_persona,A.fecha_agenda,BL.hora_inicio_bloque,BL.hora_fin_bloque,
		C.nombre_centro,ESP.nombre_especialidad from persona P inner join agenda A on P.id_persona = A.id_persona inner join
		centro_de_salud C on C.id_centrosalud =A.id_centrosalud inner join especialidades_medico E on P.id_persona = E.id_persona inner join
		especialidad ESP on ESP.id_especialidad = E.id_especialidad inner join bloque BL on A.id_agenda = BL.id_agenda where
		BL.id_bloque not in (select id_bloque from cita) and A.id_centrosalud=#{id_centro} and ESP.id_especialidad =#{id_especialidad}
		ORDER BY fecha_agenda DESC"
		resultado = connection.execute(sql)
		return resultado
     end

   def self.citas_disponibles_medico(id_centro,id_personaM)

    sql="select P.nombre_persona,P.apellidop_persona,P.apellidom_persona,A.fecha_agenda,BL.hora_inicio_bloque,BL.hora_fin_bloque,
      C.nombre_centro,ESP.nombre_especialidad from persona P inner join agenda A on P.id_persona = A.id_persona inner join
      centro_de_salud C on C.id_centrosalud =A.id_centrosalud inner join especialidades_medico E on P.id_persona = E.id_persona inner join
      especialidad ESP on ESP.id_especialidad = E.id_especialidad inner join bloque BL on A.id_agenda = BL.id_agenda where
      BL.id_bloque not in (select id_bloque from cita) and A.id_centrosalud=#{id_centro} and P.id_persona=#{id_personaM}
      ORDER BY fecha_agenda DESC"
      resultado = connection.execute(sql)
      return resultado

     end
	
end
