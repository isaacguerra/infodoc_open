class CriarModulo < ActiveRecord::Migration
  def self.up
    create_table :modulos do |t|
      t.string :nome, nil=>false
      t.string :descricao, nil=>false
      t.boolean :status,:default=>true
      t.timestamps
    end
    add_index :modulos, :nome
  end

  def self.down
    drop_table :modulos
  end
end

