<script>
	// @ts-nocheck

	import LSystem from 'lindenmayer'
	import { tree1, koch } from '$lib/l-systems.js'

	const examples = [tree1, koch]

	$: id = 0
	$: iterations = 1
	$: axiom = examples[id].axiom
	$: productions = examples[id].productions

	$: lsystem = new LSystem({
		axiom,
		productions,
	})

	const change = value => {
		iterations += value
	}
</script>

<div>L-System</div>
<select bind:value={id}>
	{#each examples as e}
		<option value={e.id}>{e.name}</option>
	{/each}
</select>
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
