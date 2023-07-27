module Halo2Hs.C.Fp where

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


{# fun pure unsafe halo2_rs_fp_zero as fpZero
     {}
  -> `Fp'
#}

{# fun pure unsafe halo2_rs_fp_one as fpOne
     {}
  -> `Fp'
#}

{# fun pure unsafe halo2_rs_fp_double as fpDouble
     { `Fp'
     }
  -> `Fp'
#}

{# fun pure unsafe halo2_rs_fp_neg as fpNeg
     { `Fp'
     }
  -> `Fp'
#}

{# fun pure unsafe halo2_rs_fp_square as fpSquare
     { `Fp'
     }
  -> `Fp'
#}

{# fun pure unsafe halo2_rs_fp_mul as fpMul
     { `Fp'
     , `Fp'
     }
  -> `Fp'
#}

{# fun pure unsafe halo2_rs_fp_add as fpAdd
     { `Fp'
     , `Fp'
     }
  -> `Fp'
#}

{# fun pure unsafe halo2_rs_fp_sub as fpSub
     { `Fp'
     , `Fp'
     }
  -> `Fp'
#}
