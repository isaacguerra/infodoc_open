class Core::PerfilController < ApplicationController
  def index
    @usuario = @sessao_usuario.usuario
  end

  def edit
    @usuario = @sessao_usuario.usuario
  end

  def update
    @usuario = @sessao_usuario.usuario
    if @usuario.encriptar(@usuario.chave_criptografia, params[:senha_atual]) == @usuario.senha_encriptada
      if @usuario.update_attributes(params[:usuario])
        flash[:notice] = "Perfil Alterado com Sucesso!"
        redirect_to :action=>"index"
      else
        render :action=>"edit"
      end
    else
      flash[:notice] = "Senha Atual não Confere"
      render :action=>"edit"
    end
  end
end

