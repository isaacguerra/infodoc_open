class CreateBlogs < ActiveRecord::Migration
  def self.up
    create_table :blogs do |t|
      t.integer :entidade_id
      t.integer :usuario_id
      t.integer :destinatario_id
      t.string  :menssagem
      t.timestamps
    end
    add_index :blogs, :entidade_id
    add_index :blogs, :usuario_id
    add_index :blogs, :destinatario_id
    add_index :blogs, :menssagem
  end

  def self.down
    drop_table :blogs
  end
end

