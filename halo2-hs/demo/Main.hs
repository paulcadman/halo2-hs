module Main (main) where

import C.GettingStarted

main :: IO ()
main = do
    putStrLn "\n# Getting started\n"
    print $ halo2RsAdd 1 2

