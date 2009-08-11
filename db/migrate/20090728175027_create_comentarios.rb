class CreateComentarios < ActiveRecord::Migration
  def self.up
    create_table :comentarios do |t|
      t.integer :entidade_id, nil=>false
      t.integer :usuario_id, nil=>false
    	t.references :comentavel, :polymorphic => true
    	t.text :conteudo
    end
  end

  def self.down
    drop_table :comentarios
  end
end

