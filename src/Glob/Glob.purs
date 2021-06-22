module MagLibs.Glob where

import Prelude

import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)
import Effect.Aff (Aff, makeAff)
import Effect.Uncurried (EffectFn2, EffectFn3, mkEffectFn2, runEffectFn3)

glob :: forall r. String -> Record r -> (Either String (Array String) -> Effect Unit) -> Effect Unit
glob pattern opts cb = runEffectFn3 globImpl pattern opts (mkEffectFn2 cb')
  where cb' = \nullableStr matchesArr -> do
          let
            mbStr = toMaybe nullableStr
            arg = case mbStr of
              Nothing -> Right matchesArr
              Just err -> Left err
          cb arg

foreign import globImpl :: forall r. EffectFn3 String (Record r) (EffectFn2 (Nullable String) (Array String) Unit) Unit

globAff :: forall r. String -> Record r -> Aff (Either String (Array String))
globAff pattern opts = makeAff \cb -> do
  glob pattern opts \esas -> do
    cb (Right esas)
  mempty
