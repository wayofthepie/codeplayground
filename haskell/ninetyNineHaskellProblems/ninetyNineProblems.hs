{-
    Problem One : Find the last element of a list
-}
lastElement :: [a] -> a
lastElement [x]     = x
lastElement (_:xs)  = lastElement xs


{-  
    Problem Two : Find the last but one element of a list
-}
lastButOne :: [a] -> a
lastButOne x = x !! ((length x) - 2)


{-
    Problem Three : Find the kth element of a list, first element is '1'
-}
elementAt :: Int -> [a] -> a
elementAt x ys = ys !! (x - 1)


{-
    Problem Four : Find the number of elements in a list.
-}
numElemsInList :: [a] -> Int
numElemsInList = foldr (const (+1)) 0


{-
    Problem Five : Reverse a list
-}
reverseList :: [a] -> [a]
reverseList = foldl (flip (:)) []

{-
    Problem Six : Find whether list is a palindrome
-}
isPalindrome :: Eq a => [a] -> Bool
isPalindrome xs =  xs == reverse xs
