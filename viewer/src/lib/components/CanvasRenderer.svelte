<script>
  import { onMount } from 'svelte'

  import { canvasTurtle as turtle } from '$lib/turtle.js'
  export /**
   * @type {string | number}
   */
  let height
  export /**
   * @type {string | number}
   */
  let width
  /**
   * @type {HTMLCanvasElement}
   */
  let canvas
  export /**
   * @type {string}
   */
  let path
  export /**
   * @type {number}
   */
  let delta
  export /**
   * @type {number}
   */
  let distance
  export /**
   * @type {boolean}
   */
  let doClear

  /**
   * @type {CanvasRenderingContext2D | null}
   */
  let c

  onMount(async () => {
    c = canvas.getContext('2d')
  })
  $: turtle({ c, X: canvas?.width, Y: canvas?.height })({ δ: delta, d: distance, doClear })(path)
</script>

<div style="height: {height}px; width: {width}px;">
  <slot />
  <canvas bind:this={canvas} {width} {height} />
</div>

<style>
  canvas {
    background-color: rgb(42, 166, 238);
    box-shadow: 0.2em 0.2em 4em lightblue, -0.2em -0.2em 4em lightgreen;
    /* margin: 2em auto; */
    padding: 0;
  }
</style>
