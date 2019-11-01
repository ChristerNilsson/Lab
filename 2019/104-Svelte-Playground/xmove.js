const fs = require('fs-extra')

const srcpath = process.argv[2]
const dstpath = process.argv[3]

try {
	console.log(`Copying ${srcpath} to ${dstpath}`)
	fs.moveSync(srcpath, dstpath)
} catch (err) {
	console.log('Error in xmove')
}
