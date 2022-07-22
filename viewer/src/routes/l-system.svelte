<script>
  // @ts-nocheck
  import { onMount } from 'svelte'
  import LSystem from 'lindenmayer'
  import { branchA, branchB, branchC, branchD, koch } from '$lib/l-systems.js'

  const examples = [koch, branchA, branchB, branchC, branchD]
  let lsystem = ''

  $: id = 0
  $: iterations = 1
  $: axiom = examples[id].axiom
  $: productions = examples[id].productions
  $: degree = examples[id].degree ?? 90

  $: lsystem = new LSystem({
    axiom,
    productions,
  })

  const change = value => {
    iterations = parseInt(iterations, 10) + value
    console.log({ value })
    if (iterations > lsystems.length) {
      iterate()
    }
  }

  let lsystems = []

  const iterate = () => {
    const l = lsystem.iterate()
    lsystems = [...lsystems, l]
  }

  onMount(() => {
    iterate()
  })
</script>

<div>L-System</div>
<select bind:value={id}>
  {#each examples as e}
    <option value={e.id}>{e.name}</option>
  {/each}
</select>
<div>
  <label for="axiom">axiom</label>
  <input id="axiom" bind:value={axiom} type="textarea" width="100%" />
</div>
<div>
  <ul>
    <lh>productions:</lh>
    {#each Object.entries(productions) as [k, production]}
      <li>
        <label for={`key_${k}`}>{k}</label>
        <input id={`key_${k}`} value={production()} />
        <span style="color: grey; margin: 0.5em;">
          {production().length} symbols
        </span>
      </li>
    {/each}
  </ul>
</div>
<div style="display: flex; flex-direction: row;">
  <label for="iterations">iterations</label>
  <input id="iterations" bind:value={iterations} />
  <button on:click={() => change(-1)}>-</button>
  <button on:click={() => change(1)}>+</button>
</div>
<div style="display: flex; flex-direction: column;">
  {#each lsystems as l, i}
    <span>{i + 1}. iteration</span>
    <textarea style={`height: ${Math.ceil(l.length / 120)}em`}>{l}</textarea>
    <span style="color: grey; margin: 0.5em;">
      {l.length} symbols
    </span>
    <br />
  {/each}
</div>

<style>
  lh {
    font-weight: 800;
  }
  ul {
    list-style: none;
  }
  input {
    min-width: 2em;
  }
  textarea {
    min-width: 40em;
    width: 80vw;
    min-height: 1.5em;
  }
</style>
