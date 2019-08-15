// Generated by CoffeeScript 2.3.2
var body, books, crap, createAndAppend, div, h1, h2, h3, head, img, li, stack, title, ul;

createAndAppend = (type, parent, attributes = {}) => {
  var elem, key, value;
  elem = document.createElement(type);
  parent.appendChild(elem);
  for (key in attributes) {
    value = attributes[key];
    elem[key] = value;
  }
  return elem;
};

stack = [];

crap = (attributes, f, type) => {
  if (typeof type === 'object') {
    stack.push(type);
  } else {
    stack.push(createAndAppend(type, _.last(stack), attributes));
  }
  f();
  return stack.pop();
};

head = (f = () => {}) => {
  return crap({}, f, document.head);
};

body = (f = () => {}) => {
  return crap({}, f, document.body);
};

title = (attributes, f = () => {}) => {
  return crap(attributes, f, 'title');
};

h1 = (attributes, f = () => {}) => {
  return crap(attributes, f, 'h1');
};

h2 = (attributes, f = () => {}) => {
  return crap(attributes, f, 'h2');
};

h3 = (attributes, f = () => {}) => {
  return crap(attributes, f, 'h3');
};

ul = (attributes, f = () => {}) => {
  return crap(attributes, f, 'ul');
};

li = (attributes, f = () => {}) => {
  return crap(attributes, f, 'li');
};

img = (attributes, f = () => {}) => {
  return crap(attributes, f, 'img');
};

div = (attributes, f = () => {}) => {
  return crap(attributes, f, 'div');
};

//##############################################################
books = [
  {
    title: 'The Kite Runner',
    author: 'Khaled Hosseini',
    language: 'English',
    cover: '3.jpg'
  },
  {
    title: 'Number the Stars',
    author: 'lois Lowry',
    language: 'English',
    cover: '4.jpg'
  },
  {
    title: 'Pride and Prejudice',
    author: 'Jane Austen',
    language: 'English',
    cover: '5.jpg'
  },
  {
    title: 'The Outsiders',
    author: 'S.E Hinton',
    language: 'English',
    cover: '7.jpg'
  },
  {
    title: 'Little Women',
    author: 'Louisa May',
    language: 'English',
    cover: '8.jpg'
  }
];

head(() => {
  return title({
    innerText: 'Elia Books'
  });
});

body(() => {
  h1({
    innerText: 'My Must Read Books',
    style: 'background:red'
  });
  return ul({
    style: 'background:yellow'
  }, () => {
    var book, i, len, results;
    results = [];
    for (i = 0, len = books.length; i < len; i++) {
      book = books[i];
      results.push(li({
        style: 'background:gray'
      }, () => {
        h2({
          innerText: book.title,
          style: 'background:green; color:yellow'
        });
        h3({
          innerText: 'Author: ' + book.author,
          style: 'background:orange'
        });
        h3({
          innerText: 'Language: ' + book.language
        });
        return img({
          src: book.cover,
          height: 42
        });
      }));
    }
    return results;
  });
});

