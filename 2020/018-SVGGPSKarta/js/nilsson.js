// Generated by CoffeeScript 2.4.1
var assert, bg, bsort, circle, compare, fc, fixColor, getParameters, merp, nilsson_version, print, range, rd, sc, sw;

nilsson_version = "1.5"; // getParameters with 0 parameters fixed 


// chai visar listinnehåll på ett bra sätt. 
// _.isEqual(a,b) fungerar också men det blir sämre listutskrifter
assert = function(a, b, msg = 'Assert failure') {
  return chai.assert.deepEqual(a, b, msg);
};

fixColor = function(args) {
  var a, b, g, n, r;
  n = args.length;
  a = 1;
  if (n === 1) {
    [r, g, b] = [args[0], args[0], args[0]];
  }
  if (n === 2) {
    [r, g, b, a] = [args[0], args[0], args[0], args[1]];
  }
  if (n === 3) {
    [r, g, b] = args;
  }
  if (n === 4) {
    [r, g, b, a] = args;
  }
  return color(255 * r, 255 * g, 255 * b, 255 * a);
};

fc = function() {
  if (arguments.length === 0) {
    return noFill();
  } else {
    return fill(fixColor(arguments));
  }
};

sc = function() {
  if (arguments.length === 0) {
    return noStroke();
  } else {
    return stroke(fixColor(arguments));
  }
};

bg = function() {
  return background(fixColor(arguments));
};

sw = function(n) {
  return strokeWeight(n);
};

circle = function(x, y, r) {
  return ellipse(x, y, 2 * r, 2 * r);
};

rd = function(degrees) {
  return rotate(radians(degrees));
};

print = console.log;

range = _.range; // from underscore.coffee

merp = function(y1, y2, i, x1 = 0, x2 = 1) {
  return map(i, x1, x2, y1, y2);
};

getParameters = function(h = window.location.href) {
  var arr, f, s;
  h = decodeURI(h);
  arr = h.split('?');
  if (arr.length !== 2) {
    return {};
  }
  s = arr[1];
  if (s === '') {
    return {};
  }
  return _.object((function() {
    var k, len, ref, results;
    ref = s.split('&');
    results = [];
    for (k = 0, len = ref.length; k < len; k++) {
      f = ref[k];
      results.push(f.split('='));
    }
    return results;
  })());
};

assert(getParameters('http:\\christernilsson.github.io\Shortcut\www'), {});

assert(getParameters('http:\\christernilsson.github.io\Shortcut\www?'), {});

assert(getParameters('http:\\christernilsson.github.io\Shortcut\www?a=0&b=1'), {
  'a': '0',
  'b': '1'
});

compare = function(a, b) {
  var c, i, k, len, ref;
  if (typeof a === "object" && typeof b === "object") {
    ref = range(Math.min(a.length, b.length));
    for (k = 0, len = ref.length; k < len; k++) {
      i = ref[k];
      c = compare(a[i], b[i]);
      if (c !== 0) {
        return c;
      }
    }
  } else {
    return (a > b ? -1 : (a < b ? 1 : 0));
  }
  return 0;
};

assert(compare(12, 13), 1);

assert(compare(12, 12), 0);

assert(compare(13, 12), -1);

assert(compare([1, 11], [1, 2]), -1);

assert(compare([1, 11], [1, 11]), 0);

assert(compare([1, 2], [1, 11]), 1);

assert(compare([1, '11'], [1, '2']), 1);

assert(compare([1, '11'], [1, '11']), 0);

assert(compare([1, '2'], [1, '11']), -1);

bsort = function(list, cmp = compare) {
  var i, j, k, l, len, len1, ref, ref1;
  ref = range(list.length);
  for (k = 0, len = ref.length; k < len; k++) {
    i = ref[k];
    ref1 = range(list.length - 1);
    for (l = 0, len1 = ref1.length; l < len1; l++) {
      j = ref1[l];
      if (cmp(list[j], list[j + 1]) < 0) {
        [list[j], list[j + 1]] = [list[j + 1], list[j]];
      }
    }
  }
  return list;
};

assert(bsort([1, 8, 2], compare), [1, 2, 8]);

assert(bsort([1, 8, 2], compare), [1, 2, 8]);

assert(bsort([[1], [8], [2]], compare), [[1], [2], [8]]);

assert(bsort([[2, 1], [2, 8], [2, 2]], compare), [[2, 1], [2, 2], [2, 8]]);

assert(bsort([[1, 8], [1, 7], [1, 9]], compare), [[1, 7], [1, 8], [1, 9]]);

