class Wikihistoriapage < ActiveRecord::Base
  belongs_to :wikipage
  belongs_to :usuario

  validates_presence_of :wikipage_id
  validates_presence_of :usuario_id

  #scopos----------
  named_scope :da_pagina, lambda {|id| {:conditions=>["wikipage_id = ?", id]}}
  #-------------
end

