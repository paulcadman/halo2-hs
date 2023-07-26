module C.GettingStarted (halo2RsAdd) where

#include "halo2_rs.h"

import Data.Word

{# fun pure unsafe halo2_rs_add as halo2RsAdd
     { `Word64'
     , `Word64'
     }
  -> `Word64'
#}
