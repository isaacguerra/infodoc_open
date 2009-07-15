class Ecm::CadastrosController < ApplicationController
  def index
    @formulario = Formulario.find(params[:formulario_id])
  end

  def show
    @formulario = Formulario.find(params[:formulario_id])
    @cadastro = Cadastro.find(params[:id])
  end

  def new
    @formulario = Formulario.find(params[:formulario_id])
    @cadastro = Cadastro.new
    @cadastro.monta_acessores(@formulario)
  end

  def create
    @formulario = Formulario.find(params[:formulario_id])
    @cadastro = Cadastro.new()
    @cadastro.monta_acessores(@formulario)
    @cadastro.validar(@formulario, params[:cadastro])
    if @cadastro.errors.count > 0
      @params = params[:cadastro]
      render :action => "new"
    else
      @cadastro.entidade_id = params[:cadastro][:entidade_id]
      @cadastro.formulario_id = params[:cadastro][:formulario_id]
      @cadastro.formulariocategoria_id = params[:cadastro][:formulariocategoria_id]
      @cadastro.formulariotipo_id = params[:cadastro][:formulariotipo_id]
      @cadastro.usuario_id = params[:cadastro][:usuario_id]
      @cadastro.save
      @cadastro.salvar_itens(params[:cadastro])
      flash[:notice] = "Categoria Criada com Sucesso!"
      redirect_to :action=>"show",:id=>@cadastro.id
    end
  end

  def edit
    @formulario = Formulario.find(params[:formulario_id])
    @cadastro = Cadastro.find(params[:id])
    @cadastro.monta_acessores(@formulario)
  end

  def update
    @formulario = Formulario.find(params[:formulario_id])
    @cadastro = Cadastro.find(params[:id])
    @cadastro.monta_acessores(@formulario)
    @cadastro.validar(@formulario, params[:cadastro])
    if @cadastro.errors.count > 0
      @params = params[:cadastro]
      render :action => "edit", :id=>@cadastro
    else
      @cadastro.update_itens(params[:cadastro])
      flash[:notice] = "Categoria Criada com Sucesso!"
      redirect_to :action=>"show",:id=>@cadastro.id
    end
  end

  def busca
    @formulario = Formulario.find(params[:id])
    @form_item = Itensformulario.find(@formulario.principal_id)
    @cadastro_itens = EcmItemTexto.do_formulario(@formulario.id).do_itens_formulario(@formulario.principal_id).find(:all, :conditions=>["conteudo like ?", "%#{params[:filtro]}%"])
    @tipo = params[:tipo]
    render :update do |page|
      page.visual_effect(:highlight , 'cadastros')
      page.replace_html "cadastros", render(:partial => "filtro")
    end
  end

  def view_busca_avancada
    @formulario = Formulario.find(params[:id])
    render :update do |page|
      page.visual_effect(:highlight , 'filtro_avancado')
      page.replace_html "filtro_avancado", render(:partial => "busca_avancada")
    end
  end

  def busca_avancada
    @formulario = Formulario.find(params[:id])
    @form_item = Itensformulario.find(@formulario.principal_id)

    sql = "select c.id from cadastros as c "
    @formulario.itensformularios.each do |i|
      if params[:filtro]["check_#{i.id}"] == "1"
        sql << " inner join ecm_item_#{i.tipo}s as i#{i.id} on c.id = i#{i.id}.cadastro_id"
      end
    end
    sql << " where c.formulario_id =  #{@formulario.id} "
    @formulario.itensformularios.each do |i|
      if params[:filtro]["check_#{i.id}"] == "1" and params[:cadastro]["item_#{i.id}"] != ""
        if i.tipo == "texto" or i.tipo == "texto_longo"
          sql << " and i#{i.id}.conteudo "
          if params[:acao]["acao_#{i.id}"] == "="
            sql << " like '%" << params[:cadastro]["item_#{i.id}"] << "%' "
          else
            sql << " not like '%" << params[:cadastro]["item_#{i.id}"] << "%' "
          end
        end
        if i.tipo == "data" or i.tipo == "data_hora"
          sql << " and i#{i.id}.conteudo "
          if params[:acao]["acao_#{i.id}"] == "="
            sql << " between " << params[:cadastro]["item1_#{i.id}"] << " and " << params[:cadastro]["item2_#{i.id}"]
          else
            sql << " not between " << params[:cadastro]["item1_#{i.id}"] << " and " << params[:cadastro]["item2_#{i.id}"]
          end
        end
        if i.tipo == "numero_inteiro" or i.tipo == "numero_decimal"
          sql << " and i#{i.id}.conteudo "
          if params[:acao]["acao_#{i.id}"] == "="
            sql << " > " << params[:cadastro]["item1_#{i.id}"] << " and i#{i.id}.conteudo < " << params[:cadastro]["item2_#{i.id}"]
          else
            sql << " < " << params[:cadastro]["item1_#{i.id}"] << " and i#{i.id}.conteudo > " << params[:cadastro]["item2_#{i.id}"]
          end
        end
        if i.tipo == "referencia"
          sql << " and i#{i.id}.referencia_id = " << params[:cadastro]["item_#{i.id}"]
        end
      end
    end
    cadastros = Cadastro.find_by_sql(sql).collect {|c| c.id}
    @cadastro_itens = EcmItemTexto.do_formulario(@formulario.id).do_itens_formulario(@formulario.principal_id).find(:all, :conditions=>["cadastro_id in (?)", cadastros])
    @tipo = params[:tipo]
    render :update do |page|
      page.visual_effect(:highlight , 'cadastros')
      page.replace_html "cadastros", render(:partial => "filtro")
    end
  end

  def ajax
    @formulario = Formulario.find(params[:formulario_id])
    @item = Itensformulario.find(params[:item_id])
    render :update do |page|
      page.visual_effect(:highlight , params[:div])
      page.replace_html params[:div], render(:text=> ecm_ajax(@item.itenstipo.componente, @item, params))
    end
  end
end

