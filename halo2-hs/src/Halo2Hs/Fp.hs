module Halo2Hs.Fp (
  Fp
  , fpFromRaw
  , fpFromRawArgs
  , fpDebug
  , fpMul
  , fpAdd
  , fpSub
  , fpOne
  , fpZero
  , fpDouble
  , fpNeg
  , fpSquare
  , fpEq
  , fpInvert
  , fpSqrt
) where

import Foreign.Rust.Marshall.Variable
import Data.Text (Text)
import Halo2Hs.C.Fp

fpDebug :: Fp -> IO Text
fpDebug = withBorshVarBuffer . halo2FpDebug

fpInvert :: Fp -> IO (Maybe Fp)
fpInvert fp = fpInvertUnsafe fp >>= fpToMaybe

fpSqrt :: Fp -> IO (Maybe Fp)
fpSqrt fp = fpSqrtUnsafe fp >>= fpToMaybe
