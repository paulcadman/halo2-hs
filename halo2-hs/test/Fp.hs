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
 , testCase "fpSqrt fpOne is equal to fpOne" $ do
     r <- fpSqrt fpOne
     case r of
       Nothing -> assertFailure "expected fpSqrt fpOne to be fpOne"
       Just s -> do
         fpEq s fpOne @? "fpSqrt fpOne is not equal to fpOne"
 , testCase "fpSqrt fpZero is equal to fpZero" $ do
     r <- fpSqrt fpZero
     case r of
       Nothing -> assertFailure "expected fpSqrt fpZero to be fpZero"
       Just s -> do
         fpEq s fpZero @? "fpSqrt fpZero is not equal to fpZero"
 ]
