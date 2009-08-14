class CreateEcmItemReferencias < ActiveRecord::Migration
  def self.up
    create_table :ecm_item_referencias do |t|
      t.integer :entidade_id
      t.integer :formulariocategoria_id
      t.integer :formulario_id
      t.integer :itensformulario_id
      t.integer :cadastro_id
      t.integer :campo
      t.integer :referencia_id
    end
    add_index :ecm_item_referencias, :entidade_id
    add_index :ecm_item_referencias, :formulariocategoria_id
    add_index :ecm_item_referencias, :formulario_id
    add_index :ecm_item_referencias, :itensformulario_id
    add_index :ecm_item_referencias, :cadastro_id
    add_index :ecm_item_referencias, :referencia_id

    add_index :ecm_item_referencias, [:entidade_id, :formulariocategoria_id, :itensformulario_id, :formulario_id, :cadastro_id, :referencia_id], :name=>"index_ecm_referencias"
  end


  def self.down
    drop_table :ecm_item_referencias
  end
end

