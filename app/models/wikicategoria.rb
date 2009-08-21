class Wikicategoria < ActiveRecord::Base
  belongs_to :entidade
  has_many :wikipages
  acts_as_tree

  validates_presence_of :entidade_id
  validates_presence_of :nome

  #scopos----------
  named_scope :raiz, :conditions=>["parent_id is null"]
  named_scope :da_entidade, lambda {|id| {:conditions=>["entidade_id = ?", id]}}
  #-------------
end

