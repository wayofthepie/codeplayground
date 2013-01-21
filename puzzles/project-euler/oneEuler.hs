{-
    If we list all the natural numbers below 10 that are multiples of 3 or 5, 
    we get 3, 5, 6 and 9. The sum of these multiples is 23.
    Find the sum of all the multiples of 3 or 5 below 1000.
-}

{-
    first (naive) solution
    sums the multiples of 3 and 5 in the list "xs" 
-}
sumIfNotMultiples :: [Int] -> Int
sumIfNotMultiples xs = sum [x | x <- xs, (mod x 3 == 0) || (mod x 5 == 0) && (mod x 15) /= 0 ]

{- 
    closed solution (see codeplayground/latex/project-euler/projectEuler.tex for in-depth analysis)
-}
--pe1 :: Integer -> Integer -> Integer -> Integer
--pe1 a b n = (f a n  + f b n  - f (a*b) n) `div` 2

{-
    sumMultiples : sums all the multiples of "x" up to, but not including "y"
-}
--sumMultiples :: Integer -> Integer -> Integer
--sumMultiples x (y - 1) = x * ((y-1) `div` x) * (((y-1) `div` x) + 1)
  
{-
    Closed solution for problem one
-}
projectEulerOne :: Integer -> Integer -> Integer -> Integer
projectEulerOne a b n = (sumMultiples a n  + sumMultiples b n  
                            - sumMultiples (a*b) n) `div` 2
        where sumMultiples x y = x * f x y * (f x y + 1)
              f x y = ((y-1) `div` x)