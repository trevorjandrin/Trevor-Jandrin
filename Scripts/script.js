
window.onload=function()
{
    
    var drop_content=document.getElementsByClassName("drop_content");
    var dropdown=document.getElementsByClassName("dropdown");
    
    for(var i=0; i<dropdown.length;i++)
    {
        var width=dropdown[i].clientWidth;
        width=width+"px";
        drop_content[i].style.minWidth=width;
    }
};

    window.onscroll=function(){ 
       var image=document.getElementById("trevor_Image");
    var scroll=window.scrollY;
    image.style.rotate=scroll*2+"deg";
    };
function display_none()
{
var navigation=document.getElementsByTagName("nav");
navigation[0].style.display="none";
var footer=document.getElementsByTagName("footer");
footer[0].style.display="block";
}
function display_nav()
{
var navigation=document.getElementsByTagName("nav");
var footer=document.getElementsByTagName("footer");
footer[0].style.display="none";
navigation[0].style.display="block";
}