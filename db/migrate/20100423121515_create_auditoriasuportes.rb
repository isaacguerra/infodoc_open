class CreateAuditoriasuportes < ActiveRecord::Migration
  def self.up
    create_table :auditoriasuportes do |t|
      t.integer :entidade_id
      t.integer :usuario_id

      t.boolean :backup_biro
      t.text    :backup_biro_obs

      t.boolean :backup_servidor
      t.text    :backup_servidor_obs

      t.boolean :manutencaodesktop
      t.text    :manutencaodesktop_obs

      t.boolean :manutencaoservidor
      t.text    :manutencaoservidor_obs

      t.boolean :manutencaoscanner
      t.text    :manutencaoscanner_obs

      t.boolean :manutencaoredelogica
      t.text    :manutencaoredelogica_obs

      t.boolean :manutencaoredeeletrica
      t.text    :manutencaoredeeletrica_obs

      t.boolean :treinamentointerno
      t.text    :treinamentointerno_obs

      t.boolean :treinamentocliente
      t.text    :treinamentocliente_obs

      t.boolean :auditado
      t.integer :auditor_id

      t.timestamps
    end
  end

  def self.down
    drop_table :auditoriasuportes
  end
end

