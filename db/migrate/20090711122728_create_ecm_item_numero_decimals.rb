class CreateEcmItemNumeroDecimals < ActiveRecord::Migration
  def self.up
    create_table :ecm_item_numero_decimals do |t|
      t.integer :entidade_id
      t.integer :formulariocategoria_id
      t.integer :formulario_id
      t.integer :itensformulario_id
      t.integer :cadastro_id
      t.float :conteudo
    end
    add_index :ecm_item_numero_decimals, :entidade_id
    add_index :ecm_item_numero_decimals, :formulariocategoria_id
    add_index :ecm_item_numero_decimals, :formulario_id
    add_index :ecm_item_numero_decimals, :itensformulario_id
    add_index :ecm_item_numero_decimals, :cadastro_id
    add_index :ecm_item_numero_decimals, :conteudo

    add_index :ecm_item_numero_decimals, [:entidade_id, :formulariocategoria_id, :formulario_id, :itensformulario_id, :cadastro_id, :conteudo], :name=>"index_ecm_numero_decimals"
  end

  def self.down
    drop_table :ecm_item_numero_decimals
  end
end

