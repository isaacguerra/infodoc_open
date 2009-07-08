class CriarSistema < ActiveRecord::Migration
  def self.up
    create_table :sistemas do |t|
      t.integer :modulo_id, nil=>false
      t.string :nome, nil=>false
      t.string :descricao, nil=>false
      t.string :rota, nil=>false
      t.string :controle, nil=>false
      t.boolean :menu,:default=>true
      t.boolean :status,:default=>true
      t.timestamps
    end
    add_index :sistemas, :nome
    add_index :sistemas, :rota
    add_index :sistemas, :controle
    add_index :sistemas, :menu
    add_index :sistemas, :status
  end

  def self.down
    drop_table :sistemas
  end
end

