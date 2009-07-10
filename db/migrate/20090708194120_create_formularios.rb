class CreateFormularios < ActiveRecord::Migration
  def self.up
    create_table :formularios do |t|
      t.integer :formulariocategoria_id, nil=>false
      t.integer :formulariotipo_id, nil=>false
      t.integer :entidade_id, nil=>false
      t.integer :principal_id

      t.string :titulo, nil=>false, :size=>255
      t.string :descricao, nil=>false, :size=>255

      t.boolean :status, :default=>true

      t.timestamps
    end
    add_index :formularios, :entidade_id
    add_index :formularios, :formulariotipo_id
    add_index :formularios, :formulariocategoria_id
    add_index :formularios, :titulo
    add_index :formularios, :status
  end

  def self.down
    drop_table :formularios
  end
end

