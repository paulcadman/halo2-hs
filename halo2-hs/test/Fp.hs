module Fp where

import Test.Tasty
import Test.Tasty.HUnit

import Halo2Hs.Fp

fpTests :: TestTree
fpTests = testGroup "Fp Tests"
 [ testCase "fpOne is equal to itself" $
     fpEq fpOne fpOne @? "fpOne is not equal to itself"
 , testCase "fpOne is not equal to fpZero" $
     (not <$> fpEq fpOne fpZero @?) "fpOne is equal to fpZero"
 ]
