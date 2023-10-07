<svelte:options accessors={true}/>
<script>
	import ParentContact from './ContactView.svelte';

	export let contacts;

	$: {
		//Event, wen nsich Daten ändern
    }
</script>

<div class="GlobalAppFont" style="height: 300px; overflow-y: auto;">
	<ParentContact contact={contacts} />
</div>

<style>
	.GlobalAppFont {
		font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen-Sans, Ubuntu, Cantarell, "Helvetica Neue", sans-serif;
		font-size: small;
	}
</style>