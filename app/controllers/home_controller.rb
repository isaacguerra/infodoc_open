class HomeController < ApplicationController
  skip_before_filter :autenticado
  skip_before_filter :autorizado

  def index
  end
end

