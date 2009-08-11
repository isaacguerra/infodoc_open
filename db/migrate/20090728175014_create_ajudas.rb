class CreateAjudas < ActiveRecord::Migration
  def self.up
    create_table :ajudas do |t|
      t.integer :entidade_id, nil=>false
    	t.references :ajudavel, :polymorphic => true
    	t.text :conteudo
    end
  end

  def self.down
    drop_table :ajudas
  end
end

