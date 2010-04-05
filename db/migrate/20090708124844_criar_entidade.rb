class CriarEntidade < ActiveRecord::Migration
  def self.up
    create_table :entidades do |t|
      t.string :nome, nil=>false
      t.string :razao_social
      t.string :cpf_cnpj,:limit=>18,nil=>false
      t.string :cidade
      t.string :endereco
      t.string :bairro
      t.string :cep,:limit=>10
      t.string :telefone
      t.string :email
      t.string :nome_responsavel
      t.string :telefone_responsavel
      t.string :email_responsavel
      t.boolean :status,:default=>true

      t.string  :tema
      t.string  :logo_file_name
      t.string  :logo_content_type
      t.integer :logo_file_size

      t.timestamps
    end
    add_index :entidades, :nome
    add_index :entidades, :razao_social
    add_index :entidades, :endereco
    add_index :entidades, :nome_responsavel
    add_index :entidades, :telefone_responsavel
  end

  def self.down
    drop_table :core_entidades
  end
end

