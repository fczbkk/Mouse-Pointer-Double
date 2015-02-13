# create cursor element
elm = document.body.appendChild document.createElement 'div'
elm.className = 'mousePointerDouble'

# move cursor with the mouse
document.body.addEventListener 'mousemove', (event) ->
  elm.style.left = "#{event.pageX}px"
  elm.style.top = "#{event.pageY}px"
