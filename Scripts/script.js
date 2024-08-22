
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
    var Date=document.getElementById("Date");
    Date.innerHTML="Date: 8/19/2024";
    var linkedin=document.getElementById("img_Linkedin");
    var mail=document.getElementById("img_Mail");
    var phone=document.getElementById("img_Phone");
    linkedin.alt="Picture of Linkedin logo.";
    mail.alt="Picture of Mail";
    phone.alt="Picture of a phone";
    
};

    window.onscroll=function(){ 
       var image=document.getElementById("trevor_Image");
    var scroll=window.scrollY;
    image.style.rotate=scroll*2+"deg";
    };