class Auditoriacadastro < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :cadastro
  belongs_to :formulario
end

