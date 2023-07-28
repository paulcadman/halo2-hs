module Main (main) where

import Halo2Hs.Fp

main :: IO ()
main = do
    putStrLn "\n# Creating field elements\n"
    fp1 <- fpFromRaw [0,1,0,0]
    fp2 <- fpFromRawArgs 1 1 1 1
    let one = fpOne
        zero = fpZero
    fpDebug fp1 >>= print
    fpDebug fp2 >>= print
    fpMul fp1 fp2 >>= fpDebug >>= print
    fpNeg fp1 >>= fpNeg >>= fpDebug >>= print
    fpDouble fp2 >>= fpDebug >>= print
    fpDebug one >>= print
    fpDebug zero >>= print
    (show <$> fpEq one zero) >>= print
    (show <$> fpEq one one) >>= print
