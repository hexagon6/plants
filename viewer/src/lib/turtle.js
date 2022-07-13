import { concat, filter, map, pipe as _, reduce, tap } from 'ramda'

// const log = tap(console.log)
export const canvasTurtle =
  ({ /** @type {canvas 2d context} */ c, /** @type {number} */ X, /** @type {number} */ Y }) =>
  ({ /** @type {float} */ δ, /** @type {float} */ d, /** @type {boolean} */ doClear }) =>
  (/** @type {string} */ input) => {
    if (!c) {
      return
    }
    const center = {
      X: X / 2,
      Y: Y / 2,
    }
    if (doClear) {
      c.clearRect(0, 0, X, Y)
    }
    // starting circle
    c.fillStyle = 'brown'
    c.beginPath()
    c.arc(center.X, Y, 2, 0, Math.PI * 2, true)
    c.fill()
    c.strokeStyle = 'lightgreen'
    let direction = 0 /* 0 = North, 90 = East, 180 = South, 270 = West */
    let xPos = center.X
    let yPos = Y
    let stack = [] // [{xPos, yPos, direction}]
    const actions = {
      '[': () => {
        console.log('push to stack')
        stack.push({ xPos, yPos, direction })
      },
      ']': () => {
        console.log('pop the stack')
        const { xPos: _x, yPos: _y, direction: _dir } = stack.pop({ xPos, yPos, direction })
        xPos = _x
        yPos = _y
        direction = _dir
      },
      F: () => {
        // console.log(`move forward 1 step with length d ${d} while drawing a line segment`)

        c.beginPath()
        c.moveTo(xPos, yPos)
        // console.log(`from x0=${xPos}, to x1=${2} in ${direction}`)
        const V = (direction / 360) * 2 * Math.PI
        xPos = xPos + d * Math.sin(V)
        yPos = yPos - d * Math.cos(V)
        // console.log({ d, δ, xPos, yPos })
        c.lineTo(xPos, yPos)
        c.closePath()
        c.stroke()
      },
      f: () => {
        const V = (direction / 180) * Math.PI
        xPos = xPos + d * Math.sin(V)
        yPos = yPos - d * Math.cos(V)
        // console.log(`move forward 1 step with length d ${d} without drawing`)
      },
      '-': () => {
        direction = (direction + δ) % 360
        // console.log(`turn right by angle δ ${δ}, ${direction}`)
      },
      '+': () => {
        direction = (direction + 360 - δ) % 360
        // console.log(`turn left by angle δ ${δ}, ${direction}`)
      },
    }

    map(
      _(
        (/** @type {string} */ char) => (char in actions ? actions[char] : () => {}),
        f => f(),
      ),
    )(input.split(''))
  }

export const svgTurtle =
  ({ /** @type {number} */ X, /** @type {number} */ Y }) =>
  ({ /** @type {float} */ δ, /** @type {float} */ d, /** @type {boolean} */ doClear }) =>
  (/** @type {string} */ input) => {
    const center = {
      X: X / 2,
      Y: Y / 2,
    }
    let direction = 0 /* 0 = North, 90 = East, 180 = South, 270 = West */
    let xPos = center.X
    let yPos = Y
    let stack = [] // [{xPos, yPos, direction}]
    const actions = {
      '[': () => {
        console.log('push to stack')
        stack.push({ xPos, yPos, direction })
        return `M ${xPos} ${yPos}`
      },
      ']': () => {
        console.log('pop the stack')
        const { xPos: _x, yPos: _y, direction: _dir } = stack.pop()
        xPos = _x
        yPos = _y
        direction = _dir
        return `M ${xPos} ${yPos}`
      },
      F: () => {
        // console.log(`move forward 1 step with length d ${d} while drawing a line segment`)
        const V = (direction / 360) * 2 * Math.PI
        xPos = xPos + d * Math.sin(V)
        yPos = yPos - d * Math.cos(V)
        return `L ${xPos} ${yPos}`
      },
      f: () => {
        const V = (direction / 180) * Math.PI
        xPos = xPos + d * Math.sin(V)
        yPos = yPos - d * Math.cos(V)
        console.log(`move forward 1 step with length d ${d} without drawing`)
        return `M ${xPos} ${yPos}`
      },
      '-': () => {
        direction = (direction + δ) % 360
        console.log(`turn right by angle δ ${δ}, ${direction}`)
        return ''
      },
      '+': () => {
        direction = (direction + 360 - δ) % 360
        console.log(`turn left by angle δ ${δ}, ${direction}`)
        return ''
      },
    }

    const path = _(
      map(
        _(
          (/** @type {string} */ char) => (char in actions ? actions[char] : () => {}),
          f => f(),
        ),
      ),
      filter(f => f !== ''),
    )(input.split('')).join(' ')
    return `M ${center.X},${Y}
		${path}`
  }

export const allowedStrings = 'Ff-+'.split('')
