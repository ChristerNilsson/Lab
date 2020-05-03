// Generated by CoffeeScript 2.4.1
var bakgrund, clearLog, draw, enableLog, handle_pinch_zoom, log, logEvents, setup, touchEnded, touchMoved, touchStarted, tpCache, update_background;

logEvents = false;

tpCache = [];

bakgrund = '#000';

setup = function() {
  return createCanvas(windowWidth, windowHeight / 2);
};

draw = function() {
  return background(bakgrund);
};

enableLog = function(ev) {
  return logEvents = !logEvents;
};

log = function(name, ev, printTargetIds) {
  var j, len, o, s, t;
  o = document.getElementsByTagName('output')[0];
  s = name + ": touches = " + touches.length; // + "  ; targetTouches = " + ev.targetTouches.length + " ; changedTouches = " + ev.changedTouches.length
  o.innerHTML += s + " <br>";
  if (printTargetIds) {
    s = "";
    for (j = 0, len = touches.length; j < len; j++) {
      t = touches[j];
      s += "... id = " + t.id + " <br>";
    }
    return o.innerHTML += s;
  }
};

clearLog = function(event) {
  var o;
  o = document.getElementsByTagName('output')[0];
  return o.innerHTML = "";
};

update_background = function(ev) {
  var n;
  console.log(ev);
  n = touches.length;
  if (n === 1) {
    return bakgrund = "yellow";
  } else if (n === 2) {
    return bakgrund = "pink";
  } else {
    return bakgrund = "lightblue";
  }
};

// This is a very basic 2-touch move/pinch/zoom handler that does not include
// error handling, only handles horizontal moves, etc.
handle_pinch_zoom = function(ev) {
  var PINCH_THRESHHOLD, diff1, diff2, i, j, len, point1, point2, ref, results;
  console.log(ev);
  if (touches.length === 2 && ev.changedTouches.length === 2) {
    // Check if the two target touches are the same ones that started
    // the 2-touch
    point1 = -1;
    point2 = -1;
    ref = range(tpCache.length);
    results = [];
    for (j = 0, len = ref.length; j < len; j++) {
      i = ref[j];
      if (tpCache[i].id === touches[0].id) {
        point1 = i;
      }
      if (tpCache[i].id === touches[1].id) {
        point2 = i;
      }
      if (point1 >= 0 && point2 >= 0) {
        
        // Calculate the difference between the start and move coordinates
        diff1 = Math.abs(tpCache[point1].clientX - touches[0].clientX);
        diff2 = Math.abs(tpCache[point2].clientX - touches[1].clientX);
        // This threshold is device dependent as well as application specific
        PINCH_THRESHHOLD = ev.target.clientWidth / 10;
        if (diff1 >= PINCH_THRESHHOLD && diff2 >= PINCH_THRESHHOLD) {
          results.push(ev.target.style.background = "green");
        } else {
          results.push(void 0);
        }
      } else {
        results.push(tpCache = []);
      }
    }
    return results;
  }
};

touchStarted = function(ev) {
  var j, len, t;
  console.log(ev);
  // If the user makes simultaneious touches, the browser will fire a
  // separate touchstart event for each touch point. Thus if there are
  // three simultaneous touches, the first touchstart event will have
  // targetTouches length of one, the second event will have a length
  // of two, and so on.
  ev.preventDefault();
  // Cache the touch points for later processing of 2-touch pinch/zoom
  if (touches.length === 2) {
    for (j = 0, len = tTouches.length; j < len; j++) {
      t = tTouches[j];
      tpCache.push(t);
    }
  }
  if (logEvents) {
    log("touchStart", ev, true);
  }
  return update_background(ev);
};

