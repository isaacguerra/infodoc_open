class Entidade < ActiveRecord::Base
   has_many :usuarios
   has_many :grupos
   has_many :moduloentidades
   has_many :paginaentidades
   has_many :cadastropublicos
   has_one :perfilentidade
   has_many :formulariocategorias

   has_attached_file :logo

   validates_presence_of :nome
   validates_presence_of :cpf_cnpj
   validates_presence_of :endereco
   validates_presence_of :cidade
   validates_presence_of :bairro
   validates_presence_of :cep
   validates_presence_of :telefone
   validates_presence_of :email
   validates_presence_of :nome_responsavel
   validates_presence_of :telefone_responsavel
   validates_presence_of :email_responsavel
   validates_presence_of :status
   validates_uniqueness_of :cpf_cnpj
   validates_length_of :cpf_cnpj, :in => 11..14, :allow_nil=>false
end

