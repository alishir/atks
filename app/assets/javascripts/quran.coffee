# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

paintIt = (element, backgroundColor, textColor) ->
  console.log($(".ayaWord[data-selected-background-color]"))
  for word in $(".ayaWord[data-selected-background-color]")
    word.style.backgroundColor = $(word).data("original-background-color")
  element.style.backgroundColor = backgroundColor
  if textColor?
    element.style.color = textColor


$ ->
  $(".ayaWord[data-selected-background-color]").click (e) ->
    e.preventDefault()
    backgroundColor = $(this).data("selected-background-color")
    textColor = $(this).data("text-color")
    paintIt(this, backgroundColor, textColor)

