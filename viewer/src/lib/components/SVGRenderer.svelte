<script>
  import { svgTurtle } from '$lib/turtle.js'

  export /**
   * @type {number}
   */
  let width
  export /**
   * @type {string | number}
   */
  let height
  export /**
   * @type {{ width: number; height: number; }}
   */
  let delta
  export /**
   * @type {number}
   */
  let distance
  export /**
   * @type {boolean}
   */
  let doClear = true
  export /**
   * @type {string}
   */
  let path
</script>

<div style="height: {height}px; width: {width}px;">
  <slot />
  <svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%" viewBox="0 0 {width} {height}">
    <circle cx={width / 2} cy={height} r="2" fill="brown" />
    <path
      fill="transparent"
      stroke="lightgreen"
      d={svgTurtle({ X: width, Y: height })({ δ: delta, d: distance, doClear })(path)}
    />
  </svg>
</div>

<style>
  svg {
    background-color: rgb(42, 166, 238);
    box-shadow: 0.2em 0.2em 4em lightblue, -0.2em -0.2em 4em lightgreen;
    margin: 2em auto;
    padding: 0;
  }
</style>
