class Itenstipo < ActiveRecord::Base
  validates_presence_of :nome
  validates_presence_of :tipo
  validates_presence_of :componente
  #validates_presence_of :status

  named_scope :ativo, :conditions=>{:status=>true}
end

