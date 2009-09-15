class Sessao < ActiveRecord::Base
    belongs_to :usuario
    belongs_to :entidade

    serialize :opcoes

    #scopos----------
    named_scope :ativo, :conditions=>{:status=>true}
    named_scope :do_usuario, lambda {|id| {:conditions=>["usuario_id = ?", id]}}
    named_scope :da_entidade, lambda {|id| {:conditions=>["entidade_id = ?", id]}}
    #-------------

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

      #sistemas disponiveis
      sistemas = []
      self.usuario.grupousuarios.each do |gu|
        gu.grupo.gruposistemas.each do |gs|
          ja = false
          sistemas.each do |ar|
            if ar[0] == gs.sistema_id
              ja = true
              if ar[1] < gs.permissao
                ar[1] = gs.permissao
              end
            end
          end
          sistemas << [gs.sistema_id, gs.permissao, gs.sistema.controle, gs.sistema.rota, gs.sistema.nome, gs.sistema.menu, gs.sistema.status, gs.sistema.modulo_id, gs.sistema.modulo.nome] unless ja
        end
      end
      self.opcoes = sistemas
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

