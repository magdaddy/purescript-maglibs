module MagLibs.SocketIo.Message where

import Prelude

import Effect (Effect)
import Effect.Aff (Aff)
import MagLibs.SocketIo.Client (ClientSocket, emit, emitReq)
import MagLibs.SocketIo.Client (on) as Client
import MagLibs.SocketIo.Server (Namespace, ServerSocket, nspEmit)
import MagLibs.SocketIo.Server (on, onReq, onReqAff) as Server
import Simple.JSON (class ReadForeign, class WriteForeign)
import Type.Prelude (class IsSymbol, Proxy, reflectSymbol)

data ServerToClientMsg :: Type -> Type -> Type
data ServerToClientMsg name typ = ServerToClientMsg name

data ClientToServerMsg :: Type -> Type -> Type
data ClientToServerMsg name typ = ClientToServerMsg name

serverEmit :: forall name typ. IsSymbol name => WriteForeign typ =>
  ServerToClientMsg (Proxy name) typ -> typ -> Namespace -> Effect Unit
serverEmit (ServerToClientMsg name) = nspEmit (reflectSymbol name)

clientEmit :: forall name typ. IsSymbol name => WriteForeign typ =>
  ClientToServerMsg (Proxy name) typ -> typ -> ClientSocket -> Effect Unit
clientEmit (ClientToServerMsg name) = emit (reflectSymbol name)

serverOn :: forall name typ. IsSymbol name => ReadForeign typ =>
  ClientToServerMsg (Proxy name) typ -> ServerSocket -> (typ -> Effect Unit) -> Effect Unit
serverOn (ClientToServerMsg name) = Server.on (reflectSymbol name)

clientOn :: forall name typ. IsSymbol name => ReadForeign typ =>
  ServerToClientMsg (Proxy name) typ -> ClientSocket -> (typ -> Effect Unit) -> Effect Unit
clientOn (ServerToClientMsg name) = Client.on (reflectSymbol name)


data ClientToServerReq :: Type -> Type -> Type -> Type
data ClientToServerReq name reqTyp resTyp = ClientToServerReq name

clientReq :: forall name reqTyp resTyp.
  IsSymbol name => WriteForeign reqTyp => ReadForeign resTyp =>
  ClientToServerReq (Proxy name) reqTyp resTyp -> reqTyp -> ClientSocket -> (resTyp -> Effect Unit) -> Effect Unit
clientReq (ClientToServerReq name) = emitReq (reflectSymbol name)

serverOnReq :: forall name reqTyp resTyp.
  IsSymbol name => ReadForeign reqTyp => WriteForeign resTyp =>
  ClientToServerReq (Proxy name) reqTyp resTyp -> ServerSocket -> (reqTyp -> Effect resTyp) -> Effect Unit
serverOnReq (ClientToServerReq name) = Server.onReq (reflectSymbol name)

serverOnReqAff :: forall name reqTyp resTyp.
  IsSymbol name => ReadForeign reqTyp => WriteForeign resTyp =>
  ClientToServerReq (Proxy name) reqTyp resTyp -> ServerSocket -> (reqTyp -> Aff resTyp) -> Effect Unit
serverOnReqAff (ClientToServerReq name) = Server.onReqAff (reflectSymbol name)
