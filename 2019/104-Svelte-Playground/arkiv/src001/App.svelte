<script>
	import FindPage from './FindPage.svelte'
	import EditPage from './EditPage.svelte'

	let pattern = ''
	let page = 0
	let lines
	lines = localStorage.Organizer 
	if (!lines) lines = "12 Batteri\n65 Bensin \n64 Bestick\n43 Blöjor \n52 Brandlarm\n52 Chifonet\n41 Cykelgrejer\n42 Cykelgrejer\n22 Cykellampor\n22 Cykellås\n65 Cykelolja\n21 Dammsugarpåsar\n36 Dämpare\n61 Diverse\n12 Elmätare\n13 Elprylar, små\n32 Etiketter\n22 Ficklampor\n24 Fickplunta\n45 Fotvård\n32 Glasögonfodral\n14 Glödlampor\n16 Glödlampor\n15 Glödlampor, stora\n54 Glögglas\n11 Gruppschema\n21 Gummiband\n11 Häftapparat\n55 Handdukar\n44 Hårvård\n36 IKEA-delar\n63 Kåsor\n11 Klammer\n13 Klister\n12 Laddare\n33 Lås\n13 Märkpennor\n26 Möss\n33 Nycklar\n44 Ögonvård\n44 Öronvård\n21 Pappersnäsdukar\n13 Pennor\n63 Plastflaskor\n62 Plastpåsar\n35 Plugg\n13 Proppar\n65 Putsgrejer\n46 Rakgrejer\n51 Remmar\n56 Skovård\n31 Skruvar\n35 Skruvar\n51 Snören\n34 Specialverktyg\n26 Streckkodläsare\n66 Strykjärn\n52 Svinto\n53 Sygrejer\n32 Tändstickor\n46 Tandvård\n23 Tape\n11 Tätningslist\n25 Toagrejer\n21 Tvättklämmor\n26 USB-grejer\n26 Wattmätare"

	const save = (lines0) => {
		lines = lines0
		localStorage.Organizer = lines
		page = 1-page
	}

	const keyup = (pattern0) => pattern = pattern0

</script> 

{#if page==0}
	<FindPage keyup={keyup} click={() => page=1-page} lines={lines} pattern={pattern}/>
{:else}
	<EditPage click={save} lines={lines}/>
{/if}
