class Formulario < ActiveRecord::Base
  belongs_to :formulariocategoria
  belongs_to :formulariotipo
  belongs_to :entidade
  has_many :cadastros
  has_many :itensformularios

  validates_presence_of :formulariocategoria_id
  validates_presence_of :formulariotipo_id
  validates_presence_of :entidade_id
  validates_presence_of :titulo
  validates_presence_of :descricao

  #scopos----------
  named_scope :ativo, :conditions=>{:status=>true}
  named_scope :da_entidade, lambda {|id| {:conditions=>["entidade_id = ?", id]}}
  named_scope :da_categoria, lambda {|id| {:conditions=>["formulariocategoria_id = ?", id]}}
  named_scope :do_tipo, lambda {|id| {:conditions=>["formulariotipo_id = ?", id]}}
  #-------------


end

