{-
    If we list all the natural numbers below 10 that are multiples of 3 or 5, 
    we get 3, 5, 6 and 9. The sum of these multiples is 23.
    Find the sum of all the multiples of 3 or 5 below 1000.
-}

-- sums the multiples of 3 and 5 in the list "xs" 
sumIfNotMultiples :: [Int] -> Int
sumIfNotMultiples xs = sum [x | x <- xs, (mod x 3 == 0) || (mod x 5 == 0) && (mod x 15) /= 0 ]

-- Closed solution (from helix7 project euler solution (python) forum post in problem)
pe1 :: Integer -> Integer -> Integer -> Integer
pe1 a b n = (f a n  + f b n  - f (a*b) n) `div` 2
    where f x y = x * ((y-1) `div` x) * (((y-1) `div` x) + 1)