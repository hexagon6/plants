<script>
	// @ts-nocheck

	import LSystem from 'lindenmayer'
	import { fromPairs, map } from 'ramda'
	$: iterations = 0
	$: axiom = 'F-F-F-F'
	let productions = { F: () => 'F-F+F+FF-F-F+F' }

	$: lsystem = new LSystem({
		axiom,
		productions,
	})

	const change = value => {
		iterations += value
	}
</script>

<div>L-System</div>
<div>
	<input bind:value={axiom} type="textarea" width="100%" />
</div>
<div>
	<ul>
		<lh>productions:</lh>
		{#each Object.entries(productions) as production}
			<li>
				{production}
			</li>
		{/each}
	</ul>
</div>
<input bind:value={iterations} />

<button on:click={() => change(-1)}>-</button>
<button on:click={() => change(1)}>+</button>
<div>
	<code>
		{#each Array.from({ length: iterations }).map((_, i) => i) as _}
			<input type="textarea" value={lsystem.iterate()} />
			<br />
		{/each}
	</code>
</div>

<style>
	lh {
		font-weight: 800;
	}
	ul {
		list-style: none;
	}
</style>
