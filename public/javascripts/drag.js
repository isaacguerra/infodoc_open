$(document).ready(
/* minimizar conteudo da janela
==================================*/

	function () {
     	$('a.mini').click(function() {
  
          $('.conteudo_verbete', this.parentNode.parentNode.parentNode).hide('fast');
            
          return false;
  
        });
/* maximizar o conteudo da janela
================================== */        

        $('a.max').click(function() {
  
          $('.conteudo_verbete', this.parentNode.parentNode.parentNode).show('fast');
            
          return false;
  
        });
/* Fechar a janela */
        
        $('a.fechar').click(function() {
  
          $( this.parentNode.parentNode.parentNode).hide('fast');
            
          return false;
  
        });
/*
Arrastar e soltar
======================================== */       

		$('#pagina_verbete').Sortable(
			{
				accept : 		'verbete',
				helperclass : 	'sorthelper',
				activeclass : 	'sortableactive',
				hoverclass : 	'sortablehover',
				opacity: 		0.8,
				/*fx:				200,*/
				revert:			true,
				handle:         'div.titulo_verbete',
				floats:			true,
				tolerance:		'pointer'
			}
		)
	}
);
/*
var toggleContent = function(e)
{
	var targetContent = $('div.conteudo_verbete', this.parentNode.parentNode);
	if (targetContent.css('display') == 'none') {
		targetContent.hide(300);
		$(this).html('[-]');
	} else {
		targetContent.hide(300);
		$(this).html('[+]');
	}
	return false;
};
*/

