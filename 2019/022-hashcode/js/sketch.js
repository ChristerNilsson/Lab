// Generated by CoffeeScript 2.3.2
var arr, draw, marker, mousePressed, n, setup;

n = 5;

arr = "#111 #222 #333 #444 #555 #666 #777 #888 #999 #aaa #bbb #ccc #ddd #eee".split(' ');

marker = -1;

setup = function() {
  return createCanvas(n * 250 + 1, n * 200 + 1);
};

draw = function() {
  var c1, c2, clr, i, index, j, k, len, r1, r2, results, slice;
  results = [];
  for (index = k = 0, len = slices.length; k < len; index = ++k) {
    slice = slices[index];
    sw(1);
    [r1, c1, r2, c2, clr] = slice;
    sc(clr < 8 ? 1 : 0);
    if (marker === index) {
      
      //print marker,index
      stroke(255, 0, 0);
    }
    fill(arr[clr]);
    rect(n * c1, n * r1, n * c2 - n * c1 + n, n * r2 - n * r1 + n);
    stroke(0, 255, 0);
    sw(2);
    results.push((function() {
      var l, len1, ref, results1;
      ref = range(r1, r2 + 1);
      results1 = [];
      for (l = 0, len1 = ref.length; l < len1; l++) {
        j = ref[l];
        results1.push((function() {
          var len2, m, ref1, results2;
          ref1 = range(c1, c2 + 1);
          results2 = [];
          for (m = 0, len2 = ref1.length; m < len2; m++) {
            i = ref1[m];
            results2.push(point(n * (i + 0.5), n * (j + 0.5)));
          }
          return results2;
        })());
      }
      return results1;
    })());
  }
  return results;
};

mousePressed = function() {
  var c1, c2, clr, index, k, len, r1, r2, results, slice;
  results = [];
  for (index = k = 0, len = slices.length; k < len; index = ++k) {
    slice = slices[index];
    [r1, c1, r2, c2, clr] = slice;
    if ((n * c1 - 1 <= mouseX && mouseX <= n * c2 + 1) && (n * r1 - 1 <= mouseY && mouseY <= n * r2 + 1)) {
      marker = index;
      results.push(print(slice));
    } else {
      results.push(void 0);
    }
  }
  return results;
};

// setup = ->
// 	createCanvas n*1000+1,n*1000+1	

