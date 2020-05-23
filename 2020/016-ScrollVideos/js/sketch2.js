// Generated by CoffeeScript 2.4.1
var draw, setup, touchStarted, ts;

ts = 50;

setup = function() {
  createCanvas(windowWidth, windowHeight); // 10 fps på Android
  //createCanvas 100,100 # 60 fps
  return textAlign(CENTER, CENTER);
};

draw = function() {
  var fr;
  bg(0.5);
  fr = frameRate();
  textSize(ts);
  text(round(ts), width / 2, 0.50 * height);
  return text(round(fr), width / 2, 0.75 * height);
};

touchStarted = function() {
  return ts++;
};

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic2tldGNoMi5qcyIsInNvdXJjZVJvb3QiOiIuLiIsInNvdXJjZXMiOlsiY29mZmVlXFxza2V0Y2gyLmNvZmZlZSJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiO0FBQUEsSUFBQSxJQUFBLEVBQUEsS0FBQSxFQUFBLFlBQUEsRUFBQTs7QUFBQSxFQUFBLEdBQUs7O0FBRUwsS0FBQSxHQUFRLFFBQUEsQ0FBQSxDQUFBO0VBQ1AsWUFBQSxDQUFhLFdBQWIsRUFBeUIsWUFBekIsRUFBQTs7U0FFQSxTQUFBLENBQVUsTUFBVixFQUFpQixNQUFqQjtBQUhPOztBQUtSLElBQUEsR0FBTyxRQUFBLENBQUEsQ0FBQTtBQUNOLE1BQUE7RUFBQSxFQUFBLENBQUcsR0FBSDtFQUNBLEVBQUEsR0FBSyxTQUFBLENBQUE7RUFDTCxRQUFBLENBQVMsRUFBVDtFQUNBLElBQUEsQ0FBSyxLQUFBLENBQU0sRUFBTixDQUFMLEVBQWdCLEtBQUEsR0FBTSxDQUF0QixFQUF3QixJQUFBLEdBQU8sTUFBL0I7U0FDQSxJQUFBLENBQUssS0FBQSxDQUFNLEVBQU4sQ0FBTCxFQUFnQixLQUFBLEdBQU0sQ0FBdEIsRUFBd0IsSUFBQSxHQUFPLE1BQS9CO0FBTE07O0FBT1AsWUFBQSxHQUFlLFFBQUEsQ0FBQSxDQUFBO1NBQUcsRUFBQTtBQUFIIiwic291cmNlc0NvbnRlbnQiOlsidHMgPSA1MFxyXG5cclxuc2V0dXAgPSAtPlxyXG5cdGNyZWF0ZUNhbnZhcyB3aW5kb3dXaWR0aCx3aW5kb3dIZWlnaHQgIyAxMCBmcHMgcMOlIEFuZHJvaWRcclxuXHQjY3JlYXRlQ2FudmFzIDEwMCwxMDAgIyA2MCBmcHNcclxuXHR0ZXh0QWxpZ24gQ0VOVEVSLENFTlRFUlxyXG5cclxuZHJhdyA9IC0+XHJcblx0YmcgMC41XHJcblx0ZnIgPSBmcmFtZVJhdGUoKVxyXG5cdHRleHRTaXplIHRzXHJcblx0dGV4dCByb3VuZCh0cyksIHdpZHRoLzIsMC41MCAqIGhlaWdodFxyXG5cdHRleHQgcm91bmQoZnIpLCB3aWR0aC8yLDAuNzUgKiBoZWlnaHRcclxuXHJcbnRvdWNoU3RhcnRlZCA9IC0+IHRzKysiXX0=
//# sourceURL=c:\Lab\2020\016-ScrollVideos\coffee\sketch2.coffee