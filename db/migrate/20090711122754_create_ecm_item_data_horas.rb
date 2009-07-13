class CreateEcmItemDataHoras < ActiveRecord::Migration
  def self.up
    create_table :ecm_item_data_horas do |t|
      t.integer :entidade_id
      t.integer :formulariocategoria_id
      t.integer :formulario_id
      t.integer :itensformulario_id
      t.integer :cadastro_id
      t.datetime :conteudo
    end
    add_index :ecm_item_data_horas, :entidade_id
    add_index :ecm_item_data_horas, :formulariocategoria_id
    add_index :ecm_item_data_horas, :formulario_id
    add_index :ecm_item_data_horas, :itensformulario_id
    add_index :ecm_item_data_horas, :cadastro_id
    add_index :ecm_item_data_horas, :conteudo

    add_index :ecm_item_data_horas, [:entidade_id, :formulariocategoria_id, :formulario_id, :itensformulario_id, :cadastro_id, :conteudo], :name=>"index_ecm_data_horas"
  end

  def self.down
    drop_table :ecm_item_data_horas
  end
end

