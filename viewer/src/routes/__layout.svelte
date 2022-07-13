<nav>
  <a href="/">Home</a>
  <a href="/turtle/eyJwYXRoIjoiRkZGLUZGLUYtRitGK0ZGLUYtRkZGIiwiZGVsdGEiOjkwLCJkaXN0YW5jZSI6MjB9"
    >Turtle Playground</a
  >
  <a href="/l-system">L-System Playground</a>
  <a href="/axial-tree">Axial tree</a>
  <a href="/about">About</a>
</nav>

<main
  style="display: flex; flex-flow: column; margin: 0 auto;
    background: var(--bright)"
>
  <div>
    <slot />
  </div>
</main>

<style>
  nav {
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: space-evenly;
    margin: 0 auto;
    padding: 0.4em 1em;
    background: var(--medium);
  }

  nav > a {
    color: var(--black);
    border-radius: 0.5em;
    text-decoration: none;
    padding: 0.5em 1em;
    margin: 0 auto;
    box-shadow: 0.25em 0.25em 0.25em var(--dark), -0.1em -0.1em 0.1em var(--alternate);
    transition: all ease-in-out 0.5s;
  }
  nav > a:hover {
    border: 1px solid var(--alternate);
    color: var(--alternate);
    background: var(--dark);
    border: 2em;
    box-shadow: 0.25em 0.25em 0.25em var(--black), -0.1em -0.1em 0.1em var(--bright);
  }

  main > div {
    margin: 1em auto;
  }
</style>