// draw = ->
// 	for slice in slices
// 		sw 1
// 		[r1,c1,r2,c2,index] = slice	
// 		sc if index<8 then 1 else 0
// 		fill arr[index]
// 		rect n*c1,n*r1,n*c2-n*c1+n,n*r2-n*r1+n
// 		stroke 0,255,0
// 		sw 2
// 		for j in range r1,r2+1
// 			for i in range c1,c2+1
// 				point n*(i+0.5),n*(j+0.5)

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic2tldGNoLmpzIiwic291cmNlUm9vdCI6Ii4uIiwic291cmNlcyI6WyJjb2ZmZWVcXHNrZXRjaC5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLElBQUEsR0FBQSxFQUFBLElBQUEsRUFBQSxNQUFBLEVBQUEsWUFBQSxFQUFBLENBQUEsRUFBQTs7QUFBQSxDQUFBLEdBQUk7O0FBQ0osR0FBQSxHQUFNLHVFQUF1RSxDQUFDLEtBQXhFLENBQThFLEdBQTlFOztBQUNOLE1BQUEsR0FBUyxDQUFDOztBQUVWLEtBQUEsR0FBUSxRQUFBLENBQUEsQ0FBQTtTQUNQLFlBQUEsQ0FBYSxDQUFBLEdBQUUsR0FBRixHQUFNLENBQW5CLEVBQXFCLENBQUEsR0FBRSxHQUFGLEdBQU0sQ0FBM0I7QUFETzs7QUFHUixJQUFBLEdBQU8sUUFBQSxDQUFBLENBQUE7QUFDTixNQUFBLEVBQUEsRUFBQSxFQUFBLEVBQUEsR0FBQSxFQUFBLENBQUEsRUFBQSxLQUFBLEVBQUEsQ0FBQSxFQUFBLENBQUEsRUFBQSxHQUFBLEVBQUEsRUFBQSxFQUFBLEVBQUEsRUFBQSxPQUFBLEVBQUE7QUFBQTtFQUFBLEtBQUEsd0RBQUE7O0lBQ0MsRUFBQSxDQUFHLENBQUg7SUFDQSxDQUFDLEVBQUQsRUFBSSxFQUFKLEVBQU8sRUFBUCxFQUFVLEVBQVYsRUFBYSxHQUFiLENBQUEsR0FBb0I7SUFDcEIsRUFBQSxDQUFNLEdBQUEsR0FBSSxDQUFQLEdBQWMsQ0FBZCxHQUFxQixDQUF4QjtJQUNBLElBQUcsTUFBQSxLQUFVLEtBQWI7OztNQUVDLE1BQUEsQ0FBTyxHQUFQLEVBQVcsQ0FBWCxFQUFhLENBQWIsRUFGRDs7SUFHQSxJQUFBLENBQUssR0FBSSxDQUFBLEdBQUEsQ0FBVDtJQUNBLElBQUEsQ0FBSyxDQUFBLEdBQUUsRUFBUCxFQUFVLENBQUEsR0FBRSxFQUFaLEVBQWUsQ0FBQSxHQUFFLEVBQUYsR0FBSyxDQUFBLEdBQUUsRUFBUCxHQUFVLENBQXpCLEVBQTJCLENBQUEsR0FBRSxFQUFGLEdBQUssQ0FBQSxHQUFFLEVBQVAsR0FBVSxDQUFyQztJQUVBLE1BQUEsQ0FBTyxDQUFQLEVBQVMsR0FBVCxFQUFhLENBQWI7SUFDQSxFQUFBLENBQUcsQ0FBSDs7O0FBQ0E7QUFBQTtNQUFBLEtBQUEsdUNBQUE7Ozs7QUFDQztBQUFBO1VBQUEsS0FBQSx3Q0FBQTs7MEJBQ0MsS0FBQSxDQUFNLENBQUEsR0FBRSxDQUFDLENBQUEsR0FBRSxHQUFILENBQVIsRUFBZ0IsQ0FBQSxHQUFFLENBQUMsQ0FBQSxHQUFFLEdBQUgsQ0FBbEI7VUFERCxDQUFBOzs7TUFERCxDQUFBOzs7RUFaRCxDQUFBOztBQURNOztBQWlCUCxZQUFBLEdBQWUsUUFBQSxDQUFBLENBQUE7QUFDZCxNQUFBLEVBQUEsRUFBQSxFQUFBLEVBQUEsR0FBQSxFQUFBLEtBQUEsRUFBQSxDQUFBLEVBQUEsR0FBQSxFQUFBLEVBQUEsRUFBQSxFQUFBLEVBQUEsT0FBQSxFQUFBO0FBQUE7RUFBQSxLQUFBLHdEQUFBOztJQUNDLENBQUMsRUFBRCxFQUFJLEVBQUosRUFBTyxFQUFQLEVBQVUsRUFBVixFQUFhLEdBQWIsQ0FBQSxHQUFvQjtJQUNwQixJQUFHLENBQUEsQ0FBQSxHQUFFLEVBQUYsR0FBSyxDQUFMLElBQVUsTUFBVixJQUFVLE1BQVYsSUFBb0IsQ0FBQSxHQUFFLEVBQUYsR0FBSyxDQUF6QixDQUFBLElBQStCLENBQUEsQ0FBQSxHQUFFLEVBQUYsR0FBSyxDQUFMLElBQVUsTUFBVixJQUFVLE1BQVYsSUFBb0IsQ0FBQSxHQUFFLEVBQUYsR0FBSyxDQUF6QixDQUFsQztNQUNDLE1BQUEsR0FBUzttQkFDVCxLQUFBLENBQU0sS0FBTixHQUZEO0tBQUEsTUFBQTsyQkFBQTs7RUFGRCxDQUFBOztBQURjOztBQXhCZiIsInNvdXJjZXNDb250ZW50IjpbIm4gPSA1XHJcbmFyciA9IFwiIzExMSAjMjIyICMzMzMgIzQ0NCAjNTU1ICM2NjYgIzc3NyAjODg4ICM5OTkgI2FhYSAjYmJiICNjY2MgI2RkZCAjZWVlXCIuc3BsaXQgJyAnXHJcbm1hcmtlciA9IC0xXHJcblxyXG5zZXR1cCA9IC0+XHJcblx0Y3JlYXRlQ2FudmFzIG4qMjUwKzEsbioyMDArMVx0XHJcblxyXG5kcmF3ID0gLT5cclxuXHRmb3Igc2xpY2UsaW5kZXggaW4gc2xpY2VzXHJcblx0XHRzdyAxXHJcblx0XHRbcjEsYzEscjIsYzIsY2xyXSA9IHNsaWNlXHRcclxuXHRcdHNjIGlmIGNscjw4IHRoZW4gMSBlbHNlIDBcclxuXHRcdGlmIG1hcmtlciA9PSBpbmRleCBcclxuXHRcdFx0I3ByaW50IG1hcmtlcixpbmRleFxyXG5cdFx0XHRzdHJva2UgMjU1LDAsMFxyXG5cdFx0ZmlsbCBhcnJbY2xyXVxyXG5cdFx0cmVjdCBuKmMxLG4qcjEsbipjMi1uKmMxK24sbipyMi1uKnIxK25cclxuXHJcblx0XHRzdHJva2UgMCwyNTUsMFxyXG5cdFx0c3cgMlxyXG5cdFx0Zm9yIGogaW4gcmFuZ2UgcjEscjIrMVxyXG5cdFx0XHRmb3IgaSBpbiByYW5nZSBjMSxjMisxXHJcblx0XHRcdFx0cG9pbnQgbiooaSswLjUpLG4qKGorMC41KVxyXG5cclxubW91c2VQcmVzc2VkID0gLT5cclxuXHRmb3Igc2xpY2UsaW5kZXggaW4gc2xpY2VzXHJcblx0XHRbcjEsYzEscjIsYzIsY2xyXSA9IHNsaWNlXHJcblx0XHRpZiBuKmMxLTEgPD0gbW91c2VYIDw9IG4qYzIrMSBhbmQgbipyMS0xIDw9IG1vdXNlWSA8PSBuKnIyKzFcclxuXHRcdFx0bWFya2VyID0gaW5kZXhcclxuXHRcdFx0cHJpbnQgc2xpY2VcclxuXHJcbiMgc2V0dXAgPSAtPlxyXG4jIFx0Y3JlYXRlQ2FudmFzIG4qMTAwMCsxLG4qMTAwMCsxXHRcclxuXHJcbiMgZHJhdyA9IC0+XHJcbiMgXHRmb3Igc2xpY2UgaW4gc2xpY2VzXHJcbiMgXHRcdHN3IDFcclxuIyBcdFx0W3IxLGMxLHIyLGMyLGluZGV4XSA9IHNsaWNlXHRcclxuIyBcdFx0c2MgaWYgaW5kZXg8OCB0aGVuIDEgZWxzZSAwXHJcbiMgXHRcdGZpbGwgYXJyW2luZGV4XVxyXG4jIFx0XHRyZWN0IG4qYzEsbipyMSxuKmMyLW4qYzErbixuKnIyLW4qcjErblxyXG4jIFx0XHRzdHJva2UgMCwyNTUsMFxyXG4jIFx0XHRzdyAyXHJcbiMgXHRcdGZvciBqIGluIHJhbmdlIHIxLHIyKzFcclxuIyBcdFx0XHRmb3IgaSBpbiByYW5nZSBjMSxjMisxXHJcbiMgXHRcdFx0XHRwb2ludCBuKihpKzAuNSksbiooaiswLjUpXHJcbiJdfQ==
//# sourceURL=C:\Lab\2019\022-hashcode\coffee\sketch.coffee