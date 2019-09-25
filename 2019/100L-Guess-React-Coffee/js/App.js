// Generated by CoffeeScript 2.4.1
var App, crap, div, input, stack,
  boundMethodCheck = function(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new Error('Bound instance method accessed before binding'); } };

import React from 'react';

import ReactDOM from 'react-dom';

import Game from './game.js';

import _ from 'lodash';

//################################
stack = [[]];

crap = function(type, props = {}, arr = [], f = () => {}) {
  var children;
  stack.push([]);
  f();
  children = stack.pop();
  _.last(stack).push(React.createElement(type, props, ...arr, ...children));
  return _.last(stack);
};

div = (props, arr, f) => {
  return crap('div', props, arr, f);
};

input = (props, arr, f) => {
  return crap('input', props, arr, f);
};

//################################
App = class App extends React.Component {
  constructor(props) {
    super(props);
    this.render = this.render.bind(this);
    this.handleKeyUp = this.handleKeyUp.bind(this);
    this.state = {
      game: new Game(2)
    };
  }

  render() {
    boundMethodCheck(this, App);
    stack = [[]];
    return div({}, [], () => {
      div({}, [this.state.game.low, '-', this.state.game.high]);
      return input({
        onKeyUp: this.handleKeyUp
      });
    });
  }

  handleKeyUp(evt) {
    boundMethodCheck(this, App);
    if (evt.key !== 'Enter') {
      return;
    }
    if (evt.target.value === '') {
      this.state.game.init(2);
    } else {
      this.state.game.action(evt.target.value);
    }
    evt.target.value = '';
    return this.setState((state) => {
      return {
        game: state.game
      };
    });
  }

};

ReactDOM.render(<App />, document.getElementById("root"));

