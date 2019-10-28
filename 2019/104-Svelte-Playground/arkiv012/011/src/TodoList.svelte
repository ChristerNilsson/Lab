<script>
	import Todo from './Todo.svelte'
 
	let lastId = 0
 
	const createTodo = (text, done = false) => ({id: ++lastId, text, done})
 
	let todoText = ''
 
	let todos = [
		createTodo('learn Svelte', true),
		createTodo('build a Svelte app')
	]

	function addTodo() {
		todos = todos.concat(createTodo(todoText))
		todoText = '' 
	}

	const archiveCompleted = () => todos = todos.filter(t => !t.done)
	const deleteTodo = id => todos = todos.filter(t => t.id !== id)
	const toggleDone = id => todos = todos.map(t => (t.id === id ? {...t, done: !t.done} : t))

</script>

<style>
	button {
		margin-left: 10px;
	}
 
	/* This removes the bullets from a bulleted list. */
	ul.unstyled {
		list-style: none;
		margin-left: 0;
		padding-left: 0;
	}
</style>
 
<div>
	<h2>To Do List</h2>
	<div>
		status = {todos.filter(t => !t.done).length} of {todos.length} remaining
		<button on:click={archiveCompleted}>Archive Completed</button>
	</div>
	<br />
	<form on:submit|preventDefault>
		<input
			type="text"
			size="30"
			autofocus
			placeholder="enter new todo here"
			bind:value={todoText}
		/>
		<button disabled={!todoText} on:click={addTodo}>
			Add
		</button>
	</form>

	<ul class="unstyled">
		{#each todos as todo}
			<Todo
				text = {todo.text}
				done = {todo.done}
				on:toggleDone={() => toggleDone(todo.id)}
				on:delete={() => deleteTodo(todo.id)}
			/>
		{/each}
	</ul>
</div>