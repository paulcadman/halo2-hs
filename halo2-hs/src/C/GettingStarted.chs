module C.GettingStarted (halo2FpFromRaw, halo2FpFromRawArgs, fpDebug) where

#include "halo2_rs.h"

import Data.Word
import Foreign.Rust.Marshall.Variable
import Data.Text (Text)

{#pointer *Fp foreign finalizer halo2_rs_free_fp newtype #}

{# fun unsafe halo2_rs_fp_from_raw as halo2FpFromRaw
     { toBorshVar*  `[Word64]'& }
  -> `Fp'
#}

{# fun unsafe halo2_rs_fp_from_raw_args as halo2FpFromRawArgs
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

fpDebug :: Fp -> IO Text
fpDebug = withBorshVarBuffer . halo2FpDebug
