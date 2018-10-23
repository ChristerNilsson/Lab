class HP35
	constructor : ->
		@rom = [
			0,221,2,255,2, 36,0, 23,1, 68,2, 68,0,132,1, 16,2,209,3,251,0, 95,0,195,1,168,3,103,2,238,3,226,
			0, 46,0,144,3,234,3,234,3,234,0,107,2,105,0,168,2,168,0,255,3,234,3,234,3,234,0, 48,0,204,0,170,
			1,168,0, 67,1,211,0,204,0, 48,0,  0,0,131,1, 68,0, 68,0,187,2, 68,0,159,2,132,3, 11,0, 46,0,144,
			3, 40,3,111,3,234,3,234,3,234,0, 75,2,103,3,168,1,113,3,119,3,203,2,206,0,196,1,219,1, 40,0, 52,
			2,206,3,117,1, 46,2,250,1, 22,3,106,3,131,1,186,3,155,3, 54,3, 76,3,155,0, 28,1,234,0,  2,1, 51,
			2,196,2,214,3,166,1, 20,2, 31,1,125,3,119,0,210,1,114,0,218,3,138,1,119,0,206,0, 52,1,142,3, 12,
			1, 42,1,138,1,186,1,163,0,170,1,122,1, 95,1, 76,3,170,1, 20,1, 11,3, 42,0, 42,3,221,1, 10,2,206,
			3, 44,2, 39,3,178,1,235,2,209,0,144,1, 20,3,219,3,178,0,250,1,142,1,186,1,255,0,218,0,170,3, 76,
			1, 22,1,106,2,126,1, 59,2,118,2,  3,0,202,3,221,2,214,1,158,3, 44,2, 79,0,142,1,238,0, 76,1, 18,
			0, 60,1,162,2, 63,3,174,0,236,3,231,0,202,1,132,1,235,0,254,1,168,0, 46,3,250,3,250,1,250,1,250,
			0, 74,2,143,3,174,3,166,1,166,2,159,3,174,2, 38,0, 74,2,251,2,142,3,234,0, 14,2,251,2,163,2,246,
			0,212,2,211,3,126,0,254,1,212,2,223,1, 40,1,196,0,206,1,110,0,190,1,254,2, 46,0, 48,0,144,1,113,
			1, 68,3,119,2,206,1,158,2, 36,3, 63,1,250,2,  4,1, 84,3, 55,1,234,3, 27,0, 40,0, 20,3, 31,0, 36,
			0, 28,3, 44,3, 67,2, 40,2, 20,3, 51,1, 14,1,100,0,208,1, 40,3,174,1,117,1,196,3,221,2,189,2, 43,
			2,214,0, 28,0,172,1, 23,3, 12,2,238,2,246,3,226,3,226,0,140,0, 60,3, 98,3,191,0,  2,3,171,3,226,
			3, 46,0, 48,1,  4,2,212,0,115,1,191,0,254,2,164,3, 15,1,148,3,243,0, 28,2,146,1,233,2,168,3,111,
			3,207,3, 46,0,161,1,168,0,161,1,168,2, 84,0, 39,3,174,1, 84,0, 75,0,222,2,153,1, 40,2,149,2, 97,
			0,149,1,168,2,153,2,148,3,107,2,238,3,226,1, 38,3,166,1,106,2,146,1,186,0,103,2,210,1,234,0,119,
			2,206,2,142,1, 40,2, 46,1,  7,2, 46,1, 12,3,123,1, 40,3,174,1,162,0,183,0,174,1,142,0,138,3, 47,
			1,142,0, 84,0,151,2,148,1,183,1, 84,0, 87,0,254,3,190,0, 55,2,146,3,126,0,235,1,254,3, 50,1,210,
			3, 46,1, 46,3, 82,0,239,1,168,2,206,3,178,3, 46,1, 18,1, 40,3,254,3,254,0,143,0,206,0, 42,2,214,
			2,201,1, 98,1,168,3,174,1, 12,2,145,1,140,2,109,2, 12,2,109,0,140,2, 24,2,140,2,109,2, 57,2,109,
			3, 49,1, 14,2,109,0,142,3, 45,3, 49,2,174,2,153,2, 84,1,179,0,254,2, 97,0,100,0,206,1, 98,1,234,
			0, 84,2,151,2,153,3, 49,2,174,2,149,3, 49,2,174,2,174,2, 85,2,174,3,173,3, 49,2,140,2,113,2, 57,
			2, 12,2,117,0,140,2, 24,1,140,2,113,1, 12,2,113,2,113,3, 46,2, 78,3, 76,1, 88,3,239,1,140,2, 24,
			1,152,1, 88,0,152,1, 24,2, 88,0, 84,3,107,0, 48,2,238,3,226,0, 16,1, 16,1, 14,2,150,2, 46,2,135,
			1,254,3, 14,2,131,3,142,1, 16,1, 16,1, 74,1, 16,1,226,3, 78,2,163,3,206,1, 14,0, 28,2, 82,0, 44,
			2,167,0,183,1,226,3, 22,2,203,3,150,1, 22,0, 28,0, 44,2,207,0,183,0, 28,3,150,3,111,0, 16,1,122,
			1,122,2,234,3, 94,2,126,3, 27,1, 16,2,  6,3, 43,0,254,3, 46,3, 14,1, 16,0,206,2,204,1,216,2, 24,
			1, 88,0,216,2, 88,2, 24,0, 88,1,152,0,216,1, 88,3, 12,0, 48,0, 16,3,138,3,123,1, 98,1,254,0, 44,
			2,239,3,170,2,234,0, 98,3,155,2,206,2, 78,2, 42,0,202,3, 12,2,187,1, 16,2,146,2,146,1,126,3,179,
			1,210,3, 18,2, 50,0,142,3,126,3,187,3,178,1,168,0, 30,0,  7,1, 14,3,178,1, 40,2,146,1,126,2, 62,
			0, 16,3, 62,3,254,2, 86,1, 18,0, 75,1,168,2,153,1,142,2, 20,1, 11,2,238,3, 70,0,  3,2,206,1,126,
			0,  3,1,254,1, 46,2, 89,3, 98,0, 71,3, 50,3,158,0,  7,1,204,1,181,2, 12,2,117,2, 76,2,113,3,249,
			2,140,2,113,1,245,2,204,2,113,3,125,2,113,2,229,2,113,3,217,3,174,1, 78,0, 26,0,191,1, 78,3, 46,
			0, 28,1, 14,0,108,0,195,3,174,1,190,0,227,0,230,1,234,2,204,3, 21,2, 84,0, 27,1, 84,2, 83,3,217,
			2,157,2, 83,3,217,3,177,2,229,2,204,2,109,3,125,2,140,2,109,1,245,2, 76,2,109,3,249,2, 12,2,109,
			2,109,2,109,1,140,2,242,3, 76,2, 46,3,174,1,152,2, 59,0,148,1,123,3,234,2,122,3, 11,3, 22,1,103,
			3,150,1, 14,1,106,1,115,2,206,0,210,3,170,1,190,1,179,3, 46,3, 14,0,238,2,206,2, 46,0,206,1,102,
			0,148,1,219,1, 24,1,230,1,231,1,152,0,108,1,215,2, 78,2, 78,0,148,2, 83,0, 48,1,204,0,216,0,216,
			0, 24,2, 24,1, 88,0, 24,2, 88,3,171,2, 89,3,226,1, 46,1,126,2, 27,2,210,3,174,1, 22,3,174,3,126,
			2, 35,3, 46,3,226,3, 49,0,144,2,210,3,126,2, 87,2,254,3,142,0, 48,0,144,2,206,2, 46,2,131,3,142,
			1,126,2,127,3,174,1, 22,3,174,1,183,0,204,1,202,1, 94,2,175,0,190,3, 38,2,238,3, 44,3, 23,0,102,
			2,219,0, 84,0,  3,0,146,3,102,1,250,2, 50,3,166,0,144,2, 36,1,152,2, 88,0,216,0, 88,1, 24,1,216,
			0, 88,3,155,3,230,1,147,3,142,1, 98,3, 19,2,206,0, 60,3,108,3, 23,1,234,2,254,3, 12,0, 46,2, 98,
			3, 91,1, 14,1,106,2,110,3, 63,0,206,1, 42,3,142,2,126,3, 31,3,166,1,142,0, 46,3, 12,1,235,2, 76,
			0,216,0, 88,0, 24,0, 88,1,216,2, 88,2, 24,0, 24,1, 88,1, 88,0,216,3,119,3,174,1, 46,1,134,2,186,
			1,123,1,250,2,206,1,234,3,203,1,159,0,206,3, 12,0,152,0,216,0, 24,0,152,1, 88,2,  7,1, 76,1,251
		]

		@asm = asm.split "\n"

		# register
		@a = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] 
		@b = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] 
		@c = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] # x
		@d = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] # y
		@e = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] # z
		@f = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] # t
		@m = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] 
		@t = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] 
		@s = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] # 12 bit Status

		@p = 0
		@offset = 0 # bank
		@pc = 0 # program counter
		@first = -1 # first digit
		@last = -1 # last digit
		@fetch_h = -1
		@fetch_l = -1
		@op_code = 0
		@key_code = 255
		@display_enable = true
		@update_display = true
		@carry = 0
		@prevCarry = 0
		@ret = 0

		@zero = 0 # alltid 0
		@word_select = 0
		@key_rom = 0
		@error = 0

		@TRACE = false 
		@SPEED = 1000 # 1=slow 1000=fast

	compact : (lst) -> 
		n = lst.length
		if n==16 then n=14
		res = lst.slice 0,n
		res.reverse()
		res.join ''

	toggle : ->
		@TRACE = not @TRACE
		@SPEED = if @SPEED == 1 then 1000 else 1	

	decorate : (trace, data) ->	if @TRACE then print "#{trace.padEnd 40} #{data}"

	singleStep : ->
		data = ''
		@prevCarry = @carry
		@carry = 0
		@fetch_h = @rom[@offset*256*2 + @pc*2 + 0]    
		@fetch_l = @rom[@offset*256*2 + @pc*2 + 1] 

		instr = @asm[@offset*256 + @pc]
		if ':' in instr
			[lbl,cmd]  = instr.split ':'
			lbl = (lbl + ':').padEnd 8
			cmd = cmd.trim()
		else 
			[lbl,cmd] = ['        ',instr.trim()]		
		if cmd.startsWith('then ') then cmd = '  '+cmd
		instr = lbl+cmd

		trace = "#{@offset}:#{str(@pc).padStart 3,'0'} #{instr}"

		if (@pc==191) & (@offset==0) then	@error = 1
		
		@pc++
		@pc %= 256

		if @key_code < 255
			@error = 0
			@key_rom = @key_code
			@key_code = 255
			@s[0] = 1

		if (@fetch_l & 0x03) == 0x01 # Jump subroutine
			@ret = @pc
			@pc = ((@fetch_l>>2) & 0x3f) | ((@fetch_h<<6) & 0x0c0)
			data = "PC=#{@pc}"

		if (@fetch_l & 0x7F) == 0x030 then @pc = @ret
		if (@fetch_l & 0x7F) == 0x010 then @offset = ((@fetch_h<<1) & 6) | ((@fetch_l>>7) & 1)

		if @fetch_l == 0x0D0
			@pc = @key_rom
			@s[0] = 0
			data = "PC=#{@pc}"

		if keyboard.available() then @key_code = keyboard.read()
				
		# *********************************************************

		if (@fetch_l & 0x03f) == 0x014
			@carry = @s[ ((@fetch_h&0x03)<<2) | ( (@fetch_l&0x0c0)>>6) ]
			data = "S=#{@compact @s}"

		if (@fetch_l & 0x03f) == 0x004
			@s[ ((@fetch_h&0x03)<<2) | ( (@fetch_l&0x0c0)>>6) ]=1
			data = "S=#{@compact @s}"

		if (@fetch_l & 0x03f) == 0x024
			@s[ ((@fetch_h&0x03)<<2) | ( (@fetch_l&0x0c0)>>6) ]=0
			data = "S=#{@compact @s}"

		if (@fetch_l & 0x03f) == 0x034
			for i in range 12
				@s[i] = 0
			data = "S=#{@compact @s}"

		#*********************************************************

		if (@fetch_l & 0x03f) == 0x02C
			@carry = 0
			if @p == (((@fetch_h & 0x03)<<2) | ( (@fetch_l & 0x0c0)>>6)) then @carry = 1
			data = "P=#{@p}"

		if (@fetch_l & 0x03f) == 0x00C
			@p = ((@fetch_h & 0x03)<<2)  | ((@fetch_l & 0x0c0)>>6) 
			data = "P=#{@p}"

		if (@fetch_l & 0x03f) == 0x03C
			@p = (@p+1) & 0x0f
			data = "P=#{@p}"

		if (@fetch_l & 0x03f) == 0x01C
			@p = (@p-1) & 0x0f
			data = "P=#{@p}"

		#********************************* math operation

		if (@fetch_l & 0x3F) == 0x18 # load constant
			constant = ((@fetch_l>>6)|(@fetch_h<<2))
			@c[@p] = constant
			@p = (@p - 1) & 0x0f
			data = "C=#{@compact @c}  P=#{@p}"

		if ((@fetch_h & 0x03) == 0x00) && ((@fetch_l & 0x0ef) == 0x0A8) # print 'exch_m'
			for i in range WSIZE
				[@c[i],@m[i]] = [@m[i],@c[i]]
			data = "C=#{@compact @c} M=#{@compact @m}"

		if ((@fetch_h & 0x03) == 0x01) && ((@fetch_l & 0x0ef) == 0x028) # print 'c_to_stack'
			for i in range WSIZE 
				[@f[i],@e[i],@d[i]] = [@e[i],@d[i],@c[i]]
			data = "F=#{@compact @f} E=#{@compact @e} D=#{@compact @d}"

		if ((@fetch_h & 0x03) == 0x01) && ((@fetch_l & 0x0ef) == 0x0A8)	# print 'stack_to_a'   
			for i in range WSIZE
				[@a[i],@d[i],@e[i]] = [@d[i],@e[i],@f[i]]
			data = "A=#{@compact @a} D=#{@compact @d} E=#{@compact @e}"

		if ((@fetch_h & 0x03) == 0x02) && ((@fetch_l & 0x0ef) == 0x0A8) # print 'm_to_c'    
			for i in range WSIZE
				@c[i] = @m[i]
			data = "C=#{@compact @c}"

		if ((@fetch_h & 0x03) == 0x03) && ((@fetch_l & 0x0ef) == 0x028) # print 'down_rotate'    
			for i in range WSIZE
				[@c[i],@d[i],@e[i],@f[i]] = [@d[i],@e[i],@f[i],@c[i]]
			data = "C=#{@compact @c} D=#{@compact @d} E=#{@compact @e} F=#{@compact @f}"

		if ((@fetch_h & 0x03) == 0x03) && ((@fetch_l & 0x0ef) == 0x0A8) # print 'clear_reg'  
			for i in range WSIZE
				@a[i] = @b[i] = @c[i] = @d[i] = @e[i] = @f[i] = @m[i] = 0  

		if ((@fetch_h & 0x03) == 0x00) && ((@fetch_l & 0x0ef) == 0x028)
			@display_enable = false
			@update_display = false
			
		if ((@fetch_h & 0x03) == 0x02) && ((@fetch_l & 0x0ef) == 0x028) # print 'display toggle'
			@display_enable = ! @display_enable
			if @display_enable then @update_display = true

		if (@fetch_l & 0x03) == 0x03 # print "Cond Branch: ",@pc
			if @prevCarry != 1
				@pc = ((@fetch_l&0x0fc)>>2) | ( (@fetch_h&0x03)<<6)
			data = "PC=#{@pc}"

		if (@fetch_l & 0x03) == 0x02 # A&R
			@word_select = (@fetch_l>>2) & 0x07
			@op_code = (@fetch_l>>5) & 0x07
			@op_code = @op_code | ((@fetch_h<<3) & 0x018)

			@get_f_l @word_select

			if @op_code == 0x0 # 0 + B
				@carry = 0 
				for i in range @first,@last+1 
					@carry |= if @b[i] != 0 then 1 else 0
				data = "Carry=#{@carry}"
		 
			if @op_code == 0x01 # 0 -> B
				for i in range @first,@last+1 
					@b[i] = 0
				@carry = 0
				data = "B=#{@compact @b}"
		 
			if @op_code == 0x02 # A-C
				@carry = 0
				for i in range @first,@last+1 
					@t[i] = @do_sub @a[i], @c[i]
				data = "T=#{@compact @t}"
		 
			if @op_code == 0x03 # C-1
				@carry = 1
				for i in range @first,@last+1 
					@carry &= if @c[i] == 0 then 1 else 0
				data = "Carry=#{@carry}"
		 
			if @op_code == 0x04	# B->C
				for i in range @first,@last+1 
					@c[i] = @b[i]
				@carry = 0
				data = "C=#{@compact @c}"
		 
			if @op_code == 0x05 # 0-C -> C
				@carry = 0
				for i in range @first,@last+1 
					@c[i]= @do_sub @zero, @c[i]
				data = "C=#{@compact @c}"
		 
			if @op_code == 0x06 # 0 -> C
				for i in range @first,@last+1 
					@c[i] = 0
				@carry = 0
				data = "C=#{@compact @c}"
		 
			if @op_code == 0x07 # 0-C-1 -> C
				@carry = 1
				for i in range @first,@last+1 
					@c[i] = @do_sub @zero, @c[i]
				data = "C=#{@compact @c}"

			if @op_code == 0x08 # Shift A Left
				for i in range @last,@first-1,-1 
					@a[i] = if i == @first then 0 else @a[i-1]
				@carry = 0
				data = "A=#{@compact @a}"
		 
			if @op_code ==  0x09 # A -> B
				for i in range @first,@last+1
					@b[i] = @a[i]
				@carry=0
				data = "B=#{@compact @b}"
		 
			if @op_code == 0x0a	# A-C -> C
				@carry = 0
				for i in range @first,@last+1 
					@c[i] = @do_sub @a[i], @c[i]
				data = "C=#{@compact @c}"

			if @op_code == 0x0b	# C-1 -> C
				@carry = 1
				for i in range @first,@last+1 
					@c[i] = @do_sub @c[i], @zero
				data = "C=#{@compact @c}"

			if @op_code == 0x0c # C -> A
				for i in range @first,@last+1 
					@a[i] = @c[i]
				@carry = 0
				data = "A=#{@compact @a}"
		 
			if @op_code == 0x0d # 0-C 
				for i in range @first,@last+1 
					@carry |= if @c[i] != 0 then 1 else 0
				data = "Carry=#{@carry}"

			if @op_code == 0x0e # A+C -> C
				@carry = 0
				for i in range @first,@last+1 
					@c[i] = @do_add @a[i], @c[i]
				data = "C=#{@compact @c}"

			if @op_code == 0x0f # C+1 -> C
				@carry = 1
				for i in range @first,@last+1 
					@c[i] = @do_add @c[i], @zero
				data = "C=#{@compact @c}"

			if @op_code == 0x010 # A-B
				for i in range @first,@last+1 
					@t[i] = @do_sub @a[i], @b[i]
				data = "T=#{@compact @t}"

			if @op_code == 0x011 # B <-> C
				[@b[i],@c[i]] = [@c[i],@b[i]] for i in range @first,@last+1 
				@carry = 0
				data = "B=#{@compact @b} C=#{@compact @c}"
		 
			if @op_code == 0x012 # Shift C Right
				for i in range @first,@last+1
					@c[i] = if i == @last then 0 else @c[i+1]
				@carry = 0
				data = "C=#{@compact @c}"
		 
			if @op_code == 0x013 # A-1
				@carry = 1
				for i in range @first,@last+1 
					@carry &= if @a[i] == 0 then 1 else 0
				data = "Carry=#{@carry}"
		 
			if @op_code == 0x014 # Shift B Right
				for i in range @first,@last+1 
					@b[i] = if i == @last then 0 else @b[i+1]
				@carry = 0
				data = "B=#{@compact @b}"
		 
			if @op_code == 0x015 # C+C -> C
				@carry = 0
				for i in range @first,@last+1
					@c[i] = @do_add @c[i], @c[i]
				data = "C=#{@compact @c}"

			if @op_code == 0x016 # Shift A Right
				for i in range @first,@last+1 
					@a[i] = if i == @last then 0 else @a[i+1]
				@carry = 0
				data = "A=#{@compact @a}"

			if @op_code == 0x017 # 0 -> A
				for i in range @first,@last+1 
					@a[i] = 0
				@carry = 0
				data = "A=#{@compact @a}"
		 
			if @op_code == 0x018 # A-B -> A
				@carry = 0
				for i in range @first,@last+1
					@a[i] = @do_sub @a[i], @b[i]
				data = "A=#{@compact @a} B=#{@compact @b}"
		 
			if @op_code == 0x019 # A <-> B
				for i in range @first,@last+1 
					[@a[i],@b[i]] = [@b[i],@a[i]]
				@carry = 0
				data = "A=#{@compact @a} B=#{@compact @b}"
		 
			if @op_code == 0x01a # A-C -> A
				@carry = 0
				for i in range @first,@last+1 
					@a[i] = @do_sub @a[i], @c[i]
				data = "A=#{@compact @a} C=#{@compact @c}"

			if @op_code == 0x01b # A-1 -> A
				@carry = 1
				for i in range @first,@last+1 
					@a[i] = @do_sub @a[i], @zero
				data = "A=#{@compact @a}"
		
			if @op_code == 0x01c # A+B -> A
				@carry = 0
				for i in range @first,@last+1 
					@a[i] = @do_add @a[i], @b[i]
				data = "A=#{@compact @a} B=#{@compact @b}"
		
			if @op_code == 0x01d # C <-> A
				[@a[i],@c[i]] = [@c[i],@a[i]] for i in range @first,@last+1 
				@carry = 0
				data = "A=#{@compact @a} C=#{@compact @c}"
		
			if @op_code == 0x01e # A+C -> A
				@carry = 0
				for i in range @first,@last+1 
					@a[i] = @do_add @a[i], @c[i]
				data = "A=#{@compact @a} C=#{@compact @c}"
		
			if @op_code == 0x01f # A+1 -> A
				@carry = 1
				for i in range @first,@last+1 
					@a[i] = @do_add @a[i], @zero
				data = "A=#{@compact @a}"

			#**************************************************************************

			if @display_enable then @update_display = true

			# if !@display_enable
			# 	if @update_display then lcd.update()
			# 	@update_display = false
			lcd.update()

		if "#{@offset}:#{@pc}" not in "0:199 0:200 0:201 0:205 0:206".split ' ' # the display loop
			@decorate trace,data

	get_f_l : (ws) -> 
		if @word_select == 0 then [@first,@last] = [@p,@p]
		if @word_select == 1 then [@first,@last] = [3,12]
		if @word_select == 2 then [@first,@last] = [0,2]
		if @word_select == 3 then [@first,@last] = [0,13]
		if @word_select == 4 then [@first,@last] = [0,@p]
		if @word_select == 5 then [@first,@last] = [3,13]
		if @word_select == 6 then [@first,@last] = [2,2]
		if @word_select == 7 then [@first,@last] = [13,13]

	do_add : (x, y) ->
		@res = x + y + @carry
		if @res > 9
			@res -= 10
			@carry = 1
		else
			@carry = 0
		@res

	do_sub : (x, y) ->
		@res = (x - y) - @carry
		if @res < 0
			@res += 10
			@carry = 1
		else
			@carry = 0
		@res
