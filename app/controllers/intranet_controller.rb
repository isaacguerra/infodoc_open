class IntranetController < ApplicationController
  skip_before_filter :autorizado

  def index
  end
end

