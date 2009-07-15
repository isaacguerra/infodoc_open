class CreateGrupoformularios < ActiveRecord::Migration
  def self.up
    create_table :grupoformularios do |t|
      t.integer :grupo_id, nil=>false
      t.integer :formulario_id, nil=>false
      t.integer :permissao, nil=>false
    end
    add_index :grupoformularios, :grupo_id
    add_index :grupoformularios, :formulario_id
    add_index :grupoformularios, :permissao
  end

  def self.down
    drop_table :grupoformularios
  end
end

