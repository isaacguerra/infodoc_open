# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  before_filter :autenticado
  #before_filter :autorizado

  protected
  def autenticado
    unless session[:sessao_atual].nil?
      @sessao_usuario = Sessao.find(session[:sessao_atual])
      unless @sessao_usuario
        flash[:notice] = "Login Requerido!"
        session[:return_to] = request.request_uri
        redirect_to :controller => "core/login", :action=>:index
        return false
      else
        if @sessao_usuario.ultima_data_acesso+20.minutes > DateTime.now+3.hours
          flash[:notice] = "Sessão Expirada por tempo limite!"
          @sessao_usuario.fim
          session[:return_to] = request.request_uri
          redirect_to :controller => "core/login", :action=>:index
          return false
        else
          #@sessao_usuario.acesso
          @menu_modulo = []
          opcoes = @sessao_usuario.opcoes.to_a
          opcoes.each {|m| @menu_modulo << m[8]}
          @menu_modulo.uniq!
          @menu_modulo.compact!
          return true
        end
      end
    else
      flash[:notice] = "Login Requerido!"
      session[:return_to] = request.request_uri
      redirect_to :controller => "core/login", :action=>:index
      return false
    end
  end

  def autorizado
    if @sessao_usuario.opcoes
    @nivel_permissao=0
    @sessao_usuario.opcoes.each do |o|
      if o[2].downcase == self.class.to_s.downcase
        @nivel_permissao = o[1]
      end
    end
    if @nivel_permissao == 0
      flash[:notice] = "Sistema não Autorizado para este Usuario!"
      redirect_to "/intranet"
      return false
    else
      #flash[:notice] = "Sistema Autorizado para este Usuario!"
      return true
    end
    else
      flash[:notice] = "Sistema não Autorizado para este Usuario!"
      redirect_to "/intranet"
      return false
    end
  end

  def render_to_pdf(options = nil)
    data = render_to_string(options)
    pdf = PDF::HTMLDoc.new
    pdf.set_option :bodycolor, :white
    pdf.set_option :toc, false
    pdf.set_option :portrait, true
    pdf.set_option :links, false
    pdf.set_option :webpage, true
    pdf.set_option :left, '2cm'
    pdf.set_option :right, '2cm'
    pdf << data
    pdf.generate
  end
end

