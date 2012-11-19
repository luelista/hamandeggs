# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
    $(".examtypesel input").change ->
        $(".examtypesel a").removeClass("btn-primary");
        $(this).closest("a").addClass("btn-primary") if $(this).is(":checked")
    
