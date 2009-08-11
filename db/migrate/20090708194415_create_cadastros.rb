class CreateCadastros < ActiveRecord::Migration
  def self.up
    create_table :cadastros do |t|
      t.integer :entidade_id
      t.integer :formulario_id
      t.integer :usuario_id
      t.integer :formulariotipo_id
      t.integer :formulariocategoria_id
      t.integer :parent_id
      t.boolean :status
      t.timestamps
    end
  end

  def self.down
    drop_table :cadastros
  end
end

