class CreateItenstipos < ActiveRecord::Migration
  def self.up
    create_table :itenstipos do |t|
      t.string :nome
      t.string :tipo
      t.string :componente
      t.boolean :status
    end
  end

  def self.down
    drop_table :itenstipos
  end
end

