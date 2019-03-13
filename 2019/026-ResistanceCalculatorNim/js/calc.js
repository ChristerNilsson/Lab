// Generated by CoffeeScript 2.3.2
var Node, Parallel, Resistor, Serial, build, clock, nd, setup;

clock = Date.now;

nd = function(num) {
  return num.toFixed(3).padStart(8);
};

Node = class Node { // abstract class
  current() {
    return this.voltage / this.resistance;
  }

  effect() {
    return this.current() * this.voltage;
  }

  report(kind, level) {
    print(`${nd(this.resistance)} ${nd(this.voltage)} ${nd(this.current())} ${nd(this.effect())}  ${level}${kind}`);
    if (this.a) {
      this.a.report(level + "| ");
    }
    if (this.b) {
      return this.b.report(level + "| ");
    }
  }

};

Resistor = class Resistor extends Node {
  constructor(resistance) {
    super();
    this.resistance = resistance;
  }

  evalR() {
    return this.resistance;
  }

  setVoltage(voltage1) {
    this.voltage = voltage1;
  }

  report(level) {
    return super.report('r', level);
  }

};

Serial = class Serial extends Node {
  constructor(a, b) {
    super();
    this.a = a;
    this.b = b;
  }

  evalR() {
    return this.resistance = this.a.evalR() + this.b.evalR();
  }

  setVoltage(voltage1) {
    var ra, rb;
    this.voltage = voltage1;
    ra = this.a.resistance;
    rb = this.b.resistance;
    this.a.setVoltage(ra / (ra + rb) * this.voltage);
    return this.b.setVoltage(rb / (ra + rb) * this.voltage);
  }

  report(level) {
    return super.report('s', level);
  }

};

Parallel = class Parallel extends Node {
  constructor(a, b) {
    super();
    this.a = a;
    this.b = b;
  }

  evalR() {
    return this.resistance = 1 / (1 / this.a.evalR() + 1 / this.b.evalR());
  }

  setVoltage(voltage1) {
    this.voltage = voltage1;
    this.a.setVoltage(this.voltage);
    return this.b.setVoltage(this.voltage);
  }

  report(level) {
    return super.report('p', level);
  }

};

build = function(voltage, s) {
  var j, len, node, ref, stack, word;
  stack = [];
  ref = s.split(' ');
  for (j = 0, len = ref.length; j < len; j++) {
    word = ref[j];
    if (word === "s") {
      stack.push(new Serial(stack.pop(), stack.pop()));
    } else if (word === "p") {
      stack.push(new Parallel(stack.pop(), stack.pop()));
    } else {
      stack.push(new Resistor(parseFloat(word)));
    }
  }
  node = stack.pop();
  node.evalR();
  node.setVoltage(voltage);
  return node;
};

