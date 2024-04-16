
//durham.footer_text = "&copy; Advanced Research Computing, Durham University, CC-BY";
cpptheme = new Theme(
    (str => str.substring(0, str.lastIndexOf("/")))(document.currentScript.src),
    '$BASEURL/style.css',
    {
	thumb: function () {
	    return '.thumb[\n.thumbtxt[\n' + this +'\n]\n]';
	}
    });
