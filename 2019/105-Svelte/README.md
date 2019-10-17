# Svelte

Svelte is a modern alternative to React. It is a compiler, not a framework.
This means small and fast. Svelte does not use a Virtual DOM. Instead, it tries, like Excel, to find out the dependencies between variables and GUI.

# Pros

* Small
* Fast
* Few slocs

# Cons

* Small user base. 2019 about 1/1000 of React.

* [svelte.dev](https://svelte.dev)
* [Rich Harris - Rethinking reactivity](https://www.youtube.com/watch?v=AdNJ3fydeao)

* [001 Organizer](https://christernilsson.github.io/Lab/2019/105-Svelte/public001)
* [002 Shortcut](https://christernilsson.github.io/Lab/2019/105-Svelte/public002)
* [003 Player Scoreboard](https://christernilsson.github.io/Lab/2019/105-Svelte/public003)
* [004 Guess My Number](https://christernilsson.github.io/Lab/2019/105-Svelte/public004)

## Start

npm run dev

## Build

npm run build

## Publish

## Keywords

* dispatch - Sends a message, with data, to a component.
* Implicit state. obj = obj touches
* on: introduces an event
* bind: two way binder between variables and GUI components
* #if :else /if
* #each /each
* event.detail - Contains data sent by dispatch
* <script></script> for .js
* <style></style>   for css

## Knowledge Nuggets

Using callbacks for data makes dispatch obsolete sometimes

## Single node_modules

Shrinks disk space from 20 Mb to 0.1 Mb per project.

Solving this by using several App.svelte
* src/App2.svelte
* Make a small change in main.js
  * import App from './App2.svelte'
  * They share the same bundle.js
  * To publish, copy the public directory

Common files
* main.js
* index.html
* global.css