class Wikipage < ActiveRecord::Base
  belongs_to :entidade
  belongs_to :wikicategoria
  has_many :wikihistoriapages
  has_many :comentarios, :as=>:comentavel

  validates_presence_of :entidade_id
  validates_presence_of :wikicategoria_id
  validates_presence_of :titulo
  validates_presence_of :conteudo

  #scopos----------
  named_scope :protegido, :conditions=>{:protegido=>true}
  named_scope :da_entidade, lambda {|id| {:conditions=>["entidade_id = ?", id]}}
  named_scope :da_categoria, lambda {|id| {:conditions=>["wikicategoria_id = ?", id]}}
  #-------------
end

