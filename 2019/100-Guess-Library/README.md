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

# My opinion about async/await/Promise/promisify/promises/then etc.

* It seems a lot of effort has been invested in making node async.
* And then a lot of efforts to make it sync again as it is too hard to use.