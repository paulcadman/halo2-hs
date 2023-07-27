module Main (main) where

import Halo2Hs.Fp

main :: IO ()
main = do
    putStrLn "\n# Creating field elements\n"
    fp1 <- fpFromRaw [0,1,0,0]
    fp2 <- fpFromRawArgs 1 1 1 1
    fpDebug fp1 >>= print
    fpDebug fp2 >>= print
    fpDebug (fpMul fp1 fp2) >>= print
    fpDebug (fpNeg (fpNeg fp1)) >>= print
    fpDebug (fpDouble fp2) >>= print
