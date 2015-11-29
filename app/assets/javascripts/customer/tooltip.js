$(function(){
    $("div.tooltip").css("opacity","0.9").hide()
    $("a[href *= 'java'").hover(function(){
        $("div.tooltip").fadeIn().css({
            "top":$(this).offset().top-20+"px",
            "left":$(this).offset().left+$(this).width()+"px"
        });
    })
})