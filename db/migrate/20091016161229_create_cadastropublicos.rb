class CreateCadastropublicos < ActiveRecord::Migration
  def self.up
    create_table :cadastropublicos do |t|
      t.integer :entidade_id
      t.integer :formulario_id
      t.string :titulo
      t.text :filtro
      t.integer :permissao
      t.boolean :status, :default=>true
      t.string :hash_validacao
      t.boolean :privado
      t.timestamps
    end
  end

  def self.down
    drop_table :cadastropublicos
  end
end

