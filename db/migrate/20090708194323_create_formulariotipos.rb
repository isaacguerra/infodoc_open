class CreateFormulariotipos < ActiveRecord::Migration
  def self.up
    create_table :formulariotipos do |t|
      t.string :tipo
      t.boolean :status
    end
  end

  def self.down
    drop_table :formulariotipos
  end
end

