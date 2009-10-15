class Paginaentidade < ActiveRecord::Base
  belongs_to :entidade
  belongs_to :usuario
  validates_presence_of :entidade_id
end

