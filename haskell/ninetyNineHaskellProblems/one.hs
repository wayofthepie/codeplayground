{-
    Find the last element of a list
-}
lastElement :: [a] -> a
lastElement [x]     = x
lastElement (_:xs)  = lastElement xs

                   