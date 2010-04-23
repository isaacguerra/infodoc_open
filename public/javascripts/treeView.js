// second example
	$("#navegacao_arquivos").treeview({
			toggle: function() {
				console.log("%s was toggled.", $(this).find(">span").text());
			},
			animated: "fast",
		collapsed: true,
		unique: true,
		persist: "cookie",
		toggle: function() {
			window.console && console.log("%o was toggled", this);
		}
		});
	

