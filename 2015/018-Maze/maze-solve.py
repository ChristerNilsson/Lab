

def Dijkstra(Graph, source):
    # Graph[u][v] is the weight from u to v (however 0 means infinity)
    infinity = 9999
    n = len(graph)
    dist = [infinity]*n   # Unknown distance function from source to v
    previous = [infinity]*n # Previous node in optimal path from source
    dist[source] = 0        # Distance from source to source
    Q = list(range(n)) # All nodes in the graph are unoptimized - thus are in Q
    while Q:           # The main loop
        u = min(Q, key=lambda n:dist[n])                 # vertex in Q with smallest dist[]
        Q.remove(u)
        if dist[u] == infinity:
            break # all remaining vertices are inaccessible from source
        for v in range(n):               # each neighbor v of u
            if Graph[u][v] and (v in Q): # where v has not yet been visited
                alt = dist[u] + Graph[u][v]
                if alt < dist[v]:       # Relax (u,v,a)
                    dist[v] = alt
                    previous[v] = u
    return previous


def display_solution(predecessor):
    res = []
    cell = len(predecessor)-1
    while cell:
        res.append(cell)
        cell = predecessor[cell]
    res.append(0)
    return res


#        +   +---+---+
#        | 0   1   2 |
#        +---+   +   +
#        | 3   4 | 5
#        +---+---+---+

graph = (
        (0,1,0,0,0,0),
        (1,0,1,0,1,0),
        (0,1,0,0,0,1),
        (0,0,0,0,1,0),
        (0,1,0,1,0,0),
        (0,0,1,0,0,0),
        )

prev = Dijkstra(graph, 0)
assert prev == [9999, 0, 1, 4, 1, 2]
assert display_solution(prev) == [5, 2, 1, 0]
