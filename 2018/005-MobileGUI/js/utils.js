'use strict';

// Generated by CoffeeScript 2.0.3
var addCell, getField, hideCanvas, makeButton, makeDiv, makeInput, showCanvas;

hideCanvas = function hideCanvas() {
  var elem;
  elem = document.getElementById('myContainer');
  return elem.style.display = 'none';
};

showCanvas = function showCanvas() {
  var elem;
  elem = document.getElementById('myContainer');
  return elem.style.display = 'block';
};

makeDiv = function makeDiv(title) {
  var b;
  b = document.createElement('div');
  b.innerHTML = title;
  return b;
};

makeInput = function makeInput(title, value) {
  var b;
  b = document.createElement('input');
  b.id = title;
  b.value = value;
  return b;
};

makeButton = function makeButton(title, f) {
  var b;
  b = document.createElement('input');
  b.type = 'button';
  b.value = title;
  b.onclick = f;
  return b;
};

addCell = function addCell(tr, value) {
  var td;
  td = document.createElement("td");
  td.appendChild(value);
  return tr.appendChild(td);
};

getField = function getField(name) {
  var element;
  element = document.getElementById(name);
  if (element) {
    return element.value;
  } else {
    return null;
  }
};
//# sourceMappingURL=utils.js.map
