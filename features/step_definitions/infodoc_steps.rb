Dado /^que estou logado$/ do
  visit "/core/install"
  visit "/core/login"
  fill_in("login[usuario]", :with=>"admin")
  fill_in("login[senha]", :with=>"123456")
  click_button("Logar")
  response.should contain("logout")
end

Dado /^que estou na pagina "([^\"]*)"$/ do |pagina|
  visit pagina
end

Entao /^eu vou para a url "([^\"]*)"$/ do |url|
  visit url
end

Dado /^que os seguintes usuarios existem:$/ do |table|
  table.hashes.each do |hash|
    visit '/core/adminusuarios/new'
    fill_in("usuario[nome]", :with=>hash[:nome])
    fill_in("usuario[login]", :with=>hash[:login])
    fill_in("usuario[email]", :with=>hash[:email])
    fill_in("usuario[senha]", :with=>hash[:senha])
    fill_in("usuario[senha_confirmation]", :with=>hash[:senha_confirmation])
    click_button("Salvar")
  end
end

Entao /^eu deveria ver "([^\"]*)"$/ do |texto|
  response.should contain(texto)
end

Entao /^marco o checkbox "([^\"]*)"$/ do |checkbox|
  check checkbox
end

Entao /^clico no link "([^\"]*)"$/ do |link|
  click_link(link)
end

Entao /^clico no botao "([^\"]*)"$/ do |botao|
  click_button(botao)
end

