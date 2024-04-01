import LSystem from 'lindenmayer'
import { fromBase64JSON } from '$lib/encoding.js'

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
