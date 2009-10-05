class Blog < ActiveRecord::Base
  belongs_to :usuario
  validates_presence_of :entidade_id
  validates_presence_of :usuario_id
  validates_presence_of :menssagem

  validates_length_of :menssagem, :maximum=>255

  named_scope :da_entidade, lambda {|id| {:conditions=>["entidade_id = ?", id]}}

  def self.busca_menssagem(usuario_id)
    us = UsuarioBlog.find(:all, :conditions=>["usuario_id = ?", usuario_id]).collect {|ub| ub.seguido_id}
    menssagens = Blog.find(:all, :limit=>5, :order=>"created_at DESC", :conditions=>["usuario_id = ? or usuario_id in (?)", usuario_id, us])
  end
end

