import qualified Crypto.Hash.SHA1 as Sha_1 
import Control.Parallel.Strategies
import qualified Data.ByteString.Char8 as Char8
import qualified Data.ByteString.Base16 as B16

mainLoop :: [[String]] -> Int -> Char8.ByteString -> Maybe String
mainLoop [] _ _ = Nothing 
mainLoop (task:xs) size hash = if ( exp /= []) then Prelude.head exp else mainLoop xs size hash
                               where exp = Prelude.filter (/=Nothing) (innerLoop (Main.chunk size task) hash)


innerLoop :: [[String]] -> Char8.ByteString -> [Maybe String]
innerLoop xs hash = Prelude.map foo xs `using` parList rseq
                    where foo list = brute list hash

brute :: [String] -> Char8.ByteString -> Maybe String
brute [] _ = Nothing  
brute (x:xs) hash = if B16.encode (Sha_1.hash (Char8.pack x)) == hash then Just x else brute xs hash

main :: IO()
main = do
    Prelude.putStrLn "enter hash here:"
    hash <- Prelude.getLine
    --let hash = "4170ac2a2782a1516fe9e13d7322ae482c1bd594"
    let hashToFind = Char8.pack hash
    let pass = mainLoop (Main.chunk 50000 passWords) 1000 (Char8.pack hash)
    case pass of
        Nothing -> Prelude.putStrLn "Can`t  find password =("
        Just res -> do
                      Prelude.putStrLn "***SUCCES***"
                      Prelude.putStrLn res
    return()


chunk :: Int -> [a] -> [[a]]
chunk n [] = []
chunk n xs = as : chunk n bs
             where (as,bs) = Prelude.splitAt n xs



passWords = [[a1] | a1 <- alphabet] ++ [[a1, a2] | a1 <- alphabet, a2 <- alphabet] ++ [[a1,a2,a3] | a1 <- alphabet,a2 <- alphabet,a3 <- alphabet]
                                                    ++[[a1,a2,a3,a4] | a1 <- alphabet,a2 <- alphabet,a3 <- alphabet, a4 <- alphabet]
                                                    ++[[a1,a2,a3,a4,a5] | a1 <- alphabet,a2 <- alphabet,a3 <- alphabet, a4 <- alphabet, a5 <- alphabet]

alphabet = ['0'..'z']