touchMoved = function(ev) {
  console.log(ev);
  // Note: if the user makes more than one "simultaneous" touches, most browsers
  // fire at least one touchmove event and some will fire several touchmoves.
  // Consequently, an application might want to "ignore" some touchmoves.

  // This function sets the target element's outline to "dashed" to visualy
  // indicate the target received a move event.

  ev.preventDefault();
  if (logEvents) {
    log("touchMove", ev, false);
  }
  // To avoid too much color flashing many touchmove events are started,
  // don't update the background if two touch points are active
  if (!touches.length === 2) { // and ev.targetTouches.length == 2)
    update_background(ev);
  }
  // Set the target element's outline to dashed to give a clear visual
  // indication the element received a move event.
  ev.target.style.outline = "dashed";
  // Check this event for 2-touch Move/Pinch/Zoom gesture
  return handle_pinch_zoom(ev);
};

touchEnded = function(ev) {
  console.log(ev);
  ev.preventDefault();
  if (logEvents) {
    log(ev.type, ev, false);
  }
  if (touches.length === 0) {
    // Restore background and outline to original values
    ev.target.style.background = "white";
    return ev.target.style.outline = "1px solid black";
  }
};

// set_handlers = (name) ->
// 	# Install event handlers for the given element
// 	el = document.getElementById name
// 	el.ontouchstart = start_handler
// 	el.ontouchmove = move_handler
// 	# Use same handler for touchcancel and touchend
// 	el.ontouchcancel = end_handler
// 	el.ontouchend = end_handler

