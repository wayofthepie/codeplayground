{-
    Find whether list is a palindrome
-}
isPalindrome :: Eq a => [a] -> Bool
isPalindrome xs =  xs == reverse xs