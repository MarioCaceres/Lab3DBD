class Rol < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :login

    def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_hash).where(["run = :value OR lower(email) = :value", { :value => login.downcase }]).first
      elsif conditions.has_key?(:run) || conditions.has_key?(:email)
        where(conditions.to_hash).first
      end
    end

    def self.crearPaciente
      sql = "SELECT insertar_paciente(1234,'Cerrillos','1997-1-8',21,'Caliche',3,5,'caca@cac2.cl','fonasa',1,'trasero','desimio','condistemper',3)"
      resultado = connection.execute(sql)
    end

    def self.citas_por_rut(rut_p)

       rut_p = Integer(rut_p) 

       sql = "SELECT perM.nombre_Persona AS nombre_med,perM.apellidop_Persona AS apell_med, b.hora_inicio_bloque AS hora,"+
          " a.fecha_agenda AS fecha,  cen.nombre_centro as centro , cen.direccion_centro AS calle, cen.numero_centro AS num, "+
          "c.box_atencion_cita AS box "+
          "FROM medico m, agenda a, bloque b, cita c, paciente p, centro_de_salud cen, persona perP, persona perM "+
          "WHERE  perP.id_persona = p.id_persona AND perM.id_persona = m.id_persona "+
          "AND a.id_Persona = m.id_Persona AND a.id_Agenda = b.id_Agenda AND "+
          "b.id_Bloque = c.id_Bloque AND c.id_Persona = p.id_Persona AND cen.id_Centrosalud = a.id_Centrosalud "+
          "AND perP.run_Persona = #{rut_p} "+
          "ORDER BY fecha"
  
      resultado = ActiveRecord::Base.connection.execute(sql)
      return resultado
    end

=begin
def self.registrar_paciente(rut_p,comuna,fecha_nac,sexo,direccion_p,num_casa,email,prevision,id_rol,nombre_p,apellidop_p,apellidom_p,dig_ver)

       rut_p = Integer(rut_p) 

       my_name    = ActiveRecord::Base.connection.quote(direccion_p)
       direccion_p = direccion_p.to_s()
       
       sexo = Integer(sexo)
       num_casa = Integer(num_casa)
       id_rol = Integer(id_rol)
       dig_ver = Integer(dig_ver)
       #comuna = Integer(comuna)

       sql = "SELECT insertar_paciente3(#{rut_p},#{comuna},'#{fecha_nac}',#{sexo},#{my_name},"+
       "#{num_casa},0,'#{email}','#{prevision}',#{id_rol},'#{nombre_p}','#{apellidop_p}','#{apellidom_p}',#{dig_ver})"
  
      resultado = ActiveRecord::Base.connection.exec_query(sql)
      return resultado
    end
=end

def self.registrar_paciente(rut_p,comuna,fecha_nac,sexo,direccion_p,num_casa,email,prevision,id_rol,nombre_p,apellidop_p,apellidom_p,dig_ver)
=begin
       rut_p = Integer(rut_p) 
       direccion_p = direccion_p
       
       sexo = Integer(sexo)
       num_casa = Integer(num_casa)
       id_rol = Integer(id_rol)
       dig_ver = Integer(dig_ver)
=end

       sql = "SELECT insertar_paciente2('#{rut_p}','#{comuna}','#{fecha_nac}',#{sexo},'#{direccion_p}',
       '#{num_casa}',0,'#{email}','#{prevision}',1,'#{nombre_p}','#{apellidop_p}','#{apellidom_p}','#{dig_ver}')"
=begin
       sqlPersona = "INSERT INTO persona (id_rol, nombre_persona, apellidop_persona, apellidom_persona, run_persona, codigo_persona)
       VALUES ('#{id_rol}','#{nombre_p}','#{apellidop_p}','#{apellidom_p}','#{rut_p}','#{dig_ver}')"

       sqlPaciente = "INSERT INTO paciente (id_persona, id_comuna,fecha_nacimiento_paciente,
       sexo_paciente,direccion_paciente,numero_paciente,email_paciente, prevision_paciente)
       VALUES ((SELECT id_persona FROM persona WHERE run_persona = '#{rut_p}'), 
       (SELECT id_comuna FROM comuna WHERE id_comuna = '#{comuna}'),'#{fecha_nac}', '#{sexo}',
       '#{direccion_p}',)"
=end
      resultado = ActiveRecord::Base.connection.exec_query(sql)
      
    end

end
