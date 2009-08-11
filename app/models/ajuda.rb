class Ajuda < ActiveRecord::Base
  belongs_to :ajudavel, :polymorphic=>true
  validates_presence_of :conteudo
end

