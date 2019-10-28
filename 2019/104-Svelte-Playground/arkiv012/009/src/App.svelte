<script>
	// Can't see any easy way of defining multiple canvasses.
	// without using new p5
	const sketch1 = (p) => {
		p.setup = () => {
			p.createCanvas(400, 400);
			p.background(0)
		}
		p.mouseMoved = () => {
			p.fill(255,255,0)
			p.rect(p.mouseX,p.mouseY,10,10)
		}
	}

	const sketch2 = (p) => {
		p.setup = () => {
			p.createCanvas(400, 400);
			p.background(128)
		}
		p.mouseMoved = () => {
			p.fill(255,0,0)
			p.rect(p.mouseX,p.mouseY,10,10)
		}
	}

	const p1 = new p5(sketch1)
	const p2 = new p5(sketch2)

</script>
