#= require modules/gmap/Gmap__accents-map
#= require modules/gmap/Gmap__mount-gmap3

@Villeme = @Villeme or {}

Villeme.Gmap = ( ->


  # attributes
  _addressArray = []
  _markerUser = "/images/marker-user.png"
  _markerPlace = "/images/marker-place.png"
  _marker = "/images/marker-user.png"


  _config =
    autocompleteWidth: $("#address").outerWidth()



  _initialize = (options) ->
    activeSearch: _activeSearch() if options.activeSearch is true
    setCanvasSize: _setCanvasSize(options.canvasSize.width, options.canvasSize.height) if options.canvasSize isnt undefined
    unableButtonToSearchAddress: _buttonToSearchAddress.disable()
    showMapCanvasIfHidden: _showMapCanvasIfHidden()
    activeAutocompleteToSearchAddress: _autocompleteToSearchAddress.active()
    setAutocompleteWidth: _setAutocompleteWidth(options.autocompleteWidth)
    setMarker: _setMarker(options.markerType)
    return



  _setAutocompleteWidth = (width) ->
    _config.autocompleteWidth = width or $("#address").outerWidth()



  _showMapCanvasIfHidden = ->
    if $('#map').css('display') is 'none'
      $('#map').show()

    return



  _setCanvasSize = (width, height) ->
    if width is undefined  and height is undefined
      $('#map').width('100%').height(350)
    else if width is undefined
      $('#map').width('100%').height(height)
    else if height is undefined
      $('#map').width(width).height(350)
    else
      $('#map').width(width).height(height)

    return



  _setMarker = (type) ->
    switch type
      when 'user' then _marker = _markerUser
      when 'place'then _marker = _markerPlace
      else             _marker = _markerUser

    return


  _activeSearch = ->
    _buttonToGetLocation()
    _inputToGetLocationOnKeyup()
    _inputToGetLocation.init()
    return



  _buttonToGetLocation = ->
    $('.js-btn-geocoder-address-for-map').click ->
      address = $('#address').val()
      @getLocationFromAddress(address,
        draggable: true
      )
      return
    return


  _inputToGetLocationOnKeyup = ->
    $('#address').keyup ->
      address = this.value
      if address.length > 5
        _inputToGetLocation.searching()
        _autocompleteToSearchAddress.update(address)
        delay( ->
          Villeme.Gmap.getLocationFromAddress(address,
            draggable: true
          )
          return
        , 1100)

      return

    delay = do ->
      timer = 0
      (callback, ms) ->
        clearTimeout timer
        timer = setTimeout(callback, ms)
        return

    return



  _inputToGetLocation =
    init: ->
      _inputToGetLocation.normal()
      $("#address").focusout ->
        address = this.value.length
        if address <= 5
          _buttonToSearchAddress.disable()
          _inputToGetLocation.invalid()

        return
      return

    normal: ->
      $("#address").css("border-color", "#cccccc").parent().find(".Gmap-loadingResponse").text("").show()
      return

    searching: ->
      $("#address").css("border-color", "#cccccc").parent().find(".Gmap-loadingResponse").text("Searching...").show()
      return

    invalid: ->
      $("#address").css("border-color", "#A94442").parent().find(".Gmap-loadingResponse").text("Address not found").show()

      shakeInput = ((intShakes=3, intDistance=10, intDuration=500) ->
        $("#address").css 'position', 'relative'
        x = 1
        while x <= intShakes
          $("#address").animate({ left: intDistance * -1 }, intDuration / intShakes / 4).animate({ left: intDistance }, intDuration / intShakes / 2).animate { left: 0 }, intDuration / intShakes / 4
          x++
      )()

      return

    valid: ->
      $("#address").css("border-color", "#5fcf80").parent().find(".Gmap-loadingResponse").show().text("Found address!").fadeOut(1000)
      return




  _buttonToSearchAddress =
    disable: ->
      $(".js-btn-to-search-address").prop("disabled", true).addClass("disabled")
      return
    enable: ->
      $(".js-btn-to-search-address").prop("disabled", false).removeClass("disabled")
      return



  _autocompleteToSearchAddress =
    active: ->

      normalize = (term) ->
        ret = ''
        i = 0
        while i < term.length
          ret += Villeme.Gmap__accentsMap[term.charAt(i)] or term.charAt(i)
          i++
        ret

      $("#address").autocomplete
        source: (request, response) ->
          matcher = new RegExp($.ui.autocomplete.escapeRegex(request.term), 'i')
          response $.grep(_addressArray, (value) ->
            value = value.label or value.value or value
            matcher.test(value) or matcher.test(normalize(value))
          )
          return
        minLength: 3
        delay: 500
        appendTo: "#modal .modal-body"
        open: ->
          $(".ui-autocomplete").css
            "display": "absolute"
            "max-width": "auto"
            "width": _config.autocompleteWidth

          return
      return

    update: (address) ->
      $("#address").gmap3
        getlatlng:
          address: address
          callback: (results) ->
            if results.length > 0
              results = results.slice(0,5)
              _addressArray = (item.formatted_address for item in results)

            return

      return




  return {

    newMap: (latitude, longitude, options) ->
      _initialize(options)
      Villeme.Gmap__mountGmap3.mountMapFromLatLong(latitude, longitude, options)
      return



    getLocationFromAddress: (address, options) ->
      Villeme.Gmap__mountGmap3.mountMapFromAddress(address, options)
      return


    getAddressOfMarker: (map, markerDragged) ->
      $(map).gmap3 getaddress:
        latLng: markerDragged.getPosition()
        callback: (results) ->

          infowindow = $(this).gmap3(get: "infowindow")
          latLng = results[0].geometry.location
          infowindowMessage = (if results and results[0] then "Endereço encontrado!" else "Endereço não encontrado")
          address = (if results and results[0] then results and results[0].formatted_address else "no address")

          $("#address").val address

          if infowindow
            infowindow.open map, markerDragged
            infowindow.setContent infowindowMessage
          else
            $("#map").gmap3 infowindow:
              anchor: markerDragged
              options:
                content: infowindowMessage

          Villeme.Gmap.centralizeMapTo(latLng)

          return
      return


    getMarker: ->
      return _marker


    setAddressInputValid: ->
      _inputToGetLocation.valid()
      _buttonToSearchAddress.enable()
      return


    setAddressInputInvalid: ->
      _inputToGetLocation.invalid()
      _buttonToSearchAddress.disable()
      return


    centralizeMapTo: (latLng) ->
      $("#map").gmap3("get").panTo latLng
      return

  }

)()