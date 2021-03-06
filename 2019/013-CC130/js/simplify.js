// Generated by CoffeeScript 2.3.2
// (c) 2017, Vladimir Agafonkin
// Simplify.js, a high-performance JS polyline simplification library
// mourner.github.io/simplify-js

// square distance between 2 points
var getSqDist, getSqSegDist, simplify, simplifyDPStep, simplifyDouglasPeucker, simplifyRadialDist;

getSqDist = function(p1, p2) {
  var dx, dy;
  dx = p1.x - p2.x;
  dy = p1.y - p2.y;
  return dx * dx + dy * dy;
};

// square distance from a point to a segment
getSqSegDist = function(p, p1, p2) {
  var dx, dy, t, x, y;
  x = p1.x;
  y = p1.y;
  dx = p2.x - x;
  dy = p2.y - y;
  if (dx !== 0 || dy !== 0) {
    t = ((p.x - x) * dx + (p.y - y) * dy) / (dx * dx + dy * dy);
    if (t > 1) {
      x = p2.x;
      y = p2.y;
    } else if (t > 0) {
      x += dx * t;
      y += dy * t;
    }
  }
  dx = p.x - x;
  dy = p.y - y;
  return dx * dx + dy * dy;
};

// rest of the code doesn't care about point format
// basic distance-based simplification
simplifyRadialDist = function(points, sqTolerance) {
  var j, len, newPoints, point, prevPoint;
  prevPoint = points[0];
  newPoints = [prevPoint];
  for (j = 0, len = points.length; j < len; j++) {
    point = points[j];
    if (getSqDist(point, prevPoint) > sqTolerance) {
      newPoints.push(point);
      prevPoint = point;
    }
  }
  if (prevPoint !== point) {
    newPoints.push(point);
  }
  return newPoints;
};

simplifyDPStep = function(points, first, last, sqTolerance, simplified) {
  var i, index, j, len, maxSqDist, ref, sqDist;
  maxSqDist = sqTolerance;
  index = null;
  ref = range(first + 1, last, 1);
  // find most distant point and keep it.
  for (j = 0, len = ref.length; j < len; j++) {
    i = ref[j];
    sqDist = getSqSegDist(points[i], points[first], points[last]);
    if (sqDist > maxSqDist) {
      index = i;
      maxSqDist = sqDist;
    }
  }
  if (maxSqDist > sqTolerance) {
    print(index, sqrt(maxSqDist), points[index]);
    if (index - first > 1) {
      simplifyDPStep(points, first, index, sqTolerance, simplified);
    }
    simplified.push(points[index]);
    if (last - index > 1) {
      return simplifyDPStep(points, index, last, sqTolerance, simplified);
    }
  }
};

// simplification using Ramer-Douglas-Peucker algorithm
simplifyDouglasPeucker = function(points, sqTolerance) {
  var last, simplified;
  last = points.length - 1;
  simplified = [points[0]];
  simplifyDPStep(points, 0, last, sqTolerance, simplified);
  simplified.push(points[last]);
  return simplified;
};

