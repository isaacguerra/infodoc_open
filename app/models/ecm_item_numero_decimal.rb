class EcmItemNumeroDecimal < ActiveRecord::Base
  belongs_to :cadastro

  validates_presence_of :entidade_id
  validates_presence_of :formulariocategoria_id
  validates_presence_of :formulario_id
  validates_presence_of :itensformulario_id
  validates_presence_of :cadastro_id
  validates_presence_of :conteudo
end

