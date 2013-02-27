module GRAPH ( Graph, Node, Edge,
               emptyGraph, nodes, edges, s2n, n2s,
               insertNode, insertEdge, outEdges ) where

--------------------------------------------------------------------------------
-- I N T E R F A C E  :  P U B L I C
--------------------------------------------------------------------------------

-- Graph : an unweighted directed graph
newtype Graph = G ([Node], [Edge]) deriving Show
--------------------------------------------------------------------------------

-- Node : a node
newtype Node = N String deriving (Eq, Show)
--------------------------------------------------------------------------------

-- Edge : an edge

type Edge = ( Node, Node, Float )  -- ( start, finish, weight )

--------------------------------------------------------------------------------

-- emptyGraph : the empty graph

emptyGraph :: Graph

--------------------------------------------------------------------------------

-- nodes g : a list of the nodes in graph 'g'

nodes :: Graph -> [ Node ]

--------------------------------------------------------------------------------

-- edges g : a list of the edges in graph 'g'

edges :: Graph -> [ Edge ]

--------------------------------------------------------------------------------

-- s2n s : a node with label 's'

s2n :: String -> Node

--------------------------------------------------------------------------------

-- n2s n : the label of node 'n'

n2s :: Node -> String

--------------------------------------------------------------------------------

-- insertNode n g : the graph formed by inserting node 'n' into graph 'g'

insertNode :: Node -> Graph -> Graph

--------------------------------------------------------------------------------

-- insertEdge e g : the graph formed by inserting edge 'e' into graph 'g'

insertEdge :: Edge -> Graph -> Graph

--------------------------------------------------------------------------------

-- outEdges n g : a list of the edges starting from node 'n' in graph 'g'

outEdges :: Node -> Graph -> [ Edge ]

--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- I M P L E M E N T A T I O N  :  P R I V A T E
--------------------------------------------------------------------------------
emptyGraph = G ([], [])

nodes (G (ns, _)) = ns

edges (G (_, es)) = es

s2n x       = N (x)

n2s (N (x)) = x

insertNode n (G (ns, es))   | null $ filter (==n) ns = G (n:ns, es) 
                            | otherwise = error "Node already exists!"

insertEdge e (G (ns, es))   | edgeExists e (G (ns, es))     = error "Edge already exists in graph!"
                            | possibleEdge e (G (ns, es))   = error "Node(s) do not exist!!"
                            | otherwise = G (ns, e:es)

outEdges n (G (_, es))     = filter (\e -> n == fromNode e) es

-- Helper
-- fromNode e : the node this Edge starts at
fromNode :: Edge -> Node
fromNode (n, _, _) = n

-- fromNode e : the node this Edge points to
toNode :: Edge -> Node
toNode (_, n, _) = n
Co
-- edgeExists e g : whether Edge e already exists in this Graph

edgeExists :: Edge -> Graph -> Bool
edgeExists e (G (_, es))    | null $ filter f es = False
                            | otherwise = True
    where f = (\x -> ((fromNode x) == (fromNode e) && (toNode x) == (toNode e)))
          
-- pathExists e g : checks if the nodes of this edge exist
possibleEdge :: Edge -> Graph -> Bool
possibleEdge e (G (ns, _))  | length (filter (== (fromNode e)) ns) == 2 = True
                            | otherwise = False




 -- (insertEdge (s2n "a", s2n "b", 2) (insertEdge (s2n "a", s2n "b", 1) (insertNode (s2n "c") ((insertNode (s2n "b") (insertNode (s2n "a") emptyGraph))))))