// both algorithms combined for awesome performance
simplify = function(points, tolerance = 1, highestQuality = false) {
  var res, sqTolerance;
  if (points.length <= 2) {
    return points;
  }
  sqTolerance = tolerance * tolerance;
  if (highestQuality) {
    points = simplifyRadialDist(points, sqTolerance);
  }
  res = simplifyDouglasPeucker(points, sqTolerance);
  print(res);
  return res;
};

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic2ltcGxpZnkuanMiLCJzb3VyY2VSb290IjoiLi4iLCJzb3VyY2VzIjpbImNvZmZlZVxcc2ltcGxpZnkuY29mZmVlIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7QUFBQTs7Ozs7QUFBQSxJQUFBLFNBQUEsRUFBQSxZQUFBLEVBQUEsUUFBQSxFQUFBLGNBQUEsRUFBQSxzQkFBQSxFQUFBOztBQUtBLFNBQUEsR0FBWSxRQUFBLENBQUMsRUFBRCxFQUFLLEVBQUwsQ0FBQTtBQUNYLE1BQUEsRUFBQSxFQUFBO0VBQUEsRUFBQSxHQUFLLEVBQUUsQ0FBQyxDQUFILEdBQU8sRUFBRSxDQUFDO0VBQ2YsRUFBQSxHQUFLLEVBQUUsQ0FBQyxDQUFILEdBQU8sRUFBRSxDQUFDO1NBQ2YsRUFBQSxHQUFLLEVBQUwsR0FBVSxFQUFBLEdBQUs7QUFISixFQUxaOzs7QUFXQSxZQUFBLEdBQWUsUUFBQSxDQUFDLENBQUQsRUFBSSxFQUFKLEVBQVEsRUFBUixDQUFBO0FBRWQsTUFBQSxFQUFBLEVBQUEsRUFBQSxFQUFBLENBQUEsRUFBQSxDQUFBLEVBQUE7RUFBQSxDQUFBLEdBQUksRUFBRSxDQUFDO0VBQ1AsQ0FBQSxHQUFJLEVBQUUsQ0FBQztFQUNQLEVBQUEsR0FBSyxFQUFFLENBQUMsQ0FBSCxHQUFPO0VBQ1osRUFBQSxHQUFLLEVBQUUsQ0FBQyxDQUFILEdBQU87RUFFWixJQUFHLEVBQUEsS0FBTSxDQUFOLElBQVcsRUFBQSxLQUFNLENBQXBCO0lBRUMsQ0FBQSxHQUFJLENBQUMsQ0FBQyxDQUFDLENBQUMsQ0FBRixHQUFNLENBQVAsQ0FBQSxHQUFZLEVBQVosR0FBaUIsQ0FBQyxDQUFDLENBQUMsQ0FBRixHQUFNLENBQVAsQ0FBQSxHQUFZLEVBQTlCLENBQUEsR0FBb0MsQ0FBQyxFQUFBLEdBQUssRUFBTCxHQUFVLEVBQUEsR0FBSyxFQUFoQjtJQUV4QyxJQUFHLENBQUEsR0FBSSxDQUFQO01BQ0MsQ0FBQSxHQUFJLEVBQUUsQ0FBQztNQUNQLENBQUEsR0FBSSxFQUFFLENBQUMsRUFGUjtLQUFBLE1BR0ssSUFBRyxDQUFBLEdBQUksQ0FBUDtNQUNKLENBQUEsSUFBSyxFQUFBLEdBQUs7TUFDVixDQUFBLElBQUssRUFBQSxHQUFLLEVBRk47S0FQTjs7RUFXQSxFQUFBLEdBQUssQ0FBQyxDQUFDLENBQUYsR0FBTTtFQUNYLEVBQUEsR0FBSyxDQUFDLENBQUMsQ0FBRixHQUFNO1NBRVgsRUFBQSxHQUFLLEVBQUwsR0FBVSxFQUFBLEdBQUs7QUFyQkQsRUFYZjs7OztBQW9DQSxrQkFBQSxHQUFxQixRQUFBLENBQUMsTUFBRCxFQUFTLFdBQVQsQ0FBQTtBQUVwQixNQUFBLENBQUEsRUFBQSxHQUFBLEVBQUEsU0FBQSxFQUFBLEtBQUEsRUFBQTtFQUFBLFNBQUEsR0FBWSxNQUFPLENBQUEsQ0FBQTtFQUNuQixTQUFBLEdBQVksQ0FBQyxTQUFEO0VBRVosS0FBQSx3Q0FBQTs7SUFDQyxJQUFHLFNBQUEsQ0FBVSxLQUFWLEVBQWlCLFNBQWpCLENBQUEsR0FBOEIsV0FBakM7TUFDQyxTQUFTLENBQUMsSUFBVixDQUFlLEtBQWY7TUFDQSxTQUFBLEdBQVksTUFGYjs7RUFERDtFQUtBLElBQUcsU0FBQSxLQUFhLEtBQWhCO0lBQTJCLFNBQVMsQ0FBQyxJQUFWLENBQWUsS0FBZixFQUEzQjs7U0FDQTtBQVhvQjs7QUFhckIsY0FBQSxHQUFpQixRQUFBLENBQUMsTUFBRCxFQUFTLEtBQVQsRUFBZ0IsSUFBaEIsRUFBc0IsV0FBdEIsRUFBbUMsVUFBbkMsQ0FBQTtBQUNoQixNQUFBLENBQUEsRUFBQSxLQUFBLEVBQUEsQ0FBQSxFQUFBLEdBQUEsRUFBQSxTQUFBLEVBQUEsR0FBQSxFQUFBO0VBQUEsU0FBQSxHQUFZO0VBQ1osS0FBQSxHQUFRO0FBR1I7O0VBQUEsS0FBQSxxQ0FBQTs7SUFDQyxNQUFBLEdBQVMsWUFBQSxDQUFhLE1BQU8sQ0FBQSxDQUFBLENBQXBCLEVBQXdCLE1BQU8sQ0FBQSxLQUFBLENBQS9CLEVBQXVDLE1BQU8sQ0FBQSxJQUFBLENBQTlDO0lBQ1QsSUFBRyxNQUFBLEdBQVMsU0FBWjtNQUNDLEtBQUEsR0FBUTtNQUNSLFNBQUEsR0FBWSxPQUZiOztFQUZEO0VBTUEsSUFBRyxTQUFBLEdBQVksV0FBZjtJQUNDLEtBQUEsQ0FBTSxLQUFOLEVBQVksSUFBQSxDQUFLLFNBQUwsQ0FBWixFQUE0QixNQUFPLENBQUEsS0FBQSxDQUFuQztJQUNBLElBQUcsS0FBQSxHQUFRLEtBQVIsR0FBZ0IsQ0FBbkI7TUFBMEIsY0FBQSxDQUFlLE1BQWYsRUFBdUIsS0FBdkIsRUFBOEIsS0FBOUIsRUFBcUMsV0FBckMsRUFBa0QsVUFBbEQsRUFBMUI7O0lBQ0EsVUFBVSxDQUFDLElBQVgsQ0FBZ0IsTUFBTyxDQUFBLEtBQUEsQ0FBdkI7SUFDQSxJQUFHLElBQUEsR0FBTyxLQUFQLEdBQWUsQ0FBbEI7YUFBeUIsY0FBQSxDQUFlLE1BQWYsRUFBdUIsS0FBdkIsRUFBOEIsSUFBOUIsRUFBb0MsV0FBcEMsRUFBaUQsVUFBakQsRUFBekI7S0FKRDs7QUFYZ0IsRUFqRGpCOzs7QUFtRUEsc0JBQUEsR0FBeUIsUUFBQSxDQUFDLE1BQUQsRUFBUyxXQUFULENBQUE7QUFDeEIsTUFBQSxJQUFBLEVBQUE7RUFBQSxJQUFBLEdBQU8sTUFBTSxDQUFDLE1BQVAsR0FBZ0I7RUFDdkIsVUFBQSxHQUFhLENBQUMsTUFBTyxDQUFBLENBQUEsQ0FBUjtFQUNiLGNBQUEsQ0FBZSxNQUFmLEVBQXVCLENBQXZCLEVBQTBCLElBQTFCLEVBQWdDLFdBQWhDLEVBQTZDLFVBQTdDO0VBQ0EsVUFBVSxDQUFDLElBQVgsQ0FBZ0IsTUFBTyxDQUFBLElBQUEsQ0FBdkI7U0FDQTtBQUx3QixFQW5FekI7OztBQTJFQSxRQUFBLEdBQVcsUUFBQSxDQUFDLE1BQUQsRUFBUyxZQUFVLENBQW5CLEVBQXNCLGlCQUFlLEtBQXJDLENBQUE7QUFDVixNQUFBLEdBQUEsRUFBQTtFQUFBLElBQUcsTUFBTSxDQUFDLE1BQVAsSUFBaUIsQ0FBcEI7QUFBMkIsV0FBTyxPQUFsQzs7RUFDQSxXQUFBLEdBQWMsU0FBQSxHQUFZO0VBQzFCLElBQUcsY0FBSDtJQUF1QixNQUFBLEdBQVMsa0JBQUEsQ0FBbUIsTUFBbkIsRUFBMkIsV0FBM0IsRUFBaEM7O0VBQ0EsR0FBQSxHQUFNLHNCQUFBLENBQXVCLE1BQXZCLEVBQStCLFdBQS9CO0VBQ04sS0FBQSxDQUFNLEdBQU47U0FDQTtBQU5VIiwic291cmNlc0NvbnRlbnQiOlsiIyAoYykgMjAxNywgVmxhZGltaXIgQWdhZm9ua2luXHJcbiMgU2ltcGxpZnkuanMsIGEgaGlnaC1wZXJmb3JtYW5jZSBKUyBwb2x5bGluZSBzaW1wbGlmaWNhdGlvbiBsaWJyYXJ5XHJcbiMgbW91cm5lci5naXRodWIuaW8vc2ltcGxpZnktanNcclxuXHJcbiMgc3F1YXJlIGRpc3RhbmNlIGJldHdlZW4gMiBwb2ludHNcclxuZ2V0U3FEaXN0ID0gKHAxLCBwMikgLT5cclxuXHRkeCA9IHAxLnggLSBwMi54XHJcblx0ZHkgPSBwMS55IC0gcDIueVxyXG5cdGR4ICogZHggKyBkeSAqIGR5XHJcblxyXG4jIHNxdWFyZSBkaXN0YW5jZSBmcm9tIGEgcG9pbnQgdG8gYSBzZWdtZW50XHJcbmdldFNxU2VnRGlzdCA9IChwLCBwMSwgcDIpIC0+XHJcblxyXG5cdHggPSBwMS54XHJcblx0eSA9IHAxLnlcclxuXHRkeCA9IHAyLnggLSB4XHJcblx0ZHkgPSBwMi55IC0geVxyXG5cclxuXHRpZiBkeCAhPSAwIHx8IGR5ICE9IDBcclxuXHJcblx0XHR0ID0gKChwLnggLSB4KSAqIGR4ICsgKHAueSAtIHkpICogZHkpIC8gKGR4ICogZHggKyBkeSAqIGR5KVxyXG5cclxuXHRcdGlmIHQgPiAxXHJcblx0XHRcdHggPSBwMi54XHJcblx0XHRcdHkgPSBwMi55XHJcblx0XHRlbHNlIGlmIHQgPiAwXHJcblx0XHRcdHggKz0gZHggKiB0XHJcblx0XHRcdHkgKz0gZHkgKiB0XHJcblxyXG5cdGR4ID0gcC54IC0geFxyXG5cdGR5ID0gcC55IC0geVxyXG5cclxuXHRkeCAqIGR4ICsgZHkgKiBkeVxyXG5cclxuIyByZXN0IG9mIHRoZSBjb2RlIGRvZXNuJ3QgY2FyZSBhYm91dCBwb2ludCBmb3JtYXRcclxuIyBiYXNpYyBkaXN0YW5jZS1iYXNlZCBzaW1wbGlmaWNhdGlvblxyXG5zaW1wbGlmeVJhZGlhbERpc3QgPSAocG9pbnRzLCBzcVRvbGVyYW5jZSkgLT5cclxuXHJcblx0cHJldlBvaW50ID0gcG9pbnRzWzBdXHJcblx0bmV3UG9pbnRzID0gW3ByZXZQb2ludF1cclxuXHJcblx0Zm9yIHBvaW50IGluIHBvaW50c1xyXG5cdFx0aWYgZ2V0U3FEaXN0KHBvaW50LCBwcmV2UG9pbnQpID4gc3FUb2xlcmFuY2VcclxuXHRcdFx0bmV3UG9pbnRzLnB1c2ggcG9pbnRcclxuXHRcdFx0cHJldlBvaW50ID0gcG9pbnRcclxuXHJcblx0aWYgcHJldlBvaW50ICE9IHBvaW50IHRoZW4gbmV3UG9pbnRzLnB1c2ggcG9pbnRcclxuXHRuZXdQb2ludHNcclxuXHJcbnNpbXBsaWZ5RFBTdGVwID0gKHBvaW50cywgZmlyc3QsIGxhc3QsIHNxVG9sZXJhbmNlLCBzaW1wbGlmaWVkKSAtPlxyXG5cdG1heFNxRGlzdCA9IHNxVG9sZXJhbmNlXHJcblx0aW5kZXggPSBudWxsXHJcblxyXG5cdCMgZmluZCBtb3N0IGRpc3RhbnQgcG9pbnQgYW5kIGtlZXAgaXQuXHJcblx0Zm9yIGkgaW4gcmFuZ2UgZmlyc3QgKyAxLCBsYXN0LCAxXHJcblx0XHRzcURpc3QgPSBnZXRTcVNlZ0Rpc3QgcG9pbnRzW2ldLCBwb2ludHNbZmlyc3RdLCBwb2ludHNbbGFzdF1cclxuXHRcdGlmIHNxRGlzdCA+IG1heFNxRGlzdFxyXG5cdFx0XHRpbmRleCA9IGlcclxuXHRcdFx0bWF4U3FEaXN0ID0gc3FEaXN0XHJcblxyXG5cdGlmIG1heFNxRGlzdCA+IHNxVG9sZXJhbmNlXHJcblx0XHRwcmludCBpbmRleCxzcXJ0KG1heFNxRGlzdCkscG9pbnRzW2luZGV4XVxyXG5cdFx0aWYgaW5kZXggLSBmaXJzdCA+IDEgdGhlbiBzaW1wbGlmeURQU3RlcCBwb2ludHMsIGZpcnN0LCBpbmRleCwgc3FUb2xlcmFuY2UsIHNpbXBsaWZpZWRcclxuXHRcdHNpbXBsaWZpZWQucHVzaCBwb2ludHNbaW5kZXhdXHJcblx0XHRpZiBsYXN0IC0gaW5kZXggPiAxIHRoZW4gc2ltcGxpZnlEUFN0ZXAgcG9pbnRzLCBpbmRleCwgbGFzdCwgc3FUb2xlcmFuY2UsIHNpbXBsaWZpZWRcclxuXHJcbiMgc2ltcGxpZmljYXRpb24gdXNpbmcgUmFtZXItRG91Z2xhcy1QZXVja2VyIGFsZ29yaXRobVxyXG5zaW1wbGlmeURvdWdsYXNQZXVja2VyID0gKHBvaW50cywgc3FUb2xlcmFuY2UpIC0+XHJcblx0bGFzdCA9IHBvaW50cy5sZW5ndGggLSAxXHJcblx0c2ltcGxpZmllZCA9IFtwb2ludHNbMF1dXHJcblx0c2ltcGxpZnlEUFN0ZXAgcG9pbnRzLCAwLCBsYXN0LCBzcVRvbGVyYW5jZSwgc2ltcGxpZmllZFxyXG5cdHNpbXBsaWZpZWQucHVzaCBwb2ludHNbbGFzdF1cclxuXHRzaW1wbGlmaWVkXHJcblxyXG4jIGJvdGggYWxnb3JpdGhtcyBjb21iaW5lZCBmb3IgYXdlc29tZSBwZXJmb3JtYW5jZVxyXG5zaW1wbGlmeSA9IChwb2ludHMsIHRvbGVyYW5jZT0xLCBoaWdoZXN0UXVhbGl0eT1mYWxzZSkgLT5cclxuXHRpZiBwb2ludHMubGVuZ3RoIDw9IDIgdGhlbiByZXR1cm4gcG9pbnRzXHJcblx0c3FUb2xlcmFuY2UgPSB0b2xlcmFuY2UgKiB0b2xlcmFuY2VcclxuXHRpZiBoaWdoZXN0UXVhbGl0eSB0aGVuIHBvaW50cyA9IHNpbXBsaWZ5UmFkaWFsRGlzdCBwb2ludHMsIHNxVG9sZXJhbmNlXHJcblx0cmVzID0gc2ltcGxpZnlEb3VnbGFzUGV1Y2tlciBwb2ludHMsIHNxVG9sZXJhbmNlXHJcblx0cHJpbnQgcmVzXHJcblx0cmVzIFxyXG4iXX0=
//# sourceURL=C:\Lab\2019\013-CC130\coffee\simplify.coffee