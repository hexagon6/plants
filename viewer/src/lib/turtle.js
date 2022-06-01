import { map, pipe as _, tap } from 'ramda'

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
		c.arc(center.X, center.Y, 2, 0, Math.PI * 2, true)
		c.fill()
		c.strokeStyle = 'lightgreen'
		let direction = 0 /* 0 = North, 90 = East, 180 = South, 270 = West */
		let xPos = center.X
		let yPos = center.Y
		const actions = {
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

export const allowedStrings = 'Ff-+'.split('')
