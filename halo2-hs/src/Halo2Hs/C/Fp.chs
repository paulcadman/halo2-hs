module Halo2Hs.C.Fp (Fp, fpFromRaw, fpFromRawArgs, halo2FpDebug) where

#include "halo2_rs.h"

import Data.Word
import Foreign.Rust.Marshall.Variable
import Data.Text (Text)

{#pointer *Fp foreign finalizer halo2_rs_free_fp newtype #}

{# fun unsafe halo2_rs_fp_from_raw as fpFromRaw
     { toBorshVar*  `[Word64]'& }
  -> `Fp'
#}

{# fun unsafe halo2_rs_fp_from_raw_args as fpFromRawArgs
     { `Word64'
     , `Word64'
     , `Word64'
     , `Word64'
     }
  -> `Fp'
#}

{# fun unsafe halo2_rs_fp_debug as halo2FpDebug
     { `Fp'
     , getVarBuffer `Buffer Text'&
     }
  -> `()'
#}
