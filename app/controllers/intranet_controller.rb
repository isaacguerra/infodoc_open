class IntranetController < ApplicationController
  skip_before_filter :autorizado

  def index
    if @sessao_usuario.entidade.paginaentidades.size > 0

    else
      render "ajuda"
    end
  end

  def ajuda
  end
end

