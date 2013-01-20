data Ord a => BST a = EmptyBST | Node (BST a) a (BST a) deriving Show

{- 
    1. numLeaves bst : number of leaves in the BST "bst"
-}
numLeaves :: Ord a => BST a -> Int
numLeaves EmptyBST              = 0
numLeaves (Node lSub _ rSub)    | (isEmptyBST lSub && isEmptyBST rSub ) = 1
                                | otherwise = numLeaves lSub + numLeaves rSub

{-
    2. minValue bst : minimum value in the BST "bst"
-}
minValue :: Ord a => BST a -> a
minValue (Node lSub x _)    | (isEmptyBST lSub) = x
                            | otherwise = minValue lSub

{-
    3. maxValue bst : maximum value in the BST "bst"
-}
maxValue :: Ord a => BST a -> a
maxValue (Node _ x rSub) | (isEmptyBST rSub) = x
                         | otherwise = maxValue rSub    

{-
    4. height bst : height of the BST "bst"
-}
height :: Ord a => BST a -> Int
height EmptyBST             = 0
height (Node lSub _ rSub)   = max (1 + height lSub) (1 + height rSub)

{-
    5. occurs v bst : if value "v" occurs in the BST "bst"
-}
occurs :: Ord a => a -> BST a -> Bool
occurs v (Node lSub x rSub) | v < x     = occurs v lSub
                            | v > x     = occurs v rSub                            
                            | otherwise = True
occurs _ EmptyBST           = False

{-
    6. mirror bst : a mirror image of the BST "bst"
-}
mirror :: Ord a => BST a -> BST a
mirror EmptyBST = EmptyBST
mirror (Node lSub x rSub) = Node (mirror rSub) x (mirror lSub)

{-
    7. treeSort list : the list "list" sorted into ascending order
-}
treeSort :: Ord a => [a] -> [a]
treeSort = bstToList . foldr (insert) EmptyBST


{-
    Helper Functions
-}
-- insert v bst : the BST formed by inserting the value "v" into the BST "bst"
insert :: Ord a => a -> BST a -> BST a
insert v EmptyBST               = leaf v
insert v (Node lSub root rSub)  = if v < root then
                                    Node (insert v lSub) root rSub
                                  else
                                    Node lSub root (insert v rSub)

-- leaf v : the single-node BST storing the value "v"
leaf :: Ord a => a -> BST a 
leaf v = Node EmptyBST v EmptyBST

-- bstToList bst : the list formed after an in order traversal of the BST "bst"
bstToList :: Ord a => BST a -> [a]
bstToList EmptyBST                      = []
bstToList (Node EmptyBST x EmptyBST)    = [x]
bstToList (Node lSub x rSub)            = bstToList lSub ++ x:bstToList rSub
   
-- isEmptyBST bst : whether the BST "bst" is an EmptyBST
isEmptyBST :: Ord a => BST a -> Bool
isEmptyBST EmptyBST   = True
isEmptyBST _          = False