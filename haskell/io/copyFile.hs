{-
    File IO
-}
import System.Environment

main :: IO()
main = do 
    [f,g]   <- getArgs
    copyFile f g

{-
    copyFile : copies fName to new file called cName
-}
copyFile :: String -> String -> IO()
copyFile fName cName = do
    s       <- readFile fName
    writeFile cName s
    
