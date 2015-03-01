# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

paintIt = (element, backgroundColor, textColor) ->
#  console.log($(".ayaWord[data-selected-bg-color]"))
  for word in $(".ayaWord[data-selected-bg-color]")
    word.style.backgroundColor = $(word).data("original-bg-color")
  element.style.backgroundColor = backgroundColor
  if textColor?
    element.style.color = textColor


$ ->
  $(".ayaWord[data-selected-bg-color]").click (e) ->
    e.preventDefault()
    backgroundColor = $(this).data("selected-bg-color")
    textColor = $(this).data("text-color")
    paintIt(this, backgroundColor, textColor)

