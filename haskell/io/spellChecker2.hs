import Data.Set
import Data.Maybe
import Text.Printf
import System.IO
import System.Environment
import System.Posix.Temp

main :: IO()
main = do
    (f, g) <- readFiles
    let dict = fromList (lines f)
        errs = mapMaybe (spell dict) (words g)
    write errs


spell d w | w `notMember` d = Just w
          | otherwise = Nothing
         
readFiles :: IO()
readFiles = do
    [s] <- getArgs
    f   <- readFile "/usr/share/dict/words"
    g   <- readFile s
    return (f,g)

write :: [String] -> IO()
write errs = do
    (t,h) <- mkstemp "/tmp/spell.XXXXXX"
    mapM_ (hPutStrLn h) errs
    hClose h
    printf "%d spelling errors written to '%s'\n" (length errs) t
    
