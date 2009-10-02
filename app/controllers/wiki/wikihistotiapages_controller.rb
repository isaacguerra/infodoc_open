class Wiki::WikihistotiapagesController < ApplicationController
  skip_before_filter :autorizado

  def index
    @wikipage = Wikipage.find(params[:wikipage_id])
    render :update do |page|
      page.visual_effect(:highlight , "historico")
      page.replace_html "historico", render(:partial=>"index")
    end
  end

  def show
    @historia = Wikihistoriapage.find(params[:id])
     render :update do |page|
      page.visual_effect(:highlight , "view_old")
      page.replace_html "view_old", render(:partial=>"show")
    end
  end

  def clean
    render :update do |page|
      page.replace_html "historico", render(:text=>"")
    end
  end
end

