/** @type {import('@sveltejs/kit').ParamMatcher} */
export function match(param) {
  return /^[A-Za-z0-9+/]+={0,2}$/.test(param)
}
