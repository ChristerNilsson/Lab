class IDAStar(Algorithm):
	queue # Queue BFSNode

  def solvePuzzle(currentState):
    solveSingleThreaded(currentState)

  def solveSingleThreaded(currentState):
		initialMovesEstimate = movesRequired = Node.h(currentState)
		# workers = new DFSWorker[1];
		# final DFSWorker dfsWorker = new DFSWorker();
		# // Add to array so GUI can poll it for the stats in real time.
		# workers[0] = dfsWorker;
		do {
				if (PuzzleConfiguration.isVerbose()) {
						System.out.print("\nSearching paths of depth " + movesRequired + "...");
				}
				dfsWorker.setConfig(currentState, "X", movesRequired, 0);
				dfsWorker.run();
				if (!solved) {
						movesRequired += 2;
				}
		} while (running);
}
#
#     private void completeBFS(final BFSNode node) {
#         solved = true;
#         shortestPath = node.getShortestPath();
#         if (PuzzleConfiguration.isVerbose()) {
#             System.out.println("done.");
#         }
#     }
#
#     /**
#      * Performs a breadth-first search starting at currentState, finding
#      * howMany unique states from which to start the threads.
#      */
#     private void findStartingPositions(final long currentState, final int howMany) {
#         BFSNode currentNode = new BFSNode(currentState, true);
#         currentNode.cost = 0;
#
#         if (currentNode.boardConfig == Node.goalState) {
#             completeBFS(currentNode);
#             return;
#         }
#
#         queue = new LinkedList<BFSNode>();
#         if (howMany == 1) {
#             queue.add(currentNode);
#             return;
#         }
#
#         int previousMovesRequired = 0;
#         while (currentNode != null) {
#             final char fromDirection = currentNode.direction;
#
#             if (fromDirection != 'R') {
#                 final BFSNode left = currentNode.moveLeftNode(null);
#                 if (left != null) {
#                     ++numberExpanded;
#                     if (left.boardConfig == Node.goalState) {
#                         completeBFS(left);
#                         return;
#                     } else {
#                         queue.add(left);
#                     }
#                 }
#             }
#             if (fromDirection != 'L') {
#                 final BFSNode right = currentNode.moveRightNode(null);
#                 if (right != null) {
#                     ++numberExpanded;
#                     if (right.boardConfig == Node.goalState) {
#                         completeBFS(right);
#                         return;
#                     } else {
#                         queue.add(right);
#                     }
#                 }
#             }
#             if (fromDirection != 'D') {
#                 final BFSNode up = currentNode.moveUpNode(null);
#                 if (up != null) {
#                     ++numberExpanded;
#                     if (up.boardConfig == Node.goalState) {
#                         completeBFS(up);
#                         return;
#                     } else {
#                         queue.add(up);
#                     }
#                 }
#             }
#             if (fromDirection != 'U') {
#                 final BFSNode down = currentNode.moveDownNode(null);
#                 if (down != null) {
#                     ++numberExpanded;
#                     if (down.boardConfig == Node.goalState) {
#                         completeBFS(down);
#                         return;
#                     } else {
#                         queue.add(down);
#                     }
#                 }
#             }
#
#             currentNode = queue.peek();
#             if (currentNode != null) {
#                 final byte movesRequired = currentNode.cost;
#
#                 if (movesRequired > previousMovesRequired) {
#                     previousMovesRequired = movesRequired;
#
#                     // Remove duplicate states while preserving the order of the
#                     // queue. We want to make sure that each thread we start is
#                     // working on a unique path.
#                     queue = new LinkedList<BFSNode>(new LinkedHashSet<BFSNode>(queue));
#
#                     if (queue.size() >= howMany) {
#                         break;
#                     }
#                 } else {
#                     currentNode = queue.poll();
#                 }
#             }
#         }
#     }
#
#     public void cleanup() { }
# }
