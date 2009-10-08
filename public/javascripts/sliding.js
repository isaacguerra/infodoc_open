/*      $(document).ready(function() {
 

        $('a.slidel').toggle(function() {

          function() {
          $('#comunicacao').toggle(500);
          $('#conteudo').css('width','99%');
          },
          function() {
          $('#conteudo').css('width','99%');
          }

        });

      });

*/

      $(document).ready(function() {
  
       // hides the slickbox as soon as the DOM is ready
  
       // (a little sooner than page load)
  
        $('#comunicacao').hide();
        $('#conteudo').css('width','99%');
  
       // shows the slickbox on clicking the noted link  
  
        $('a.slidel').click(function() {
  
          $('#comunicacao').show('slow');
          $('#conteudo').css('width','73.3%');
  
          return false;
   
        });
  
       // hides the slickbox on clicking the noted link  
  
        $('a.slideb').click(function() {
  
          $('#comunicacao').hide('fast');
          $('#conteudo').css('width','99%');
  
          return false;
  
        });
  
       
  
       // toggles the slickbox on clicking the noted link  
 
        $('a#slick-toggle').click(function() {
 
          $('#slickbox').toggle(400);
  
          return false;
  
        });
  
      });


