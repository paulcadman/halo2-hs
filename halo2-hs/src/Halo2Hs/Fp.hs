module Halo2Hs.Fp (
  Fp
  , fpFromRaw
  , fpFromRawArgs
  , fpDebug
) where

import Foreign.Rust.Marshall.Variable
import Data.Text (Text)
import Halo2Hs.C.Fp

fpDebug :: Fp -> IO Text
fpDebug = withBorshVarBuffer . halo2FpDebug
