
function mostra() {
// pega a quantidade de caracteres
quantos = document.getElementsByTagName('td').innerHTML.length;

// pega os valores do div
valores = document.getElementsByTagName('td').innerHTML;

// limpa o div
document.getElementsByTagName('td').innerHTML="";

// limite de palavras por linha no div
quebra = 10;

// o texto é quebrado em várias partes
for(var i=0; i < quantos+1; i+=quebra) {
var valor = valores.substring(i, i+quebra);
document.getElementsByTagName('td').innerHTML+=valor+"<br>";
}

}
onload=mostra; // carregamento da função

