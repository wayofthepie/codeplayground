import Data.List

{-
    Count the number of lines in a file
    Usage: ./countLines < file
-}
main :: IO()
main = interact (count . lines)

-- count : counts the number of characters in s
count :: [a] -> String
count s = show (length s) ++ "\n"

