class CreateArtefatos < ActiveRecord::Migration
  def self.up
    create_table :artefatos do |t|
      t.integer :entidade_id
      t.integer :cadastro_id
      t.string :objeto_file_name
      t.string :objeto_content_type
      t.integer :objeto_file_size
      t.datetime :objeto_updated_at
    end
  end

  def self.down
    drop_table :artefatos
  end
end

