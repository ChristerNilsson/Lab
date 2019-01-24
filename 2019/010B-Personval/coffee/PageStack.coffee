class PageStack

	constructor : -> @stack = []
	push : (page) -> @stack.push page
	pop : -> @stack.pop()
	last : -> _.last @stack

	draw : -> 
		last = @last()
		for page in @stack
			if last.modal and page == last
				fc 0,0,0,0.5
				rect 0,0,width,height	
			page.draw() 

	# Denna konstruktion nödvändig eftersom klick på Motala ger Utskrift.
	# Dvs ett klick tolkas som två. 
	mousePressed : -> 
		last = @last()
		if last.modal
			if last.mousePressed() then return				
		else
			ps = (page for page in @stack)
			for page in ps
				if page.mousePressed() then return
