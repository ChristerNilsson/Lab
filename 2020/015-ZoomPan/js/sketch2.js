// Generated by CoffeeScript 2.4.1
var bakgrund, clearLog, draw, enableLog, handle_pinch_zoom, logga, loggaEvents, setup, touchEnded, touchMoved, touchStarted, tpCache, update_background;

loggaEvents = true;

tpCache = [];

bakgrund = '#888';

setup = function() {
  createCanvas(windowWidth, windowHeight / 2);
  return logga("Hej Häpp 27!");
};

draw = function() {
  return background(bakgrund);
};

enableLog = function() {
  return loggaEvents = !loggaEvents;
};

logga = function(name, printTargetIds = false) {
  var o, t;
  if (!loggaEvents) {
    return;
  }
  o = document.getElementsByTagName('output')[0];
  o.innerHTML += `${name}: touches = ${touches.length} <br>`;
  if (printTargetIds) {
    return o.innerHTML += ((function() {
      var j, len, results;
      results = [];
      for (j = 0, len = touches.length; j < len; j++) {
        t = touches[j];
        results.push(`... id = ${t.id} <br>`);
      }
      return results;
    })()).join('<br>');
  }
};

clearLog = function() {
  var o;
  o = document.getElementsByTagName('output')[0];
  return o.innerHTML = "";
};

update_background = function(ev) {
  var n;
  n = touches.length;
  if (n === 1) {
    bakgrund = "yellow";
  } else if (n === 2) {
    bakgrund = "pink";
  } else {
    bakgrund = "lightblue";
  }
  return logga(`update_background ${bakgrund}`);
};

handle_pinch_zoom = function(ev) {
  var PINCH_THRESHHOLD, diff1, diff2, e, i, j, len, point1, point2, ref;
  try {
    logga(`  HPZ ${tpCache.length} ${touches.length}`);
    if (touches.length === 2) {
      // Check if the two target touches are the same ones that started the 2-touch
      point1 = -1;
      point2 = -1;
      ref = range(tpCache.length);
      for (j = 0, len = ref.length; j < len; j++) {
        i = ref[j];
        if (tpCache[i].id === touches[0].id) {
          point1 = i;
        }
        if (tpCache[i].id === touches[1].id) {
          point2 = i;
        }
      }
      logga(`    point ${point1} ${point2}`);
      if (point1 >= 0 && point2 >= 0) {
        // Calculate the difference between the start and move coordinates
        diff1 = Math.abs(tpCache[point1].x - touches[0].x);
        diff2 = Math.abs(tpCache[point2].x - touches[1].x);
        // This threshold is device dependent as well as application specific
        PINCH_THRESHHOLD = ev.target.clientWidth / 10;
        logga(`    diff ${diff1} ${diff2} ${PINCH_THRESHHOLD}`);
        if (diff1 >= PINCH_THRESHHOLD && diff2 >= PINCH_THRESHHOLD) {
          bakgrund = "green";
        }
        return logga(`    bakgrund ${bakgrund}`);
      } else {
        return tpCache = [];
      }
    }
  } catch (error) {
    e = error;
    return logga(`error in HPZ ${e}`);
  }
};

touchStarted = function(ev) {
  var e, j, len, t;
  try {
    logga('touchStarted', true);
    ev.preventDefault();
    if (touches.length === 2) {
      for (j = 0, len = touches.length; j < len; j++) {
        t = touches[j];
        tpCache.push(t);
      }
    }
    return update_background(ev);
  } catch (error) {
    e = error;
    return logga("error in Started");
  }
};

touchMoved = function(ev) {
  try {
    logga('touchMoved');
    ev.preventDefault();
    if (!touches.length === 2) {
      update_background(ev);
    }
    ev.target.style.outline = "dashed";
    return handle_pinch_zoom(ev);
  } catch (error) {
    return logga("error in Moved");
  }
};

