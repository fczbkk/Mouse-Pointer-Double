var cursorElm = document.createElement('div');
cursorElm.className = 'mouseDoublePointer';
document.body.appendChild(cursorElm);

document.body.addEventListener('mousemove', function (e) {
  cursorElm.style.left = (e.pageX + 1) + 'px';
  cursorElm.style.top = (e.pageY + 1) + 'px';
});