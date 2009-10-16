ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  map.namespace :core do |core|
    core.resources :login, :collection=>{:logout=>:get}
    core.resources :entidades, :has_many => :grupos
    core.resources :entidades, :has_many => :usuarios
    core.resources :entidades, :has_many => :moduloentidades
    core.resources :modulos, :has_many=>:sistemas
    core.resources :admingrupos, :has_many=>:gruposistemas
    core.resources :admingrupos, :has_many=>:grupousuarios
    core.resources :adminusuarios, :has_many=>:adminmudarsenhas
    core.resources :perfil
    core.resources :perfilentidades
    core.resources :entidades, :has_many=>:paginaentidades
  end

  map.namespace :ecm do |ecm|
    ecm.resources :categorias, :has_many=>:formularios
    ecm.resources :formularios, :has_many=>:itens_formularios
    ecm.resources :formularios, :has_many=>:permissao_formularios
    ecm.resources :formularios, :has_many=>:principal_formularios
    ecm.resources :formularios, :has_many=>:ajudas_formularios
    ecm.resources :formularios, :has_many=>:publicar_formularios
    ecm.resources :formularios, :has_many=>:cadastros
    ecm.resources :cadastros, :has_many=>:comentarios
    ecm.resources :cadastros, :has_many=>:artefatos
    ecm.resources :cadastros, :has_many=>:relacionados
  end

  map.namespace :page do |page|
    page.resources :entidade, :only=>[:show] do |entidade|
      entidade.resources :publicados, :only=>[:index, :show]
    end
    page.resources :homeentidades
  end

  map.namespace :com do |com|
    com.resources :blogs, :collection=>{:usuario_blogs=>:post, :view=>:get, :historico=>:get}
  end

  map.namespace :wiki do |wiki|
    wiki.resources :wikicategorias, :collection=>{:busca=>:get }, :has_many=>:wikipages
    wiki.resources :wikipages, :has_many=>:wikihistotiapages
    wiki.resources :wikipages, :has_many=>:wikicomentarios
    wiki.resources :wikicomentarios, :collection=>{:clean=>:get }
    wiki.resources :wikihistotiapages, :collection=>{:clean=>:get }
  end

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action
  map.root :controller => "home"
  map.resources :home
  map.resources :intranet
  map.purchase 'depoimentos', :controller => 'home', :action => 'depoimentos'
  map.purchase 'servicos', :controller => 'home', :action => 'servicos'
  map.purchase 'clientes', :controller => 'home', :action => 'clientes'
  map.purchase 'noticias', :controller => 'home', :action => 'noticias'
  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

