module Main (main) where

import C.GettingStarted

main :: IO ()
main = do
    putStrLn "\n# Creating field elements\n"
    fp1 <- halo2FpFromRaw [0,0,0,0]
    fp2 <- halo2FpFromRawArgs 0 1 0 0
    fpDebug fp1 >>= print
    fpDebug fp2 >>= print
