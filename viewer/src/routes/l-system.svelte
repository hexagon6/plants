<script>
  // @ts-nocheck
  import { Buffer } from 'buffer'
  import LSystem from 'lindenmayer'
  import { branchA, branchB, branchC, branchD, koch } from '$lib/l-systems.js'

  const examples = [koch, branchA, branchB, branchC, branchD]
  let lsystem = ''

  $: id = 0
  $: iterations = examples[id].n ?? 1
  $: axiom = examples[id].axiom
  $: productions = examples[id].productions
  $: degree = examples[id].degree ?? 90

  $: {
    lsystem = new LSystem({
      axiom,
      productions,
    })
    console.log(iterations)
    lsystem.iterate(iterations)
  }

  const change = value => {
    const newValue = parseInt(iterations, 10) + value
    iterations = newValue > 0 ? newValue : 1
  }

  const toBase64JSON = (
    /** @type {{ path: string; degree: number; distance: number; lsystem: {
    axiom: string; productions: object; n: number;
  } }} */ o,
  ) => Buffer.from(JSON.stringify(o)).toString('base64')

  $: link = toBase64JSON({
    degree,
    lsystem: {
      axiom,
      productions,
      n: iterations,
    },
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
        <input id={`key_${k}`} value={production} />
        <span style="color: grey; margin: 0.5em;">
          {production.length} symbols
        </span>
      </li>
    {/each}
  </ul>
</div>
<div style="display: flex; flex-direction: row;">
  <label for="iterations">iterations</label>
  <input id="iterations" bind:value={iterations} />
  <button disabled={iterations == 1 && 'disabled'} on:click={() => change(-1)}>-</button>
  <button disabled={lsystem?.getString().length >= 400000} on:click={() => change(1)}>+</button>
</div>
<div style="display: flex; flex-direction: column;">
  <div style="display: flex; flex-direction: row; justify-content: space-between;">
    <span>{iterations}. iteration</span>
    <a href={`turtle/${link}`}>Render</a>
    <span style="color: grey; margin: 0.5em;">
      {lsystem?.getString().length} symbols
    </span>
  </div>
  <textarea style={`height: ${Math.ceil(lsystem?.length / 100)}em`}>{lsystem.getString()}</textarea>
  <br />
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
