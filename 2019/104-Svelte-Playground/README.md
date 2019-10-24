# Svelte

Svelte is a modern alternative to React. It is a compiler, not a framework.
This means small and fast. Svelte does not use a Virtual DOM. Instead, like Excel, it finds out the dependencies between variables and GUI components.

## Pros

* Small
* Fast
* Few slocs

## Cons

* Small user base. 
  * 2019-10-17: 24775/5878791 = 0.4% of React

## Links

* [svelte.dev](https://svelte.dev)
* [Rich Harris - Rethinking reactivity](https://www.youtube.com/watch?v=AdNJ3fydeao)

## Sub Projects

* [001 Organizer](         https://christernilsson.github.io/Lab/2019/104-Svelte-Playground/arkiv/001/public)
* [002 Shortcut](          https://christernilsson.github.io/Lab/2019/104-Svelte-Playground/arkiv/002/public)
* [003 Player Scoreboard]( https://christernilsson.github.io/Lab/2019/104-Svelte-Playground/arkiv/003/public)
* [004 Guess My Number](   https://christernilsson.github.io/Lab/2019/104-Svelte-Playground/arkiv/004/public)
* [005 RPN Calculator](    https://christernilsson.github.io/Lab/2019/104-Svelte-Playground/arkiv/005/public) 
* [008 Bootstrap](    https://christernilsson.github.io/Lab/2019/104-Svelte-Playground/arkiv/008/public) 


* 005
RPN in [React](https://github.com/t-eckert/react-rpn): 525 loc 
RPN in [React](https://github.com/slinke/react-rpn-calculator) Fourbanger

## Work like this

* Make sure you are in arkiv mode, otherwise put current sub project.
* .\create 099
* .\get 099
* Make public/index.html active in Code.
* Start Go Live
* Loop until ready
	* edit src
	* ctrl-s
* Stop server 
* Stop Go Live
* .\put 099
* commit

## .\create 099

Makes a new sub project. You must be in arkiv mode

## .\destroy 099

Destroys a sub project. You must be in arkiv mode

## .\get 001

Get a sub project. You must be in arkiv mode

## .\put 001

Put a sub project. You will change to arkiv mode

## Start

npm run dev

## Build

npm run build

## styles.js

This file contains css code to be shared between components, while storing in a common file.
This file can't be a .css file.
Increases the size of bundle.js

## Svelte Keywords

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

* Using callbacks for data makes dispatch obsolete sometimes
* body {margin: 0 0}
* lodash/random increased the size of bundle.js with 600 lines.
* styles.js (emotion) increases bundle.js from 6kb to 21kb

## Bootstrap

* @import url(https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.css)
* [HackerThemes Cheat Sheet](https://hackerthemes.com/bootstrap-cheatsheet/)