// Generated by CoffeeScript 2.0.3
  /*
  eslint-disable import/first
  */
var App, Button,
  boundMethodCheck = function(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new Error('Bound instance method accessed before binding'); } },
  indexOf = [].indexOf;

import React, {
  Component
} from 'react';

Button = class Button extends Component {
  render() {
    return <button style={{
        width: 50
      }} onClick={() => {
        return this.props.calc(this.props.cmd);
      }}>{this.props.cmd}</button>;
  }

};

export default App = class App extends Component {
  constructor() {
    super();
    this.calc = this.calc.bind(this);
    this.state = {
      t: '0',
      z: '1',
      y: '2',
      x: '3',
      entering: false
    };
  }

  render() {
    return <div>
			<div>{this.state.t}</div>
			<div>{this.state.z}</div>
			<div>{this.state.y}</div>
			<div>{this.state.x}</div>
			<div><Button calc={this.calc} cmd='clr' /> <Button calc={this.calc} cmd='chs' />  <Button calc={this.calc} cmd='%' /> <Button calc={this.calc} cmd='÷' /> </div>
			<div><Button calc={this.calc} cmd='7' />   <Button calc={this.calc} cmd='8' />  <Button calc={this.calc} cmd='9' /> <Button calc={this.calc} cmd='x' /> </div>
			<div><Button calc={this.calc} cmd='4' />   <Button calc={this.calc} cmd='5' />  <Button calc={this.calc} cmd='6' /> <Button calc={this.calc} cmd='-' /> </div>
			<div><Button calc={this.calc} cmd='1' />   <Button calc={this.calc} cmd='2' />  <Button calc={this.calc} cmd='3' /> <Button calc={this.calc} cmd='+' /> </div>
			<div><Button calc={this.calc} cmd='0' />   <Button calc={this.calc} cmd='.' />  <Button calc={this.calc} cmd='enter' /> </div>
		</div>;
  }

  calc(cmd) {
    var x, y;
    boundMethodCheck(this, App);
    if (cmd === 'clr') {
      this.setState({
        x: '0',
        y: '0',
        z: '0',
        t: '0',
        entering: false
      });
    }
    if (cmd === 'enter') {
      this.setState({
        x: this.state.x,
        y: this.state.x,
        z: this.state.y,
        t: this.state.z,
        entering: false
      });
    }
    if (cmd === 'chs') {
      this.setState({
        x: -this.state.x,
        entering: false
      });
    }
    if (indexOf.call("+-x÷%", cmd) >= 0) {
      x = parseFloat(this.state.x);
      y = parseFloat(this.state.y);
      if (cmd === '+') {
        x = y + x;
      }
      if (cmd === '-') {
        x = y - x;
      }
      if (cmd === 'x') {
        x = y * x;
      }
      if (cmd === '÷') {
        x = y / x;
      }
      if (cmd === '%') {
        x = y % x;
      }
      this.setState({
        x: x.toString(),
        y: this.state.z,
        z: this.state.t,
        entering: false
      });
    }
    if (indexOf.call("0123456789.", cmd) >= 0) {
      if (this.state.entering) {
        if (indexOf.call('0123456789', cmd) >= 0 || !this.state.x.includes('.')) {
          return this.setState({
            x: this.state.x + cmd
          });
        }
      } else {
        return this.setState({
          x: cmd,
          y: this.state.x,
          z: this.state.y,
          t: this.state.z,
          entering: true
        });
      }
    }
  }

};

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiQXBwMy5qcyIsInNvdXJjZVJvb3QiOiIuLiIsInNvdXJjZXMiOlsiY29mZmVlXFxBcHAzLmNvZmZlZSJdLCJuYW1lcyI6W10sIm1hcHBpbmdzIjoiO0FBQUE7OztBQUFBLElBQUEsR0FBQSxFQUFBLE1BQUE7RUFBQTs7O0FBTUEsT0FBTyxLQUFQLEVBQUE7RUFBZ0IsU0FBaEI7Q0FBQSxNQUFBOztBQUVNLFNBQU4sTUFBQSxPQUFBLFFBQXFCLFVBQXJCO0VBQ0MsTUFBUyxDQUFBLENBQUE7V0FBSSxDQUFBLE9BQU8sS0FBQSxDQUFNLENBQUM7UUFBQyxLQUFBLEVBQU07TUFBUCxDQUFELEVBQWEsT0FBQSxDQUFVLENBQUMsQ0FBQSxDQUFBLEdBQUE7ZUFBTSxJQUFDLENBQUEsS0FBSyxDQUFDLElBQVAsQ0FBWSxJQUFDLENBQUEsS0FBSyxDQUFDLEdBQW5CO01BQU4sQ0FBRCxDQUFwQyxDQUFrRSxDQUFFLElBQUMsQ0FBQSxLQUFLLENBQUMsR0FBVCxDQUFsRSxFQUFBLE1BQUE7RUFBSjs7QUFEVjs7QUFHQSxPQUFBLFFBQXFCLE1BQU4sTUFBQSxJQUFBLFFBQWtCLFVBQWxCO0VBRWQsV0FBYyxDQUFBLENBQUE7O1FBaUJkLENBQUEsV0FBQSxDQUFBO0lBZkMsSUFBQyxDQUFBLEtBQUQsR0FBUztNQUFDLENBQUEsRUFBRSxHQUFIO01BQVEsQ0FBQSxFQUFFLEdBQVY7TUFBZSxDQUFBLEVBQUUsR0FBakI7TUFBc0IsQ0FBQSxFQUFFLEdBQXhCO01BQTZCLFFBQUEsRUFBUztJQUF0QztFQUZJOztFQUlkLE1BQVMsQ0FBQSxDQUFBO1dBQ1AsQ0FBQSxHQUFBO0dBQ0MsQ0FBQSxHQUFBLENBQUcsQ0FBRSxJQUFDLENBQUEsS0FBSyxDQUFDLENBQVQsQ0FBSCxFQUFBLEdBQUE7R0FDQSxDQUFBLEdBQUEsQ0FBRyxDQUFFLElBQUMsQ0FBQSxLQUFLLENBQUMsQ0FBVCxDQUFILEVBQUEsR0FBQTtHQUNBLENBQUEsR0FBQSxDQUFHLENBQUUsSUFBQyxDQUFBLEtBQUssQ0FB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QUFDLENBQXZDO1FBQTBDLFFBQUEsRUFBUztNQUFuRCxDQUFWLEVBUkQ7O0lBVUEsSUFBRyxhQUFPLGFBQVAsRUFBQSxHQUFBLE1BQUg7TUFDQyxJQUFHLElBQUMsQ0FBQSxLQUFLLENBQUMsUUFBVjtRQUNDLElBQUcsYUFBTyxZQUFQLEVBQUEsR0FBQSxNQUFBLElBQXVCLENBQUksSUFBQyxDQUFBLEtBQUssQ0FBQyxDQUFDLENBQUMsUUFBVCxDQUFrQixHQUFsQixDQUE5QjtpQkFDQyxJQUFDLENBQUEsUUFBRCxDQUFVO1lBQUMsQ0FBQSxFQUFHLElBQUMsQ0FBQSxLQUFLLENBQUMsQ0FBUCxHQUFXO1VBQWYsQ0FBVixFQUREO1NBREQ7T0FBQSxNQUFBO2VBR0ssSUFBQyxDQUFBLFFBQUQsQ0FBVTtVQUFDLENBQUEsRUFBRyxHQUFKO1VBQVMsQ0FBQSxFQUFFLElBQUMsQ0FBQSxLQUFLLENBQUMsQ0FBbEI7VUFBcUIsQ0FBQSxFQUFFLElBQUMsQ0FBQSxLQUFLLENBQUMsQ0FBOUI7VUFBaUMsQ0FBQSxFQUFFLElBQUMsQ0FBQSxLQUFLLENBQUMsQ0FBMUM7VUFBNkMsUUFBQSxFQUFTO1FBQXRELENBQVYsRUFITDtPQUREOztFQWRNOztBQW5CTyIsInNvdXJjZXNDb250ZW50IjpbIiMjI1xyXG5lc2xpbnQtZGlzYWJsZSBpbXBvcnQvZmlyc3RcclxuIyMjXHJcblxyXG4jIENhbGN1bGF0b3IgUlBOXHJcblxyXG5pbXBvcnQgUmVhY3QsIHsgQ29tcG9uZW50IH0gZnJvbSAncmVhY3QnXHJcblxyXG5jbGFzcyBCdXR0b24gZXh0ZW5kcyBDb21wb25lbnQgXHJcblx0cmVuZGVyIDogLT4gPGJ1dHRvbiBzdHlsZT17e3dpZHRoOjUwfX0gb25DbGljayA9IHsoKSA9PiBAcHJvcHMuY2FsYyBAcHJvcHMuY21kfT57QHByb3BzLmNtZH08L2J1dHRvbj5cclxuXHJcbmV4cG9ydCBkZWZhdWx0IGNsYXNzIEFwcCBleHRlbmRzIENvbXBvbmVudCBcclxuXHJcblx0Y29uc3RydWN0b3IgOiAtPlxyXG5cdFx0c3VwZXIoKVxyXG5cdFx0QHN0YXRlID0ge3Q6JzAnLCB6OicxJywgeTonMicsIHg6JzMnLCBlbnRlcmluZzpmYWxzZX1cclxuXHJcblx0cmVuZGVyIDogLT5cclxuXHRcdDxkaXY+XHJcblx0XHRcdDxkaXY+e0BzdGF0ZS50fTwvZGl2PlxyXG5cdFx0XHQ8ZGl2PntAc3RhdGUuen08L2Rpdj5cclxuXHRcdFx0PGRpdj57QHN0YXRlLnl9PC9kaXY+XHJcblx0XHRcdDxkaXY+e0BzdGF0ZS54fTwvZGl2PlxyXG5cdFx0XHQ8ZGl2PjxCdXR0b24gY2FsYz17QGNhbGN9IGNtZD0nY2xyJyAvPiA8QnV0dG9uIGNhbGM9e0BjYWxjfSBjbWQ9J2NocycgLz4gIDxCdXR0b24gY2FsYz17QGNhbGN9IGNtZD0nJScgLz4gPEJ1dHRvbiBjYWxjPXtAY2FsY30gY21kPSfDtycgLz4gPC9kaXY+XHJcblx0XHRcdDxkaXY+PEJ1dHRvbiBjYWxjPXtAY2FsY30gY21kPSc3JyAvPiAgIDxCdXR0b24gY2FsYz17QGNhbGN9IGNtZD0nOCcgLz4gIDxCdXR0b24gY2FsYz17QGNhbGN9IGNtZD0nOScgLz4gPEJ1dHRvbiBjYWxjPXtAY2FsY30gY21kPSd4JyAvPiA8L2Rpdj5cclxuXHRcdFx0PGRpdj48QnV0dG9uIGNhbGM9e0BjYWxjfSBjbWQ9JzQnIC8+ICAgPEJ1dHRvbiBjYWxjPXtAY2FsY30gY21kPSc1JyAvPiAgPEJ1dHRvbiBjYWxjPXtAY2FsY30gY21kPSc2JyAvPiA8QnV0dG9uIGNhbGM9e0BjYWxjfSBjbWQ9Jy0nIC8+IDwvZGl2PlxyXG5cdFx0XHQ8ZGl2PjxCdXR0b24gY2FsYz17QGNhbGN9IGNtZD0nMScgLz4gICA8QnV0dG9uIGNhbGM9e0BjYWxjfSBjbWQ9JzInIC8+ICA8QnV0dG9uIGNhbGM9e0BjYWxjfSBjbWQ9JzMnIC8+IDxCdXR0b24gY2FsYz17QGNhbGN9IGNtZD0nKycgLz4gPC9kaXY+XHJcblx0XHRcdDxkaXY+PEJ1dHRvbiBjYWxjPXtAY2FsY30gY21kPScwJyAvPiAgIDxCdXR0b24gY2FsYz17QGNhbGN9IGNtZD0nLicgLz4gIDxCdXR0b24gY2FsYz17QGNhbGN9IGNtZD0nZW50ZXInIC8+IDwvZGl2PlxyXG5cdFx0PC9kaXY+XHJcblxyXG5cdGNhbGMgOiAoY21kKSA9PiBcclxuXHRcdGlmIGNtZCA9PSAnY2xyJyAgIHRoZW4gQHNldFN0YXRlIHt4OicwJywgeTonMCcsIHo6JzAnLCB0OicwJywgZW50ZXJpbmc6ZmFsc2V9XHJcblx0XHRpZiBjbWQgPT0gJ2VudGVyJyB0aGVuIEBzZXRTdGF0ZSB7eDpAc3RhdGUueCwgeTpAc3RhdGUueCwgejpAc3RhdGUueSwgdDpAc3RhdGUueiwgZW50ZXJpbmc6ZmFsc2V9XHJcblx0XHRpZiBjbWQgPT0gJ2NocycgICB0aGVuIEBzZXRTdGF0ZSB7eCA6IC1Ac3RhdGUueCwgZW50ZXJpbmc6ZmFsc2V9XHJcblx0XHRpZiBjbWQgaW4gXCIrLXjDtyVcIlxyXG5cdFx0XHR4ID0gcGFyc2VGbG9hdCBAc3RhdGUueFxyXG5cdFx0XHR5ID0gcGFyc2VGbG9hdCBAc3RhdGUueVxyXG5cdFx0XHRpZiBjbWQgPT0gJysnIHRoZW4geCA9IHkreFxyXG5cdFx0XHRpZiBjbWQgPT0gJy0nIHRoZW4geCA9IHkteFxyXG5cdFx0XHRpZiBjbWQgPT0gJ3gnIHRoZW4geCA9IHkqeFxyXG5cdFx0XHRpZiBjbWQgPT0gJ8O3JyB0aGVuIHggPSB5L3hcclxuXHRcdFx0aWYgY21kID09ICclJyB0aGVuIHggPSB5JXhcclxuXHRcdFx0QHNldFN0YXRlIHt4OiB4LnRvU3RyaW5nKCksIHk6QHN0YXRlLnosIHo6QHN0YXRlLnQsIGVudGVyaW5nOmZhbHNlfVxyXG5cclxuXHRcdGlmIGNtZCBpbiBcIjAxMjM0NTY3ODkuXCJcclxuXHRcdFx0aWYgQHN0YXRlLmVudGVyaW5nXHJcblx0XHRcdFx0aWYgY21kIGluICcwMTIzNDU2Nzg5JyBvciBub3QgQHN0YXRlLnguaW5jbHVkZXMgJy4nXHJcblx0XHRcdFx0XHRAc2V0U3RhdGUge3g6IEBzdGF0ZS54ICsgY21kfVxyXG5cdFx0XHRlbHNlIEBzZXRTdGF0ZSB7eDogY21kLCB5OkBzdGF0ZS54LCB6OkBzdGF0ZS55LCB0OkBzdGF0ZS56LCBlbnRlcmluZzp0cnVlfVxyXG4iXX0=
//# sourceURL=C:\Lab\2017\155-React-Sandbox\coffee\App3.coffee