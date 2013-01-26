{-
    Find the kth element of a list, first element is '1'
-}
elementAt :: Int -> [a] -> a
elementAt x ys = ys !! (x - 1)
