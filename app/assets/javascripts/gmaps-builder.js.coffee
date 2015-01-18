class @Gmaps

  @markerUser = "/images/marker-user.png"
  @markerPlace = "/images/marker-place.png"

  @newMap: (@latitude, @longitude, options) ->

    Gmaps.setInitialAttributes(options)

    style = [{"featureType":"road","elementType":"geometry","stylers":[{"lightness":100},{"visibility":"simplified"}]},{"featureType":"water","elementType":"geometry","stylers":[{"visibility":"on"},{"color":"#d6defa"}]},{"featureType":"poi.business","stylers":[{"visibility":"off"}]},{"featureType":"poi","elementType":"geometry.fill","stylers":[{"color":"#dff5e6"}]},{"featureType":"road","elementType":"geometry.fill","stylers":[{"color":"#D1D1B8"}]},{"featureType":"landscape","elementType":"geometry.fill","stylers":[{"color":"#ffffff"}]}]

    $("#map").gmap3
      map:
        options:
          center: [
            @latitude
            @longitude
          ]
          zoom: options.zoom or 13
          mapTypeId: google.maps.MapTypeId.ROADMAP
          mapTypeControl: false
          mapTypeControlOptions:
            style: google.maps.MapTypeControlStyle.DROPDOWN_MENU

          navigationControl: false
          streetViewControl: false
          scrollwheel: options.scrollwheel or false
          scaleControl: options.scaleControl or false
          zoomControl: options.zoomControl or false
          zoomControlOptions:
            style: google.maps.ZoomControlStyle.SMALL,
            position: google.maps.ControlPosition.RIGHT_TOP
          styles: style

      marker:
        latLng: [
          @latitude
          @longitude
        ]
        options:
          draggable: options.draggable or false
          icon: options.marker or Gmaps.markerUser

        events:
          dragend: (marker) ->
            Gmaps.getAddressOfMarker(this, marker)
            return
    return


  @getLocationFrom: (address, options) ->
    $("#map").gmap3
      clear:
        name: "marker"

      getlatlng:
        address: address
        callback: (results) ->
          unless results
            $("#address").css("border-color", "#A94442")
            alert "Endereço não encontrado. Tente buscar outro."
          else
            $("#address").css("border-color", "#5fcf80")
            $(this).gmap3 marker:
              latLng: results[0].geometry.location
              options:
                draggable: options.draggable or false
                icon: options.marker or Gmaps.markerUser

              events:
                dragend: (marker) ->
                  Gmaps.getAddressOfMarker(this, marker)
                  return

            map = $(this).gmap3("get")
            latLng = results[0].geometry.location
            map.panTo latLng

          return

    return



  @showMapCanvasIfHidden: ->
    if $('#map').css('display') is 'none'
      $('#map').show()

    return



  @setCanvasSize: (width, height) ->
    if width is undefined  and height is undefined
      $('#map').width('100%').height(350)
    else if width is undefined
      $('#map').width('100%').height(height)
    else if height is undefined
      $('#map').width(width).height(350)
    else
      $('#map').width(width).height(height)



  @activeSearch: ->
    Gmaps.buttonToGetLocation()
    Gmaps.inputToGetLocationOnKeyup()
    return



  @buttonToGetLocation: ->
    $('.js-btn-geocoder-address-for-map').click ->
      address = $('#address').val()
      Gmaps.getLocationFrom(address,
        draggable: true
      )
      return
    return


  @inputToGetLocationOnKeyup: ->
    $('#address').keyup ->
      address = this.value
      if address.length > 5
        delay( ->
          Gmaps.getLocationFrom(address,
            draggable: true
          )
          return
        , 900)

      return

    delay = (->
      timer = 0
      (callback, ms) ->
        clearTimeout timer
        timer = setTimeout(callback, ms)
        return
    )()

    return



  @getAddressOfMarker: (map, marker) ->
    $(map).gmap3 getaddress:
      latLng: marker.getPosition()
      callback: (results) ->

        $map              = $(this).gmap3("get")
        infowindow        = $(this).gmap3(get: "infowindow")
        latLng            = results[0].geometry.location
        infowindowMessage = (if results and results[0] then "Endereço encontrado!" else "Endereço não encontrado")
        address           = (if results and results[0] then results and results[0].formatted_address else "no address")

        $("#address").val address

        if infowindow
          infowindow.open $map, marker
          infowindow.setContent infowindowMessage
        else
          $(map).gmap3 infowindow:
            anchor: marker
            options:
              content: infowindowMessage

        $map.panTo latLng

        return
    return



  @setInitialAttributes: (options) ->
    Gmaps.activeSearch() if options.activeSearch is true
    Gmaps.setCanvasSize(options.canvasSize.width, options.canvasSize.height) if options.canvasSize isnt undefined
    Gmaps.showMapCanvasIfHidden()
    return