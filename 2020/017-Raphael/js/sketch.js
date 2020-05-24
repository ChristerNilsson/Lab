// Generated by CoffeeScript 2.4.1
var Box, boxes, p, startup;

boxes = [];

//values that define the graphical properties of the page
p = null;

Box = class Box {
  constructor(x, y, w, h, name) {
    var Rect, Text;
    //deal with this individual box, position it and show a status based on color
    Rect = p.rect(x, y, w, h).attr({
      fill: '#aaa'
    });
    Text = p.text(x + w / 2, y + h / 2, name).attr({
      font: '40px Arial',
      fill: '#000'
    });
    
    //create the drag icon for this box
    // SIZE = h*0.5
    // Rect.resizer = p.rect x + w - SIZE, y + h - SIZE, SIZE, SIZE
    // 	.attr { fill: '#0ab', stroke: 'solid', opacity: 1}

    //define relations and functions for moving and positioning
    //move the boxes
    Rect.drag(this.move_drag, this.move_start, this.move_up);
    Rect.boxtext = Text;
  }

  
  //resize the boxes
  // Rect.resizer.drag @resize_drag, @resize_start, @resize_up
  // Rect.resizer.resizer = Rect
  // Rect.resizer.boxtext = Text

  //start, move, and up are the drag functions
  move_start() {
    //storing original coordinates
    this.ox = this.attr('x');
    this.oy = this.attr('y');
    this.attr({
      opacity: 0.5
    });
    
    //the resizer box
    // @resizer.ox = @resizer.attr 'x'
    // @resizer.oy = @resizer.attr 'y'
    // @resizer.attr {opacity: 0.5}

    //the box text
    this.boxtext.ox = this.attr('x') + this.attr('width') / 2;
    this.boxtext.oy = this.attr('y') + this.attr('height') / 2;
    return this.boxtext.attr({
      opacity: 0.5
    });
  }

  //visually change the box when it is being moved
  move_drag(dx, dy) {
    //move will be called with dx and dy
    this.attr({
      x: this.ox + dx,
      y: this.oy + dy
    });
    // @resizer.attr {x: @resizer.ox + dx, y: @resizer.oy + dy}
    return this.boxtext.attr({
      x: this.boxtext.ox + dx,
      y: this.boxtext.oy + dy
    });
  }

  //when the user lets go of the mouse button, reset the square's properties
  move_up() {
    //restoring the visual state
    this.attr({
      opacity: 1
    });
    // @resizer.attr {opacity: 1}
    return this.boxtext.attr({
      opacity: 1
    });
  }

};


// resize_start : ->
// 	#storing original coordinates
// 	@ox = @attr 'x'
// 	@oy = @attr 'y'

// 	#the resizer box
// 	@resizer.ow = @resizer.attr 'width'
// 	@resizer.oh = @resizer.attr 'height'

// 	#the box text
// 	@boxtext.ox = @resizer.attr('x') + @resizer.attr('width') / 2
// 	@boxtext.oy = @resizer.attr('y') + @resizer.attr('height') / 2

// resize_drag : (dx, dy) ->
// 	# move will be called with dx and dy
// 	@attr {x: @ox + dx, y: @oy + dy}
// 	@resizer.attr {width: @resizer.ow + dx, height: @resizer.oh + dy}
// 	@boxtext.attr {x: @boxtext.ox + (dx / 2), y: @boxtext.oy + (dy / 2)}

