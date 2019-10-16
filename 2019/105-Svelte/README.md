Using callbacks for data makes dispatch obsolete sometimes

[001](https://christernilsson.github.io/Lab/2019/105-Svelte/public001)
[002](https://christernilsson.github.io/Lab/2019/105-Svelte/public002)
[003](https://christernilsson.github.io/Lab/2019/105-Svelte/public003)
[004](https://christernilsson.github.io/Lab/2019/105-Svelte/public004)


## Start

npm run dev

## Build

npm run build

## Publish

## Content

* 001 Organizer
* 002 -free-
* 003 Player Scoreboard (video)
* 004 Guess My Number

# Single node_modules

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