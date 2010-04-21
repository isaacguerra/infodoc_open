class Gde::NavegadordearquivosController < ApplicationController
  def index

  end

  def create
    if params[:tipo]=="categorias"
      @categorias = Formulariocategoria.da_entidade(@sessao_usuario.entidade_id).all

      render :update do |page|
        page.visual_effect(:highlight , "pastas")
        page.replace_html "pastas", render(:partial=>"categorias")
      end
    else
      @formulario = Formulario.find(params[:formulario])
      render :update do |page|
        page.visual_effect(:highlight , "pastas")
        page.replace_html "pastas", render(:partial=>"formularios")
      end
    end
  end

  def show
  end

  def update
    params[:artefatos].each do |id|
      cadastro = Cadastro.find(id)
      if cadastro.parent.formulario.permissao(@sessao_usuario.usuario) > 0 and cadastro.artefato
        Auditoriacadastro.create(:entidade_id=>cadastro.entidade_id,
                                 :usuario_id=>cadastro.usuario_id,
                                 :usuario_nome=>@sessao_usuario.usuario.nome,
                                 :cadastro_id=>cadastro.parent.id,
                                 :formulario_id=>cadastro.formulario_id,
                                 :formulario_nome=>cadastro.formulario.titulo,
                                 :artefato_id=>cadastro.artefato.id,
                                 :acao=>"download_artefato",
                                 :descricao=>"Baixou o Artefato #{cadastro.artefato.objeto_file_name}")

        send_file(cadastro.artefato.objeto.path, :type=>cadastro.artefato.objeto_content_type)
      end
    end

  end


end

