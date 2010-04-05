class Ecm::RelatorioentidadesController < ApplicationController
  def index
    @entidade = Entidade.find(@sessao_usuario.entidade_id)
  end
end

