class CreatePaginaentidades < ActiveRecord::Migration
  def self.up
    create_table :paginaentidades do |t|
      t.integer :entidade_id
      t.integer :usuario_id
      t.text :pagina

      t.timestamps
    end
  end

  def self.down
    drop_table :paginaentidades
  end
end

