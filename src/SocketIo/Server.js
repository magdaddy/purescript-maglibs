'use strict';

// const options = {
//   cors: {
//     origin: "http://localhost:1234",
//     methods: ["GET", "POST"]
//   }
// };

exports.server = options => () => require("socket.io")(options);

exports.serverExt = httpServer => options => () => require("socket.io")(httpServer, options);

exports.of_ = nspName => server => server.of(nspName);

exports.nspEmitImpl = evtype => payload => nsp => () => nsp.emit(evtype, payload);

// io.on("connection", socket => {
//   console.log(socket.id, "connected.");
//   socket.on("disconnect", reason => console.log(socket.id, "left.", reason));
// });

exports.onConnectImpl = server => handler => () => {
  server.on("connection", handler);
}
// io.listen(3000);

exports.listen = server => port => () => server.listen(port);

exports.id = socket => socket.id;

exports.socketOnDisconnectImpl = socket => handler => () => {
  socket.on("disconnect", handler);
}

exports.onAny = msg => socket => () => socket.onAny((name, ...args) => console.log(msg, name, args))

exports.onImpl = evtype => socket => handler => () => {
  socket.on(evtype, handler);
}

exports.onReqImpl = evtype => socket => handler => () => {
  socket.on(evtype, handler);
}
