class CreateAuditoriacadastros < ActiveRecord::Migration
  def self.up
    create_table :auditoriacadastros do |t|
      t.integer  :entidade_id
      t.integer  :usuario_id
      t.string   :usuario_nome
      t.integer  :cadastro_id
      t.integer  :formulario_id
      t.string   :formulario_nome
      t.integer  :artefato_id
      t.string   :acao
      t.text     :descricao
      t.datetime :created_at
    end
    add_index :auditoriacadastros, :entidade_id
    add_index :auditoriacadastros, :usuario_id
    add_index :auditoriacadastros, :cadastro_id
    add_index :auditoriacadastros, :formulario_id
    add_index :auditoriacadastros, :acao
    add_index :auditoriacadastros, :created_at
  end

  def self.down
    drop_table :auditoriacadastros
  end
end

