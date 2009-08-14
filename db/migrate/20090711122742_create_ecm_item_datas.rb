class CreateEcmItemDatas < ActiveRecord::Migration
  def self.up
    create_table :ecm_item_datas do |t|
      t.integer :entidade_id
      t.integer :formulariocategoria_id
      t.integer :formulario_id
      t.integer :itensformulario_id
      t.integer :cadastro_id
      t.integer :campo
      t.date :conteudo
    end
    add_index :ecm_item_datas, :entidade_id
    add_index :ecm_item_datas, :formulariocategoria_id
    add_index :ecm_item_datas, :formulario_id
    add_index :ecm_item_datas, :itensformulario_id
    add_index :ecm_item_datas, :cadastro_id
    add_index :ecm_item_datas, :conteudo

    add_index :ecm_item_datas, [:entidade_id, :formulariocategoria_id, :formulario_id, :itensformulario_id, :cadastro_id, :conteudo], :name=>"index_ecm_datas"
  end

  def self.down
    drop_table :ecm_item_datas
  end
end

