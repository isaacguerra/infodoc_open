class Moduloentidade < ActiveRecord::Base
  belongs_to :entidade
  belongs_to :modulo

  validates_presence_of :entidade_id
  validates_presence_of :modulo_id
end

