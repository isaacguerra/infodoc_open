class CreateAuditoriacadastros < ActiveRecord::Migration
  def self.up
    create_table :auditoriacadastros do |t|
      t.integer  :entidade_id
      t.integer  :usuario_id
      t.integer  :cadastro_id
      t.integer  :formulario_id
      t.integer  :artefato_id
      t.string   :acao
      t.text     :descricao
      t.datetime :created_at
    end
  end

  def self.down
    drop_table :auditoriacadastros
  end
end

