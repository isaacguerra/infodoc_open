class Usuario < CouchFoo::Base
    belongs_to :entidade
    has_one :sessao
    has_many :grupousuarios
    has_many :grupos, :through => :grupousuarios

    attr_accessor :senha
    attr_accessor :senha_confirmation

    property :entidade_id, String
    property :nome, String
    property :login, String
    property :email, String
    property :senha_encriptada, String
    property :chave_criptografia, String
    property :status, Boolean

    # Magic columns, just like ActiveRecord's created_at and updated_at. These are automatically maintained by Authlogic if they are present.

    validates_uniqueness_of :login
    validates_presence_of :entidade_id
    validates_presence_of :nome
    validates_presence_of :login
    validates_presence_of :email
    validates_presence_of :senha
    validates_confirmation_of :senha

    #scopos----------
    named_scope :ativo, :conditions=>{:status=>true}
    named_scope :da_entidade, lambda {|id| {:conditions=>{:entidade_id=>id}}}
    #-------------


    before_save :encriptar_senha
    after_create :criar_sessao

    private
    def encriptar_senha
        self.chave_criptografia = random_alphanumeric(1024)
        self.senha_encriptada = encriptar(self.chave_criptografia, self.senha)
    end

    def criar_sessao
      sessao = Sessao.new
      sessao.usuario_id = self.id
      sessao.entidade_id = self.entidade_id
      sessao.save
    end

    public
    def random_alphanumeric(size=6)
        chars = ('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a + ['!','@','#','$','%','&','*']
        (0...size).collect { chars[Kernel.rand(chars.length)] }.join
    end
    def self.login(login, senha, remote_ip)
        usuario = Usuario.find(:first, :conditions=>{:login=>login, :status=>true})
        if usuario
           if usuario.senha_encriptada == usuario.encriptar(usuario.chave_criptografia, senha)
             usuario.sessao.inicia_sessao(remote_ip, usuario.nome)
             return usuario.sessao.id
          else
            return nil
          end
        else
           return nil
        end
    end
    def encriptar(salt, senha)
        return Digest::SHA1.hexdigest("#{salt}#{senha}")
    end
end