//let node = build(12.0, "8")
//let node = build(12.0, "8 10 s")
//let node = build(12.0, "3 12 p")
//let node = build(12.0, "8 4 s 12 p 6 s")
setup = function() {
  var i, j, len, node, ref, start;
  start = clock();
  ref = range(1000000);
  for (j = 0, len = ref.length; j < len; j++) {
    i = ref[j];
    node = build(18.0, "10 2 s 6 p 8 s 6 p 4 s 8 p 4 s 8 p 6 s");
  }
  print(clock() - start);
  print("     Ohm     Volt   Ampere     Watt  Network tree");
  return node.report("");
};

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiY2FsYy5qcyIsInNvdXJjZVJvb3QiOiIuLiIsInNvdXJjZXMiOlsiY29mZmVlXFxjYWxjLmNvZmZlZSJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiO0FBQUEsSUFBQSxJQUFBLEVBQUEsUUFBQSxFQUFBLFFBQUEsRUFBQSxNQUFBLEVBQUEsS0FBQSxFQUFBLEtBQUEsRUFBQSxFQUFBLEVBQUE7O0FBQUEsS0FBQSxHQUFRLElBQUksQ0FBQzs7QUFFYixFQUFBLEdBQUssUUFBQSxDQUFDLEdBQUQsQ0FBQTtTQUFTLEdBQUcsQ0FBQyxPQUFKLENBQVksQ0FBWixDQUFjLENBQUMsUUFBZixDQUF3QixDQUF4QjtBQUFUOztBQUVDLE9BQU4sTUFBQSxLQUFBLENBQUE7RUFDQyxPQUFVLENBQUEsQ0FBQTtXQUFHLElBQUMsQ0FBQSxPQUFELEdBQVcsSUFBQyxDQUFBO0VBQWY7O0VBQ1YsTUFBUyxDQUFBLENBQUE7V0FBRyxJQUFDLENBQUEsT0FBRCxDQUFBLENBQUEsR0FBYSxJQUFDLENBQUE7RUFBakI7O0VBQ1QsTUFBUyxDQUFDLElBQUQsRUFBTSxLQUFOLENBQUE7SUFDUixLQUFBLENBQU0sQ0FBQSxDQUFBLENBQUcsRUFBQSxDQUFHLElBQUMsQ0FBQSxVQUFKLENBQUgsRUFBQSxDQUFBLENBQXFCLEVBQUEsQ0FBRyxJQUFDLENBQUEsT0FBSixDQUFyQixFQUFBLENBQUEsQ0FBb0MsRUFBQSxDQUFHLElBQUMsQ0FBQSxPQUFELENBQUEsQ0FBSCxDQUFwQyxFQUFBLENBQUEsQ0FBcUQsRUFBQSxDQUFHLElBQUMsQ0FBQSxNQUFELENBQUEsQ0FBSCxDQUFyRCxHQUFBLENBQUEsQ0FBc0UsS0FBdEUsQ0FBQSxDQUFBLENBQThFLElBQTlFLENBQUEsQ0FBTjtJQUNBLElBQUcsSUFBQyxDQUFBLENBQUo7TUFBVyxJQUFDLENBQUEsQ0FBQyxDQUFDLE1BQUgsQ0FBVSxLQUFBLEdBQVEsSUFBbEIsRUFBWDs7SUFDQSxJQUFHLElBQUMsQ0FBQSxDQUFKO2FBQVcsSUFBQyxDQUFB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QUMsSUFBTixDQUFXLElBQUksUUFBSixDQUFhLFVBQUEsQ0FBVyxJQUFYLENBQWIsQ0FBWCxFQURwQjs7RUFGTjtFQUlBLElBQUEsR0FBTyxLQUFLLENBQUMsR0FBTixDQUFBO0VBQ1AsSUFBSSxDQUFDLEtBQUwsQ0FBQTtFQUNBLElBQUksQ0FBQyxVQUFMLENBQWdCLE9BQWhCO1NBQ0E7QUFUTyxFQXBDUjs7Ozs7O0FBb0RBLEtBQUEsR0FBUSxRQUFBLENBQUEsQ0FBQTtBQUNQLE1BQUEsQ0FBQSxFQUFBLENBQUEsRUFBQSxHQUFBLEVBQUEsSUFBQSxFQUFBLEdBQUEsRUFBQTtFQUFBLEtBQUEsR0FBUSxLQUFBLENBQUE7QUFDUjtFQUFBLEtBQUEscUNBQUE7O0lBQ0MsSUFBQSxHQUFPLEtBQUEsQ0FBTSxJQUFOLEVBQVksd0NBQVo7RUFEUjtFQUVBLEtBQUEsQ0FBTSxLQUFBLENBQUEsQ0FBQSxHQUFRLEtBQWQ7RUFFQSxLQUFBLENBQU0sbURBQU47U0FDQSxJQUFJLENBQUMsTUFBTCxDQUFZLEVBQVo7QUFQTyIsInNvdXJjZXNDb250ZW50IjpbImNsb2NrID0gRGF0ZS5ub3dcclxuXHJcbm5kID0gKG51bSkgLT4gbnVtLnRvRml4ZWQoMykucGFkU3RhcnQgOFxyXG5cclxuY2xhc3MgTm9kZSAjIGFic3RyYWN0IGNsYXNzXHJcblx0Y3VycmVudCA6IC0+IEB2b2x0YWdlIC8gQHJlc2lzdGFuY2VcclxuXHRlZmZlY3QgOiAtPiBAY3VycmVudCgpICogQHZvbHRhZ2VcclxuXHRyZXBvcnQgOiAoa2luZCxsZXZlbCkgLT5cclxuXHRcdHByaW50IFwiI3tuZCBAcmVzaXN0YW5jZX0gI3tuZCBAdm9sdGFnZX0gI3tuZCBAY3VycmVudCgpfSAje25kIEBlZmZlY3QoKX0gICN7bGV2ZWx9I3traW5kfVwiXHJcblx0XHRpZiBAYSB0aGVuIEBhLnJlcG9ydCBsZXZlbCArIFwifCBcIlxyXG5cdFx0aWYgQGIgdGhlbiBAYi5yZXBvcnQgbGV2ZWwgKyBcInwgXCJcclxuXHJcbmNsYXNzIFJlc2lzdG9yIGV4dGVuZHMgTm9kZVxyXG5cdGNvbnN0cnVjdG9yIDogKEByZXNpc3RhbmNlKSAtPiBzdXBlcigpXHJcblx0ZXZhbFIgOiAtPiBAcmVzaXN0YW5jZVxyXG5cdHNldFZvbHRhZ2UgOiAoQHZvbHRhZ2UpIC0+XHJcblx0cmVwb3J0IDogKGxldmVsKSAtPiBzdXBlciAncicsbGV2ZWxcclxuXHJcbmNsYXNzIFNlcmlhbCBleHRlbmRzIE5vZGVcclxuXHRjb25zdHJ1Y3RvciA6IChAYSxAYikgLT4gc3VwZXIoKVxyXG5cdGV2YWxSIDogLT4gQHJlc2lzdGFuY2UgPSBAYS5ldmFsUigpICsgQGIuZXZhbFIoKVxyXG5cdHNldFZvbHRhZ2UgOiAoQHZvbHRhZ2UpIC0+XHJcblx0XHRyYSA9IEBhLnJlc2lzdGFuY2VcclxuXHRcdHJiID0gQGIucmVzaXN0YW5jZVxyXG5cdFx0QGEuc2V0Vm9sdGFnZSByYS8ocmErcmIpICogQHZvbHRhZ2VcclxuXHRcdEBiLnNldFZvbHRhZ2UgcmIvKHJhK3JiKSAqIEB2b2x0YWdlXHJcblx0cmVwb3J0IDogKGxldmVsKSAtPiBzdXBlciAncycsbGV2ZWxcclxuXHJcbmNsYXNzIFBhcmFsbGVsIGV4dGVuZHMgTm9kZVxyXG5cdGNvbnN0cnVjdG9yIDogKEBhLEBiKSAtPiBzdXBlcigpXHJcblx0ZXZhbFIgOiAtPiBAcmVzaXN0YW5jZSA9IDEgLyAoMSAvIEBhLmV2YWxSKCkgKyAxIC8gQGIuZXZhbFIoKSlcclxuXHRzZXRWb2x0YWdlIDogKEB2b2x0YWdlKSAtPlxyXG5cdFx0QGEuc2V0Vm9sdGFnZSBAdm9sdGFnZVxyXG5cdFx0QGIuc2V0Vm9sdGFnZSBAdm9sdGFnZVxyXG5cdHJlcG9ydCA6IChsZXZlbCkgLT4gc3VwZXIgJ3AnLGxldmVsXHJcblxyXG5idWlsZCA9ICh2b2x0YWdlLCBzKSAtPlxyXG5cdHN0YWNrID0gW11cclxuXHRmb3Igd29yZCBpbiBzLnNwbGl0ICcgJ1xyXG5cdFx0aWYgICAgICB3b3JkID09IFwic1wiIHRoZW4gc3RhY2sucHVzaCBuZXcgU2VyaWFsIHN0YWNrLnBvcCgpLCBzdGFjay5wb3AoKVxyXG5cdFx0ZWxzZSBpZiB3b3JkID09IFwicFwiIHRoZW4gc3RhY2sucHVzaCBuZXcgUGFyYWxsZWwgc3RhY2sucG9wKCksIHN0YWNrLnBvcCgpXHJcblx0XHRlbHNlICAgICAgICAgICAgICAgICAgICAgc3RhY2sucHVzaCBuZXcgUmVzaXN0b3IgcGFyc2VGbG9hdCB3b3JkXHJcblx0bm9kZSA9IHN0YWNrLnBvcCgpXHJcblx0bm9kZS5ldmFsUigpXHJcblx0bm9kZS5zZXRWb2x0YWdlIHZvbHRhZ2VcclxuXHRub2RlXHJcblxyXG4jbGV0IG5vZGUgPSBidWlsZCgxMi4wLCBcIjhcIilcclxuI2xldCBub2RlID0gYnVpbGQoMTIuMCwgXCI4IDEwIHNcIilcclxuI2xldCBub2RlID0gYnVpbGQoMTIuMCwgXCIzIDEyIHBcIilcclxuI2xldCBub2RlID0gYnVpbGQoMTIuMCwgXCI4IDQgcyAxMiBwIDYgc1wiKVxyXG5cclxuc2V0dXAgPSAtPlxyXG5cdHN0YXJ0ID0gY2xvY2soKVxyXG5cdGZvciBpIGluIHJhbmdlIDEwMDAwMDBcclxuXHRcdG5vZGUgPSBidWlsZCAxOC4wLCBcIjEwIDIgcyA2IHAgOCBzIDYgcCA0IHMgOCBwIDQgcyA4IHAgNiBzXCJcclxuXHRwcmludCBjbG9jaygpLXN0YXJ0XHJcblxyXG5cdHByaW50IFwiICAgICBPaG0gICAgIFZvbHQgICBBbXBlcmUgICAgIFdhdHQgIE5ldHdvcmsgdHJlZVwiXHJcblx0bm9kZS5yZXBvcnQgXCJcIlxyXG4iXX0=
//# sourceURL=C:\Lab\2019\026-ResistanceCalculatorNim\coffee\calc.coffee