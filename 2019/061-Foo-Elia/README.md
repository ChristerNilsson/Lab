# An alternative way of building a DOM tree

* No need to state the parent
* No need to use variables
* No need to call createAndAppend
* No need to call document.createElement 
* No need to call appendChild
* Structure shown directly

Compare Coffeescript and Javascript below.

## Original
```
const title = document.createElement('title');
document.head.appendChild(title);
title.innerText = 'Elia Books';

const h1 = document.createElement('h1');
document.body.appendChild(h1);
h1.innerText = 'My Must Read Books';

const ul = document.createElement('ul');
document.body.appendChild(ul);

for (const book of books) {
  const li = document.createElement('li');
  ul.appendChild(li);

  const h2 = document.createElement('h2');
  li.appendChild(h2);
  h2.innerText = book.title;

  const h3a = document.createElement('h3');
  li.appendChild(h3a);
  h3a.innerText = 'Author: ' + book.author;

  const h3b = document.createElement('h3');
  li.appendChild(h3b);
  h3b.innerText = 'Language: ' + book.language;

  img = document.createElement('img');
  li.appendChild(img);
  img.src = book.cover;
  img.height = 42;
}
```

## using createAndAppend
```
createAndAppend('title', document.head, {innerText: 'Elia Books'});
createAndAppend('h1', document.body, {innerText: 'My Must Read Books'});
const ul = createAndAppend('ul',document.body);
for (const book of books) {
  const li = createAndAppend('li', ul);
  createAndAppend('h2', li, {innerText: book.title});
  createAndAppend('h3', li, {innerText: 'Author: ' + book.author});
  createAndAppend('h3', li, {innerText: 'Language: ' + book.language});
  createAndAppend('img', li, {src : book.cover, height: 42});
};
```

## Javascript

```
head( () => {
  title({innerText: 'Elia Books'});
});
body( () => {
  h1({innerText: 'My Must Read Books'});
  ul({}, () => {
    for (const book of books) {
      li({}, () => {
        h2({innerText: book.title});
        h3({innerText: 'Author: ' + book.author});
        h3({innerText: 'Language: ' + book.language});
        img({src: book.cover, height: 42});
      });
    };
  });
});
```

## CoffeeScript

```
head ->
  title {innerText: 'Elia Books'}
body ->
  h1 {innerText: 'My Must Read Books'}
  ul {}, ->
    for book in books
      li {}, ->
        h2 {innerText: book.title}
        h3 {innerText: 'Author: ' + book.author}
        h3 {innerText: 'Language: ' + book.language}
        img {src: book.cover, height: 42}
```
