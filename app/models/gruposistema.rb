class Gruposistema < ActiveRecord::Base
  belongs_to :grupo
  belongs_to :sistema

  validates_presence_of :grupo_id
  validates_presence_of :sistema_id
end

