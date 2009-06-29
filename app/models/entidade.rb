class Entidade < CouchFoo::Base
   has_many :usuarios

   property :nome, String
   property :razao_social, String
   property :cpf_cnpj, String
   property :cidade, String
   property :endereco, String
   property :bairro, String
   property :cep, String
   property :telefone, String
   property :email, String
   property :nome_responsavel, String
   property :telefone_responsavel, String
   property :email_responsavel, String
   property :status, Boolean

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
   validates_uniqueness_of :cpf_cnpj

end

