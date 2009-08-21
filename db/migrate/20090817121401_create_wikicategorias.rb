class CreateWikicategorias < ActiveRecord::Migration
  def self.up
    create_table :wikicategorias do |t|
      t.integer :entidade_id
      t.string :nome, :nil=>false
      t.integer :parent_id
    end
  end

  def self.down
    drop_table :wikicategorias
  end
end

