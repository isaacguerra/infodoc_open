class Comentario < ActiveRecord::Base
  belongs_to :entidade
  belongs_to :usuario
  belongs_to :comentavel, :polymorphic=>true
  validates_presence_of :conteudo
end

