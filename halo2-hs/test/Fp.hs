module Fp where

import Test.Tasty
import Test.Tasty.HUnit
import Halo2Hs.Fp

fpTests :: TestTree
fpTests = testGroup "Fp Tests"
 [ testCase "fpOne is equal to itself" $
     fpEq fpOne fpOne @? "fpOne is not equal to itself"
 , testCase "fpOne is not equal to fpZero" $
     (not <$> fpEq fpOne fpZero) @? "fpOne is equal to fpZero"
 , testCase "fpInvert fpOne is equal to fpOne" $ do
     inv <- fpInvert fpOne
     case inv of
       Nothing -> assertFailure "expected fpInvert fpOne to be fpOne"
       Just invFp -> do
         fpEq invFp fpOne @? "fpInvert fpOne is not equal to fpOne"
 , testCase "fpInvert fpZero is Nothing" $ do
     inv <- fpInvert fpZero
     case inv of
       Nothing -> return ()
       Just _ -> assertFailure "expected fpInvert fpZero to be Nothing"
 ]
