<svelte:options accessors={true} />

<script>
	import ContactHierarchyView from './ContactHierarchyView.svelte';

	export let contact;
	let sourceContactNo = '';

	$: {
		if (contact.hasOwnProperty('sourceContactNo')) {
			sourceContactNo = contact.sourceContactNo;
		}
	}
</script>

<div class="GlobalAppFont" style="height: 300px; overflow-y: auto;">
	<ContactHierarchyView contact={contact} sourceContactNo={sourceContactNo} />
</div>

<style>
	.GlobalAppFont {
		font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen-Sans, Ubuntu, Cantarell, "Helvetica Neue", sans-serif;
		font-size: small;
	}
</style>