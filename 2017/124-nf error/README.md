# nf

* nf(), nfs() and nfp() does not work as perfect as Processing does.

* Lauren McCarthy: nf() is just a formatting function for converting numbers into strings, so the number itself is left alone, and any digits beyond are truncated.

* LM: I'm not hearing a lot of energy around this or #2287 so I'd prefer to leave as is for now. thanks for the suggestion! 

* Austin Fish: No, nfs is working perfectly… be it they have a rather inefficient implementation, but aside from that the only issue is your numbers. It’s a problem with floating point numbers in all computer languages

* meiamsome: *shrug* that's just the way it works

* alca: If all you need is -0.5 to 0.4 with 1 decimal, then `x.toFixed(1)` is all you need
	Unless you have another use, toFixed should be perfect