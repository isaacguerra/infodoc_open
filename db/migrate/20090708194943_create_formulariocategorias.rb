class CreateFormulariocategorias < ActiveRecord::Migration
  def self.up
    create_table :formulariocategorias do |t|
      t.integer :entidade_id
      t.string :nome
      t.string :descricao
    end
  end

  def self.down
    drop_table :formulariocategorias
  end
end

