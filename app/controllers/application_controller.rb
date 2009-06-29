# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  before_filter :autenticado

  protected
  def autenticado
    unless session[:sessao_atual].nil?
      @sessao_usuario = Sessao.find(session[:sessao_atual])
      unless @sessao_usuario
        session[:return_to] = request.request_uri
        redirect_to :controller => "core/login", :action=>:index
        return false
      else
        if @sessao_usuario.ultima_data_acesso+20.minutes > DateTime.now
          @sessao_usuario.fim
          session[:return_to] = request.request_uri
          redirect_to :controller => "core/login", :action=>:index
          return false
        else
          @sessao_usuario.acesso
          return true
        end
      end
    else
      session[:return_to] = request.request_uri
      redirect_to :controller => "core/login", :action=>:index
      return false
    end
  end


end

