

  places = gon.places_array
  latLng = new google.maps.LatLng(gon.latitude, gon.longitude)


  $(document).ready ->

    $("#place").autocomplete
      minLength: 3
      source: places
      open: ->
        $("#ui-id-1").css("width", $("#place").width())

      response: (event, ui) ->
        if ui.content.length is 0
          $("#place").css("border-color","#5fcf80")
          $(".criar-lugar").show()

          Gmaps.newMap gon.current_user_latitude, gon.current_user_longitude,
            activeSearch: true
            canvasSize:
              width: '100%'
              height: 360
            draggable: true

          map = $(this).gmap3("get")

        else
          $("#place").css("border-color","#5fcf80")
        return

      focus: (event, ui) ->
        $("#place").val ui.item.label
        return


      select: (event, ui) ->
        $("#place").css("border-color","#5fcf80")
        $("#place").attr("data-original-title","O lugar foi selecionado!").tooltip("fixTitle").tooltip("show")
        $("#place-id").val ui.item.value
        return false
        return

    .data("ui-autocomplete")._renderItem = (ul, item) ->
      $("<li>").append("<a>" + item.label + "</a>").appendTo ul


    $(".has-tooltip").tooltip()

    $("#btn-criar-lugar").click ->
      if (!$("#btn-criar-lugar").hasClass("disabled"))

        $("#place").css("border-color","#5fcf80")

        # Ajusta o tamanho do mapa - hide to show bug
        map = $("#place-map").gmap3("get")
        google.maps.event.trigger(map, "resize")
        map.centralizeMapTo latLng

        # Faz o scroll até o mapa
        $('html, body').animate
          scrollTop: $("#place").parents(".form-group").offset().top - 90
        , 2000

        # coloca texto no marcador
        infowindow = $("#place-map").gmap3(get: "infowindow")
        content = "Oi! Busque o endereço me pegando e soltando"
        marker = $("#place-map").gmap3 get:
          name: "marker"
        $("#place-map").gmap3 infowindow:
          anchor: marker
          options:
            content: content

      return

    return
