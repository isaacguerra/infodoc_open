class Moduloentidade < CouchFoo::Base
  belongs_to :entidade
  belongs_to :modulo

  property :entidade_id, String
  property :modulo_id, String

  validates_presence_of :entidade_id
  validates_presence_of :modulo_id
end

