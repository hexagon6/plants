<script>
	// @ts-nocheck
	import { onMount } from 'svelte'
	import { page } from '$app/stores'

	import { canvasTurtle as turtle, allowedStrings } from '$lib/turtle.js'

	let width = 400
	let height = 400
	let canvas
	let c

	$: path = $page.url.searchParams.get('path') || 'FFF-FF-F-F+F+FF-F-FFF'
	$: δ = $page.url.searchParams.get('delta') || 90
	$: d = $page.url.searchParams.get('distance') || 20
	$: doClear = false

	// 'F-F-F+F+F' // -F-F+F+F+F+f-F'
	onMount(async () => {
		c = canvas.getContext('2d')
	})

	$: turtle({ c, X: canvas?.width, Y: canvas?.height })({ δ, d, doClear })(path)
</script>

<svelte:head>
	<title>Turtle Playground</title>
</svelte:head>

<canvas bind:this={canvas} {width} {height} />
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
			<input bind:value={path} type="text" />
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
</ul>

<style>
	h2 {
		text-align: center;
		margin: 0em auto 1em auto;
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