//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoic2tldGNoLmpzIiwic291cmNlUm9vdCI6Ii4uIiwic291cmNlcyI6WyJjb2ZmZWVcXHNrZXRjaC5jb2ZmZWUiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBLElBQUEsSUFBQSxFQUFBLEtBQUEsRUFBQSxJQUFBLEVBQUEsZUFBQSxFQUFBLEdBQUEsRUFBQSxFQUFBLEVBQUEsRUFBQSxFQUFBLEVBQUEsRUFBQSxJQUFBLEVBQUEsR0FBQSxFQUFBLEVBQUEsRUFBQSxLQUFBLEVBQUEsS0FBQSxFQUFBOztBQUFBLGVBQUEsR0FBa0IsQ0FBQyxJQUFELEVBQU8sTUFBUCxFQUFlLGFBQWEsQ0FBQSxDQUE1QixDQUFBLEdBQUE7QUFDakIsTUFBQSxJQUFBLEVBQUEsR0FBQSxFQUFBO0VBQUEsSUFBQSxHQUFPLFFBQVEsQ0FBQyxhQUFULENBQXVCLElBQXZCO0VBQ1AsTUFBTSxDQUFDLFdBQVAsQ0FBbUIsSUFBbkI7RUFDa0IsS0FBQSxpQkFBQTs7SUFBbEIsSUFBSyxDQUFBLEdBQUEsQ0FBTCxHQUFZO0VBQU07U0FDbEI7QUFKaUI7O0FBTWxCLEtBQUEsR0FBUTs7QUFFUixJQUFBLEdBQU8sQ0FBQyxVQUFELEVBQWEsQ0FBYixFQUFnQixJQUFoQixDQUFBLEdBQUE7RUFDTixJQUFHLE9BQU8sSUFBUCxLQUFlLFFBQWxCO0lBQWdDLEtBQUssQ0FBQyxJQUFOLENBQVcsSUFBWCxFQUFoQztHQUFBLE1BQUE7SUFDSyxLQUFLLENBQUMsSUFBTixDQUFXLGVBQUEsQ0FBZ0IsSUFBaEIsRUFBc0IsQ0FBQyxDQUFDLElBQUYsQ0FBTyxLQUFQLENBQXRCLEVBQXFDLFVBQXJDLENBQVgsRUFETDs7RUFFQSxDQUFBLENBQUE7U0FDQSxLQUFLLENBQUMsR0FBTixDQUFBO0FBSk07O0FBTVAsSUFBQSxHQUFRLENBQWEsSUFBSSxDQUFBLENBQUEsR0FBQSxFQUFBLENBQWpCLENBQUEsR0FBQTtTQUF3QixJQUFBLENBQUssQ0FBQSxDQUFMLEVBQVMsQ0FBVCxFQUFZLFFBQVEsQ0FBQyxJQUFyQjtBQUF4Qjs7QUFDUixJQUFBLEdBQVEsQ0FBYSxJQUFJLENBQUEsQ0FBQSxHQUFBLEVBQUEsQ0FBakIsQ0FBQSxHQUFBO1NBQXdCLElBQUEsQ0FBSyxDQUFBLENBQUwsRUFBUyxDQUFULEVBQVksUUFBUSxDQUFDLElBQXJCO0FBQXhCOztBQUNSLEtBQUEsR0FBUSxDQUFDLFVBQUQsRUFBYSxJQUFJLENBQUEsQ0FBQSxHQUFBLEVBQUEsQ0FBakIsQ0FBQSxHQUFBO1NBQXdCLElBQUEsQ0FBSyxVQUFMLEVBQWlCLENBQWpCLEVBQW9CLE9BQXBCO0FBQXhCOztBQUNSLEVBQUEsR0FBUSxDQUFDLFVBQUQsRUFBYSxJQUFJLENBQUEsQ0FBQSxHQUFBLEVBQUEsQ0FBakIsQ0FBQSxHQUFBO1NBQXdCLElBQUEsQ0FBSyxVQUFMLEVBQWlCLENBQWpCLEVBQW9CLElBQXBCO0FBQXhCOztBQUNSLEVBQUEsR0FBUSxDQUFDLFVBQUQsRUFBYSxJQUFJLENBQUEsQ0FBQSxHQUFBLEVBQUEsQ0FBakIsQ0FBQSxHQUFBO1NBQXdCLElBQUEsQ0FBSyxVQUFMLEVBQWlCLENBQWpCLEVBQW9CLElBQXBCO0FBQXhCOztBQUNSLEVBQUEsR0FBUSxDQUFDLFVBQUQsRUFBYSxJQUFJLENBQUEsQ0FBQSxHQUFBLEVBQUEsQ0FBakIsQ0FBQSxHQUFBO1NBQXdCLElBQUEsQ0FBSyxVQUFMLEVBQWlCLENBQWpCLEVBQW9CLElBQXBCO0FBQXhCOztBQUNSLEVBQUEsR0FBUSxDQUFDLFVBQUQsRUFBYSxJQUFJLENBQUEsQ0FBQSxHQUFBLEVBQUEsQ0FBakIsQ0FBQSxHQUFBO1NBQXdCLElBQUEsQ0FBSyxVQUFMLEVBQWlCLENBQWpCLEVBQW9CLElBQXBCO0FBQXhCOztBQUNSLEVBQUEsR0FBUSxDQUFDLFVBQUQsRUFBYSxJQUFJLENBQUEsQ0FBQSxHQUFBLEVBQUEsQ0FBakIsQ0FBQSxHQUFBO1NBQXdCLElBQUEsQ0FBSyxVQUFMLEVBQWlCLENBQWpCLEVBQW9CLElBQXBCO0FBQXhCOztBQUNSLEdBQUEsR0FBUSxDQUFDLFVBQUQsRUFBYSxJQUFJLENBQUEsQ0FBQSxHQUFBLEVBQUEsQ0FBakIsQ0FBQSxHQUFBO1NBQXdCLElBQUEsQ0FBSyxVQUFMLEVBQWlCLENBQWpCLEVBQW9CLEtBQXBCO0FBQXhCOztBQUNSLEdBQUEsR0FBUSxDQUFDLFVBQUQsRUFBYSxJQUFJLENBQUEsQ0FBQSxHQUFBLEVBQUEsQ0FBakIsQ0FBQSxHQUFBO1NBQXdCLElBQUEsQ0FBSyxVQUFMLEVBQWlCLENBQWpCLEVBQW9CLEtBQXBCO0FBQXhCLEVBdkJSOzs7QUEyQkEsS0FBQSxHQUFRO0VBQ047SUFBQyxLQUFBLEVBQU8saUJBQVI7SUFBK0IsTUFBQSxFQUFRLGlCQUF2QztJQUEwRCxRQUFBLEVBQVUsU0FBcEU7SUFBK0UsS0FBQSxFQUFPO0VBQXRGLENBRE07RUFFTjtJQUFDLEtBQUEsRUFBTyxrQkFBUjtJQUErQixNQUFBLEVBQVEsWUFBdkM7SUFBMEQsUUFBQSxFQUFVLFNBQXBFO0lBQStFLEtBQUEsRUFBTztFQUF0RixDQUZNO0VBR047SUFBQyxLQUFBLEVBQU8scUJBQVI7SUFBK0IsTUFBQSxFQUFRLGFBQXZDO0lBQTBELFFBQUEsRUFBVSxTQUFwRTtJQUErRSxLQUFBLEVBQU87RUFBdEYsQ0FITTtFQUlOO0lBQUMsS0FBQSxFQUFPLGVBQVI7SUFBK0IsTUFBQSxFQUFRLFlBQXZDO0lBQTBELFFBQUEsRUFBVSxTQUFwRTtJQUErRSxLQUFBLEVBQU87RUFBdEYsQ0FKTTtFQUtOO0lBQUMsS0FBQSxFQUFPLGNBQVI7SUFBK0IsTUFBQSxFQUFRLFlBQXZDO0lBQTBELFFBQUEsRUFBVSxTQUFwRTtJQUErRSxLQUFBLEVBQU87RUFBdEYsQ0FMTTs7O0FBUVIsSUFBQSxDQUFLLENBQUEsQ0FBQSxHQUFBO1NBQ0osS0FBQSxDQUFNO0lBQUMsU0FBQSxFQUFXO0VBQVosQ0FBTjtBQURJLENBQUw7O0FBRUEsSUFBQSxDQUFLLENBQUEsQ0FBQSxHQUFBO0VBQ0osRUFBQSxDQUFHO0lBQUMsU0FBQSxFQUFXLG9CQUFaO0lBQWtDLEtBQUEsRUFBTztFQUF6QyxDQUFIO1NBQ0EsRUFBQSxDQUFHO0lBQUMsS0FBQSxFQUFPO0VBQVIsQ0FBSCxFQUFpQyxDQUFBLENBQUEsR0FBQTtBQUNoQyxRQUFBLElBQUEsRUFBQSxDQUFBLEVBQUEsR0FBQSxFQUFBO0FBQUE7SUFBQSxLQUFBLHVDQUFBOzttQkFDQyxFQUFBLENBQUc7UUFBQyxLQUFBLEVBQU87TUFBUixDQUFILEVBQStCLENBQUEsQ0FBQSxHQUFBO1FBQzlCLEVBQUEsQ0FBRztVQUFDLFNBQUEsRUFBVyxJQUFJLENBQUMsS0FBakI7VUFBd0IsS0FBQSxFQUFPO1FBQS9CLENBQUg7UUFDQSxFQUFBLENBQUc7VUFBQyxTQUFBLEVBQVcsVUFBQSxHQUFhLElBQUksQ0FBQyxNQUE5QjtVQUFzQyxLQUFBLEVBQU87UUFBN0MsQ0FBSDtRQUNBLEVBQUEsQ0FBRztVQUFDLFNBQUEsRUFBVyxZQUFBLEdBQWUsSUFBSSxDQUFDO1FBQWhDLENBQUg7ZUFDQSxHQUFBLENBQUk7VUFBQyxHQUFBLEVBQUssSUFBSSxDQUFDLEtBQVg7VUFBa0IsTUFBQSxFQUFRO1FBQTFCLENBQUo7TUFKOEIsQ0FBL0I7SUFERCxDQUFBOztFQURnQyxDQUFqQztBQUZJLENBQUwiLCJzb3VyY2VzQ29udGVudCI6WyJjcmVhdGVBbmRBcHBlbmQgPSAodHlwZSwgcGFyZW50LCBhdHRyaWJ1dGVzID0ge30pID0+XHJcblx0ZWxlbSA9IGRvY3VtZW50LmNyZWF0ZUVsZW1lbnQgdHlwZVxyXG5cdHBhcmVudC5hcHBlbmRDaGlsZCBlbGVtXHJcblx0ZWxlbVtrZXldID0gdmFsdWUgZm9yIGtleSx2YWx1ZSBvZiBhdHRyaWJ1dGVzIFxyXG5cdGVsZW1cclxuXHJcbnN0YWNrID0gW11cclxuXHJcbmNyYXAgPSAoYXR0cmlidXRlcywgZiwgdHlwZSkgPT5cclxuXHRpZiB0eXBlb2YgdHlwZSA9PSAnb2JqZWN0JyB0aGVuIHN0YWNrLnB1c2ggdHlwZVxyXG5cdGVsc2Ugc3RhY2sucHVzaCBjcmVhdGVBbmRBcHBlbmQgdHlwZSwgXy5sYXN0KHN0YWNrKSwgYXR0cmlidXRlc1xyXG5cdGYoKVxyXG5cdHN0YWNrLnBvcCgpXHJcblxyXG5oZWFkID0gICggICAgICAgICAgICBmID0gPT4pID0+IGNyYXAge30sIGYsIGRvY3VtZW50LmhlYWRcclxuYm9keSA9ICAoICAgICAgICAgICAgZiA9ID0+KSA9PiBjcmFwIHt9LCBmLCBkb2N1bWVudC5ib2R5XHJcbnRpdGxlID0gKGF0dHJpYnV0ZXMsIGYgPSA9PikgPT4gY3JhcCBhdHRyaWJ1dGVzLCBmLCAndGl0bGUnXHJcbmgxID0gICAgKGF0dHJpYnV0ZXMsIGYgPSA9PikgPT4gY3JhcCBhdHRyaWJ1dGVzLCBmLCAnaDEnXHJcbmgyID0gICAgKGF0dHJpYnV0ZXMsIGYgPSA9PikgPT4gY3JhcCBhdHRyaWJ1dGVzLCBmLCAnaDInXHJcbmgzID0gICAgKGF0dHJpYnV0ZXMsIGYgPSA9PikgPT4gY3JhcCBhdHRyaWJ1dGVzLCBmLCAnaDMnXHJcbnVsID0gICAgKGF0dHJpYnV0ZXMsIGYgPSA9PikgPT4gY3JhcCBhdHRyaWJ1dGVzLCBmLCAndWwnXHJcbmxpID0gICAgKGF0dHJpYnV0ZXMsIGYgPSA9PikgPT4gY3JhcCBhdHRyaWJ1dGVzLCBmLCAnbGknIFxyXG5pbWcgPSAgIChhdHRyaWJ1dGVzLCBmID0gPT4pID0+IGNyYXAgYXR0cmlidXRlcywgZiwgJ2ltZydcclxuZGl2ID0gICAoYXR0cmlidXRlcywgZiA9ID0+KSA9PiBjcmFwIGF0dHJpYnV0ZXMsIGYsICdkaXYnXHJcblxyXG4jIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyNcclxuXHJcbmJvb2tzID0gW1xyXG4gIHt0aXRsZTogJ1RoZSBLaXRlIFJ1bm5lcicsICAgICBhdXRob3I6ICdLaGFsZWQgSG9zc2VpbmknLFx0bGFuZ3VhZ2U6ICdFbmdsaXNoJywgY292ZXI6ICczLmpwZycsIH0sXHJcbiAge3RpdGxlOiAnTnVtYmVyIHRoZSBTdGFycycsICAgIGF1dGhvcjogJ2xvaXMgTG93cnknLCAgICAgIGxhbmd1YWdlOiAnRW5nbGlzaCcsIGNvdmVyOiAnNC5qcGcnLCB9LFxyXG4gIHt0aXRsZTogJ1ByaWRlIGFuZCBQcmVqdWRpY2UnLCBhdXRob3I6ICdKYW5lIEF1c3RlbicsICAgICBsYW5ndWFnZTogJ0VuZ2xpc2gnLCBjb3ZlcjogJzUuanBnJywgfSxcclxuICB7dGl0bGU6ICdUaGUgT3V0c2lkZXJzJywgICAgICAgYXV0aG9yOiAnUy5FIEhpbnRvbicsICAgICAgbGFuZ3VhZ2U6ICdFbmdsaXNoJywgY292ZXI6ICc3LmpwZycsIH0sXHJcbiAge3RpdGxlOiAnTGl0dGxlIFdvbWVuJywgICAgICAgIGF1dGhvcjogJ0xvdWlzYSBNYXknLCAgICAgIGxhbmd1YWdlOiAnRW5nbGlzaCcsIGNvdmVyOiAnOC5qcGcnLCB9LFxyXG5dXHJcbiBcclxuaGVhZCA9PlxyXG5cdHRpdGxlIHtpbm5lclRleHQ6ICdFbGlhIEJvb2tzJ31cclxuYm9keSA9PlxyXG5cdGgxIHtpbm5lclRleHQ6ICdNeSBNdXN0IFJlYWQgQm9va3MnLCBzdHlsZTogJ2JhY2tncm91bmQ6cmVkJ31cclxuXHR1bCB7c3R5bGU6ICdiYWNrZ3JvdW5kOnllbGxvdyd9LCA9PiBcclxuXHRcdGZvciBib29rIGluIGJvb2tzXHJcblx0XHRcdGxpIHtzdHlsZTogJ2JhY2tncm91bmQ6Z3JheSd9LCA9PlxyXG5cdFx0XHRcdGgyIHtpbm5lclRleHQ6IGJvb2sudGl0bGUsIHN0eWxlOiAnYmFja2dyb3VuZDpncmVlbjsgY29sb3I6eWVsbG93J31cclxuXHRcdFx0XHRoMyB7aW5uZXJUZXh0OiAnQXV0aG9yOiAnICsgYm9vay5hdXRob3IsIHN0eWxlOiAnYmFja2dyb3VuZDpvcmFuZ2UnfVxyXG5cdFx0XHRcdGgzIHtpbm5lclRleHQ6ICdMYW5ndWFnZTogJyArIGJvb2subGFuZ3VhZ2V9XHJcblx0XHRcdFx0aW1nIHtzcmM6IGJvb2suY292ZXIsIGhlaWdodDogNDJ9Il19
//# sourceURL=c:\Lab\2019\061-Foo-Elia\coffee\sketch.coffee