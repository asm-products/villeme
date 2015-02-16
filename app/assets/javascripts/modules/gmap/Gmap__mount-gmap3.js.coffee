@Villeme = @Villeme or {}

Villeme.Gmap__mountGmap3 = ( ->


  return {

    mountMapFromLatLong: (latitude, longitude, options) ->

      style = [{"featureType":"road","elementType":"geometry","stylers":[{"lightness":100},{"visibility":"simplified"}]},{"featureType":"water","elementType":"geometry","stylers":[{"visibility":"on"},{"color":"#d6defa"}]},{"featureType":"poi.business","stylers":[{"visibility":"off"}]},{"featureType":"poi","elementType":"geometry.fill","stylers":[{"color":"#dff5e6"}]},{"featureType":"road","elementType":"geometry.fill","stylers":[{"color":"#D1D1B8"}]},{"featureType":"landscape","elementType":"geometry.fill","stylers":[{"color":"#ffffff"}]}]

      $("#map").gmap3
        map:
          options:
            center: [
              latitude
              longitude
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
            latitude
            longitude
          ]
          options:
            draggable: options.draggable or false
            icon: options.marker or Villeme.Gmap.getMarker()

          events:
            dragend: (marker) ->
              Villeme.Gmap.getAddressOfMarker(this, marker)
              return

      return



    mountMapFromAddress: (address, options) ->
      $("#map").gmap3
        clear:
          name: "marker"

        getlatlng:
          address: address
          callback: (results) ->
            unless results
              Villeme.Gmap.setAddressInputInvalid()
            else
              Villeme.Gmap.setAddressInputValid()

              $map = $(this).gmap3("get")

              $(this).gmap3 marker:
                latLng: results[0].geometry.location
                options:
                  draggable: options.draggable or false
                  icon: options.marker or Villeme.Gmap.getMarker()
                events:
                  dragend: (marker) ->
                    Villeme.Gmap.getAddressOfMarker($map, marker)
                    return

              latLng = results[0].geometry.location
              $map.panTo latLng

            return

      return

  }

  return

)()