const io = require("socket.io-client");

// const socket = io("ws://localhost:3007");

// socket.on("connect", () => {
//   console.log("connected!");
//   // either with send()
//   // socket.send("Hello!");

//   // or with emit() and custom event names
//   // socket.emit("salutations", "Hello!", { "mr": "john" }, Uint8Array.from([1, 2, 3, 4]));
// });

exports.connect = url => () => io(url);

exports.onImpl = evtype => soc => handler => () => soc.on(evtype, handler);

exports.emitImpl = evtype => payload => skt => () => skt.emit(evtype, payload);

exports.emitReqImpl = evtype => payload => skt => handler => () => skt.emit(evtype, payload, handler);
