{-  
    Find the last but one element of a list
-}
lastButOne :: [a] -> a
lastButOne x = x !! ((length x) - 2)