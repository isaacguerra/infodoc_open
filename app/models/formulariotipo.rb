class Formulariotipo < ActiveRecord::Base
  validates_presence_of :tipo
  #validates_presence_of :status

  named_scope :ativo, :conditions=>{:status=>true}
end

