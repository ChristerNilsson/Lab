# Guess My Number 

This is a library file used by node projects in the 100 series.

The original file for html is in project 100E-Guess-SPA.

I also tried 
```
const fs = require('fs').promises;
async function loadMonoCounter() {
    const data = await fs.readFile("monolitic.txt", "binary");
    return new Buffer(data);
}
```
but, it logged 'experimental' in the latest version of node.js.

### My opinion about async/await/Promise/promisify/promises/then etc.

* It seems a lot of effort has been invested in making node async.
* And then a lot of efforts to make it sync again as it is too hard to use.

### Lines of Code
```
A  5 CMD
B 14 CMD
C 16 CMD
D 15 CMD
E 21 SPA
F 18 API
G 17 API
H 21 GUI
I 19 GUI
J 19 GUI
K 21 GUI REACT
```