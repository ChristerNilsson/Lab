import {createEntityQuery} from '@datorama/akita'
import {todosStore} from './todos.store'
import {combineLatest} from "rxjs"

export const todosQuery = createEntityQuery(todosStore)
export const selectFilter = todosQuery.select('filter')
export const visibleTodos = combineLatest(
	selectFilter,
	todosQuery.selectAll(),
	function getVisibleTodos(filter, todos) {
		if (filter=="SHOW_COMPLETED") return todos.filter(t => t.completed)
		if (filter=="SHOW_ACTIVE")		return todos.filter(t => !t.completed)
		return todos
	}
)
