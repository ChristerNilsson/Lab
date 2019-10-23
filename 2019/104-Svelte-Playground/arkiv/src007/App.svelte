<script>
	import AboutMe from './about.svelte'
	import Projects from './projects.svelte'
	import Educations from './educations.svelte'
	import Experiences from './experiences.svelte'
	import Skills from './skills.svelte'
	import Feedback from './feedback.svelte'
	let page = 0
</script> 

<div on:click={() => {page=0}}>about me</div>
<div on:click={() => {page=1}}>projects</div>
<div on:click={() => {page=2}}>educations</div>
<div on:click={() => {page=3}}>experiences</div>
<div on:click={() => {page=4}}>skills</div>
<div on:click={() => {page=5}}>feedback</div>

{#if page==0}<AboutMe/>{/if}
{#if page==1}<Projects/>{/if}
{#if page==2}<Educations/>{/if}
{#if page==3}<Experiences/>{/if}
{#if page==4}<Skills/>{/if}
{#if page==5}<Feedback/>{/if}
