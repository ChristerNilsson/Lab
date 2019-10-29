<script>
	import Button from './button.svelte'
	import AboutMe from './about.svelte'
	import Projects from './projects.svelte'
	import Educations from './educations.svelte'
	import Experiences from './experiences.svelte'
	import Feedback from './feedback.svelte'
	import Skills from './skills.svelte'
	let page = 0
</script>

<div class="container-fluid">
	<div class="row">
		<div class="col-lg-2">
			<Button bind:page={page} nr=0 title='about me' />
			<Button bind:page={page} nr=1 title='projects' />
			<Button bind:page={page} nr=2 title='educations' />
			<Button bind:page={page} nr=3 title='experiences' />
			<Button bind:page={page} nr=4 title='skills' />
			<Button bind:page={page} nr=5 title='feedback' />
		</div>
		<div class="col-lg-10">
			{#if page==0}<AboutMe/>{/if}
			{#if page==1}<Projects/>{/if}
			{#if page==2}<Educations/>{/if}
			{#if page==3}<Experiences/>{/if}
			{#if page==4}<Skills/>{/if}
			{#if page==5}<Feedback/>{/if}		
		</div>
	</div>
</div>
