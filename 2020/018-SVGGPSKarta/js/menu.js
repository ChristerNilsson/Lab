// Generated by CoffeeScript 2.4.1
var Button, SetSector, buttons, clearMenu, make, menu, menu1, menu2, menu3, menu4, menu5, menu6, saveMenu;

buttons = [];

Button = class Button {
  constructor(x1, y1, prompt1, click1 = function() {}) {
    this.x = x1;
    this.y = y1;
    this.prompt = prompt1;
    this.click = click1;
    this.circle = raphael.circle(this.x, this.y, 100).attr({
      fill: '#ff0',
      opacity: 0.25
    }).click(this.click);
    this.text = raphael.text(this.x, this.y, this.prompt).attr(stdText).click(this.click);
  }

  remove() {
    this.circle.remove();
    return this.text.remove();
  }

};

clearMenu = function() {
  var button, i, len;
  for (i = 0, len = buttons.length; i < len; i++) {
    button = buttons[i];
    button.remove();
  }
  buttons = [];
  return scale(1);
};

SetSector = function(sector) {
  general.SECTOR = sector;
  saveGeneral();
  return clearMenu();
};

menu = function() {
  return new Button(100, window.innerHeight - 100, 'menu', function() {
    if (buttons.length > 0) {
      return clearMenu();
    } else {
      menu1();
      console.log('image.attrs.x', image.attrs.x);
      console.log('image.attrs.y', image.attrs.y);
      console.log('image._.dx', image._.dx);
      console.log('image._.dy', image._.dy);
      return console.log(image);
    }
  });
};

saveMenu = function(prompt, click) {
  var n, x, y;
  n = buttons.length;
  x = n < 4 ? 100 : window.innerWidth - 100;
  y = 200 + 200 * (n % 4);
  return buttons.push(new Button(x, y, prompt, click));
};

make = function(x, y) {
  return image.translate(x, y);
};

// dx = image.attrs.dx
// dy = image.attrs.dy
// s0 = image._.sx
// x: window.innerWidth/2 - s0*WIDTH/2 - (x-WIDTH/2)*s0
// y: window.innerHeight/2 - s0*HEIGHT/2 - (y-HEIGHT/2)*s0
menu1 = function() {
  clearMenu();
  saveMenu('center', function() {
    var dx, dy, sx, sy, x, y;
    //[cx,cy] = position
    //image.attr {x: position[0], y:position[1]}
    // center = (x0,y0,s0,x,y) -> [x0-x/s0,y0-y/s0]
    //console.log s0

    //image.attr {x: window.innerWidth/2 - (WIDTH - 1141)/s0 , y:  window.innerHeight/2 - 712/s0 } 
    //image.attr {x: (window.innerWidth-WIDTH)/2 - (1141-WIDTH/2) , y:  (window.innerHeight-HEIGHT)/2 - (712-HEIGHT/2) } 
    //image.attr {x: window.innerWidth/2 - 1141/s0 , y:  window.innerHeight/2 - 714/s0 } 

    // ingen skalning
    //image.attr {x: window.innerWidth/2 , y:  window.innerHeight/2}  # centrera NW
    //image.attr {x: window.innerWidth/2 - WIDTH/2 , y:  window.innerHeight/2 - HEIGHT/2} 		# centrera centrum
    //image.attr {x: window.innerWidth/2 - WIDTH , y:  window.innerHeight/2 - HEIGHT} 		# centrera SE
    ({dx, dy, sx, sy} = image._);
    x = (990 - dx) / sx; //- image.attrs.x
    y = (216 - dx) / sx; //- image.attrs.y
    image.translate(WIDTH / 2 - x, HEIGHT / 2 - y);
    
    // skalning
    //image.attr make x,y  # centrera Kaninparken
    //image.attr make WIDTH/2, HEIGHT/2 #{x: (innerWidth-WIDTH)/2/s0, y:  (innerHeight-HEIGHT)/2/s0}  # CENTER
    //image.attr make WIDTH, HEIGHT #{x: -WIDTH/2/s0, y:  -HEIGHT/2/s0}  # centrera SE

    //		image.attr {x: 1920/2, y: 1127/2} 
    //		image.attr {x: 1920/2, y: 1127/2} 
    console.log(image, position);
    return clearMenu();
  });
  saveMenu('out', function() {
    return scale(1 / SQ2);
  });
  saveMenu('take', function() {
    return menu4();
  });
  saveMenu('more', function() {
    return menu6();
  });
  saveMenu('setup', function() {
    return menu2();
  });
  saveMenu('aim', function() {
    return clearMenu();
  });
  saveMenu('save', function() {
    return clearMenu();
  });
  return saveMenu('in', function() {
    return scale(SQ2);
  });
};