// resize_up : ->
// 	#here is where you would update the box's position externally
// 	#...
startup = function() {
  p = Raphael('canvasdiv', window.innerWidth, window.innerHeight);
  p.rect(0, 0, window.innerWidth, window.innerHeight).attr({
    fill: '#ff0'
  });
  boxes.push(new Box(100, 100, 100, 100, 'A003'));
  boxes.push(new Box(200, 200, 200, 200, 'B'));
  boxes.push(new Box(400, 400, 300, 300, 'C'));
  return boxes.push(new Box(700, 700, 400, 400, 'D'));
};

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic2tldGNoLmpzIiwic291cmNlUm9vdCI6Ii4uIiwic291cmNlcyI6WyJjb2ZmZWVcXHNrZXRjaC5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLElBQUEsR0FBQSxFQUFBLEtBQUEsRUFBQSxDQUFBLEVBQUE7O0FBQUEsS0FBQSxHQUFRLEdBQVI7OztBQUdBLENBQUEsR0FBSTs7QUFFRSxNQUFOLE1BQUEsSUFBQTtFQUNDLFdBQWMsQ0FBQyxDQUFELEVBQUcsQ0FBSCxFQUFLLENBQUwsRUFBTyxDQUFQLEVBQVMsSUFBVCxDQUFBO0FBR2IsUUFBQSxJQUFBLEVBQUEsSUFBQTs7SUFBQSxJQUFBLEdBQU8sQ0FBQyxDQUFDLElBQUYsQ0FBTyxDQUFQLEVBQVUsQ0FBVixFQUFhLENBQWIsRUFBZ0IsQ0FBaEIsQ0FDTixDQUFDLElBREssQ0FDQTtNQUFDLElBQUEsRUFBTTtJQUFQLENBREE7SUFHUCxJQUFBLEdBQU8sQ0FBQyxDQUFDLElBQUYsQ0FBTyxDQUFBLEdBQUksQ0FBQSxHQUFJLENBQWYsRUFBa0IsQ0FBQSxHQUFJLENBQUEsR0FBSSxDQUExQixFQUE2QixJQUE3QixDQUNOLENBQUMsSUFESyxDQUNBO01BQUMsSUFBQSxFQUFNLFlBQVA7TUFBcUIsSUFBQSxFQUFNO0lBQTNCLENBREEsRUFIUDs7Ozs7Ozs7O0lBYUEsSUFBSSxDQUFDLElBQUwsQ0FBVSxJQUFDLENBQUEsU0FBWCxFQUFzQixJQUFDLENBQUEsVUFBdkIsRUFBbUMsSUFBQyxDQUFBLE9BQXBDO0lBQ0EsSUFBSSxDQUFDLE9BQUwsR0FBZTtFQWpCRixDQUFkOzs7Ozs7Ozs7RUF5QkEsVUFBYSxDQUFBLENBQUEsRUFBQTs7SUFFWixJQUFDLENBQUEsRUFBRCxHQUFNLElBQUMsQ0FBQSxJQUFELENBQU0sR0FBTjtJQUNOLElBQUMsQ0FBQSxFQUFELEdBQU0sSUFBQyxDQUFBLElBQUQsQ0FBTSxHQUFOO0lBQ04sSUFBQyxDQUFBLElBQUQsQ0FBTTtNQUFDLE9BQUEsRUFBUztJQUFWLENBQU4sRUFGQTs7Ozs7Ozs7SUFVQSxJQUFDLENBQUEsT0FBTyxDQUFDLEVBQVQsR0FBYyxJQUFDLENBQUEsSUFBRCxDQUFNLEdBQU4sQ0FBQSxHQUFhLElBQUMsQ0FBQSxJQUFELENBQU0sT0FBTixDQUFBLEdBQWlCO0lBQzVDLElBQUMsQ0FBQSxPQUFPLENBQUMsRUFBVCxHQUFjLElBQUMsQ0FBQSxJQUFELENBQU0sR0FBTixDQUFBLEdBQWEsSUFBQyxDQUFBLElBQUQsQ0FBTSxRQUFOLENBQUEsR0FBa0I7V0FDN0MsSUFBQyxDQUFBLE9BQU8sQ0FBQyxJQUFULENBQWM7TUFBQyxPQUFBLEVBQVM7SUFBVixDQUFkO0VBZFksQ0F6QmI7OztFQTBDQSxTQUFZLENBQUMsRUFBRCxFQUFLLEVBQUwsQ0FBQSxFQUFBOztJQUVYLElBQUMsQ0FBQSxJQUFELENBQU07TUFBQyxDQUFBLEVBQUcsSUFBQyxDQUFBLEVBQUQsR0FBTSxFQUFWO01BQWMsQ0FBQSxFQUFHLElBQUMsQ0FBQSxFQUFELEdBQU07SUFBdkIsQ0FBTixFQUFBOztXQUdBLElBQUMsQ0FBQSxPQUFPLENBQUMsSUFBVCxDQUFjO01BQUMsQ0FBQSxFQUFHLElBQUMsQ0FBQSxPQUFPLENBQUMsRUFBVCxHQUFjLEVBQWxCO01BQXNCLENBQUEsRUFBRyxJQUFDLENBQUEsT0FBTyxDQUFDLEVBQVQsR0FBYztJQUF2QyxDQUFkO0VBTFcsQ0ExQ1o7OztFQWtEQSxPQUFVLENBQUEsQ0FBQSxFQUFBOztJQUVULElBQUMsQ0FBQSxJQUFELENBQU07TUFBQyxPQUFBLEVBQVM7SUFBVixDQUFOLEVBQUE7O1dBRUEsSUFBQyxDQUFBLE9BQU8sQ0FBQyxJQUFULENBQWM7TUFBQyxPQUFBLEVBQVM7SUFBVixDQUFkO0VBSlM7O0FBbkRYLEVBTEE7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7QUFxRkEsT0FBQSxHQUFVLFFBQUEsQ0FBQSxDQUFBO0VBQ1QsQ0FBQSxHQUFJLE9BQUEsQ0FBUSxXQUFSLEVBQXFCLE1BQU0sQ0FBQyxVQUE1QixFQUF3QyxNQUFNLENBQUMsV0FBL0M7RUFDSixDQUFDLENBQUMsSUFBRixDQUFPLENBQVAsRUFBVSxDQUFWLEVBQWEsTUFBTSxDQUFDLFVBQXBCLEVBQWdDLE1BQU0sQ0FBQyxXQUF2QyxDQUNDLENBQUMsSUFERixDQUNPO0lBQUMsSUFBQSxFQUFNO0VBQVAsQ0FEUDtFQUVBLEtBQUssQ0FBQyxJQUFOLENBQVcsSUFBSSxHQUFKLENBQVEsR0FBUixFQUFhLEdBQWIsRUFBa0IsR0FBbEIsRUFBdUIsR0FBdkIsRUFBNEIsTUFBNUIsQ0FBWDtFQUNBLEtBQUssQ0FBQyxJQUFOLENBQVcsSUFBSSxHQUFKLENBQVEsR0FBUixFQUFhLEdBQWIsRUFBa0IsR0FBbEIsRUFBdUIsR0FBdkIsRUFBNEIsR0FBNUIsQ0FBWDtFQUNBLEtBQUssQ0FBQyxJQUFOLENBQVcsSUFBSSxHQUFKLENBQVEsR0FBUixFQUFhLEdBQWIsRUFBa0IsR0FBbEIsRUFBdUIsR0FBdkIsRUFBNEIsR0FBNUIsQ0FBWDtTQUNBLEtBQUssQ0FBQyxJQUFOLENBQVcsSUFBSSxHQUFKLENBQVEsR0FBUixFQUFhLEdBQWIsRUFBa0IsR0FBbEIsRUFBdUIsR0FBdkIsRUFBNEIsR0FBNUIsQ0FBWDtBQVBTIiwic291cmNlc0NvbnRlbnQiOlsiYm94ZXMgPSBbXVxyXG5cclxuI3ZhbHVlcyB0aGF0IGRlZmluZSB0aGUgZ3JhcGhpY2FsIHByb3BlcnRpZXMgb2YgdGhlIHBhZ2VcclxucCA9IG51bGwgXHJcblxyXG5jbGFzcyBCb3ggXHJcblx0Y29uc3RydWN0b3IgOiAoeCx5LHcsaCxuYW1lKSAtPlxyXG5cclxuXHRcdCNkZWFsIHdpdGggdGhpcyBpbmRpdmlkdWFsIGJveCwgcG9zaXRpb24gaXQgYW5kIHNob3cgYSBzdGF0dXMgYmFzZWQgb24gY29sb3JcclxuXHRcdFJlY3QgPSBwLnJlY3QgeCwgeSwgdywgaFxyXG5cdFx0XHQuYXR0ciB7ZmlsbDogJyNhYWEnfVxyXG5cclxuXHRcdFRleHQgPSBwLnRleHQgeCArIHcgLyAyLCB5ICsgaCAvIDIsIG5hbWVcclxuXHRcdFx0LmF0dHIge2ZvbnQ6ICc0MHB4IEFyaWFsJywgZmlsbDogJyMwMDAnfVxyXG5cdFx0XHRcdFxyXG5cdFx0I2NyZWF0ZSB0aGUgZHJhZyBpY29uIGZvciB0aGlzIGJveFxyXG5cdFx0IyBTSVpFID0gaCowLjVcclxuXHRcdCMgUmVjdC5yZXNpemVyID0gcC5yZWN0IHggKyB3IC0gU0laRSwgeSArIGggLSBTSVpFLCBTSVpFLCBTSVpFXHJcblx0XHQjIFx0LmF0dHIgeyBmaWxsOiAnIzBhYicsIHN0cm9rZTogJ3NvbGlkJywgb3BhY2l0eTogMX1cclxuXHRcdFxyXG5cdFx0I2RlZmluZSByZWxhdGlvbnMgYW5kIGZ1bmN0aW9ucyBmb3IgbW92aW5nIGFuZCBwb3NpdGlvbmluZ1xyXG5cdFx0I21vdmUgdGhlIGJveGVzXHJcblx0XHRSZWN0LmRyYWcgQG1vdmVfZHJhZywgQG1vdmVfc3RhcnQsIEBtb3ZlX3VwXHJcblx0XHRSZWN0LmJveHRleHQgPSBUZXh0XHJcblx0XHRcclxuXHRcdCNyZXNpemUgdGhlIGJveGVzXHJcblx0XHQjIFJlY3QucmVzaXplci5kcmFnIEByZXNpemVfZHJhZywgQHJlc2l6ZV9zdGFydCwgQHJlc2l6ZV91cFxyXG5cdFx0IyBSZWN0LnJlc2l6ZXIucmVzaXplciA9IFJlY3RcclxuXHRcdCMgUmVjdC5yZXNpemVyLmJveHRleHQgPSBUZXh0XHJcblxyXG5cdCNzdGFydCwgbW92ZSwgYW5kIHVwIGFyZSB0aGUgZHJhZyBmdW5jdGlvbnNcclxuXHRtb3ZlX3N0YXJ0IDogLT5cclxuXHRcdCNzdG9yaW5nIG9yaWdpbmFsIGNvb3JkaW5hdGVzXHJcblx0XHRAb3ggPSBAYXR0ciAneCdcclxuXHRcdEBveSA9IEBhdHRyICd5J1xyXG5cdFx0QGF0dHIge29wYWNpdHk6IDAuNX1cclxuXHRcdFxyXG5cdFx0I3RoZSByZXNpemVyIGJveFxyXG5cdFx0IyBAcmVzaXplci5veCA9IEByZXNpemVyLmF0dHIgJ3gnXHJcblx0XHQjIEByZXNpemVyLm95ID0gQHJlc2l6ZXIuYXR0ciAneSdcclxuXHRcdCMgQHJlc2l6ZXIuYXR0ciB7b3BhY2l0eTogMC41fVxyXG5cdFx0XHJcblx0XHQjdGhlIGJveCB0ZXh0XHJcblx0XHRAYm94dGV4dC5veCA9IEBhdHRyKCd4JykgKyBAYXR0cignd2lkdGgnKSAvIDJcclxuXHRcdEBib3h0ZXh0Lm95ID0gQGF0dHIoJ3knKSArIEBhdHRyKCdoZWlnaHQnKSAvIDJcclxuXHRcdEBib3h0ZXh0LmF0dHIge29wYWNpdHk6IDAuNX1cclxuXHJcblx0I3Zpc3VhbGx5IGNoYW5nZSB0aGUgYm94IHdoZW4gaXQgaXMgYmVpbmcgbW92ZWRcclxuXHRtb3ZlX2RyYWcgOiAoZHgsIGR5KSAtPlxyXG5cdFx0I21vdmUgd2lsbCBiZSBjYWxsZWQgd2l0aCBkeCBhbmQgZHlcclxuXHRcdEBhdHRyIHt4OiBAb3ggKyBkeCwgeTogQG95ICsgZHl9XHJcblxyXG5cdFx0IyBAcmVzaXplci5hdHRyIHt4OiBAcmVzaXplci5veCArIGR4LCB5OiBAcmVzaXplci5veSArIGR5fVxyXG5cdFx0QGJveHRleHQuYXR0ciB7eDogQGJveHRleHQub3ggKyBkeCwgeTogQGJveHRleHQub3kgKyBkeX1cclxuXHJcblx0I3doZW4gdGhlIHVzZXIgbGV0cyBnbyBvZiB0aGUgbW91c2UgYnV0dG9uLCByZXNldCB0aGUgc3F1YXJlJ3MgcHJvcGVydGllc1xyXG5cdG1vdmVfdXAgOiAtPlxyXG5cdFx0I3Jlc3RvcmluZyB0aGUgdmlzdWFsIHN0YXRlXHJcblx0XHRAYXR0ciB7b3BhY2l0eTogMX1cclxuXHRcdCMgQHJlc2l6ZXIuYXR0ciB7b3BhY2l0eTogMX1cclxuXHRcdEBib3h0ZXh0LmF0dHIge29wYWNpdHk6IDF9XHJcblx0XHRcclxuXHQjIHJlc2l6ZV9zdGFydCA6IC0+XHJcblx0IyBcdCNzdG9yaW5nIG9yaWdpbmFsIGNvb3JkaW5hdGVzXHJcblx0IyBcdEBveCA9IEBhdHRyICd4J1xyXG5cdCMgXHRAb3kgPSBAYXR0ciAneSdcclxuXHRcdFxyXG5cdCMgXHQjdGhlIHJlc2l6ZXIgYm94XHJcblx0IyBcdEByZXNpemVyLm93ID0gQHJlc2l6ZXIuYXR0ciAnd2lkdGgnXHJcblx0IyBcdEByZXNpemVyLm9oID0gQHJlc2l6ZXIuYXR0ciAnaGVpZ2h0J1xyXG5cdFx0XHJcblx0IyBcdCN0aGUgYm94IHRleHRcclxuXHQjIFx0QGJveHRleHQub3ggPSBAcmVzaXplci5hdHRyKCd4JykgKyBAcmVzaXplci5hdHRyKCd3aWR0aCcpIC8gMlxyXG5cdCMgXHRAYm94dGV4dC5veSA9IEByZXNpemVyLmF0dHIoJ3knKSArIEByZXNpemVyLmF0dHIoJ2hlaWdodCcpIC8gMlxyXG5cclxuXHQjIHJlc2l6ZV9kcmFnIDogKGR4LCBkeSkgLT5cclxuXHQjIFx0IyBtb3ZlIHdpbGwgYmUgY2FsbGVkIHdpdGggZHggYW5kIGR5XHJcblx0IyBcdEBhdHRyIHt4OiBAb3ggKyBkeCwgeTogQG95ICsgZHl9XHJcblx0IyBcdEByZXNpemVyLmF0dHIge3dpZHRoOiBAcmVzaXplci5vdyArIGR4LCBoZWlnaHQ6IEByZXNpemVyLm9oICsgZHl9XHJcblx0IyBcdEBib3h0ZXh0LmF0dHIge3g6IEBib3h0ZXh0Lm94ICsgKGR4IC8gMiksIHk6IEBib3h0ZXh0Lm95ICsgKGR5IC8gMil9XHJcblxyXG5cdCMgcmVzaXplX3VwIDogLT5cclxuXHQjIFx0I2hlcmUgaXMgd2hlcmUgeW91IHdvdWxkIHVwZGF0ZSB0aGUgYm94J3MgcG9zaXRpb24gZXh0ZXJuYWxseVxyXG5cdCMgXHQjLi4uXHJcblxyXG5zdGFydHVwID0gLT5cclxuXHRwID0gUmFwaGFlbCAnY2FudmFzZGl2Jywgd2luZG93LmlubmVyV2lkdGgsIHdpbmRvdy5pbm5lckhlaWdodFxyXG5cdHAucmVjdCAwLCAwLCB3aW5kb3cuaW5uZXJXaWR0aCwgd2luZG93LmlubmVySGVpZ2h0XHJcblx0XHQuYXR0ciB7ZmlsbDogJyNmZjAnfVxyXG5cdGJveGVzLnB1c2ggbmV3IEJveCAxMDAsIDEwMCwgMTAwLCAxMDAsICdBMDAzJ1xyXG5cdGJveGVzLnB1c2ggbmV3IEJveCAyMDAsIDIwMCwgMjAwLCAyMDAsICdCJ1xyXG5cdGJveGVzLnB1c2ggbmV3IEJveCA0MDAsIDQwMCwgMzAwLCAzMDAsICdDJ1xyXG5cdGJveGVzLnB1c2ggbmV3IEJveCA3MDAsIDcwMCwgNDAwLCA0MDAsICdEJ1xyXG4iXX0=
//# sourceURL=c:\Lab\2020\017-Raphael\coffee\sketch.coffee