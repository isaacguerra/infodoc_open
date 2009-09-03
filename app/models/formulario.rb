class Formulario < ActiveRecord::Base
  belongs_to :formulariocategoria
  belongs_to :formulariotipo
  belongs_to :entidade
  has_many :cadastros
  has_many :itensformularios
  has_many :ajudas, :as=>:ajudavel


  validates_presence_of :formulariocategoria_id
  validates_presence_of :formulariotipo_id
  validates_presence_of :entidade_id
  validates_presence_of :titulo
  validates_presence_of :descricao

  #scopos----------
  named_scope :ativo, :conditions=>["status = ? and principal_id is not null", true]
  named_scope :da_entidade, lambda {|id| {:conditions=>["entidade_id = ?", id]}}
  named_scope :da_categoria, lambda {|id| {:conditions=>["formulariocategoria_id = ?", id]}}
  named_scope :do_tipo, lambda {|id| {:conditions=>["formulariotipo_id = ?", id]}}
  #-------------

  def funcional
    if self.status == true and self.principal_id
      return true
    else
      return false
    end
  end

  def permissao(usuario)
    p = Grupoformulario.maximum("permissao", :conditions=>["formulario_id = ? and grupo_id in (?)", self.id, usuario.grupos])
    if p
      return p
    else
      return 0
    end
  end

end

