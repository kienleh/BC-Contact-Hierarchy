import App from './App.svelte';

var app = new App({
	target: document.getElementById('contactParentAddin'),
	props: {
		contacts: JSON.parse('{"contactNo":"KT000257","contactName":"Company","contactType":0,"persons":[]}')
	}
});

export default app;