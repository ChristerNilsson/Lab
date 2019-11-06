<script>
	import {Store} from './Store.svelte'
</script> 

<Store/>
<button on:click={()=> $Store+=1}>Incr2</button>
