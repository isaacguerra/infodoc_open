class Auditoriasuporte < ActiveRecord::Base
  named_scope :auditado, :conditions=>{:auditado=>true}
  named_scope :da_entidade, lambda {|id| {:conditions=>["entidade_id = ?", id]}}
  named_scope :do_usuario, lambda {|id| {:conditions=>["usuario_id = ?", id]}}
end

