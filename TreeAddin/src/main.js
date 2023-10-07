import App from './App.svelte';

var app = new App({
	target: document.getElementById('contactTreeAddin'),
	props: {
		contact: JSON.parse('{"contactNo":"KT000258","contactName":"Firma 1","contactType":0,"persons":[],"children":[{"contactNo":"KT000259","contactName":"Firma 2","contactType":0,"persons":[],"children":[]},{"contactNo":"KT000260","contactName":"Firma 3","contactType":0,"persons":[],"children":[{"contactNo":"KT000261","contactName":"Firma 4","contactType":0,"persons":[],"children":[]}]}],"sourceContactNo":"KT000259"}')
	}
});

export default app;