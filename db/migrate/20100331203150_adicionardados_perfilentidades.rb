class AdicionardadosPerfilentidades < ActiveRecord::Migration
  def self.up
    add_column :entidades, :mediaarquivo, :integer, :default=>0
    add_column :entidades, :quantidadearquivo, :integer, :default=>0
    add_column :entidades, :espacodisco, :float, :default=>0
  end

  def self.down
    remove_column :entidades, :mediaarquivo
    remove_column :entidades, :quantidadearquivo
    remove_column :entidades, :espacodisco
  end
end

