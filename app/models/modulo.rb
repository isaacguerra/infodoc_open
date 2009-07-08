class Modulo < ActiveRecord::Base
  has_many :sistemas
  has_many :moduloentidades

  validates_presence_of :nome
  validates_uniqueness_of :nome
  validates_presence_of :descricao
end

