<script>
	import Skill from './skill.svelte'
</script>

<style>
	* {box-sizing: border-box}
	h1 {text-align:center}
	table {
    margin-left:auto; 
    margin-right:auto;
  }
</style>

<h1>My Skills</h1>
<table>
		<Skill value='80' bg="4CAF50" title='HTML' />
		<Skill value='100' bg="2196F3" title='CSS' />
		<Skill value='65' bg="f44336" title='Javascript'/>
		<Skill value='60' bg="808080" title='React'/>
		<Skill value='70' bg="4CAF50" title='Database'/>
		<Skill value='50' bg="2196F3" title='Node.js'/>
		<Skill value='80' bg="f44336" title='Git & GitHub'/>
		<Skill value='70' bg="808080" title='Java'/>
		<Skill value='90' bg="4CAF50" title='Agile & Scrum'/>
		<Skill value='40' bg="2196F3" title='API'/>
		<Skill value='75' bg="f44336" title='Electric Engineer'/>
</table>
