function iframeAutoHeight(quem,heu){
    //by Micox - elmicox.blogspot.com - elmicox.com - webly.com.br  
    if(navigator.appName.indexOf("Internet Explorer")>-1){ //ie sucks
        var func_temp = function(){
            var val_temp = quem.contentWindow.document.body.scrollHeight + 5
            quem.style.height = val_temp + "px";
            alert(val_temp)        }
        setTimeout(function() { func_temp() },100) //ie sucks        
    }else{
        var val = quem.contentWindow.document.body.parentNode.offsetHeight + 5
        quem.style.height= val + "px";
    }    
}