export default App;

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiQXBwLmpzIiwic291cmNlUm9vdCI6Ii4uIiwic291cmNlcyI6WyJjb2ZmZWVcXEFwcC5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLElBQUEsR0FBQSxFQUFBLElBQUEsRUFBQSxHQUFBLEVBQUEsS0FBQSxFQUFBLEtBQUE7RUFBQTs7QUFBQSxPQUFPLEtBQVAsTUFBQTs7QUFDQSxPQUFPLFFBQVAsTUFBQTs7QUFDQSxPQUFPLElBQVAsTUFBQTs7QUFDQSxPQUFPLENBQVAsTUFBQSxTQUhBOzs7QUFPQSxLQUFBLEdBQVEsQ0FBQyxFQUFEOztBQUNSLElBQUEsR0FBTyxRQUFBLENBQUMsSUFBRCxFQUFNLFFBQU0sQ0FBQSxDQUFaLEVBQWUsTUFBSSxFQUFuQixFQUFzQixJQUFHLENBQUEsQ0FBQSxHQUFBLEVBQUEsQ0FBekIsQ0FBQTtBQUNOLE1BQUE7RUFBQSxLQUFLLENBQUMsSUFBTixDQUFXLEVBQVg7RUFDQSxDQUFBLENBQUE7RUFDQSxRQUFBLEdBQVcsS0FBSyxDQUFDLEdBQU4sQ0FBQTtFQUNYLENBQUMsQ0FBQyxJQUFGLENBQU8sS0FBUCxDQUFhLENBQUMsSUFBZCxDQUFtQixLQUFLLENBQUMsYUFBTixDQUFvQixJQUFwQixFQUEwQixLQUExQixFQUFpQyxHQUFHLEdBQXBDLEVBQXlDLEdBQUcsUUFBNUMsQ0FBbkI7U0FDQSxDQUFDLENBQUMsSUFBRixDQUFPLEtBQVA7QUFMTTs7QUFPUCxHQUFBLEdBQVEsQ0FBQyxLQUFELEVBQU8sR0FBUCxFQUFXLENBQVgsQ0FBQSxHQUFBO1NBQWlCLElBQUEsQ0FBSyxLQUFMLEVBQVcsS0FBWCxFQUFpQixHQUFqQixFQUFxQixDQUFyQjtBQUFqQjs7QUFDUixLQUFBLEdBQVEsQ0FBQyxLQUFELEVBQU8sR0FBUCxFQUFXLENBQVgsQ0FBQSxHQUFBO1NBQWlCLElBQUEsQ0FBSyxPQUFMLEVBQWEsS0FBYixFQUFtQixHQUFuQixFQUF1QixDQUF2QjtBQUFqQixFQWhCUjs7O0FBb0JNLE1BQU4sTUFBQSxJQUFBLFFBQWtCLEtBQUssQ0FBQyxVQUF4QjtFQUNDLFdBQWMsQ0FBQyxLQUFELENBQUE7O1FBSWQsQ0FBQSxhQUFBLENBQUE7UUFNQSxDQUFBLGtCQUFBLENBQUE7SUFSQyxJQUFDLENBQUEsS0FBRCxHQUFTO01BQUMsSUFBQSxFQUFNLElBQUksSUFBSixDQUFTLENBQVQ7SUFBUDtFQUZJOztFQUlkLE1BQVMsQ0FBQSxDQUFBOzJCQUxKO0lBTUosS0FBQSxHQUFRLENBQUMsRUFBRDtXQUNSLEdBQUEsQ0FBSSxDQUFBLENBQUosRUFBTyxFQUFQLEVBQVUsQ0FBQSxDQUFBLEdBQUE7TUFDVCxHQUFBLENBQUksQ0FBQSxDQUFKLEVBQVEsQ0FBQyxJQUFDLENBQUEsS0FBSyxDQUFDLElBQUksQ0FBQyxHQUFiLEVBQWlCLEdBQWpCLEVBQXFCLElBQUMsQ0FBQSxLQUFLLENBQUMsSUFBSSxDQUFDLElBQWpDLENBQVI7YUFDQSxLQUFBLENBQU07UUFBQyxPQUFBLEVBQVMsSUFBQyxDQUFBO01BQVgsQ0FBTjtJQUZTLENBQVY7RUFGUTs7RUFNVCxXQUFjLENBQUMsR0FBRCxDQUFBOzJCQVhUO0lBWUosSUFBSSxHQUFHLENBQUMsR0FBSixLQUFXLE9BQWY7QUFBNkIsYUFBN0I7O0lBQ0EsSUFBSSxHQUFHLENBQUMsTUFBTSxDQUFDLEtBQVgsS0FBb0IsRUFBeEI7TUFBaUMsSUFBQyxDQUFBLEtBQUssQ0FBQyxJQUFJLENBQUMsSUFBWixDQUFpQixDQUFqQixFQUFqQztLQUFBLE1BQUE7TUFDSyxJQUFDLENBQUEsS0FBSyxDQUFDLElBQUksQ0FBQyxNQUFaLENBQW1CLEdBQUcsQ0FBQyxNQUFNLENBQUMsS0FBOUIsRUFETDs7SUFFQSxHQUFHLENBQUMsTUFBTSxDQUFDLEtBQVgsR0FBbUI7V0FDbkIsSUFBQyxDQUFBLFFBQUQsQ0FBVSxDQUFDLEtBQUQsQ0FBQSxHQUFBO2FBQVk7UUFBQyxJQUFBLEVBQU0sS0FBSyxDQUFDO01BQWI7SUFBWixDQUFWO0VBTGE7O0FBWGY7O0FBa0JBLFFBQVEsQ0FBQyxNQUFULENBQWlCLENBQUEsR0FBQSxHQUFqQixFQUF3QixRQUFRLENBQUMsY0FBVCxDQUF3QixNQUF4QixDQUF4Qjs7QUFFQSxPQUFBLFFBQWUiLCJzb3VyY2VzQ29udGVudCI6WyJpbXBvcnQgUmVhY3QgZnJvbSAncmVhY3QnXG5pbXBvcnQgUmVhY3RET00gZnJvbSAncmVhY3QtZG9tJ1xuaW1wb3J0IEdhbWUgZnJvbSAnLi9nYW1lLmpzJ1xuaW1wb3J0IF8gZnJvbSAnbG9kYXNoJ1xuXG4jIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyNcblxuc3RhY2sgPSBbW11dXG5jcmFwID0gKHR5cGUscHJvcHM9e30sYXJyPVtdLGY9ID0+KSAtPlxuXHRzdGFjay5wdXNoIFtdXG5cdGYoKVxuXHRjaGlsZHJlbiA9IHN0YWNrLnBvcCgpXG5cdF8ubGFzdChzdGFjaykucHVzaCBSZWFjdC5jcmVhdGVFbGVtZW50KHR5cGUsIHByb3BzLCAuLi5hcnIsIC4uLmNoaWxkcmVuKVxuXHRfLmxhc3Qoc3RhY2spXG5cbmRpdiAgID0gKHByb3BzLGFycixmKSA9PiBjcmFwICdkaXYnLHByb3BzLGFycixmXG5pbnB1dCA9IChwcm9wcyxhcnIsZikgPT4gY3JhcCAnaW5wdXQnLHByb3BzLGFycixmXG5cbiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjI1xuXG5jbGFzcyBBcHAgZXh0ZW5kcyBSZWFjdC5Db21wb25lbnQgXG5cdGNvbnN0cnVjdG9yIDogKHByb3BzKSAtPlxuXHRcdHN1cGVyKHByb3BzKVxuXHRcdEBzdGF0ZSA9IHtnYW1lOiBuZXcgR2FtZSgyKX1cblxuXHRyZW5kZXIgOiAoKSA9PlxuXHRcdHN0YWNrID0gW1tdXVxuXHRcdGRpdiB7fSxbXSw9PlxuXHRcdFx0ZGl2IHt9LCBbQHN0YXRlLmdhbWUubG93LCctJyxAc3RhdGUuZ2FtZS5oaWdoXVxuXHRcdFx0aW5wdXQge29uS2V5VXA6IEBoYW5kbGVLZXlVcH1cblxuXHRoYW5kbGVLZXlVcCA6IChldnQpID0+XG5cdFx0aWYgKGV2dC5rZXkgIT0gJ0VudGVyJykgdGhlbiByZXR1cm5cblx0XHRpZiAoZXZ0LnRhcmdldC52YWx1ZSA9PSAnJykgdGhlbiBAc3RhdGUuZ2FtZS5pbml0KDIpXG5cdFx0ZWxzZSBAc3RhdGUuZ2FtZS5hY3Rpb24oZXZ0LnRhcmdldC52YWx1ZSlcblx0XHRldnQudGFyZ2V0LnZhbHVlID0gJydcblx0XHRAc2V0U3RhdGUoKHN0YXRlKSA9PiAoe2dhbWU6IHN0YXRlLmdhbWV9KSlcblx0XG5SZWFjdERPTS5yZW5kZXIoPEFwcC8+LCBkb2N1bWVudC5nZXRFbGVtZW50QnlJZChcInJvb3RcIikpXG5cbmV4cG9ydCBkZWZhdWx0IEFwcFxuIl19
//# sourceURL=c:\Lab\2019\100L-Guess-React-Coffee\coffee\App.coffee