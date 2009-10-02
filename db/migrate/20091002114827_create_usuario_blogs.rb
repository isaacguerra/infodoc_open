class CreateUsuarioBlogs < ActiveRecord::Migration
  def self.up
    create_table :usuario_blogs do |t|
      t.integer :entidade_id
      t.integer :usuario_id
      t.integer :seguido_id
    end
    add_index :usuario_blogs, :entidade_id
    add_index :usuario_blogs, :usuario_id
    add_index :usuario_blogs, :seguido_id
  end

  def self.down
    drop_table :usuario_blogs
  end
end

