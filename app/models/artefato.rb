class Artefato < ActiveRecord::Base
  belongs_to :entidade
  belongs_to :cadastro

  file_column :objeto_file_name, :store_dir => "uploadartefatos/"

  validates_presence_of :cadastro_id
  validates_presence_of :entidade_id
end

