This proposal can handle things style can't handle.
Like s1 with margin > 0.

## Frameworks

* Bootstrap: col-1 to col-12 does not seem to handle this
* Materialize: s1 to s12 does not seem to handle this
* Svelte:

This proposal is not intended to replace style. It should be used as a solution where expressions must be calculated in the class code.

## Usage

```
const MARGPX = 1
const MARGPROC = 0.1
let w = 150
let s = 's3'

const calcS = (i) => `width:${(100-2*MARGPROC*12/i)*(i/12)}%`

'margpx':`margin:${MARGPX}px`,
'width':`width:${w-2*MARGPX}px`,
'margproc':`margin:${MARGPROC}%`,
s3 : calcS(3), 
```

```
<div style={style('width margpx')}>
<div style={style(s + ' margproc')}>
```

```
width:148px;
margin:1px;

width:24.8%;
margin:0.1%;
```
