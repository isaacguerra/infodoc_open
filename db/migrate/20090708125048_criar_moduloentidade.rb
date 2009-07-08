class CriarModuloentidade < ActiveRecord::Migration
  def self.up
    create_table :moduloentidades do |t|
      t.integer :modulo_id, nil=>false
      t.integer :entidade_id, nil=>false
    end
    add_index :moduloentidades, :entidade_id
    add_index :moduloentidades, :modulo_id
  end

  def self.down
    drop_table :moduloentidades
  end
end

