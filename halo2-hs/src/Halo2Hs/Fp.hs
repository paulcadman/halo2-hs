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
) where

import Foreign.Rust.Marshall.Variable
import Data.Text (Text)
import Halo2Hs.C.Fp

fpDebug :: Fp -> IO Text
fpDebug = withBorshVarBuffer . halo2FpDebug
