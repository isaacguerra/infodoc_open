class CreateEcmItemTextoLongos < ActiveRecord::Migration
  def self.up
    create_table :ecm_item_texto_longos do |t|
      t.integer :entidade_id
      t.integer :formulariocategoria_id
      t.integer :formulario_id
      t.integer :itensformulario_id
      t.integer :cadastro_id
      t.integer :campo
      t.text :conteudo
    end
    add_index :ecm_item_texto_longos, :entidade_id
    add_index :ecm_item_texto_longos, :formulariocategoria_id
    add_index :ecm_item_texto_longos, :formulario_id
    add_index :ecm_item_texto_longos, :itensformulario_id
    add_index :ecm_item_texto_longos, :cadastro_id
    add_index :ecm_item_texto_longos, :conteudo

    add_index :ecm_item_texto_longos, [:entidade_id, :formulariocategoria_id, :formulario_id, :itensformulario_id, :cadastro_id, :conteudo], :name=>"index_ecm_texto_longos"
  end

  def self.down
    drop_table :ecm_item_texto_longos
  end
end

