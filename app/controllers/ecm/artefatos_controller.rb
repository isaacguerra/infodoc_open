class Ecm::ArtefatosController < ApplicationController
  skip_before_filter :autorizado

  def index
    @cadastro = Cadastro.find(params[:cadastro_id])
    @new_form = Formulario.find(:all, :conditions=>["formulariotipo_id = 2 and formulariocategoria_id = ?", @cadastro.formulariocategoria_id]).collect {|f| [f.titulo, f.id] if f.funcional}.compact
    render :update do |page|
      page.visual_effect(:highlight , "artefatos")
      page.replace_html "artefatos", render(:partial=>"index")
    end
  end

  def show
    @cadastro = Cadastro.find(params[:cadastro_id])
    render :update do |page|
      page.visual_effect(:highlight , "new_artefato")
      page.replace_html "new_artefato", render(:partial=>"new")
    end
  end

  def new
    @parent = Cadastro.find(params[:cadastro_id])
    @formulario = Formulario.find(params[:formulario_id])
    @cadastro = Cadastro.new
    @cadastro.acessores("objeto_file_name")
    @cadastro.monta_acessores(@formulario)
    render :update do |page|
      page.visual_effect(:highlight , "new_artefato")
      page.replace_html "new_artefato", render(:partial=>"new")
    end
  end

  def create
    @parent = Cadastro.find(params[:cadastro_id])
    @formulario = Formulario.find(params[:cadastro][:formulario_id])
    @cadastro = Cadastro.new()
    @cadastro.monta_acessores(@formulario)
    @cadastro.validar(@formulario, params[:cadastro])
    @cadastro.errors.add("Artefato Requerido!") unless params[:cadastro][:objeto]
    if @cadastro.errors.count > 0
      flash[:notice] = "Impossivel criar o Artefato"
      redirect_to ecm_formulario_cadastro_path(@parent.formulario_id, @parent)
    else
      @cadastro.entidade_id = params[:cadastro][:entidade_id]
      @cadastro.formulario_id = params[:cadastro][:formulario_id]
      @cadastro.formulariocategoria_id = params[:cadastro][:formulariocategoria_id]
      @cadastro.formulariotipo_id = params[:cadastro][:formulariotipo_id]
      @cadastro.usuario_id = params[:cadastro][:usuario_id]
      @cadastro.save
      @cadastro.salvar_itens(params[:cadastro])
      @parent.children << @cadastro
      @artefato = Artefato.new
      @artefato.cadastro_id = @cadastro.id
      @artefato.entidade_id = @cadastro.entidade_id
      @artefato.objeto = params[:cadastro][:objeto]
      @artefato.save
      if params[:ocr] == "1"
        @artefato.send_later :fazer_ocr
      end
      Auditoriacadastro.create(:entidade_id=>@cadastro.entidade_id,
                               :usuario_id=>@cadastro.usuario_id,
                               :usuario_nome=>@sessao_usuario.usuario.nome,
                               :cadastro_id=>@cadastro.parent.id,
                               :formulario_id=>@cadastro.formulario_id,
                               :formulario_nome=>@cadastro.formulario.titulo,
                               :artefato_id=>@artefato.id,
                               :acao=>"create_artefato",
                               :descricao=>"Criou o Artefato #{@artefato.objeto_file_name}")
      flash[:notice] = "Artefato Criada com Sucesso!"
      redirect_to ecm_formulario_cadastro_path(@parent.formulario_id, @parent)
    end
  end

  def clean
    render :update do |page|
      page.visual_effect(:highlight , "artefatos")
      page.replace_html "artefatos", render(:text=>"")
    end
  end

  def download
    @cadastro = Cadastro.find(params[:id])
    if @cadastro.parent.formulario.permissao(@sessao_usuario.usuario) > 0 and @cadastro.artefato
      Auditoriacadastro.create(:entidade_id=>@cadastro.entidade_id,
                               :usuario_id=>@cadastro.usuario_id,
                               :usuario_nome=>@sessao_usuario.usuario.nome,
                               :cadastro_id=>@cadastro.parent.id,
                               :formulario_id=>@cadastro.formulario_id,
                               :formulario_nome=>@cadastro.formulario.titulo,
                               :artefato_id=>@cadastro.artefato.id,
                               :acao=>"download_artefato",
                               :descricao=>"Baixou o Artefato #{@cadastro.artefato.objeto_file_name}")

      send_file(@cadastro.artefato.objeto.path, :type=>@cadastro.artefato.objeto_content_type)
    end
  end

  def destroy
    @cadastro = Cadastro.find(params[:cadastro_id])
    @artefato = Cadastro.find(params[:id])
    if @cadastro.formulario.permissao(@sessao_usuario.usuario) > 2
      Auditoriacadastro.create(:entidade_id=>@cadastro.entidade_id,
                               :usuario_id=>@cadastro.usuario_id,
                               :usuario_nome=>@sessao_usuario.usuario.nome,
                               :cadastro_id=>@cadastro.id,
                               :formulario_id=>@artefato.formulario_id,
                               :formulario_nome=>@artefato.formulario.titulo,
                               :artefato_id=>@artefato.artefato.id,
                               :acao=>"destroy_artefato",
                               :descricao=>"Excluiu o Artefato #{@artefato.artefato.objeto_file_name}")
      @artefato.destroy
      flash[:notice] = "Artefato Excluido com Sucesso!"
      redirect_to ecm_formulario_cadastro_path(@cadastro.formulario_id, @cadastro)
    else
      flash[:notice] = "impossivel excluir o cadastro"
      redirect_to ecm_formulario_cadastro_path(@cadastro.formulario_id, @cadastro)
    end
  end

  def ocr
    @artefato = Cadastro.find(params[:id])
    render :ocr, :layout => "clean"
  end
end

