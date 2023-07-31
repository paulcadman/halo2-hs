module Halo2Hs.C.Fp where

#include "halo2_rs.h"

import Data.Word
import Foreign.Rust.Marshall.Variable
import Data.Text (Text)
import Foreign.Ptr (nullPtr)

{#pointer *Fp foreign finalizer halo2_rs_free_fp newtype #}

fpToMaybe :: Fp -> IO (Maybe Fp)
fpToMaybe fp =  withFp fp $ \ptr ->
    if ptr == nullPtr
        then return Nothing
        else return $ Just fp

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

{# fun unsafe halo2_rs_fp_eq as fpEq
     { `Fp'
     , `Fp'
     }
  -> `Bool'
#}

{# fun unsafe halo2_rs_fp_invert as fpInvertUnsafe
     { `Fp'
     }
  -> `Fp'
#}

{# fun pure unsafe halo2_rs_fp_zero as fpZero
     {}
  -> `Fp'
#}

{# fun pure unsafe halo2_rs_fp_one as fpOne
     {}
  -> `Fp'
#}

{# fun unsafe halo2_rs_fp_double as fpDouble
     { `Fp'
     }
  -> `Fp'
#}

{# fun unsafe halo2_rs_fp_neg as fpNeg
     { `Fp'
     }
  -> `Fp'
#}

{# fun unsafe halo2_rs_fp_square as fpSquare
     { `Fp'
     }
  -> `Fp'
#}

{# fun unsafe halo2_rs_fp_mul as fpMul
     { `Fp'
     , `Fp'
     }
  -> `Fp'
#}

{# fun unsafe halo2_rs_fp_add as fpAdd
     { `Fp'
     , `Fp'
     }
  -> `Fp'
#}

{# fun unsafe halo2_rs_fp_sub as fpSub
     { `Fp'
     , `Fp'
     }
  -> `Fp'
#}
