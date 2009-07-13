class CreateEcmItemImagems < ActiveRecord::Migration
  def self.up
    create_table :ecm_item_imagems do |t|
      t.integer :entidade_id
      t.integer :formulariocategoria_id
      t.integer :formulario_id
      t.integer :itensformulario_id
      t.integer :cadastro_id
      t.string :imagem_file_name
      t.string :imagem_content_type
      t.integer :imagem_file_size
    end

    add_index :ecm_item_imagems, :entidade_id
    add_index :ecm_item_imagems, :formulariocategoria_id
    add_index :ecm_item_imagems, :formulario_id
    add_index :ecm_item_imagems, :itensformulario_id
    add_index :ecm_item_imagems, :cadastro_id

    add_index :ecm_item_listas, [:entidade_id, :formulariocategoria_id, :formulario_id, :itensformulario_id, :cadastro_id], :name=>"index_ecm_imagem"
  end

  def self.down
    drop_table :ecm_item_imagems
  end
end

