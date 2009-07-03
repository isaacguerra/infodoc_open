class Core::AdminmudarsenhasController < ApplicationController
  def edit
    @usuario = Usuario.find(params[:adminusuario_id])
  end

  def update
    @usuario = Usuario.find(params[:adminusuario_id])
    @usuario.senha = params[:usuario][:senha]
    @usuario.senha_confirmation = params[:usuario][:senha_confirmation]
    if @usuario.save
      flash[:notice] = "Senha alterada com Sucesso!"
      redirect_to core_adminusuario_path(@usuario)
    else
      render :action=>"edit", :adminusuario_id=>@usuario
    end
  end
end

