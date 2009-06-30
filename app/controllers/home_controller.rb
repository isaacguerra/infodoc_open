class HomeController < ApplicationController
  skip_before_filter :autenticado
  def index
  end
end
