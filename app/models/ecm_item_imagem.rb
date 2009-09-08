class EcmItemImagem < ActiveRecord::Base
  belongs_to :cadastro

  validates_presence_of :entidade_id
  validates_presence_of :formulariocategoria_id
  validates_presence_of :formulario_id
  validates_presence_of :itensformulario_id
  validates_presence_of :cadastro_id

  has_attached_file :imagem

  #scopos----------
  named_scope :do_formulario, lambda {|id| {:conditions=>["formulario_id = ?", id]}}
  named_scope :do_cadastro, lambda {|id| {:conditions=>["cadastro_id = ?", id]}}
  named_scope :do_itens_formulario, lambda {|id| {:conditions=>["itensformulario_id = ?", id]}}
  #-------------
end

