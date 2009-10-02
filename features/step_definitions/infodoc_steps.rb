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
    usuario = Usuario.new(hash)
    usuario.save
  end
end

Entao /^eu deveria ver "([^\"]*)"$/ do |texto|
  response.should contain(texto)
end

