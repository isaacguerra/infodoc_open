class Page::EntidadeController < ApplicationController
  skip_filter :autenticado
  skip_filter :autorizado

  layout 'home'

  def show
    @entidade = Entidade.find(params[:id])
  end

end

