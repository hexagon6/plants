<script context="module">
  import { Buffer } from 'buffer'
  const fromBase64JSON = b => (b ? JSON.parse(Buffer.from(b, 'base64')) : {})
  export async function load({ params: { params } }) {
    const { delta, distance, path } = fromBase64JSON(params)
    return { props: { delta, distance, path } }
  }
</script>

<script>
  // @ts-nocheck
  import SvgRenderer from '$lib/components/SVGRenderer.svelte'
  import CanvasRenderer from '$lib/components/CanvasRenderer.svelte'
  import { allowedStrings } from '$lib/turtle.js'
  import { KochKurve, TurtleTest, Sierpinski } from '$lib/renderpaths.js'

  const toBase64JSON = o => Buffer.from(JSON.stringify(o)).toString('base64')

  // [[SL,SR,SL].join('-'), [SR,SL,SR].join('+'), [SL,SR,SL].join('-')].join('-')
  let width = 400
  let height = 400
  $: renderMode = 'canvas'

  export let path = 'F-F+F+FF-F-F+F'
  export let delta = 90
  export let distance = 20

  $: δ = delta
  $: d = distance
  $: doClear = true
</script>

<svelte:head>
  <title>Turtle Playground</title>
</svelte:head>

<article>
  <div style="margin: 4em;">
    {#if renderMode == 'canvas'}
      <CanvasRenderer {height} {width} delta={δ} distance={d} {path} />
    {:else if renderMode == 'svg'}
      <SvgRenderer {height} {width} delta={δ} distance={d} {path} />
    {/if}
  </div>
</article>

<ul>
  <li>
    actions:
    <code>
      {allowedStrings}
    </code>
  </li>
  <li>
    <label
      >turtle path
      <input bind:value={path} type="textarea" width="100%" />
    </label>
  </li>
  <lh>turtle parameters</lh>
  <li>
    <input bind:value={δ} type="range" min="0" max="359" />
    δ: {δ}
  </li>
  <li>
    <input bind:value={d} type="range" min="1" max="50" />
    d: {d}
  </li>
  <li>
    <label>
      clear canvas before drawing
      <input bind:value={doClear} type="checkbox" />
    </label>
  </li>
  <lh>Rendering Mode</lh>
  <li>
    <label>
      <button
        style={`color: ${renderMode != 'canvas' ? 'grey' : 'inherit'}`}
        on:click={() => {
          renderMode = 'canvas'
        }}>Canvas</button
      >
      /
      <button
        style={`color: ${renderMode != 'svg' ? 'grey' : 'inherit'}`}
        on:click={() => {
          renderMode = 'svg'
        }}>SVG</button
      >
    </label>
  </li>
</ul>
<div>
  current settings:
  <a href="/turtle/{toBase64JSON({ path, delta: δ, distance: d })}">Share this link</a>
</div>
<div>
  presets:
  <a href="/turtle/{toBase64JSON({ path: TurtleTest, delta: 90, distance: 20 })}">Turtle Test</a>
  <a href="/turtle/{toBase64JSON({ path: KochKurve, delta: 90, distance: 10 })}">Koch Kurve n=1</a>
  <a href="/turtle/{toBase64JSON({ path: Sierpinski, delta: 60, distance: 6 })}">wrong Sierpinski</a
  >
</div>

<style>
  /* h2 {
		text-align: center;
		margin: 0em auto 1em auto;
	} */
  article {
    display: flex;
    flex-direction: row;
    justify-content: space-around;
  }

  article > * {
    margin: 1em;
  }

  canvas {
    background-color: rgb(42, 166, 238);
    box-shadow: 0.2em 0.2em 4em lightblue, -0.2em -0.2em 4em lightgreen;
    margin: 2em auto;
    padding: 0;
  }

  ul {
    list-style: none;
    margin: 2em auto;
  }
</style>
