class Artefato < ActiveRecord::Base
  belongs_to :entidade
  belongs_to :cadastro

  #file_column :objeto_file_name, :store_dir => "uploadartefatos/"
  has_attached_file :objeto, :path => ":rails_root/uploadartefatos/system/:class/:attachment/:id/:style/:basename.:extension"

  validates_presence_of :cadastro_id
  validates_presence_of :entidade_id
end

