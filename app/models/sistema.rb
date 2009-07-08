class Sistema < ActiveRecord::Base
  belongs_to :modulo
  has_many :gruposistemas

  validates_presence_of :modulo_id
  validates_presence_of :nome
  validates_presence_of :descricao
  validates_presence_of :rota
  validates_presence_of :controle

  validates_uniqueness_of :nome
  validates_uniqueness_of :controle

  named_scope :do_modulo, lambda {|id| {:conditions=>["modulo_id=?",id]}}
end

