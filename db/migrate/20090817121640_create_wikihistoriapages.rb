class CreateWikihistoriapages < ActiveRecord::Migration
  def self.up
    create_table :wikihistoriapages do |t|
      t.integer :wikipage_id, :nil=>false
      t.integer :usuario_id, :nil=>false
      t.text :conteudo_antigo
      t.timestamps
    end
  end

  def self.down
    drop_table :wikihistoriapages
  end
end

