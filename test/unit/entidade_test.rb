require 'test_helper'

class EntidadeTest < ActiveSupport::TestCase

  context 'Validação da entidade' do
    setup do
      @entidade = Factory(:entidade1)
    end

    should_validate_presence_of :nome
    should_validate_presence_of :cpf_cnpj
    should_validate_presence_of :cidade
    should_validate_presence_of :endereco
    should_validate_presence_of :bairro
    should_validate_presence_of :cep
    should_validate_presence_of :telefone
    should_validate_presence_of :email
    should_validate_presence_of :nome_responsavel
    should_validate_presence_of :telefone_responsavel
    should_validate_presence_of :email_responsavel

    should_ensure_length_in_range :cpf_cnpj, (11..14)
  end
end

