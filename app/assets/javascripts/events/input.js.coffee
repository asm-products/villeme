class @Input

  @count = 0

  constructor: (@input) ->
    @borderDefault = "rgb(204, 204, 204)"
    @borderGreen = "green"
    Input.count += 1
    console.log "Input Transition created! We have" + Input.count

  addFocus: ->
    @input.css "border-color": @borderGreen
    console.log "Input focused!"

  removeFocus: ->
    @input.css "border-color": @borderDefault
    console.log "Input unfocused!"



