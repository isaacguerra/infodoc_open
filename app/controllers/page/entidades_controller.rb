class Page::EntidadesController < ApplicationController
  def index
    redirect_to "/"
  end
  def show
    @entidade = Entidade.find(params[:id])
  end
end

