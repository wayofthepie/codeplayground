{-
    Find the number of elements in a list.
-}
numElemsInList :: [a] -> Int
numElemsInList = foldr (const (+1)) 0
  