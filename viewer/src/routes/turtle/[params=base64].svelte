<script context="module">
  import { Buffer } from 'buffer'
  const fromBase64JSON = (/** @type string */ b) =>
    b ? JSON.parse(Buffer.from(b, 'base64').toString()) : {}
  // @ts-ignore
  export async function load({ params: { params } }) {
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
    return { props: { degree, distance, path: newPath() } }
  }
</script>

<script>
  import LSystem from 'lindenmayer'
  import SvgRenderer from '$lib/components/SVGRenderer.svelte'
  import CanvasRenderer from '$lib/components/CanvasRenderer.svelte'
  import { allowedStrings } from '$lib/turtle.js'
  import { KochKurve, TurtleTest, Sierpinski } from '$lib/renderpaths.js'

  const toBase64JSON = (
    /** @type {{ path?: string; degree: number; distance: number; lsystem?: {
    axiom: string; productions: object; n: number;
  } }} */ o,
  ) => Buffer.from(JSON.stringify(o)).toString('base64')

  // [[SL,SR,SL].join('-'), [SR,SL,SR].join('+'), [SL,SR,SL].join('-')].join('-')
  let width = 1200
  let height = width
  $: renderMode = 'canvas'

  export let path = 'F-F+F+FF-F-F+F'
  export let degree = 90
  export let distance = 20

  $: δ = degree
  $: d = distance
  $: doClear = true
</script>

<svelte:head>
  <title>Turtle Playground</title>
</svelte:head>

<article>
  <div style="margin: 4em;">
    {#if renderMode == 'canvas'}
      <CanvasRenderer {height} {width} degree={δ} distance={d} {path} {doClear} />
    {:else if renderMode == 'svg'}
      <SvgRenderer {height} {width} degree={δ} distance={d} {path} />
    {/if}
  </div>
</article>

<ul>
  <li>
    action symbols:
    <code>
      {allowedStrings}
    </code>
  </li>
  <li>
    <label
      >turtle path
      <textarea bind:value={path} />
      <!-- style={`height: ${Math.max(path.length / 100, 100)}px; word-wrap: wrap;`} -->
      <span style="color: grey; margin: 0.5em;">
        {path.length} symbols
      </span>
    </label>
  </li>
  <lh>turtle parameters</lh>
  <li>
    <label>
      δ: {δ}
      <input bind:value={δ} type="range" min="0" max="359" />
    </label>
    <label>
      d: {d}
      <input bind:value={d} type="range" min="1" max="50" />
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
    {#if renderMode === 'canvas'}
      <label>
        clear canvas before drawing
        <input bind:checked={doClear} type="checkbox" />
      </label>
    {/if}
  </li>
</ul>
<div>
  current settings:
  <a href="/turtle/{toBase64JSON({ path, degree: δ, distance: d })}">Share this link</a>
</div>
<div>
  presets:
  <a href="/turtle/{toBase64JSON({ path: TurtleTest, degree: 90, distance: 20 })}">Turtle Test</a>
  <a href="/turtle/{toBase64JSON({ path: KochKurve, degree: 90, distance: 10 })}">Koch Kurve n=1</a>
  <a href="/turtle/{toBase64JSON({ path: Sierpinski, degree: 60, distance: 6 })}"
    >wrong Sierpinski</a
  >
</div>

<style>
  /* h2 {
		text-align: center;
		margin: 0em auto 1em auto;
	} */
  article {
    display: flex;
    flex-direction: column;
    justify-content: space-around;
  }

  article > * {
    margin: 1em;
  }

  label {
    display: flex;
    justify-content: center;
    align-items: center;
    margin: 1em auto;
    padding: 0.5em;
    width: 100%;
    border-radius: 0.5em;
  }

  label:hover {
    box-shadow: 0 0 2em rgba(1, 1, 1, 0.2);
  }

  ul {
    list-style: none;
    margin: 2em auto;
  }

  li {
    margin: 0.2em 0;
  }

  textarea {
    width: 100%;
    height: 200px;
  }
</style>
