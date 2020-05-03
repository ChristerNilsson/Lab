// Generated by CoffeeScript 2.4.1
var bakgrund, clearLog, draw, enableLog, handle_pinch_zoom, logga, loggaEvents, setup, touchEnded, touchMoved, touchStarted, tpCache, update_background;

loggaEvents = false;

tpCache = [];

bakgrund = '#888';

setup = function() {
  createCanvas(windowWidth, windowHeight / 2);
  return logga("Hej Häpp 28!");
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

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic2tldGNoMi5qcyIsInNvdXJjZVJvb3QiOiIuLiIsInNvdXJjZXMiOlsiY29mZmVlXFxza2V0Y2gyLmNvZmZlZSJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiO0FBQUEsSUFBQSxRQUFBLEVBQUEsUUFBQSxFQUFBLElBQUEsRUFBQSxTQUFBLEVBQUEsaUJBQUEsRUFBQSxLQUFBLEVBQUEsV0FBQSxFQUFBLEtBQUEsRUFBQSxVQUFBLEVBQUEsVUFBQSxFQUFBLFlBQUEsRUFBQSxPQUFBLEVBQUE7O0FBQUEsV0FBQSxHQUFjOztBQUNkLE9BQUEsR0FBVTs7QUFDVixRQUFBLEdBQVc7O0FBRVgsS0FBQSxHQUFRLFFBQUEsQ0FBQSxDQUFBO0VBQ1AsWUFBQSxDQUFhLFdBQWIsRUFBeUIsWUFBQSxHQUFhLENBQXRDO1NBQ0EsS0FBQSxDQUFNLGNBQU47QUFGTzs7QUFJUixJQUFBLEdBQU8sUUFBQSxDQUFBLENBQUE7U0FBRyxVQUFBLENBQVcsUUFBWDtBQUFIOztBQUVQLFNBQUEsR0FBWSxRQUFBLENBQUEsQ0FBQTtTQUFHLFdBQUEsR0FBYyxDQUFJO0FBQXJCOztBQUVaLEtBQUEsR0FBUSxRQUFBLENBQUMsSUFBRCxFQUFPLGlCQUFlLEtBQXRCLENBQUE7QUFDUCxNQUFBLENBQUEsRUFBQTtFQUFBLElBQUcsQ0FBSSxXQUFQO0FBQXdCLFdBQXhCOztFQUNBLENBQUEsR0FBSSxRQUFRLENBQUMsb0JBQVQsQ0FBOEIsUUFBOUIsQ0FBd0MsQ0FBQSxDQUFBO0VBQzVDLENBQUMsQ0FBQyxTQUFGLElBQWUsQ0FBQSxDQUFBLENBQUcsSUFBSCxDQUFRLFlBQVIsQ0FBQSxDQUFzQixPQUFPLENBQUMsTUFBOUIsQ0FBcUMsS0FBckM7RUFDZixJQUFHLGNBQUg7V0FBdUIsQ0FBQyxDQUFDLFNBQUYsSUFBZTs7QUFBeUI7TUFBQSxLQUFBLHlDQUFBOztxQkFBeEIsQ0FBQSxTQUFBLENBQUEsQ0FBWSxDQUFDLENBQUMsRUFBZCxDQUFpQixLQUFqQjtNQUF3QixDQUFBOztRQUF6QixD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QUFOLEVBQXNCLElBQXRCO0lBQ0EsRUFBRSxDQUFDLGNBQUgsQ0FBQTtJQUNBLElBQUcsT0FBTyxDQUFDLE1BQVIsS0FBa0IsQ0FBckI7TUFDQyxLQUFBLHlDQUFBOztRQUNDLE9BQU8sQ0FBQyxJQUFSLENBQWEsQ0FBYjtNQURELENBREQ7O1dBR0EsaUJBQUEsQ0FBa0IsRUFBbEIsRUFORDtHQUFBLGFBQUE7SUFPTTtXQUNMLEtBQUEsQ0FBTSxrQkFBTixFQVJEOztBQURjOztBQVdmLFVBQUEsR0FBYSxRQUFBLENBQUMsRUFBRCxDQUFBO0FBQ1o7SUFDQyxLQUFBLENBQU0sWUFBTjtJQUNBLEVBQUUsQ0FBQyxjQUFILENBQUE7SUFDQSxJQUFHLENBQUksT0FBTyxDQUFDLE1BQVosS0FBc0IsQ0FBekI7TUFBZ0MsaUJBQUEsQ0FBa0IsRUFBbEIsRUFBaEM7O0lBQ0EsRUFBRSxDQUFDLE1BQU0sQ0FBQyxLQUFLLENBQUMsT0FBaEIsR0FBMEI7V0FDMUIsaUJBQUEsQ0FBa0IsRUFBbEIsRUFMRDtHQUFBLGFBQUE7V0FPQyxLQUFBLENBQU0sZ0JBQU4sRUFQRDs7QUFEWTs7QUFVYixVQUFBLEdBQWEsUUFBQSxDQUFDLEVBQUQsQ0FBQTtBQUNaLE1BQUE7QUFBQTtJQUNDLEtBQUEsQ0FBTSxZQUFOO0lBQ0EsRUFBRSxDQUFDLGNBQUgsQ0FBQTtJQUNBLElBQUcsT0FBTyxDQUFDLE1BQVIsS0FBa0IsQ0FBckI7O01BRUMsRUFBRSxDQUFDLE1BQU0sQ0FBQyxLQUFLLENBQUMsVUFBaEIsR0FBNkI7YUFDN0IsRUFBRSxDQUFDLE1BQU0sQ0FBQyxLQUFLLENBQUMsT0FBaEIsR0FBMEIsa0JBSDNCO0tBSEQ7R0FBQSxhQUFBO0lBT007V0FDTCxLQUFBLENBQU0sZ0JBQU4sRUFSRDs7QUFEWSIsInNvdXJjZXNDb250ZW50IjpbImxvZ2dhRXZlbnRzID0gZmFsc2VcclxudHBDYWNoZSA9IFtdXHJcbmJha2dydW5kID0gJyM4ODgnXHJcblxyXG5zZXR1cCA9IC0+XHJcblx0Y3JlYXRlQ2FudmFzIHdpbmRvd1dpZHRoLHdpbmRvd0hlaWdodC8yXHJcblx0bG9nZ2EgXCJIZWogSMOkcHAgMjghXCJcclxuXHJcbmRyYXcgPSAtPlx0YmFja2dyb3VuZCBiYWtncnVuZFxyXG5cclxuZW5hYmxlTG9nID0gLT4gbG9nZ2FFdmVudHMgPSBub3QgbG9nZ2FFdmVudHNcclxuXHJcbmxvZ2dhID0gKG5hbWUsIHByaW50VGFyZ2V0SWRzPWZhbHNlKSAtPlxyXG5cdGlmIG5vdCBsb2dnYUV2ZW50cyB0aGVuIHJldHVyblxyXG5cdG8gPSBkb2N1bWVudC5nZXRFbGVtZW50c0J5VGFnTmFtZSgnb3V0cHV0JylbMF1cclxuXHRvLmlubmVySFRNTCArPSBcIiN7bmFtZX06IHRvdWNoZXMgPSAje3RvdWNoZXMubGVuZ3RofSA8YnI+XCJcclxuXHRpZiBwcmludFRhcmdldElkcyB0aGVuIG8uaW5uZXJIVE1MICs9IChcIi4uLiBpZCA9ICN7dC5pZH0gPGJyPlwiIGZvciB0IGluIHRvdWNoZXMpLmpvaW4gJzxicj4nXHJcblxyXG5jbGVhckxvZyA9IC0+XHJcblx0byA9IGRvY3VtZW50LmdldEVsZW1lbnRzQnlUYWdOYW1lKCdvdXRwdXQnKVswXVxyXG5cdG8uaW5uZXJIVE1MID0gXCJcIlxyXG5cclxudXBkYXRlX2JhY2tncm91bmQgPSAoZXYpIC0+XHJcblx0biA9IHRvdWNoZXMubGVuZ3RoXHJcblx0aWYgbj09MSB0aGVuIGJha2dydW5kID0gXCJ5ZWxsb3dcIlxyXG5cdGVsc2UgaWYgbj09MiB0aGVuIGJha2dydW5kID0gXCJwaW5rXCJcclxuXHRlbHNlIGJha2dydW5kID0gXCJsaWdodGJsdWVcIlxyXG5cdGxvZ2dhIFwidXBkYXRlX2JhY2tncm91bmQgI3tiYWtncnVuZH1cIlxyXG5cclxuaGFuZGxlX3BpbmNoX3pvb20gPSAoZXYpIC0+XHJcblx0dHJ5XHJcblx0XHRsb2dnYSBcIiAgSFBaICN7dHBDYWNoZS5sZW5ndGh9ICN7dG91Y2hlcy5sZW5ndGh9XCJcclxuXHRcdGlmIHRvdWNoZXMubGVuZ3RoID09IDJcclxuXHRcdFx0IyBDaGVjayBpZiB0aGUgdHdvIHRhcmdldCB0b3VjaGVzIGFyZSB0aGUgc2FtZSBvbmVzIHRoYXQgc3RhcnRlZCB0aGUgMi10b3VjaFxyXG5cdFx0XHRwb2ludDEgPSAtMVxyXG5cdFx0XHRwb2ludDIgPSAtMVxyXG5cdFx0XHRmb3IgaSBpbiByYW5nZSB0cENhY2hlLmxlbmd0aFxyXG5cdFx0XHRcdGlmIHRwQ2FjaGVbaV0uaWQgPT0gdG91Y2hlc1swXS5pZCB0aGVuIHBvaW50MSA9IGlcclxuXHRcdFx0XHRpZiB0cENhY2hlW2ldLmlkID09IHRvdWNoZXNbMV0uaWQgdGhlbiBwb2ludDIgPSBpXHJcblx0XHRcdGxvZ2dhIFwiICAgIHBvaW50ICN7cG9pbnQxfSAje3BvaW50Mn1cIlxyXG5cdFx0XHRpZiBwb2ludDEgPj0wIGFuZCBwb2ludDIgPj0gMFxyXG5cdFx0XHRcdCMgQ2FsY3VsYXRlIHRoZSBkaWZmZXJlbmNlIGJldHdlZW4gdGhlIHN0YXJ0IGFuZCBtb3ZlIGNvb3JkaW5hdGVzXHJcblx0XHRcdFx0ZGlmZjEgPSBNYXRoLmFicyh0cENhY2hlW3BvaW50MV0ueCAtIHRvdWNoZXNbMF0ueClcclxuXHRcdFx0XHRkaWZmMiA9IE1hdGguYWJzKHRwQ2FjaGVbcG9pbnQyXS54IC0gdG91Y2hlc1sxXS54KVxyXG5cclxuXHRcdFx0XHQjIFRoaXMgdGhyZXNob2xkIGlzIGRldmljZSBkZXBlbmRlbnQgYXMgd2VsbCBhcyBhcHBsaWNhdGlvbiBzcGVjaWZpY1xyXG5cdFx0XHRcdFBJTkNIX1RIUkVTSEhPTEQgPSBldi50YXJnZXQuY2xpZW50V2lkdGggLyAxMFxyXG5cdFx0XHRcdGxvZ2dhIFwiICAgIGRpZmYgI3tkaWZmMX0gI3tkaWZmMn0gI3tQSU5DSF9USFJFU0hIT0xEfVwiXHJcblx0XHRcdFx0aWYgZGlmZjEgPj0gUElOQ0hfVEhSRVNISE9MRCBhbmQgZGlmZjIgPj0gUElOQ0hfVEhSRVNISE9MRCB0aGVuIGJha2dydW5kID0gXCJncmVlblwiXHJcblx0XHRcdFx0bG9nZ2EgXCIgICAgYmFrZ3J1bmQgI3tiYWtncnVuZH1cIlxyXG5cdFx0XHRlbHNlXHJcblx0XHRcdFx0dHBDYWNoZSA9IFtdXHJcblx0Y2F0Y2ggZVxyXG5cdFx0bG9nZ2EgXCJlcnJvciBpbiBIUFogI3tlfVwiXHJcblxyXG50b3VjaFN0YXJ0ZWQgPSAoZXYpIC0+XHJcblx0dHJ5XHJcblx0XHRsb2dnYSAndG91Y2hTdGFydGVkJywgdHJ1ZVxyXG5cdFx0ZXYucHJldmVudERlZmF1bHQoKVxyXG5cdFx0aWYgdG91Y2hlcy5sZW5ndGggPT0gMlxyXG5cdFx0XHRmb3IgdCBpbiB0b3VjaGVzXHJcblx0XHRcdFx0dHBDYWNoZS5wdXNoIHRcclxuXHRcdHVwZGF0ZV9iYWNrZ3JvdW5kIGV2XHJcblx0Y2F0Y2ggZVxyXG5cdFx0bG9nZ2EgXCJlcnJvciBpbiBTdGFydGVkXCJcclxuXHJcbnRvdWNoTW92ZWQgPSAoZXYpIC0+XHJcblx0dHJ5XHJcblx0XHRsb2dnYSAndG91Y2hNb3ZlZCdcclxuXHRcdGV2LnByZXZlbnREZWZhdWx0KClcclxuXHRcdGlmIG5vdCB0b3VjaGVzLmxlbmd0aCA9PSAyIHRoZW4gdXBkYXRlX2JhY2tncm91bmQgZXZcclxuXHRcdGV2LnRhcmdldC5zdHlsZS5vdXRsaW5lID0gXCJkYXNoZWRcIlxyXG5cdFx0aGFuZGxlX3BpbmNoX3pvb20gZXZcclxuXHRjYXRjaCBcclxuXHRcdGxvZ2dhIFwiZXJyb3IgaW4gTW92ZWRcIlxyXG5cclxudG91Y2hFbmRlZCA9IChldikgLT5cclxuXHR0cnlcdFxyXG5cdFx0bG9nZ2EgJ3RvdWNoRW5kZWQnXHJcblx0XHRldi5wcmV2ZW50RGVmYXVsdCgpXHJcblx0XHRpZiB0b3VjaGVzLmxlbmd0aCA9PSAwXHJcblx0XHRcdCMgUmVzdG9yZSBiYWNrZ3JvdW5kIGFuZCBvdXRsaW5lIHRvIG9yaWdpbmFsIHZhbHVlc1xyXG5cdFx0XHRldi50YXJnZXQuc3R5bGUuYmFja2dyb3VuZCA9IFwid2hpdGVcIlxyXG5cdFx0XHRldi50YXJnZXQuc3R5bGUub3V0bGluZSA9IFwiMXB4IHNvbGlkIGJsYWNrXCJcclxuXHRjYXRjaCBlXHJcblx0XHRsb2dnYSBcImVycm9yIGluIEVuZGVkXCJcclxuIl19
//# sourceURL=c:\Lab\2020\015-ZoomPan\coffee\sketch2.coffee