import { Buffer } from 'buffer'

export const toBase64JSON = (/** @type object */ o) =>
  Buffer.from(JSON.stringify(o)).toString('base64')

export const fromBase64JSON = (/** @type string */ b) =>
  b ? JSON.parse(Buffer.from(b, 'base64').toString()) : {}
