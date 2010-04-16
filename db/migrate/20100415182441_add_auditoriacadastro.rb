class AddAuditoriacadastro < ActiveRecord::Migration
  def self.up
    add_column :cadastros, :auditado, :boolean, :default=>false
    add_column :cadastros, :auditor_id, :integer, :default=>nil
    add_column :cadastros, :auditado_at, :date, :default=>nil
  end

  def self.down
    remove_column :cadastros, :auditado
    remove_column :cadastros, :auditor_id
    remove_column :cadastros, :auditado_at
  end
end

