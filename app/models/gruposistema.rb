class Gruposistema < CouchFoo::Base
  belongs_to :grupo
  belongs_to :sistema

  property :grupo_id, String
  property :sistema_id, String
  property :permissao, Integer
end

