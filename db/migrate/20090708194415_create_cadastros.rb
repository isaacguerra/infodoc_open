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
      t.boolean :publicado, :default=>false
      t.text :filtro
      t.timestamps
    end
    add_index :cadastros, :entidade_id
    add_index :cadastros, :formulariocategoria_id
    add_index :cadastros, :formulario_id
    add_index :cadastros, :formulariotipo_id
    add_index :cadastros, :usuario_id
    add_index :cadastros, :parent_id
    add_index :cadastros, :status
  end

  def self.down
    drop_table :cadastros
  end
end

