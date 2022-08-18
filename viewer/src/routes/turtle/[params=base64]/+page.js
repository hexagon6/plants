import { Buffer } from 'buffer'
import LSystem from 'lindenmayer'

const fromBase64JSON = (/** @type string */ b) =>
  b ? JSON.parse(Buffer.from(b, 'base64').toString()) : {}
export function load({ params: { params } }) {
  const { degree, distance, path, lsystem } = fromBase64JSON(params)
  const { n, axiom, productions } = lsystem || {}
  const newPath = () => {
    if (!path) {
      // @ts-ignore
      const _lsystem = new LSystem({
        axiom,
        productions,
      })
      _lsystem.iterate(n)
      return _lsystem.getString()
    } else {
      return path
    }
  }
  return { degree, distance, path: newPath() }
}
