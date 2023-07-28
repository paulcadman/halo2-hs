module Main where

import Test.Tasty
import Fp

tests :: TestTree
tests = testGroup "Tests" [fpTests]

main :: IO ()
main = defaultMain tests
