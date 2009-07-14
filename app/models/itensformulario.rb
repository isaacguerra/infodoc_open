class Itensformulario < ActiveRecord::Base
  belongs_to :itenstipo
  belongs_to :formulario

  serialize :opcoes

  validates_presence_of :entidade_id
  validates_presence_of :formulario_id
  #validates_presence_of :itenstipo_id
  #validates_presence_of :rotulo
  #validates_presence_of :posicao
  #validates_presence_of :tipo
  #validates_presence_of :componente
  #validates_presence_of :opcoes

  #scopos----------
  named_scope :da_entidade, lambda {|id| {:conditions=>["entidade_id = ?", id]}}
  named_scope :do_formulario, lambda {|id| {:conditions=>["formulario_id = ?", id]}}
  named_scope :do_itenstipo, lambda {|id| {:conditions=>["itenstipo_id = ?", id]}}
  named_scope :do_tipo, lambda {|id| {:conditions=>["tipo = ?", id]}}
  #-------------

  after_create :apos_criar

  def apos_criar
    if self.formulario.cadastros.size > 0
      self.formulario.cadastros.each do |cadastro|
        if self.itenstipo.tipo == "texto"
          cadastro_item = EcmItemTexto.new
          if self.opcoes[:default]
            cadastro_item.conteudo = self.opcoes[:default]
          else
            cadastro_item.conteudo = "--"
          end
        elsif self.itenstipo.tipo == "texto_longo"
          cadastro_item = EcmItemTextoLongo.new
          if self.opcoes[:default]
            cadastro_item.conteudo = self.opcoes[:default]
          else
            cadastro_item.conteudo = "--"
          end
        elsif self.itenstipo.tipo == "numero_inteiro"
          cadastro_item = EcmItemNumeroInteiro.new
          if self.opcoes[:default]
            cadastro_item.conteudo = self.opcoes[:default]
          else
            cadastro_item.conteudo = 0
          end
        elsif self.itenstipo.tipo == "numero_decimal"
          cadastro_item = EcmItemNumeroDecimal.new
          if self.opcoes[:default]
            cadastro_item.conteudo = self.opcoes[:default]
          else
            cadastro_item.conteudo = 0
          end
        elsif self.itenstipo.tipo == "data"
          cadastro_item = EcmItemData.new
          if self.opcoes[:default]
            cadastro_item.conteudo = self.opcoes[:default]
          else
            cadastro_item.conteudo = Date.now
          end
        elsif self.itenstipo.tipo == "data_hora"
          cadastro_item = EcmItemDataHora.new
          if self.opcoes[:default]
            cadastro_item.conteudo = self.opcoes[:default]
          else
            cadastro_item.conteudo = DateTime.now
          end
        elsif self.itenstipo.tipo == "imagem"
          cadastro_item = EcmItemImagem.new
          if self.opcoes[:default]
            cadastro_item.conteudo = self.opcoes[:default]
          else
            cadastro_item.conteudo = "--"
          end
        elsif self.itenstipo.tipo == "referencia"
          cadastro_item = EcmItemReferencia.new
          if self.opcoes[:default]
            cadastro_item.referencia_id = self.opcoes[:default]
          else
            cadastro_item.referencia_id = Ecm::Cadastro.find(:first, :conditions=>["formulario_id = ?", self.formulario_refencia_id]).id
          end
        end
        cadastro_item.entidade_id = cadastro.entidade_id
        cadastro_item.formulariocategoria_id = cadastro.formulario.formulariocategoria_id
        cadastro_item.formulario_id = cadastro.formulario_id
        cadastro_item.itensformulario_id = self.id
        cadastro_item.cadastro_id = cadastro.id
        cadastro_item.save!
      end
    end
  end

  def antes_de_remover
    if self.formulario.cadastros.size > 0
    end
  end
end

