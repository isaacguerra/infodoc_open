class CriarGrupousuario < ActiveRecord::Migration
  def self.up
    create_table :grupousuarios do |t|
      t.integer :grupo_id, nil=>false
      t.integer :usuario_id, nil=>false
    end
    add_index :grupousuarios, :grupo_id
    add_index :grupousuarios, :usuario_id
  end

  def self.down
    drop_table :grupousuarios
  end
end

