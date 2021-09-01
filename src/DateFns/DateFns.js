'use strict';

let format = require('date-fns/fp/format');
let parse = require('date-fns/fp/parse');
let parseISO = require('date-fns/fp/parseISO');

let add = require('date-fns/fp/add');

// fix for weird bug here, I guess it has something to do with bundling...
if (process.title === 'browser') {
  format = format.default;
  parse = parse.default;
  parseISO = parseISO.default;
  add = add.default;
}

exports.format = format;
exports.formatN = format;

exports.parseImpl = parse;

exports.parseISO = parseISO;

// ---

exports.add = add;