menu2 = function() {
  clearMenu();
  saveMenu('PanSpeed', function() {
    general.PANSPEED = !general.PANSPEED;
    saveGeneral();
    return clearMenu();
  });
  saveMenu('Coins', function() {
    general.COINS = !general.COINS;
    saveGeneral();
    return clearMenu();
  });
  saveMenu('Distance', function() {
    general.DISTANCE = !general.DISTANCE;
    saveGeneral();
    return clearMenu();
  });
  saveMenu('Trail', function() {
    general.TRAIL = !general.TRAIL;
    saveGeneral();
    return clearMenu();
  });
  return saveMenu('Sector', function() {
    return menu3();
  });
};

menu3 = function() {
  clearMenu();
  saveMenu('10', function() {
    return SetSector(10);
  });
  saveMenu('20', function() {
    return SetSector(20);
  });
  saveMenu('30', function() {
    return SetSector(30);
  });
  saveMenu('45', function() {
    return SetSector(45);
  });
  saveMenu('60', function() {
    return SetSector(60);
  });
  return saveMenu('90', function() {
    return SetSector(90);
  });
};

menu4 = function() {
  clearMenu();
  saveMenu('ABCDE', function() {
    return menu5('ABCDE');
  });
  saveMenu('FGHIJ', function() {
    return menu5('FGHIJ');
  });
  saveMenu('KLMNO', function() {
    return menu5('KLMNO');
  });
  saveMenu('PQRST', function() {
    return menu5('PQRST');
  });
  saveMenu('UVWXYZ', function() {
    return menu5('UVWXYZ');
  });
  return saveMenu('Clear', function() {
    return clearMenu();
  });
};

menu5 = function(letters) { // ABCDE
  var i, len, letter, results;
  clearMenu();
  results = [];
  for (i = 0, len = letters.length; i < len; i++) {
    letter = letters[i];
    results.push(saveMenu(letter, function() {
      return clearMenu();
    }));
  }
  return results;
};

