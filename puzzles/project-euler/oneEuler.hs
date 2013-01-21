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
    closed solution for problem one
    see codeplayground/latex/project-euler/projectEuler.tex for in-depth analysis
-}
projectEulerOne :: Integer -> Integer -> Integer -> Integer
projectEulerOne a b n = (sumMultiples a n  + sumMultiples b n - sumMultiples (a*b) n) `div` 2
        where sumMultiples x y = x * f x y * (f x y + 1)
              f x y = ((y-1) `div` x)
