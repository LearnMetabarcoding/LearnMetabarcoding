$(document).ready(function() {
    //
    //
    $(".toggle > *").hide();
    $(".toggle .admonition-title").show();
    $(".toggle .admonition-title").click(function() {
        $(this).parent().children().not(".admonition-title").toggle(400);
        $(this).parent().children(".admonition-title").toggleClass("open");
    })
});

$(document).ready(function() {
    //
    //
    $(".togglegreen > *").hide();
    $(".togglegreen .admonition-title").show();
    $(".togglegreen .admonition-title").click(function() {
        $(this).parent().children().not(".admonition-title").toggle(400);
        $(this).parent().children(".admonition-title").toggleClass("open");
    })
});