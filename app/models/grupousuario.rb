class Grupousuario < CouchFoo::Base
  belongs_to :grupo
  belongs_to :usuario

  property :grupo_id, String
  property :usuario_id, String
end

