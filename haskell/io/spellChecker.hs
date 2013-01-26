import System.Environment
import Control.Monad
import Data.Set

main = do
    [s] <- getArgs
    f <- readFile "/usr/share/dict/words"
    g <- readFile s
    let dict = fromList (lines f)
    mapM_ (spell dict) (words g)


-- spell : Prints the word 'w' if it does not exist in the dictionary 'd'    

spell :: Set [Char] -> [Char] -> IO()
spell d w = when (w `notMember` d) (putStrLn w)
