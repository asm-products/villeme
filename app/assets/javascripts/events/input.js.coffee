class @Input

  constructor: (@input) ->
    @borderDefault = "rgb(204, 204, 204)"
    @borderGreen = "green"
    console.log "Input Transition created!"

  addFocus: ->
    @input.css "border-color": @borderGreen
    console.log "Input focused!"

  removeFocus: ->
    @input.css "border-color": @borderDefault
    console.log "Input unfocused!"



