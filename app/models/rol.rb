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
end
