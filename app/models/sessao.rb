class Sessao < CouchFoo::Base
    belongs_to :usuario

    property :usuario_id, String
    property :hash_sessao, String
    property :nome_usuario, String
    property :status, Boolean

    property :num_login, Integer
    property :ultima_data_acesso, DateTime
    property :corrente_data_login, DateTime
    property :ultima_data_login, DateTime
    property :corrente_login_ip, String
    property :ultimo_login_ip, String

    property :opcoes, Array

    def inicia_sessao(ip, nome)
      self.nome_usuario = nome
      if self.num_login
        self.num_login += 1
      else
        self.num_login = 1
      end
      self.ultimo_login_ip = self.corrente_login_ip
      self.corrente_login_ip = ip
      self.ultima_data_login = self.corrente_data_login
      self.corrente_data_login = DateTime.now
      self.ultima_data_acesso = DateTime.now
      self.status = true
      self.save
    end

    def fim
      self.status = false
      self.save
    end

    def acesso
      self.ultima_data_acesso = DateTime.now
      self.save
    end

end

