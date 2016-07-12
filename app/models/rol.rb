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

end
