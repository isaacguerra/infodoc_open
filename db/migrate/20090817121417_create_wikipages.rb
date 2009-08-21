class CreateWikipages < ActiveRecord::Migration
  def self.up
    create_table :wikipages do |t|
      t.integer :entidade_id, :nil=>false
      t.integer :wikicategoria_id, :nil=>false
      t.string :titulo, :nil=>false
      t.text :conteudo, :nil=>false
      t.boolean :protegido, :default=>false
      t.timestamps
    end
  end

  def self.down
    drop_table :wikipages
  end
end

