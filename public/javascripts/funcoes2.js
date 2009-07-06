            /**************************  LISTAR ********************************/
              /*************************** SCRIPT  mousehover ********************/
             /*************************** nos elementos de uma lista ************/
            /*******************************************************************/
var x;
x=$(document);
x.ready(inicializarEventos);
function inicializarEventos() {
var x;
x=$("#listar tr,#logout");
x.hover(entraMouse,saleMouse);
}
function entraMouse() {
$(this).css("background-color","#FAF5DC");
$(this).css("color","#000000");

}
function saleMouse() {
$(this).css("background-color","#ffffff");
$(this).css("color","#000000");
}

