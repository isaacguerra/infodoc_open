class Ecm::AuditoriaproducaosController < ApplicationController
  def index
  end
  
  def show
    if params[:id] == "artefato"
      render :update do |page|
        page.visual_effect(:highlight , "filtro")
        page.replace_html "filtro", render(:partial=>"artefato")
      end
    else
      render :update do |page|
        page.visual_effect(:highlight , "filtro")
        page.replace_html "filtro", render(:partial=>"relacionado")
      end
    end
  end
  
  def create
    if params[:tipo]=="artefato"
      quant = params[:quant].to_i
      @cadastros = Cadastro.do_formulario(params[:formulario]).find(:all, :select=>"id, parent_id, formulario_id")
      @cadastros.collect! {|c| c if c.children.size != quant}
      @cadastros.compact!
    
      render :update do |page|
        page.visual_effect(:highlight , "resultado")
        page.replace_html "resultado", render(:partial=>"resultartefato")
      end
    else
      @form_pai = Formulario.find(params[:formulario_pai])
      @form_filho = Formulario.find(params[:formulario_filho])
      
      if_ff = Itensformulario.find(:all, :conditions=>["formulario_id=? and tipo='referencia'", @form_filho.id])
      
      id_iff = nil   
      
      if if_ff.size > 0
         if_ff.each do |iff|
            id_iff = iff.id if iff.tipo=="referencia" and iff.opcoes[0][:referenciado].to_i==@form_pai.id
         end          
      end
      
      if id_iff
        cads_pai = Cadastro.do_formulario(@form_pai.id).find(:all, :select=>"id, formulario_id")
        @errados = []
        @errados_q = []
        cads_pai.each do |c| 
          tem = EcmItemReferencia.do_formulario(@form_filho.id).do_itens_formulario(id_iff).count(:id, :conditions=>["referencia_id=?",c.id])
          unless tem == 1
            @errados << c
            @errados_q << tem
          end
        end
        render :update do |page|
          page.visual_effect(:highlight , "resultado")
          page.replace_html "resultado", render(:partial=>"resultrelacionado")
        end
      else
        render :update do |page|
          page.visual_effect(:highlight , "resultado")
          page.replace_html "resultado", render(:text=>"Formularios não Relacionados")
        end
      end
      
      
      
      
    end
  end
end
