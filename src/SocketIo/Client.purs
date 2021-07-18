module MagLibs.SocketIo.Client where

import Prelude

import Data.Either (Either(..))
import Effect (Effect)
import Effect.Exception (throw)
import Effect.Uncurried (EffectFn1, mkEffectFn1)
import Foreign (Foreign)
import Simple.JSON (class ReadForeign, class WriteForeign, read, write)

data SocketEvent
  = Connect

foreign import data ClientSocket :: Type

foreign import connect :: String -> Effect ClientSocket

-- foreign import socketOn :: String -> ClientSocket -> Effect Unit -> Effect Unit

on ::
  forall payload. ReadForeign payload =>
  String -> ClientSocket -> (payload -> Effect Unit) -> Effect Unit
on evtype skt handler = onImpl evtype skt (mkEffectFn1 handler')
  where
  handler' foreignPl = case read foreignPl of
    Left err -> throw $ "in 'on client' " <> evtype <> ": " <> show err
    Right pl -> handler pl

foreign import onImpl ::
  String -> ClientSocket -> (EffectFn1 Foreign Unit) -> Effect Unit


emit ::
  forall payload. WriteForeign payload =>
  String -> payload -> ClientSocket -> Effect Unit
emit name pl skt = emitImpl name (write pl) skt

foreign import emitImpl :: String -> Foreign -> ClientSocket -> Effect Unit


emitReq ::
  forall reqPl resPl. WriteForeign reqPl => ReadForeign resPl =>
  String -> reqPl -> ClientSocket -> (resPl -> Effect Unit) -> Effect Unit
emitReq name pl skt handler = emitReqImpl name (write pl) skt (mkEffectFn1 handler')
  where
  handler' foreignPl = case read foreignPl of
    Left err -> throw $ "in 'reqResponse client' " <> name <> ": " <> show err
    Right resPl -> handler resPl

foreign import emitReqImpl :: String -> Foreign -> ClientSocket -> (EffectFn1 Foreign Unit) -> Effect Unit

foreign import removeAllListenersForEvent :: String -> ClientSocket -> Effect Unit