// init = ->
// 	set_handlers "target1"
// 	set_handlers "target2"
// 	set_handlers "target3"
// 	set_handlers "target4"

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic2tldGNoMi5qcyIsInNvdXJjZVJvb3QiOiIuLiIsInNvdXJjZXMiOlsiY29mZmVlXFxza2V0Y2gyLmNvZmZlZSJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiO0FBQUEsSUFBQSxRQUFBLEVBQUEsUUFBQSxFQUFBLElBQUEsRUFBQSxTQUFBLEVBQUEsaUJBQUEsRUFBQSxHQUFBLEVBQUEsU0FBQSxFQUFBLEtBQUEsRUFBQSxVQUFBLEVBQUEsVUFBQSxFQUFBLFlBQUEsRUFBQSxPQUFBLEVBQUE7O0FBQUEsU0FBQSxHQUFZOztBQUNaLE9BQUEsR0FBVTs7QUFDVixRQUFBLEdBQVc7O0FBRVgsS0FBQSxHQUFRLFFBQUEsQ0FBQSxDQUFBO1NBQ1AsWUFBQSxDQUFhLFdBQWIsRUFBeUIsWUFBQSxHQUFhLENBQXRDO0FBRE87O0FBR1IsSUFBQSxHQUFPLFFBQUEsQ0FBQSxDQUFBO1NBQ04sVUFBQSxDQUFXLFFBQVg7QUFETTs7QUFHUCxTQUFBLEdBQVksUUFBQSxDQUFDLEVBQUQsQ0FBQTtTQUFRLFNBQUEsR0FBWSxDQUFJO0FBQXhCOztBQUVaLEdBQUEsR0FBTSxRQUFBLENBQUMsSUFBRCxFQUFPLEVBQVAsRUFBVyxjQUFYLENBQUE7QUFDTCxNQUFBLENBQUEsRUFBQSxHQUFBLEVBQUEsQ0FBQSxFQUFBLENBQUEsRUFBQTtFQUFBLENBQUEsR0FBSSxRQUFRLENBQUMsb0JBQVQsQ0FBOEIsUUFBOUIsQ0FBd0MsQ0FBQSxDQUFBO0VBQzVDLENBQUEsR0FBSSxJQUFBLEdBQU8sY0FBUCxHQUF3QixPQUFPLENBQUMsT0FEcEM7RUFFQSxDQUFDLENBQUMsU0FBRixJQUFlLENBQUEsR0FBSTtFQUVuQixJQUFHLGNBQUg7SUFDQyxDQUFBLEdBQUk7SUFDSixLQUFBLHlDQUFBOztNQUNDLENBQUEsSUFBSyxXQUFBLEdBQWMsQ0FBQyxDQUFDLEVBQWhCLEdBQXFCO0lBRDNCO1dBRUEsQ0FBQyxDQUFDLFNBQUYsSUFBZSxFQUpoQjs7QUFMSzs7QUFXTixRQUFBLEdBQVcsUUFBQSxD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QTtFQUNBLElBQUcsU0FBSDtJQUFrQixHQUFBLENBQUksV0FBSixFQUFpQixFQUFqQixFQUFxQixLQUFyQixFQUFsQjtHQVRBOzs7RUFhQSxJQUFHLENBQUksT0FBTyxDQUFDLE1BQVosS0FBc0IsQ0FBekI7SUFDQyxpQkFBQSxDQUFrQixFQUFsQixFQUREO0dBYkE7OztFQWtCQSxFQUFFLENBQUMsTUFBTSxDQUFDLEtBQUssQ0FBQyxPQUFoQixHQUEwQixTQWxCMUI7O1NBcUJBLGlCQUFBLENBQWtCLEVBQWxCO0FBdEJZOztBQXdCYixVQUFBLEdBQWEsUUFBQSxDQUFDLEVBQUQsQ0FBQTtFQUNaLE9BQU8sQ0FBQyxHQUFSLENBQVksRUFBWjtFQUNBLEVBQUUsQ0FBQyxjQUFILENBQUE7RUFDQSxJQUFHLFNBQUg7SUFBa0IsR0FBQSxDQUFJLEVBQUUsQ0FBQyxJQUFQLEVBQWEsRUFBYixFQUFpQixLQUFqQixFQUFsQjs7RUFDQSxJQUFHLE9BQU8sQ0FBQyxNQUFSLEtBQWtCLENBQXJCOztJQUVDLEVBQUUsQ0FBQyxNQUFNLENBQUMsS0FBSyxDQUFDLFVBQWhCLEdBQTZCO1dBQzdCLEVBQUUsQ0FBQyxNQUFNLENBQUMsS0FBSyxDQUFDLE9BQWhCLEdBQTBCLGtCQUgzQjs7QUFKWTs7QUFqR2IiLCJzb3VyY2VzQ29udGVudCI6WyJsb2dFdmVudHMgPSBmYWxzZVxyXG50cENhY2hlID0gW11cclxuYmFrZ3J1bmQgPSAnIzAwMCdcclxuXHJcbnNldHVwID0gLT5cclxuXHRjcmVhdGVDYW52YXMgd2luZG93V2lkdGgsd2luZG93SGVpZ2h0LzJcclxuXHJcbmRyYXcgPSAtPlxyXG5cdGJhY2tncm91bmQgYmFrZ3J1bmRcclxuXHJcbmVuYWJsZUxvZyA9IChldikgLT4gbG9nRXZlbnRzID0gbm90IGxvZ0V2ZW50c1xyXG5cclxubG9nID0gKG5hbWUsIGV2LCBwcmludFRhcmdldElkcykgLT5cclxuXHRvID0gZG9jdW1lbnQuZ2V0RWxlbWVudHNCeVRhZ05hbWUoJ291dHB1dCcpWzBdXHJcblx0cyA9IG5hbWUgKyBcIjogdG91Y2hlcyA9IFwiICsgdG91Y2hlcy5sZW5ndGggIyArIFwiICA7IHRhcmdldFRvdWNoZXMgPSBcIiArIGV2LnRhcmdldFRvdWNoZXMubGVuZ3RoICsgXCIgOyBjaGFuZ2VkVG91Y2hlcyA9IFwiICsgZXYuY2hhbmdlZFRvdWNoZXMubGVuZ3RoXHJcblx0by5pbm5lckhUTUwgKz0gcyArIFwiIDxicj5cIlxyXG5cclxuXHRpZiBwcmludFRhcmdldElkc1xyXG5cdFx0cyA9IFwiXCJcclxuXHRcdGZvciB0IGluIHRvdWNoZXNcclxuXHRcdFx0cyArPSBcIi4uLiBpZCA9IFwiICsgdC5pZCArIFwiIDxicj5cIlxyXG5cdFx0by5pbm5lckhUTUwgKz0gc1xyXG5cclxuY2xlYXJMb2cgPSAoZXZlbnQpIC0+XHJcblx0byA9IGRvY3VtZW50LmdldEVsZW1lbnRzQnlUYWdOYW1lKCdvdXRwdXQnKVswXVxyXG5cdG8uaW5uZXJIVE1MID0gXCJcIlxyXG5cclxudXBkYXRlX2JhY2tncm91bmQgPSAoZXYpIC0+XHJcblx0Y29uc29sZS5sb2cgZXZcclxuXHRuID0gdG91Y2hlcy5sZW5ndGhcclxuXHRpZiBuPT0xIHRoZW4gYmFrZ3J1bmQgPSBcInllbGxvd1wiXHJcblx0ZWxzZSBpZiBuPT0yIHRoZW4gYmFrZ3J1bmQgPSBcInBpbmtcIlxyXG5cdGVsc2UgYmFrZ3J1bmQgPSBcImxpZ2h0Ymx1ZVwiXHJcblxyXG4jIFRoaXMgaXMgYSB2ZXJ5IGJhc2ljIDItdG91Y2ggbW92ZS9waW5jaC96b29tIGhhbmRsZXIgdGhhdCBkb2VzIG5vdCBpbmNsdWRlXHJcbiMgZXJyb3IgaGFuZGxpbmcsIG9ubHkgaGFuZGxlcyBob3Jpem9udGFsIG1vdmVzLCBldGMuXHJcbmhhbmRsZV9waW5jaF96b29tID0gKGV2KSAtPlxyXG5cdGNvbnNvbGUubG9nIGV2XHJcblx0aWYgdG91Y2hlcy5sZW5ndGggPT0gMiBhbmQgZXYuY2hhbmdlZFRvdWNoZXMubGVuZ3RoID09IDJcclxuXHRcdCMgQ2hlY2sgaWYgdGhlIHR3byB0YXJnZXQgdG91Y2hlcyBhcmUgdGhlIHNhbWUgb25lcyB0aGF0IHN0YXJ0ZWRcclxuXHRcdCMgdGhlIDItdG91Y2hcclxuXHRcdHBvaW50MSA9IC0xXHJcblx0XHRwb2ludDIgPSAtMVxyXG5cdFx0Zm9yIGkgaW4gcmFuZ2UgdHBDYWNoZS5sZW5ndGhcclxuXHRcdFx0aWYgdHBDYWNoZVtpXS5pZCA9PSB0b3VjaGVzWzBdLmlkIHRoZW4gcG9pbnQxID0gaVxyXG5cdFx0XHRpZiB0cENhY2hlW2ldLmlkID09IHRvdWNoZXNbMV0uaWQgdGhlbiBwb2ludDIgPSBpXHJcblxyXG5cdFx0XHRpZiAocG9pbnQxID49MCAmJiBwb2ludDIgPj0gMCkgXHJcblx0XHRcdFx0IyBDYWxjdWxhdGUgdGhlIGRpZmZlcmVuY2UgYmV0d2VlbiB0aGUgc3RhcnQgYW5kIG1vdmUgY29vcmRpbmF0ZXNcclxuXHRcdFx0XHRkaWZmMSA9IE1hdGguYWJzKHRwQ2FjaGVbcG9pbnQxXS5jbGllbnRYIC0gdG91Y2hlc1swXS5jbGllbnRYKVxyXG5cdFx0XHRcdGRpZmYyID0gTWF0aC5hYnModHBDYWNoZVtwb2ludDJdLmNsaWVudFggLSB0b3VjaGVzWzFdLmNsaWVudFgpXHJcblxyXG5cdFx0XHRcdCMgVGhpcyB0aHJlc2hvbGQgaXMgZGV2aWNlIGRlcGVuZGVudCBhcyB3ZWxsIGFzIGFwcGxpY2F0aW9uIHNwZWNpZmljXHJcblx0XHRcdFx0UElOQ0hfVEhSRVNISE9MRCA9IGV2LnRhcmdldC5jbGllbnRXaWR0aCAvIDEwXHJcblx0XHRcdFx0aWYgZGlmZjEgPj0gUElOQ0hfVEhSRVNISE9MRCBhbmQgZGlmZjIgPj0gUElOQ0hfVEhSRVNISE9MRCB0aGVuIGV2LnRhcmdldC5zdHlsZS5iYWNrZ3JvdW5kID0gXCJncmVlblwiXHJcblx0XHRcdGVsc2VcclxuXHRcdFx0XHR0cENhY2hlID0gW11cclxuXHJcbnRvdWNoU3RhcnRlZCA9IChldikgLT5cclxuXHRjb25zb2xlLmxvZyBldlxyXG5cdCMgSWYgdGhlIHVzZXIgbWFrZXMgc2ltdWx0YW5laW91cyB0b3VjaGVzLCB0aGUgYnJvd3NlciB3aWxsIGZpcmUgYVxyXG5cdCMgc2VwYXJhdGUgdG91Y2hzdGFydCBldmVudCBmb3IgZWFjaCB0b3VjaCBwb2ludC4gVGh1cyBpZiB0aGVyZSBhcmVcclxuXHQjIHRocmVlIHNpbXVsdGFuZW91cyB0b3VjaGVzLCB0aGUgZmlyc3QgdG91Y2hzdGFydCBldmVudCB3aWxsIGhhdmVcclxuXHQjIHRhcmdldFRvdWNoZXMgbGVuZ3RoIG9mIG9uZSwgdGhlIHNlY29uZCBldmVudCB3aWxsIGhhdmUgYSBsZW5ndGhcclxuXHQjIG9mIHR3bywgYW5kIHNvIG9uLlxyXG5cdGV2LnByZXZlbnREZWZhdWx0KClcclxuXHQjIENhY2hlIHRoZSB0b3VjaCBwb2ludHMgZm9yIGxhdGVyIHByb2Nlc3Npbmcgb2YgMi10b3VjaCBwaW5jaC96b29tXHJcblx0aWYgdG91Y2hlcy5sZW5ndGggPT0gMlxyXG5cdFx0Zm9yIHQgaW4gdFRvdWNoZXNcclxuXHRcdFx0dHBDYWNoZS5wdXNoIHRcclxuXHRpZiBsb2dFdmVudHMgdGhlbiBsb2cgXCJ0b3VjaFN0YXJ0XCIsIGV2LCB0cnVlXHJcblx0dXBkYXRlX2JhY2tncm91bmQgZXZcclxuXHJcbnRvdWNoTW92ZWQgPSAoZXYpIC0+XHJcblx0Y29uc29sZS5sb2cgZXZcclxuXHQjIE5vdGU6IGlmIHRoZSB1c2VyIG1ha2VzIG1vcmUgdGhhbiBvbmUgXCJzaW11bHRhbmVvdXNcIiB0b3VjaGVzLCBtb3N0IGJyb3dzZXJzXHJcblx0IyBmaXJlIGF0IGxlYXN0IG9uZSB0b3VjaG1vdmUgZXZlbnQgYW5kIHNvbWUgd2lsbCBmaXJlIHNldmVyYWwgdG91Y2htb3Zlcy5cclxuXHQjIENvbnNlcXVlbnRseSwgYW4gYXBwbGljYXRpb24gbWlnaHQgd2FudCB0byBcImlnbm9yZVwiIHNvbWUgdG91Y2htb3Zlcy5cclxuXHQjXHJcblx0IyBUaGlzIGZ1bmN0aW9uIHNldHMgdGhlIHRhcmdldCBlbGVtZW50J3Mgb3V0bGluZSB0byBcImRhc2hlZFwiIHRvIHZpc3VhbHlcclxuXHQjIGluZGljYXRlIHRoZSB0YXJnZXQgcmVjZWl2ZWQgYSBtb3ZlIGV2ZW50LlxyXG5cdCNcclxuXHRldi5wcmV2ZW50RGVmYXVsdCgpXHJcblx0aWYgbG9nRXZlbnRzIHRoZW4gbG9nIFwidG91Y2hNb3ZlXCIsIGV2LCBmYWxzZVxyXG5cclxuXHQjIFRvIGF2b2lkIHRvbyBtdWNoIGNvbG9yIGZsYXNoaW5nIG1hbnkgdG91Y2htb3ZlIGV2ZW50cyBhcmUgc3RhcnRlZCxcclxuXHQjIGRvbid0IHVwZGF0ZSB0aGUgYmFja2dyb3VuZCBpZiB0d28gdG91Y2ggcG9pbnRzIGFyZSBhY3RpdmVcclxuXHRpZiBub3QgdG91Y2hlcy5sZW5ndGggPT0gMiAjIGFuZCBldi50YXJnZXRUb3VjaGVzLmxlbmd0aCA9PSAyKVxyXG5cdFx0dXBkYXRlX2JhY2tncm91bmQgZXZcclxuXHJcblx0IyBTZXQgdGhlIHRhcmdldCBlbGVtZW50J3Mgb3V0bGluZSB0byBkYXNoZWQgdG8gZ2l2ZSBhIGNsZWFyIHZpc3VhbFxyXG5cdCMgaW5kaWNhdGlvbiB0aGUgZWxlbWVudCByZWNlaXZlZCBhIG1vdmUgZXZlbnQuXHJcblx0ZXYudGFyZ2V0LnN0eWxlLm91dGxpbmUgPSBcImRhc2hlZFwiXHJcblxyXG5cdCMgQ2hlY2sgdGhpcyBldmVudCBmb3IgMi10b3VjaCBNb3ZlL1BpbmNoL1pvb20gZ2VzdHVyZVxyXG5cdGhhbmRsZV9waW5jaF96b29tIGV2XHJcblxyXG50b3VjaEVuZGVkID0gKGV2KSAtPlxyXG5cdGNvbnNvbGUubG9nIGV2XHJcblx0ZXYucHJldmVudERlZmF1bHQoKVxyXG5cdGlmIGxvZ0V2ZW50cyB0aGVuIGxvZyBldi50eXBlLCBldiwgZmFsc2VcclxuXHRpZiB0b3VjaGVzLmxlbmd0aCA9PSAwXHJcblx0XHQjIFJlc3RvcmUgYmFja2dyb3VuZCBhbmQgb3V0bGluZSB0byBvcmlnaW5hbCB2YWx1ZXNcclxuXHRcdGV2LnRhcmdldC5zdHlsZS5iYWNrZ3JvdW5kID0gXCJ3aGl0ZVwiXHJcblx0XHRldi50YXJnZXQuc3R5bGUub3V0bGluZSA9IFwiMXB4IHNvbGlkIGJsYWNrXCJcclxuXHJcbiMgc2V0X2hhbmRsZXJzID0gKG5hbWUpIC0+XHJcbiMgXHQjIEluc3RhbGwgZXZlbnQgaGFuZGxlcnMgZm9yIHRoZSBnaXZlbiBlbGVtZW50XHJcbiMgXHRlbCA9IGRvY3VtZW50LmdldEVsZW1lbnRCeUlkIG5hbWVcclxuIyBcdGVsLm9udG91Y2hzdGFydCA9IHN0YXJ0X2hhbmRsZXJcclxuIyBcdGVsLm9udG91Y2htb3ZlID0gbW92ZV9oYW5kbGVyXHJcbiMgXHQjIFVzZSBzYW1lIGhhbmRsZXIgZm9yIHRvdWNoY2FuY2VsIGFuZCB0b3VjaGVuZFxyXG4jIFx0ZWwub250b3VjaGNhbmNlbCA9IGVuZF9oYW5kbGVyXHJcbiMgXHRlbC5vbnRvdWNoZW5kID0gZW5kX2hhbmRsZXJcclxuXHJcbiMgaW5pdCA9IC0+XHJcbiMgXHRzZXRfaGFuZGxlcnMgXCJ0YXJnZXQxXCJcclxuIyBcdHNldF9oYW5kbGVycyBcInRhcmdldDJcIlxyXG4jIFx0c2V0X2hhbmRsZXJzIFwidGFyZ2V0M1wiXHJcbiMgXHRzZXRfaGFuZGxlcnMgXCJ0YXJnZXQ0XCJcclxuIl19
//# sourceURL=c:\Lab\2020\015-ZoomPan\coffee\sketch2.coffee