menu6 = function() {
  clearMenu();
  saveMenu('Init', function() {
    return initSpeaker();
  });
  saveMenu('Mail', function() {
    return executeMail();
  });
  saveMenu('Delete', function() {
    return storage.deleteControl();
  });
  saveMenu('Clear', function() {
    return storage.clear();
  });
  saveMenu('Info', function() {
    var i, item, len, ref;
    ref = info();
    for (i = 0, len = ref.length; i < len; i++) {
      item = ref[i];
      console.log(item);
    }
    return clearMenu();
  });
  return saveMenu('GPS', function() {
    locationUpdate({
      coords: {
        latitude: 59.269494,
        longitude: 18.168736
      }
    });
    return clearMenu();
  });
};

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoibWVudS5qcyIsInNvdXJjZVJvb3QiOiIuLiIsInNvdXJjZXMiOlsiY29mZmVlXFxtZW51LmNvZmZlZSJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiO0FBQUEsSUFBQSxNQUFBLEVBQUEsU0FBQSxFQUFBLE9BQUEsRUFBQSxTQUFBLEVBQUEsSUFBQSxFQUFBLElBQUEsRUFBQSxLQUFBLEVBQUEsS0FBQSxFQUFBLEtBQUEsRUFBQSxLQUFBLEVBQUEsS0FBQSxFQUFBLEtBQUEsRUFBQTs7QUFBQSxPQUFBLEdBQVU7O0FBRUosU0FBTixNQUFBLE9BQUE7RUFDQyxXQUFjLEdBQUEsSUFBQSxTQUFBLFdBQTJCLFFBQUEsQ0FBQSxDQUFBLEVBQUEsQ0FBM0IsQ0FBQTtJQUFDLElBQUMsQ0FBQTtJQUFHLElBQUMsQ0FBQTtJQUFHLElBQUMsQ0FBQTtJQUFRLElBQUMsQ0FBQTtJQUNoQyxJQUFDLENBQUEsTUFBRCxHQUFVLE9BQU8sQ0FBQyxNQUFSLENBQWUsSUFBQyxDQUFBLENBQWhCLEVBQWtCLElBQUMsQ0FBQSxDQUFuQixFQUFxQixHQUFyQixDQUNULENBQUMsSUFEUSxDQUNIO01BQUMsSUFBQSxFQUFNLE1BQVA7TUFBZSxPQUFBLEVBQVM7SUFBeEIsQ0FERyxDQUVULENBQUMsS0FGUSxDQUVGLElBQUMsQ0FBQSxLQUZDO0lBR1YsSUFBQyxDQUFBLElBQUQsR0FBUSxPQUFPLENBQUMsSUFBUixDQUFhLElBQUMsQ0FBQSxDQUFkLEVBQWdCLElBQUMsQ0FBQSxDQUFqQixFQUFtQixJQUFDLENBQUEsTUFBcEIsQ0FDUCxDQUFDLElBRE0sQ0FDRCxPQURDLENBRVAsQ0FBQyxLQUZNLENBRUEsSUFBQyxDQUFBLEtBRkQ7RUFKSzs7RUFPZCxNQUFTLENBQUEsQ0FBQTtJQUNSLElBQUMsQ0FBQSxNQUFNLENBQUMsTUFBUixDQUFBO1dBQ0EsSUFBQyxDQUFBLElBQUksQ0FBQyxNQUFOLENBQUE7RUFGUTs7QUFSVjs7QUFZQSxTQUFBLEdBQVksUUFBQSxDQUFBLENBQUE7QUFDWCxN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LFNBQVg7UUFBc0IsU0FBQSxFQUFXO01BQWpDO0lBQVQsQ0FBZjtXQUNBLFNBQUEsQ0FBQTtFQUZlLENBQWhCO0FBVk8iLCJzb3VyY2VzQ29udGVudCI6WyJidXR0b25zID0gW11cclxuXHJcbmNsYXNzIEJ1dHRvblx0XHJcblx0Y29uc3RydWN0b3IgOiAoQHgsIEB5LCBAcHJvbXB0LCBAY2xpY2sgPSAtPikgLT5cclxuXHRcdEBjaXJjbGUgPSByYXBoYWVsLmNpcmNsZSBAeCxAeSwxMDBcclxuXHRcdFx0LmF0dHIge2ZpbGw6ICcjZmYwJywgb3BhY2l0eTogMC4yNX1cclxuXHRcdFx0LmNsaWNrIEBjbGlja1xyXG5cdFx0QHRleHQgPSByYXBoYWVsLnRleHQgQHgsQHksQHByb21wdFxyXG5cdFx0XHQuYXR0ciBzdGRUZXh0XHJcblx0XHRcdC5jbGljayBAY2xpY2tcclxuXHRyZW1vdmUgOiAtPlxyXG5cdFx0QGNpcmNsZS5yZW1vdmUoKVxyXG5cdFx0QHRleHQucmVtb3ZlKClcclxuXHJcbmNsZWFyTWVudSA9IC0+XHJcblx0Zm9yIGJ1dHRvbiBpbiBidXR0b25zXHJcblx0XHRidXR0b24ucmVtb3ZlKClcclxuXHRidXR0b25zID0gW10gXHJcblx0c2NhbGUgMVxyXG5cclxuU2V0U2VjdG9yID0gKHNlY3RvcikgLT5cclxuXHRnZW5lcmFsLlNFQ1RPUiA9IHNlY3RvclxyXG5cdHNhdmVHZW5lcmFsKClcclxuXHRjbGVhck1lbnUoKVxyXG5cclxubWVudSA9IC0+XHJcblx0bmV3IEJ1dHRvbiAxMDAsd2luZG93LmlubmVySGVpZ2h0LTEwMCwnbWVudScsIC0+IFxyXG5cdFx0aWYgYnV0dG9ucy5sZW5ndGggPiAwIFxyXG5cdFx0XHRjbGVhck1lbnUoKVxyXG5cdFx0ZWxzZSBcclxuXHRcdFx0bWVudTEoKVxyXG5cdFx0XHRjb25zb2xlLmxvZyAnaW1hZ2UuYXR0cnMueCcsaW1hZ2UuYXR0cnMueFxyXG5cdFx0XHRjb25zb2xlLmxvZyAnaW1hZ2UuYXR0cnMueScsaW1hZ2UuYXR0cnMueVxyXG5cdFx0XHRjb25zb2xlLmxvZyAnaW1hZ2UuXy5keCcsaW1hZ2UuXy5keFxyXG5cdFx0XHRjb25zb2xlLmxvZyAnaW1hZ2UuXy5keScsaW1hZ2UuXy5keVxyXG5cdFx0XHRjb25zb2xlLmxvZyBpbWFnZVxyXG5cclxuc2F2ZU1lbnUgPSAocHJvbXB0LGNsaWNrKSAtPlxyXG5cdG4gPSBidXR0b25zLmxlbmd0aFxyXG5cdHggPSBpZiBuIDwgNCB0aGVuIDEwMCBlbHNlIHdpbmRvdy5pbm5lcldpZHRoLTEwMFxyXG5cdHkgPSAyMDAgKyAyMDAgKiAobiAlIDQpXHJcblx0YnV0dG9ucy5wdXNoIG5ldyBCdXR0b24geCx5LCBwcm9tcHQsIGNsaWNrXHJcblxyXG5tYWtlID0gKHgseSkgLT4gXHJcblx0aW1hZ2UudHJhbnNsYXRlIHgseVxyXG5cdCMgZHggPSBpbWFnZS5hdHRycy5keFxyXG5cdCMgZHkgPSBpbWFnZS5hdHRycy5keVxyXG5cdCMgczAgPSBpbWFnZS5fLnN4XHJcblx0IyB4OiB3aW5kb3cuaW5uZXJXaWR0aC8yIC0gczAqV0lEVEgvMiAtICh4LVdJRFRILzIpKnMwXHJcblx0IyB5OiB3aW5kb3cuaW5uZXJIZWlnaHQvMiAtIHMwKkhFSUdIVC8yIC0gKHktSEVJR0hULzIpKnMwXHJcblxyXG5tZW51MSA9IC0+XHJcblx0Y2xlYXJNZW51KClcclxuXHRzYXZlTWVudSAnY2VudGVyJywgLT5cclxuXHRcdCNbY3gsY3ldID0gcG9zaXRpb25cclxuXHRcdCNpbWFnZS5hdHRyIHt4OiBwb3NpdGlvblswXSwgeTpwb3NpdGlvblsxXX1cclxuICAgICMgY2VudGVyID0gKHgwLHkwLHMwLHgseSkgLT4gW3gwLXgvczAseTAteS9zMF1cclxuXHRcdCNjb25zb2xlLmxvZyBzMFxyXG5cclxuXHRcdCNpbWFnZS5hdHRyIHt4OiB3aW5kb3cuaW5uZXJXaWR0aC8yIC0gKFdJRFRIIC0gMTE0MSkvczAgLCB5OiAgd2luZG93LmlubmVySGVpZ2h0LzIgLSA3MTIvczAgfSBcclxuXHRcdCNpbWFnZS5hdHRyIHt4OiAod2luZG93LmlubmVyV2lkdGgtV0lEVEgpLzIgLSAoMTE0MS1XSURUSC8yKSAsIHk6ICAod2luZG93LmlubmVySGVpZ2h0LUhFSUdIVCkvMiAtICg3MTItSEVJR0hULzIpIH0gXHJcblx0XHQjaW1hZ2UuYXR0ciB7eDogd2luZG93LmlubmVyV2lkdGgvMiAtIDExNDEvczAgLCB5OiAgd2luZG93LmlubmVySGVpZ2h0LzIgLSA3MTQvczAgfSBcclxuXHJcblx0XHQjIGluZ2VuIHNrYWxuaW5nXHJcblx0XHQjaW1hZ2UuYXR0ciB7eDogd2luZG93LmlubmVyV2lkdGgvMiAsIHk6ICB3aW5kb3cuaW5uZXJIZWlnaHQvMn0gICMgY2VudHJlcmEgTldcclxuXHRcdCNpbWFnZS5hdHRyIHt4OiB3aW5kb3cuaW5uZXJXaWR0aC8yIC0gV0lEVEgvMiAsIHk6ICB3aW5kb3cuaW5uZXJIZWlnaHQvMiAtIEhFSUdIVC8yfSBcdFx0IyBjZW50cmVyYSBjZW50cnVtXHJcblx0XHQjaW1hZ2UuYXR0ciB7eDogd2luZG93LmlubmVyV2lkdGgvMiAtIFdJRFRIICwgeTogIHdpbmRvdy5pbm5lckhlaWdodC8yIC0gSEVJR0hUfSBcdFx0IyBjZW50cmVyYSBTRVxyXG5cclxuXHRcdHtkeCxkeSxzeCxzeX0gPSBpbWFnZS5fXHJcblx0XHR4ID0gKDk5MCAtIGR4KS9zeCAjLSBpbWFnZS5hdHRycy54XHJcblx0XHR5ID0gKDIxNiAtIGR4KS9zeCAjLSBpbWFnZS5hdHRycy55XHJcblx0XHRpbWFnZS50cmFuc2xhdGUgV0lEVEgvMi14LCBIRUlHSFQvMi15XHJcblx0XHRcclxuXHRcdCMgc2thbG5pbmdcclxuXHRcdCNpbWFnZS5hdHRyIG1ha2UgeCx5ICAjIGNlbnRyZXJhIEthbmlucGFya2VuXHJcblx0XHQjaW1hZ2UuYXR0ciBtYWtlIFdJRFRILzIsIEhFSUdIVC8yICN7eDogKGlubmVyV2lkdGgtV0lEVEgpLzIvczAsIHk6ICAoaW5uZXJIZWlnaHQtSEVJR0hUKS8yL3MwfSAgIyBDRU5URVJcclxuXHRcdCNpbWFnZS5hdHRyIG1ha2UgV0lEVEgsIEhFSUdIVCAje3g6IC1XSURUSC8yL3MwLCB5OiAgLUhFSUdIVC8yL3MwfSAgIyBjZW50cmVyYSBTRVxyXG5cclxuXHJcbiNcdFx0aW1hZ2UuYXR0ciB7eDogMTkyMC8yLCB5OiAxMTI3LzJ9IFxyXG4jXHRcdGltYWdlLmF0dHIge3g6IDE5MjAvMiwgeTogMTEyNy8yfSBcclxuXHRcdGNvbnNvbGUubG9nIGltYWdlLHBvc2l0aW9uXHJcblx0XHRjbGVhck1lbnUoKVxyXG5cdHNhdmVNZW51ICdvdXQnLCAtPiBzY2FsZSAxL1NRMlxyXG5cdHNhdmVNZW51ICd0YWtlJywgLT4gbWVudTQoKVxyXG5cdHNhdmVNZW51ICdtb3JlJywgLT4gbWVudTYoKVxyXG5cdHNhdmVNZW51ICdzZXR1cCcsIC0+IG1lbnUyKClcclxuXHRzYXZlTWVudSAnYWltJywgLT4gY2xlYXJNZW51KClcclxuXHRzYXZlTWVudSAnc2F2ZScsIC0+IGNsZWFyTWVudSgpXHJcblx0c2F2ZU1lbnUgJ2luJywgLT4gc2NhbGUgU1EyXHJcblxyXG5tZW51MiA9IC0+XHJcblx0Y2xlYXJNZW51KClcclxuXHRzYXZlTWVudSAnUGFuU3BlZWQnLCAtPiBcclxuXHRcdGdlbmVyYWwuUEFOU1BFRUQgPSBub3QgZ2VuZXJhbC5QQU5TUEVFRFxyXG5cdFx0c2F2ZUdlbmVyYWwoKVxyXG5cdFx0Y2xlYXJNZW51KClcclxuXHRzYXZlTWVudSAnQ29pbnMnLCAtPlxyXG5cdFx0Z2VuZXJhbC5DT0lOUyA9IG5vdCBnZW5lcmFsLkNPSU5TXHJcblx0XHRzYXZlR2VuZXJhbCgpXHJcblx0XHRjbGVhck1lbnUoKVxyXG5cdHNhdmVNZW51ICdEaXN0YW5jZScsIC0+XHJcblx0XHRnZW5lcmFsLkRJU1RBTkNFID0gbm90IGdlbmVyYWwuRElTVEFOQ0VcclxuXHRcdHNhdmVHZW5lcmFsKClcclxuXHRcdGNsZWFyTWVudSgpXHJcblx0c2F2ZU1lbnUgJ1RyYWlsJywgLT5cclxuXHRcdGdlbmVyYWwuVFJBSUwgPSBub3QgZ2VuZXJhbC5UUkFJTFxyXG5cdFx0c2F2ZUdlbmVyYWwoKVxyXG5cdFx0Y2xlYXJNZW51KClcclxuXHRzYXZlTWVudSAnU2VjdG9yJywgLT4gbWVudTMoKVxyXG5cclxubWVudTMgPSAtPlxyXG5cdGNsZWFyTWVudSgpXHJcblx0c2F2ZU1lbnUgJzEwJywgLT4gU2V0U2VjdG9yIDEwXHJcblx0c2F2ZU1lbnUgJzIwJywgLT4gU2V0U2VjdG9yIDIwXHJcblx0c2F2ZU1lbnUgJzMwJywgLT4gU2V0U2VjdG9yIDMwXHJcblx0c2F2ZU1lbnUgJzQ1JywgLT4gU2V0U2VjdG9yIDQ1XHJcblx0c2F2ZU1lbnUgJzYwJywgLT4gU2V0U2VjdG9yIDYwXHJcblx0c2F2ZU1lbnUgJzkwJywgLT4gU2V0U2VjdG9yIDkwXHJcblxyXG5tZW51NCA9IC0+XHJcblx0Y2xlYXJNZW51KClcclxuXHRzYXZlTWVudSAnQUJDREUnLCAtPiBtZW51NSAnQUJDREUnXHJcblx0c2F2ZU1lbnUgJ0ZHSElKJywgLT4gbWVudTUgJ0ZHSElKJ1xyXG5cdHNhdmVNZW51ICdLTE1OTycsIC0+IG1lbnU1ICdLTE1OTydcclxuXHRzYXZlTWVudSAnUFFSU1QnLCAtPiBtZW51NSAnUFFSU1QnXHJcblx0c2F2ZU1lbnUgJ1VWV1hZWicsIC0+IG1lbnU1ICdVVldYWVonXHJcblx0c2F2ZU1lbnUgJ0NsZWFyJywgLT4gY2xlYXJNZW51KClcclxuXHJcbm1lbnU1ID0gKGxldHRlcnMpIC0+ICMgQUJDREVcclxuXHRjbGVhck1lbnUoKVxyXG5cdGZvciBsZXR0ZXIgaW4gbGV0dGVyc1xyXG5cdFx0c2F2ZU1lbnUgbGV0dGVyLCAtPiBjbGVhck1lbnUoKVxyXG5cclxubWVudTYgPSAtPlxyXG5cdGNsZWFyTWVudSgpXHJcblx0c2F2ZU1lbnUgJ0luaXQnLCAtPiBpbml0U3BlYWtlcigpXHJcblx0c2F2ZU1lbnUgJ01haWwnLCAtPiBleGVjdXRlTWFpbCgpXHJcblx0c2F2ZU1lbnUgJ0RlbGV0ZScsIC0+IHN0b3JhZ2UuZGVsZXRlQ29udHJvbCgpXHJcblx0c2F2ZU1lbnUgJ0NsZWFyJywgLT4gc3RvcmFnZS5jbGVhcigpXHJcblx0c2F2ZU1lbnUgJ0luZm8nLCAtPiBcclxuXHRcdGZvciBpdGVtIGluIGluZm8oKVxyXG5cdFx0XHRjb25zb2xlLmxvZyBpdGVtXHJcblx0XHRjbGVhck1lbnUoKVxyXG5cdHNhdmVNZW51ICdHUFMnLCAtPlxyXG5cdFx0bG9jYXRpb25VcGRhdGUge2Nvb3Jkczoge2xhdGl0dWRlOiA1OS4yNjk0OTQsIGxvbmdpdHVkZTogMTguMTY4NzM2fX1cclxuXHRcdGNsZWFyTWVudSgpXHJcbiJdfQ==
//# sourceURL=c:\Lab\2020\018-SVGGPSKarta\coffee\menu.coffee