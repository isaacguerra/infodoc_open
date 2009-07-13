class CreateEcmItemTextos < ActiveRecord::Migration
  def self.up
    create_table :ecm_item_textos do |t|
      t.integer :entidade_id
      t.integer :formulariocategoria_id
      t.integer :formulario_id
      t.integer :itensformulario_id
      t.integer :cadastro_id
      t.string :conteudo
    end
    add_index :ecm_item_textos, :entidade_id
    add_index :ecm_item_textos, :formulariocategoria_id
    add_index :ecm_item_textos, :formulario_id
    add_index :ecm_item_textos, :itensformulario_id
    add_index :ecm_item_textos, :cadastro_id
    add_index :ecm_item_textos, :conteudo

    add_index :ecm_item_textos, [:entidade_id, :formulariocategoria_id, :itensformulario_id, :formulario_id, :cadastro_id, :conteudo], :name=>"index_ecm_texto"
  end

  def self.down
    drop_table :ecm_item_textos
  end
end