assert(bsort([3, 2, 4, 1], compare), [1, 2, 3, 4]);

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoibmlsc3Nvbi5qcyIsInNvdXJjZVJvb3QiOiIuLiIsInNvdXJjZXMiOlsiY29mZmVlXFxuaWxzc29uLmNvZmZlZSJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiO0FBQUEsSUFBQSxNQUFBLEVBQUEsRUFBQSxFQUFBLEtBQUEsRUFBQSxNQUFBLEVBQUEsT0FBQSxFQUFBLEVBQUEsRUFBQSxRQUFBLEVBQUEsYUFBQSxFQUFBLElBQUEsRUFBQSxlQUFBLEVBQUEsS0FBQSxFQUFBLEtBQUEsRUFBQSxFQUFBLEVBQUEsRUFBQSxFQUFBOztBQUFBLGVBQUEsR0FBa0IsTUFBbEI7Ozs7O0FBSUEsTUFBQSxHQUFTLFFBQUEsQ0FBQyxDQUFELEVBQUksQ0FBSixFQUFPLE1BQUksZ0JBQVgsQ0FBQTtTQUFnQyxJQUFJLENBQUMsTUFBTSxDQUFDLFNBQVosQ0FBc0IsQ0FBdEIsRUFBeUIsQ0FBekIsRUFBNEIsR0FBNUI7QUFBaEM7O0FBRVQsUUFBQSxHQUFXLFFBQUEsQ0FBQyxJQUFELENBQUE7QUFDVixNQUFBLENBQUEsRUFBQSxDQUFBLEVBQUEsQ0FBQSxFQUFBLENBQUEsRUFBQTtFQUFBLENBQUEsR0FBSSxJQUFJLENBQUM7RUFDVCxDQUFBLEdBQUk7RUFDSixJQUF1QyxDQUFBLEtBQUssQ0FBNUM7SUFBQSxDQUFDLENBQUQsRUFBRyxDQUFILEVBQUssQ0FBTCxDQUFBLEdBQVUsQ0FBQyxJQUFLLENBQUEsQ0FBQSxDQUFOLEVBQVMsSUFBSyxDQUFBLENBQUEsQ0FBZCxFQUFpQixJQUFLLENBQUEsQ0FBQSxDQUF0QixFQUFWOztFQUNBLElBQWlELENBQUEsS0FBSyxDQUF0RDtJQUFBLENBQUMsQ0FBRCxFQUFHLENBQUgsRUFBSyxDQUFMLEVBQU8sQ0FBUCxDQUFBLEdBQVksQ0FBQyxJQUFLLENBQUEsQ0FBQSxDQUFOLEVBQVMsSUFBSyxDQUFBLENBQUEsQ0FBZCxFQUFpQixJQUFLLENBQUEsQ0FBQSxDQUF0QixFQUF5QixJQUFLLENBQUEsQ0FBQSxDQUE5QixFQUFaOztFQUNB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QSxDQUFPLEtBQUEsQ0FBTSxDQUFDLENBQUMsQ0FBRCxDQUFELEVBQUssQ0FBQyxDQUFELENBQUwsRUFBUyxDQUFDLENBQUQsQ0FBVCxDQUFOLEVBQW9CLE9BQXBCLENBQVAsRUFBcUMsQ0FBQyxDQUFDLENBQUQsQ0FBRCxFQUFLLENBQUMsQ0FBRCxDQUFMLEVBQVMsQ0FBQyxDQUFELENBQVQsQ0FBckM7O0FBQ0EsTUFBQSxDQUFPLEtBQUEsQ0FBTSxDQUFDLENBQUMsQ0FBRCxFQUFHLENBQUgsQ0FBRCxFQUFPLENBQUMsQ0FBRCxFQUFHLENBQUgsQ0FBUCxFQUFhLENBQUMsQ0FBRCxFQUFHLENBQUgsQ0FBYixDQUFOLEVBQTBCLE9BQTFCLENBQVAsRUFBMkMsQ0FBQyxDQUFDLENBQUQsRUFBRyxDQUFILENBQUQsRUFBTyxDQUFDLENBQUQsRUFBRyxDQUFILENBQVAsRUFBYSxDQUFDLENBQUQsRUFBRyxDQUFILENBQWIsQ0FBM0M7O0FBQ0EsTUFBQSxDQUFPLEtBQUEsQ0FBTSxDQUFDLENBQUMsQ0FBRCxFQUFHLENBQUgsQ0FBRCxFQUFRLENBQUMsQ0FBRCxFQUFHLENBQUgsQ0FBUixFQUFlLENBQUMsQ0FBRCxFQUFHLENBQUgsQ0FBZixDQUFOLEVBQTRCLE9BQTVCLENBQVAsRUFBNkMsQ0FBQyxDQUFDLENBQUQsRUFBRyxDQUFILENBQUQsRUFBUSxDQUFDLENBQUQsRUFBRyxDQUFILENBQVIsRUFBZSxDQUFDLENBQUQsRUFBRyxDQUFILENBQWYsQ0FBN0M7O0FBQ0EsTUFBQSxDQUFPLEtBQUEsQ0FBTSxDQUFDLENBQUQsRUFBRyxDQUFILEVBQUssQ0FBTCxFQUFPLENBQVAsQ0FBTixFQUFpQixPQUFqQixDQUFQLEVBQWtDLENBQUMsQ0FBRCxFQUFHLENBQUgsRUFBSyxDQUFMLEVBQU8sQ0FBUCxDQUFsQyIsInNvdXJjZXNDb250ZW50IjpbIm5pbHNzb25fdmVyc2lvbiA9IFwiMS41XCIgIyBnZXRQYXJhbWV0ZXJzIHdpdGggMCBwYXJhbWV0ZXJzIGZpeGVkIFxuXG4jIGNoYWkgdmlzYXIgbGlzdGlubmVow6VsbCBww6UgZXR0IGJyYSBzw6R0dC4gXG4jIF8uaXNFcXVhbChhLGIpIGZ1bmdlcmFyIG9ja3PDpSBtZW4gZGV0IGJsaXIgc8OkbXJlIGxpc3R1dHNrcmlmdGVyXG5hc3NlcnQgPSAoYSwgYiwgbXNnPSdBc3NlcnQgZmFpbHVyZScpIC0+IGNoYWkuYXNzZXJ0LmRlZXBFcXVhbCBhLCBiLCBtc2dcblxuZml4Q29sb3IgPSAoYXJncykgLT5cblx0biA9IGFyZ3MubGVuZ3RoXG5cdGEgPSAxXG5cdFtyLGcsYl0gPSBbYXJnc1swXSxhcmdzWzBdLGFyZ3NbMF1dIGlmIG4gPT0gMVxuXHRbcixnLGIsYV0gPSBbYXJnc1swXSxhcmdzWzBdLGFyZ3NbMF0sYXJnc1sxXV0gaWYgbiA9PSAyIFxuXHRbcixnLGJdID0gYXJncyBpZiBuID09IDNcblx0W3IsZyxiLGFdID0gYXJncyBpZiBuID09IDRcblx0cmV0dXJuIGNvbG9yIDI1NSAqIHIsIDI1NSAqIGcsIDI1NSAqIGIsIDI1NSAqIGFcblxuZmMgPSAtPiBpZiBhcmd1bWVudHMubGVuZ3RoID09IDAgdGhlbiBub0ZpbGwoKSBlbHNlIGZpbGwgZml4Q29sb3IgYXJndW1lbnRzXG5zYyA9IC0+IGlmIGFyZ3VtZW50cy5sZW5ndGggPT0gMCB0aGVuIG5vU3Ryb2tlKCkgZWxzZSBzdHJva2UgZml4Q29sb3IgYXJndW1lbnRzXG5iZyA9IC0+IGJhY2tncm91bmQgZml4Q29sb3IgYXJndW1lbnRzXG5zdyA9IChuKSAtPiBzdHJva2VXZWlnaHQgblxuY2lyY2xlID0gKHgseSxyKSAtPiBlbGxpcHNlIHgseSwyKnIsMipyXG5yZCA9IChkZWdyZWVzKSAtPiByb3RhdGUgcmFkaWFucyBkZWdyZWVzXG5wcmludCA9IGNvbnNvbGUubG9nXG5yYW5nZSA9IF8ucmFuZ2UgIyBmcm9tIHVuZGVyc2NvcmUuY29mZmVlXG5tZXJwID0gKHkxLHkyLGkseDE9MCx4Mj0xKSAtPiBtYXAgaSx4MSx4Mix5MSx5MlxuXG5nZXRQYXJhbWV0ZXJzID0gKGggPSB3aW5kb3cubG9jYXRpb24uaHJlZikgLT4gXG5cdGggPSBkZWNvZGVVUkkgaFxuXHRhcnIgPSBoLnNwbGl0KCc/Jylcblx0aWYgYXJyLmxlbmd0aCAhPSAyIHRoZW4gcmV0dXJuIHt9XG5cdHMgPSBhcnJbMV1cblx0aWYgcz09JycgdGhlbiByZXR1cm4ge31cblx0Xy5vYmplY3QoZi5zcGxpdCAnPScgZm9yIGYgaW4gcy5zcGxpdCgnJicpKVxuYXNzZXJ0IGdldFBhcmFtZXRlcnMoJ2h0dHA6XFxcXGNocmlzdGVybmlsc3Nvbi5naXRodWIuaW9cXFNob3J0Y3V0XFx3d3cnKSwge31cbmFzc2VydCBnZXRQYXJhbWV0ZXJzKCdodHRwOlxcXFxjaHJpc3Rlcm5pbHNzb24uZ2l0aHViLmlvXFxTaG9ydGN1dFxcd3d3PycpLCB7fVxuYXNzZXJ0IGdldFBhcmFtZXRlcnMoJ2h0dHA6XFxcXGNocmlzdGVybmlsc3Nvbi5naXRodWIuaW9cXFNob3J0Y3V0XFx3d3c/YT0wJmI9MScpLCB7J2EnOicwJywgJ2InOicxJ31cblxuY29tcGFyZSA9IChhLGIpIC0+XG5cdGlmIHR5cGVvZiBhID09IFwib2JqZWN0XCIgYW5kIHR5cGVvZiBiID09IFwib2JqZWN0XCJcblx0XHRmb3IgaSBpbiByYW5nZSBNYXRoLm1pbiBhLmxlbmd0aCxiLmxlbmd0aFxuXHRcdFx0YyA9IGNvbXBhcmUgYVtpXSxiW2ldXG5cdFx0XHRpZiBjICE9IDAgdGhlbiByZXR1cm4gY1xuXHRlbHNlXG5cdFx0cmV0dXJuIChpZiBhID4gYiB0aGVuIC0xIGVsc2UgKGlmIGEgPCBiIHRoZW4gMSBlbHNlIDApKVxuXHQwXG5hc3NlcnQgY29tcGFyZSgxMiwxMyksIDFcbmFzc2VydCBjb21wYXJlKDEyLDEyKSwgMFxuYXNzZXJ0IGNvbXBhcmUoMTMsMTIpLCAtMVxuYXNzZXJ0IGNvbXBhcmUoWzEsMTFdLFsxLDJdKSwgLTFcbmFzc2VydCBjb21wYXJlKFsxLDExXSxbMSwxMV0pLCAwXG5hc3NlcnQgY29tcGFyZShbMSwyXSxbMSwxMV0pLCAxXG5hc3NlcnQgY29tcGFyZShbMSwnMTEnXSxbMSwnMiddKSwgMVxuYXNzZXJ0IGNvbXBhcmUoWzEsJzExJ10sWzEsJzExJ10pLCAwXG5hc3NlcnQgY29tcGFyZShbMSwnMiddLFsxLCcxMSddKSwgLTFcblxuYnNvcnQgPSAobGlzdCxjbXA9Y29tcGFyZSkgLT5cblx0Zm9yIGkgaW4gcmFuZ2UgbGlzdC5sZW5ndGhcblx0XHRmb3IgaiBpbiByYW5nZSBsaXN0Lmxlbmd0aC0xXG5cdFx0XHRbbGlzdFtqXSwgbGlzdFtqKzFdXSA9IFtsaXN0W2orMV0sIGxpc3Rbal1dIGlmIGNtcChsaXN0W2pdLCBsaXN0W2orMV0pIDwgMFxuXHRsaXN0XG5hc3NlcnQgYnNvcnQoWzEsOCwyXSxjb21wYXJlKSwgWzEsMiw4XVxuYXNzZXJ0IGJzb3J0KFsxLDgsMl0sY29tcGFyZSksIFsxLDIsOF1cbmFzc2VydCBic29ydChbWzFdLFs4XSxbMl1dLGNvbXBhcmUpLCBbWzFdLFsyXSxbOF1dXG5hc3NlcnQgYnNvcnQoW1syLDFdLFsyLDhdLFsyLDJdXSxjb21wYXJlKSwgW1syLDFdLFsyLDJdLFsyLDhdXVxuYXNzZXJ0IGJzb3J0KFtbMSw4XSwgWzEsN10sIFsxLDldXSxjb21wYXJlKSwgW1sxLDddLCBbMSw4XSwgWzEsOV1dXG5hc3NlcnQgYnNvcnQoWzMsMiw0LDFdLCBjb21wYXJlKSwgWzEsMiwzLDRdXG5cbiJdfQ==
//# sourceURL=c:\github\gpsKarta\coffee\nilsson.coffee