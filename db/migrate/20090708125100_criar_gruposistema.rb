class CriarGruposistema < ActiveRecord::Migration
  def self.up
    create_table :gruposistemas do |t|
      t.integer :grupo_id, nil=>false
      t.integer :sistema_id, nil=>false
      t.integer :permissao, nil=>false
    end
    add_index :gruposistemas, :grupo_id
    add_index :gruposistemas, :sistema_id
    add_index :gruposistemas, :permissao
  end

  def self.down
    drop_table :gruposistemas
  end
end

