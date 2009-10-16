class Page::PublicadosController < ApplicationController
  skip_filter :autenticado
  skip_filter :autorizado

  def index
  end

  def show
  end
end

