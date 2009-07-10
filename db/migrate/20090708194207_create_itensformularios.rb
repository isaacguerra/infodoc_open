class CreateItensformularios < ActiveRecord::Migration
  def self.up
    create_table :itensformularios do |t|
      t.integer :entidade_id, nil=>false
      t.integer :formulario_id, nil=>false
      t.integer :itenstipo_id, nil=>false
      t.string :rotulo
      t.string :posicao
      t.string :tipo
      t.text :opcoes
    end
  end

  def self.down
    drop_table :itensformularios
  end
end

