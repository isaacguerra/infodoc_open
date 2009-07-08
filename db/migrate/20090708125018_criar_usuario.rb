class CriarUsuario < ActiveRecord::Migration
   def self.up
    create_table :usuarios do |t|
      t.integer :entidade_id, nil=>false
      t.string :nome, nil=>false
      t.string :login, nil=>false
      t.string :email, nil=>false
      t.string :senha_encriptada, nil=>false
      t.string :chave_criptografia, nil=>false
      t.boolean :status,:default=>true
      t.timestamps
    end
    add_index :usuarios, :entidade_id
    add_index :usuarios, :nome
    add_index :usuarios, :login
    add_index :usuarios, [:login,:senha_encriptada], :name=>"index_login_senha"
    add_index :usuarios, :senha_encriptada
    add_index :usuarios, :status
  end

  def self.down
    drop_table :usuarios
  end
end

