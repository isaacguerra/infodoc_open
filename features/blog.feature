Funcionalidade: Blogs

	Para Comunicar meus usuarios
	Eu preciso de um Microblog que possa criar pequenas menssagens
	Onde meus usuarios possam se vincular e acompanhar

	Contexto:
        Dado que estou logado
        Dado que estou na pagina "intranet"

    Cenario: definir acompanhates
        Dado que os seguintes usuarios existem:
          |entidade_id|nome|login|email|status|senha|senha_confirmation|
          |1|jose|jose|jose@uol.uom.br|true|123|123|
          |1|luis|luis|luis@uol.uom.br|true|123|123|
          |1|claudio|claudio|claudio@uol.uom.br|true|123|123|
        Entao eu vou para a url "/com/blogs/"
        Entao eu deveria ver "jose"
        Entao eu deveria ver "luis"
        Entao eu deveria ver "claudio"

