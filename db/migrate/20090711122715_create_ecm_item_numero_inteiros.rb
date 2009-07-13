class CreateEcmItemNumeroInteiros < ActiveRecord::Migration
  def self.up
    create_table :ecm_item_numero_inteiros do |t|
      t.integer :entidade_id
      t.integer :formulariocategoria_id
      t.integer :formulario_id
      t.integer :itensformulario_id
      t.integer :cadastro_id
      t.integer :conteudo
    end
    add_index :ecm_item_numero_inteiros, :entidade_id
    add_index :ecm_item_numero_inteiros, :formulariocategoria_id
    add_index :ecm_item_numero_inteiros, :formulario_id
    add_index :ecm_item_numero_inteiros, :itensformulario_id
    add_index :ecm_item_numero_inteiros, :cadastro_id
    add_index :ecm_item_numero_inteiros, :conteudo

    add_index :ecm_item_numero_inteiros, [:entidade_id, :formulariocategoria_id, :formulario_id, :itensformulario_id, :cadastro_id, :conteudo], :name=>"index_ecm_numero_inteiros"
  end

  def self.down
    drop_table :ecm_item_numero_inteiros
  end
end

