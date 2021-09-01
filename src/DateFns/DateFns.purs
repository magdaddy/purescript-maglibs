module MagLibs.DateFns where

import Data.JSDate (JSDate)

foreign import format :: String -> JSDate -> String
foreign import formatN :: String -> Number -> String


parse :: String -> String -> JSDate
parse fmtStr dateStr = parseImpl 0.0 fmtStr dateStr

foreign import parseImpl :: Number -> String -> String -> JSDate

foreign import parseISO :: String -> JSDate

---

foreign import add :: forall r. Record r -> JSDate -> JSDate
