class UsuarioBlog < ActiveRecord::Base
  belongs_to :usuario
  validates_presence_of :entidade_id
  validates_presence_of :usuario_id
  validates_presence_of :seguido_id

  named_scope :da_entidade, lambda {|id| {:conditions=>["entidade_id = ?", id]}}
  named_scope :seguidores_de, lambda {|id| {:conditions=>["seguido_id = ?", id]}}

  def busca_menssagem(usuario_id)
    us = UsuarioBlog.find(:all, :conditions=>["usuario_id = ?", usuario_id]).collect {|ub| ub.seguido_id}
    menssagens = Blog.find(:all, :limit=>10, :order=>"id DESC", :conditions=>["usuario_id = ? and usuario_id in (?)", usuario_id, us])
  end
end