touchEnded = function(ev) {
  var e;
  try {
    logga('touchEnded');
    ev.preventDefault();
    if (touches.length === 0) {
      // Restore background and outline to original values
      ev.target.style.background = "white";
      return ev.target.style.outline = "1px solid black";
    }
  } catch (error) {
    e = error;
    return logga("error in Ended");
  }
};

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic2tldGNoMi5qcyIsInNvdXJjZVJvb3QiOiIuLiIsInNvdXJjZXMiOlsiY29mZmVlXFxza2V0Y2gyLmNvZmZlZSJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiO0FBQUEsSUFBQSxRQUFBLEVBQUEsUUFBQSxFQUFBLElBQUEsRUFBQSxTQUFBLEVBQUEsaUJBQUEsRUFBQSxLQUFBLEVBQUEsV0FBQSxFQUFBLEtBQUEsRUFBQSxVQUFBLEVBQUEsVUFBQSxFQUFBLFlBQUEsRUFBQSxPQUFBLEVBQUE7O0FBQUEsV0FBQSxHQUFjOztBQUNkLE9BQUEsR0FBVTs7QUFDVixRQUFBLEdBQVc7O0FBRVgsS0FBQSxHQUFRLFFBQUEsQ0FBQSxDQUFBO0VBQ1AsWUFBQSxDQUFhLFdBQWIsRUFBeUIsWUFBQSxHQUFhLENBQXRDO1NBQ0EsS0FBQSxDQUFNLGNBQU47QUFGTzs7QUFJUixJQUFBLEdBQU8sUUFBQSxDQUFBLENBQUE7U0FBRyxVQUFBLENBQVcsUUFBWDtBQUFIOztBQUVQLFNBQUEsR0FBWSxRQUFBLENBQUEsQ0FBQTtTQUFHLFdBQUEsR0FBYyxDQUFJO0FBQXJCOztBQUVaLEtBQUEsR0FBUSxRQUFBLENBQUMsSUFBRCxFQUFPLGlCQUFlLEtBQXRCLENBQUE7QUFDUCxNQUFBLENBQUEsRUFBQTtFQUFBLElBQUcsQ0FBSSxXQUFQO0FBQXdCLFdBQXhCOztFQUNBLENBQUEsR0FBSSxRQUFRLENBQUMsb0JBQVQsQ0FBOEIsUUFBOUIsQ0FBd0MsQ0FBQSxDQUFBO0VBQzVDLENBQUMsQ0FBQyxTQUFGLElBQWUsQ0FBQSxDQUFBLENBQUcsSUFBSCxDQUFRLFlBQVIsQ0FBQSxDQUFzQixPQUFPLENBQUMsTUFBOUIsQ0FBcUMsS0FBckM7RUFDZixJQUFHLGNBQUg7V0FBdUIsQ0FBQyxDQUFDLFNBQUYsSUFBZTs7QUFBeUI7TUFBQSxLQUFBLHlDQUFBOztxQkFBeEIsQ0FBQSxTQUFBLENBQUEsQ0FBWSxDQUFDLENBQUMsRUFBZCxDQUFpQixLQUFqQjtNQUF3QixDQUFBOztRQUF6QixD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QUFOLEVBQXNCLElBQXRCO0lBQ0EsRUFBRSxDQUFDLGNBQUgsQ0FBQTtJQUNBLElBQUcsT0FBTyxDQUFDLE1BQVIsS0FBa0IsQ0FBckI7TUFDQyxLQUFBLHlDQUFBOztRQUNDLE9BQU8sQ0FBQyxJQUFSLENBQWEsQ0FBYjtNQURELENBREQ7O1dBR0EsaUJBQUEsQ0FBa0IsRUFBbEIsRUFORDtHQUFBLGFBQUE7SUFPTTtXQUNMLEtBQUEsQ0FBTSxrQkFBTixFQVJEOztBQURjOztBQVdmLFVBQUEsR0FBYSxRQUFBLENBQUMsRUFBRCxDQUFBO0FBQ1o7SUFDQyxLQUFBLENBQU0sWUFBTjtJQUNBLEVBQUUsQ0FBQyxjQUFILENBQUE7SUFDQSxJQUFHLENBQUksT0FBTyxDQUFDLE1BQVosS0FBc0IsQ0FBekI7TUFBZ0MsaUJBQUEsQ0FBa0IsRUFBbEIsRUFBaEM7O0lBQ0EsRUFBRSxDQUFDLE1BQU0sQ0FBQyxLQUFLLENBQUMsT0FBaEIsR0FBMEI7V0FDMUIsaUJBQUEsQ0FBa0IsRUFBbEIsRUFMRDtHQUFBLGFBQUE7V0FPQyxLQUFBLENBQU0sZ0JBQU4sRUFQRDs7QUFEWTs7QUFVYixVQUFBLEdBQWEsUUFBQSxDQUFDLEVBQUQsQ0FBQTtBQUNaLE1BQUE7QUFBQTtJQUNDLEtBQUEsQ0FBTSxZQUFOO0lBQ0EsRUFBRSxDQUFDLGNBQUgsQ0FBQTtJQUNBLElBQUcsT0FBTyxDQUFDLE1BQVIsS0FBa0IsQ0FBckI7O01BRUMsRUFBRSxDQUFDLE1BQU0sQ0FBQyxLQUFLLENBQUMsVUFBaEIsR0FBNkI7YUFDN0IsRUFBRSxDQUFDLE1BQU0sQ0FBQyxLQUFLLENBQUMsT0FBaEIsR0FBMEIsa0JBSDNCO0tBSEQ7R0FBQSxhQUFBO0lBT007V0FDTCxLQUFBLENBQU0sZ0JBQU4sRUFSRDs7QUFEWSIsInNvdXJjZXNDb250ZW50IjpbImxvZ2dhRXZlbnRzID0gdHJ1ZVxyXG50cENhY2hlID0gW11cclxuYmFrZ3J1bmQgPSAnIzg4OCdcclxuXHJcbnNldHVwID0gLT5cclxuXHRjcmVhdGVDYW52YXMgd2luZG93V2lkdGgsd2luZG93SGVpZ2h0LzJcclxuXHRsb2dnYSBcIkhlaiBIw6RwcCAyNyFcIlxyXG5cclxuZHJhdyA9IC0+XHRiYWNrZ3JvdW5kIGJha2dydW5kXHJcblxyXG5lbmFibGVMb2cgPSAtPiBsb2dnYUV2ZW50cyA9IG5vdCBsb2dnYUV2ZW50c1xyXG5cclxubG9nZ2EgPSAobmFtZSwgcHJpbnRUYXJnZXRJZHM9ZmFsc2UpIC0+XHJcblx0aWYgbm90IGxvZ2dhRXZlbnRzIHRoZW4gcmV0dXJuXHJcblx0byA9IGRvY3VtZW50LmdldEVsZW1lbnRzQnlUYWdOYW1lKCdvdXRwdXQnKVswXVxyXG5cdG8uaW5uZXJIVE1MICs9IFwiI3tuYW1lfTogdG91Y2hlcyA9ICN7dG91Y2hlcy5sZW5ndGh9IDxicj5cIlxyXG5cdGlmIHByaW50VGFyZ2V0SWRzIHRoZW4gby5pbm5lckhUTUwgKz0gKFwiLi4uIGlkID0gI3t0LmlkfSA8YnI+XCIgZm9yIHQgaW4gdG91Y2hlcykuam9pbiAnPGJyPidcclxuXHJcbmNsZWFyTG9nID0gLT5cclxuXHRvID0gZG9jdW1lbnQuZ2V0RWxlbWVudHNCeVRhZ05hbWUoJ291dHB1dCcpWzBdXHJcblx0by5pbm5lckhUTUwgPSBcIlwiXHJcblxyXG51cGRhdGVfYmFja2dyb3VuZCA9IChldikgLT5cclxuXHRuID0gdG91Y2hlcy5sZW5ndGhcclxuXHRpZiBuPT0xIHRoZW4gYmFrZ3J1bmQgPSBcInllbGxvd1wiXHJcblx0ZWxzZSBpZiBuPT0yIHRoZW4gYmFrZ3J1bmQgPSBcInBpbmtcIlxyXG5cdGVsc2UgYmFrZ3J1bmQgPSBcImxpZ2h0Ymx1ZVwiXHJcblx0bG9nZ2EgXCJ1cGRhdGVfYmFja2dyb3VuZCAje2Jha2dydW5kfVwiXHJcblxyXG5oYW5kbGVfcGluY2hfem9vbSA9IChldikgLT5cclxuXHR0cnlcclxuXHRcdGxvZ2dhIFwiICBIUFogI3t0cENhY2hlLmxlbmd0aH0gI3t0b3VjaGVzLmxlbmd0aH1cIlxyXG5cdFx0aWYgdG91Y2hlcy5sZW5ndGggPT0gMlxyXG5cdFx0XHQjIENoZWNrIGlmIHRoZSB0d28gdGFyZ2V0IHRvdWNoZXMgYXJlIHRoZSBzYW1lIG9uZXMgdGhhdCBzdGFydGVkIHRoZSAyLXRvdWNoXHJcblx0XHRcdHBvaW50MSA9IC0xXHJcblx0XHRcdHBvaW50MiA9IC0xXHJcblx0XHRcdGZvciBpIGluIHJhbmdlIHRwQ2FjaGUubGVuZ3RoXHJcblx0XHRcdFx0aWYgdHBDYWNoZVtpXS5pZCA9PSB0b3VjaGVzWzBdLmlkIHRoZW4gcG9pbnQxID0gaVxyXG5cdFx0XHRcdGlmIHRwQ2FjaGVbaV0uaWQgPT0gdG91Y2hlc1sxXS5pZCB0aGVuIHBvaW50MiA9IGlcclxuXHRcdFx0bG9nZ2EgXCIgICAgcG9pbnQgI3twb2ludDF9ICN7cG9pbnQyfVwiXHJcblx0XHRcdGlmIHBvaW50MSA+PTAgYW5kIHBvaW50MiA+PSAwXHJcblx0XHRcdFx0IyBDYWxjdWxhdGUgdGhlIGRpZmZlcmVuY2UgYmV0d2VlbiB0aGUgc3RhcnQgYW5kIG1vdmUgY29vcmRpbmF0ZXNcclxuXHRcdFx0XHRkaWZmMSA9IE1hdGguYWJzKHRwQ2FjaGVbcG9pbnQxXS54IC0gdG91Y2hlc1swXS54KVxyXG5cdFx0XHRcdGRpZmYyID0gTWF0aC5hYnModHBDYWNoZVtwb2ludDJdLnggLSB0b3VjaGVzWzFdLngpXHJcblxyXG5cdFx0XHRcdCMgVGhpcyB0aHJlc2hvbGQgaXMgZGV2aWNlIGRlcGVuZGVudCBhcyB3ZWxsIGFzIGFwcGxpY2F0aW9uIHNwZWNpZmljXHJcblx0XHRcdFx0UElOQ0hfVEhSRVNISE9MRCA9IGV2LnRhcmdldC5jbGllbnRXaWR0aCAvIDEwXHJcblx0XHRcdFx0bG9nZ2EgXCIgICAgZGlmZiAje2RpZmYxfSAje2RpZmYyfSAje1BJTkNIX1RIUkVTSEhPTER9XCJcclxuXHRcdFx0XHRpZiBkaWZmMSA+PSBQSU5DSF9USFJFU0hIT0xEIGFuZCBkaWZmMiA+PSBQSU5DSF9USFJFU0hIT0xEIHRoZW4gYmFrZ3J1bmQgPSBcImdyZWVuXCJcclxuXHRcdFx0XHRsb2dnYSBcIiAgICBiYWtncnVuZCAje2Jha2dydW5kfVwiXHJcblx0XHRcdGVsc2VcclxuXHRcdFx0XHR0cENhY2hlID0gW11cclxuXHRjYXRjaCBlXHJcblx0XHRsb2dnYSBcImVycm9yIGluIEhQWiAje2V9XCJcclxuXHJcbnRvdWNoU3RhcnRlZCA9IChldikgLT5cclxuXHR0cnlcclxuXHRcdGxvZ2dhICd0b3VjaFN0YXJ0ZWQnLCB0cnVlXHJcblx0XHRldi5wcmV2ZW50RGVmYXVsdCgpXHJcblx0XHRpZiB0b3VjaGVzLmxlbmd0aCA9PSAyXHJcblx0XHRcdGZvciB0IGluIHRvdWNoZXNcclxuXHRcdFx0XHR0cENhY2hlLnB1c2ggdFxyXG5cdFx0dXBkYXRlX2JhY2tncm91bmQgZXZcclxuXHRjYXRjaCBlXHJcblx0XHRsb2dnYSBcImVycm9yIGluIFN0YXJ0ZWRcIlxyXG5cclxudG91Y2hNb3ZlZCA9IChldikgLT5cclxuXHR0cnlcclxuXHRcdGxvZ2dhICd0b3VjaE1vdmVkJ1xyXG5cdFx0ZXYucHJldmVudERlZmF1bHQoKVxyXG5cdFx0aWYgbm90IHRvdWNoZXMubGVuZ3RoID09IDIgdGhlbiB1cGRhdGVfYmFja2dyb3VuZCBldlxyXG5cdFx0ZXYudGFyZ2V0LnN0eWxlLm91dGxpbmUgPSBcImRhc2hlZFwiXHJcblx0XHRoYW5kbGVfcGluY2hfem9vbSBldlxyXG5cdGNhdGNoIFxyXG5cdFx0bG9nZ2EgXCJlcnJvciBpbiBNb3ZlZFwiXHJcblxyXG50b3VjaEVuZGVkID0gKGV2KSAtPlxyXG5cdHRyeVx0XHJcblx0XHRsb2dnYSAndG91Y2hFbmRlZCdcclxuXHRcdGV2LnByZXZlbnREZWZhdWx0KClcclxuXHRcdGlmIHRvdWNoZXMubGVuZ3RoID09IDBcclxuXHRcdFx0IyBSZXN0b3JlIGJhY2tncm91bmQgYW5kIG91dGxpbmUgdG8gb3JpZ2luYWwgdmFsdWVzXHJcblx0XHRcdGV2LnRhcmdldC5zdHlsZS5iYWNrZ3JvdW5kID0gXCJ3aGl0ZVwiXHJcblx0XHRcdGV2LnRhcmdldC5zdHlsZS5vdXRsaW5lID0gXCIxcHggc29saWQgYmxhY2tcIlxyXG5cdGNhdGNoIGVcclxuXHRcdGxvZ2dhIFwiZXJyb3IgaW4gRW5kZWRcIlxyXG4iXX0=
//# sourceURL=c:\Lab\2020\015-ZoomPan\coffee\sketch2.coffee