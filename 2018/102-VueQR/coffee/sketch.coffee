new Vue 
	el : 
		'#app'
	data : 
		message : 'Hello Vue.js!'
	methods : 
		decodeQr : (v) -> console.log 'holi', v
		onInit : (promise) -> 
			# show loading indicator

			try 
				await promise
				# successfully initialized
			catch error 
				console.log error.name
				# if error.name == 'NotAllowedError'
				# 	console.log('1')
				# 	# user denied camera access permisson
				# else if (error.name == 'NotFoundError') 
				# 	console.log('2')
				# 	# no suitable camera device installed
				# else if (error.name == 'NotSupportedError') 
				# 	console.log('3')

				# 	# page is not served over HTTPS (or localhost)
				# else if (error.name == 'NotReadableError') 
				# 	console.log('4')

				# 	# maybe camera is already in use
				# else if (error.name == 'OverconstrainedError') 
				# 	console.log('5')

				# 	# passed constraints don't match any camera.
				# 	# Did you requested the front camera although there is none?
				# else 
				# 	console.log('6')
				# 	# browser might be lacking features (WebRTC, ...)
				
			finally
				console.log 'holi!'
				try 
					await sleep 1000
					navigator.mediaDevices
						.getUserMedia { audio: true, video: { facingMode: "environment" } }
						.then mediaStream => 
							console.log 'holi async'
							await sleep 1000
							track = mediaStream.getVideoTracks()[0]
							capabilities = track.getCapabilities()
			
							if !('zoom' in capabilities)
								this.message = 'NOT SUPPORTED'
								return
							else
								this.message = 'WORKS!!'
							
							track.applyConstraints { advanced: [{ zoom: 1 }] }
						
						.catch error => console.log 'error!', error
					
					sleep = (ms = 0) -> new Promise resolve => setTimeout(resolve, ms)

				catch error
					this.message = 'ERROR!' + error
				
Vue.use VueQrcodeReader
