class CriarSessao < ActiveRecord::Migration
  def self.up
    create_table :sessaos do |t|
      t.integer :usuario_id, nil=>false
      t.integer :entidade_id, nil=>false
      t.string :nome_usuario
      t.integer :num_login
      t.datetime :ultima_data_acesso
      t.datetime :corrente_data_login
      t.datetime :ultima_data_login
      t.string :corrente_login_ip
      t.string :ultimo_login_ip
      t.text :opcoes
      t.boolean :status,:default=>true
    end
    add_index :sessaos, :entidade_id
    add_index :sessaos, :usuario_id
  end

  def self.down
    drop_table :sessaos
  end
end

