<style>
	* {box-sizing: border-box}
</style>

<script>
	export let title
	export let value
	export let bg
</script>

<tr style="width:110%">
	<td style="width:10%">{title}</td>
	<td style="width:100%; background-color:#f0f0f0;">
		<div style="width:{value}%; background-color:#{bg};text-align:right; color:white">
			{value}%
		</div>
	</td>
</tr>
