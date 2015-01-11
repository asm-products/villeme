class @Input

  @count = 0


  constructor: (@input) ->
    @borderDefault = "rgb(204, 204, 204)"
    @borderGreen = "green"
    @borderRed = "red"

    Input.count += 1

    console.log "Input Transition created! We have" + Input.count

  addGreenFocus: ->
    @input.css "border-color": @borderGreen
    console.log "Input focused!"

  addRedFocus: ->
    @input.css "border-color": @borderRed
    console.log "Input alerted!"

  removeFocus: ->
    @input.css "border-color": @borderDefault
    console.log "Input unfocused!"

  validSize: ->
    if @inputLength() > @inputMaxLengthValidate() or @inputLength() < @inputMinLengthValidate()
      @inputInvalided()
    else if @inputLength() is 0
      @removeFocus()
    else
      @inputValided()


  inputInvalided: ->
    @addRedFocus()
    @input.parents().next(".tip").text(@input.data("tip"))

    console.log "Input Invalided!"

  inputValided: ->
    @addGreenFocus()
    @input.parents().next(".tip").text("")

    console.log "Input Valided!"

  inputLength: ->
    @input.val().length

  inputMaxLengthValidate: ->
    @input.data("max-length")

  inputMinLengthValidate: ->
    @input.data("min-length")