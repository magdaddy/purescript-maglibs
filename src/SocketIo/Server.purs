module MagLibs.SocketIo.Server where

import Prelude

import Data.Either (Either(..))
import Effect (Effect)
import Effect.Aff (Aff, runAff_)
import Effect.Exception (throw)
import Effect.Uncurried (EffectFn1, EffectFn2, mkEffectFn1, mkEffectFn2, runEffectFn1)
import Foreign (Foreign)
import Node.HTTP (Server) as Http
import Simple.JSON (class ReadForeign, class WriteForeign, read, write)

type NamespaceName = String

foreign import data Server :: Type
foreign import data Namespace :: Type
foreign import data ServerSocket :: Type

foreign import server :: forall r. Record r -> Effect Server

foreign import serverExt :: forall r. Http.Server -> Record r -> Effect Server

foreign import of_ :: NamespaceName -> Server -> Namespace

nspEmit ::
  forall payload. WriteForeign payload =>
  String -> payload -> Namespace -> Effect Unit
nspEmit name pl nsp = nspEmitImpl name (write pl) nsp

foreign import nspEmitImpl :: String -> Foreign -> Namespace -> Effect Unit

onConnect :: Namespace -> (ServerSocket -> Effect Unit) -> Effect Unit
onConnect srv handler = onConnectImpl srv (mkEffectFn1 handler)

foreign import onConnectImpl :: Namespace -> (EffectFn1 ServerSocket Unit) -> Effect Unit

foreign import listen :: Server -> Int -> Effect Unit

foreign import id :: ServerSocket -> String

socketOnDisconnect :: ServerSocket -> (String -> Effect Unit) -> Effect Unit
socketOnDisconnect skt handler = socketOnDisconnectImpl skt (mkEffectFn1 handler)

foreign import socketOnDisconnectImpl :: ServerSocket -> (EffectFn1 String Unit) -> Effect Unit

foreign import onAny :: String -> ServerSocket -> Effect Unit

on ::
  forall payload. ReadForeign payload =>
  String -> ServerSocket -> (payload -> Effect Unit) -> Effect Unit
on evtype skt handler = onImpl evtype skt (mkEffectFn1 handler')
  where
  handler' foreignPl = case read foreignPl of
    Left err -> throw $ "in 'on server' " <> evtype <> ": " <> show err
    Right pl -> handler pl

foreign import onImpl ::
  String -> ServerSocket -> (EffectFn1 Foreign Unit) -> Effect Unit
  -- forall payload.
  -- String -> ServerSocket -> (EffectFn1 payload Unit) -> Effect Unit

onReq ::
  forall reqPl resPl. WriteForeign resPl => ReadForeign reqPl =>
  String -> ServerSocket -> (reqPl -> Effect resPl) -> Effect Unit
onReq evtype skt handler = onReqImpl evtype skt (mkEffectFn2 handler')
  where
  handler' foreignPl cb = case read foreignPl of
    Left err -> throw $ "in 'onReq server' " <> evtype <> ": " <> show err
    Right pl -> do
      res <- handler pl
      runEffectFn1 cb (write res)

foreign import onReqImpl ::
  String -> ServerSocket -> (EffectFn2 Foreign (EffectFn1 Foreign Unit) Unit) -> Effect Unit

onReqAff ::
  forall reqPl resPl. WriteForeign resPl => ReadForeign reqPl =>
  String -> ServerSocket -> (reqPl -> Aff resPl) -> Effect Unit
onReqAff evtype skt handler = onReqImpl evtype skt (mkEffectFn2 handler')
  where
  handler' foreignPl cb = case read foreignPl of
    Left err -> throw $ "in 'onReqAff server' " <> evtype <> ": " <> show err
    Right pl -> do
      -- res <- handler pl
      -- runEffectFn1 cb (write res)
      runAff_ (affCb cb) (handler pl)
  affCb cb eeReq = case eeReq of
    Left err -> throw $ "aff failed in 'onReqAff server' " <> evtype <> ": " <> show err
    Right fpl -> runEffectFn1 cb (write fpl)
