// import adapter from '@sveltejs/adapter-auto';
import preprocess from 'svelte-preprocess'
import adapter_ipfs from 'sveltejs-adapter-ipfs'

/** @type {import('@sveltejs/kit').Config} */
const config = {
	preprocess: preprocess(),
	kit: {
		adapter: adapter_ipfs({
			removeBuiltInServiceWorkerRegistration: true,
			injectPagesInServiceWorker: true,
		}),
	},
}

export default config
