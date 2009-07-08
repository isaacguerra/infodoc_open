class Grupousuario < ActiveRecord::Base
  belongs_to :grupo
  belongs_to :usuario

  validates_presence_of :grupo_id
  validates_presence_of :usuario_id
end

