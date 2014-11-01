
gmaps_builder_user = ->

  style = [{"featureType":"road","elementType":"geometry","stylers":[{"lightness":100},{"visibility":"simplified"}]},{"featureType":"water","elementType":"geometry","stylers":[{"visibility":"on"},{"color":"#d6defa"}]},{"featureType":"poi.business","stylers":[{"visibility":"off"}]},{"featureType":"poi","elementType":"geometry.fill","stylers":[{"color":"#dff5e6"}]},{"featureType":"road","elementType":"geometry.fill","stylers":[{"color":"#D1D1B8"}]},{"featureType":"landscape","elementType":"geometry.fill","stylers":[{"color":"#ffffff"}]}]


  $("#user-map").gmap3
    map:
      options:
        center: [
          gon.latitude
          gon.longitude
        ]
        zoom: 13
        mapTypeId: google.maps.MapTypeId.ROADMAP
        mapTypeControl: false
        mapTypeControlOptions:
          style: google.maps.MapTypeControlStyle.DROPDOWN_MENU

        navigationControl: false
        scrollwheel: true
        streetViewControl: false
        zoomControl: false
        styles: style 


    marker:
      values:
        gon.events_local_formatted
        

      options: 
        draggable: false

      events:
        mouseover: (marker, event, context) ->
          $(".infobox").fadeIn("fast").text(context.data.address)
          return

        mouseout: ->
          $(".infobox").fadeOut("fast")
          return

        click: (marker, event, context) ->
          $.ajax(
            url: context.data.link + ".json"
          ).done (data) ->
            $("#load-event .clear").html("")
            $("#load-event .load-title").html data.event.name
            $("#load-event .load-image img").attr("src", data.image)
            $("#load-event .load-body > p").html data.event.description
            jQuery.each data.event_categories, (i, val) ->
              $("#load-event .load-categories").append("<div class='item " + val.name.toLowerCase() + "'>" + val.name + "</div>")
              return

            $("#load-event").fadeIn()
            
            return

          return


  return



$(document).on 'ready page:done', ->


  setTimeout gmaps_builder_user 850

  map = $(this).gmap3("get")

  $("#infobox-wrapper").append("<div class='infobox'></div>")

  # função para limpar infoboxes do mapa
  gmap_clear_markers = ->
    $(".infobox").each ->
      $(this).remove()
      return

    return
  
  # Botao para chamar o endereço no mapa
  $("#botao").click ->
    endereco = $("#endereco").val()
    buscaLatlong endereco
    return


  return