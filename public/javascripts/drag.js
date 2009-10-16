
$(document).ready(
	function () {
		$('a.closeEl').bind('click', toggleContent);
		$('div.groupWrapper').Sortable(
			{
				accept: 'groupItem',
				helperclass: 'sortHelper',
				activeclass : 	'sortableactive',
				hoverclass : 	'sortablehover',
				handle: 'div.itemHeader',
				tolerance: 'pointer',
				onChange : function(ser)
				{
				},
				onStart : function()
				{
					$.iAutoscroller.start(this, document.getElementsByTagName('body'));
				},
				onStop : function()
				{
					$.iAutoscroller.stop();
				}
			}
		);
	}
);
var toggleContent = function(e)
{
	var targetContent = $('div.itemContent', this.parentNode.parentNode);
	if (targetContent.css('display') == 'none') {
		targetContent.slideDown(300);
		$(this).html('[-]');
	} else {
		targetContent.slideUp(300);
		$(this).html('[+]');
	}
	return false;
};
function serialize(s)
{
	serial = $.SortSerialize(s);
	alert(serial.hash);
};

/*
$(document).ready(function(){ 
      $('.verbete').Draggable(
                              {
                                      handler:'titulo_verbete',
                                      grid: [50,50],
                                      ghosting: true,
                                      opacity: 0.5,
                                      containment : '#pagina_verbete'

                              }
                      );
       });
*/       

$(document).ready(
	function () {
		$('#pagina_verbete').Sortable(
			{
				accept : 		'verbete',
				helperclass : 	'sorthelper',
				activeclass : 	'sortableactive',
				hoverclass : 	'sortablehover',
				opacity: 		0.8,
				/*fx:				200,*/
				revert:			true,
				floats:			true,
				tolerance:		'pointer'
			}
		)
	}
);


