module GRAPH ( Graph, Node, Edge,
               emptyGraph, nodes, edges, s2n, n2s,
               insertNode, insertEdge ) where

--------------------------------------------------------------------------------
-- I N T E R F A C E  :  P U B L I C
--------------------------------------------------------------------------------

-- Graph : an unweighted directed graph
newtype Graph = G ( [ ( Node, [Edge]) ] ) deriving Show
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
emptyGraph = G ([])


nodes (G xs) = map fst xs


edges (G xs) = concat (map snd xs)


s2n x     = N x


n2s (N x) = x


insertNode n (G xs) | null $ filter (\(x,_) -> x == n) xs = G ((n, []):xs) 
                    | otherwise = error "Node already exists!!"

                    
insertEdge e (G xs) | edgeExists   e (edges (G xs))   = error "Edge already exists in graph!!"
                    | not $ possibleEdge e (nodes (G xs))   = error "Node(s) do not exist!!"
                    | otherwise = G( insertEdge' e (head xs) (tail xs) )
               
               
outEdges n (G ([]))         = error "Node does not exist!"                    
outEdges n (G ((x, es):xs)) | n == x = es
                            | otherwise = outEdges n (G xs)
    
{- Helper functions -}
-- fromNode e : the node this Edge starts at
fromNode :: Edge -> Node
fromNode (n, _, _) = n


-- fromNode e : the node this Edge points to
toNode :: Edge -> Node
toNode (_, n, _) = n


-- edgeExists e g : whether Edge e already exists in this Graph
edgeExists :: Edge -> [Edge] -> Bool
edgeExists e es   | null $ filter p es = False
                  | otherwise = True
    where p = (\x -> ((fromNode x) == (fromNode e) && (toNode x) == (toNode e)))

    
-- possibleEdge e g : checks if the nodes of this edge exist
possibleEdge :: Edge -> [Node] -> Bool
possibleEdge e ns  | length (filter p ns) == 2 = True
                   | otherwise = False
    where p = (\x -> x == (fromNode e) || x == (toNode e))
    
    
-- insertEdge e x ys : insert an edge into its source node edge list
insertEdge' :: Edge -> (Node, [Edge]) -> [(Node, [Edge])] -> [(Node, [Edge])]
insertEdge' e x ys  | fromNode e == fst x = (fst x, e: snd x) : ys
                    | otherwise =  x : insertEdge' e (head ys) (tail ys) 


 -- (insertEdge (s2n "a", s2n "b", 2) (insertEdge (s2n "a", s2n "b", 2) (insertEdge (s2n "a", s2n "b", 1) (insertNode (s2n "c") ((insertNode (s2n "b") (insertNode (s2n "a") emptyGraph)))))))





