class CreateCategoriaNoticias < ActiveRecord::Migration
  def self.up
    create_table :categoria_noticias do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :categoria_noticias
  end
end
