class CriarGrupo < ActiveRecord::Migration
  def self.up
    create_table :grupos do |t|
      t.integer :entidade_id, nil=>false
      t.string :nome, nil=>false
      t.string :descricao, nil=>false
      t.boolean :status,:default=>true
      t.timestamps
    end
    add_index :grupos, :entidade_id
    add_index :grupos, :nome
    add_index :grupos, :status
  end

  def self.down
    drop_table :grupos
  end
end

