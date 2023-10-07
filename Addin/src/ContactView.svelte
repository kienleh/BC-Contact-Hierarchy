<script>
	export let contact;

	$: {
		console.log(contact);
    }

    /*****
	* contact lookup BC
	******/
	function bcLookup(contactNo) {
        console.log("Lookup Contact: " + contactNo);
        Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('LookupContact', [contactNo]);
	}
</script>

<div>
    <button class="ContactButton" on:click="{bcLookup(contact.contactNo)}">
        {#if contact.contactType === 0}
            <span class="CompanyHeader">{contact.contactNo} {contact.contactName}</span>
        {:else}
            <span>{contact.contactName}</span>
        {/if}
    </button>

    {#if contact.hasOwnProperty('persons')}
        {#each contact.persons as person}
            <div class="PersonBox">
                <svelte:self contact={person}></svelte:self>
            </div>
        {/each}
    {/if}

    {#if contact.hasOwnProperty('parentContact')}
        <div class="ParentBox">
            <svelte:self contact={contact.parentContact}></svelte:self>
        </div>
    {/if} 
</div>

<style>
    .ParentBox {
        padding-left: 10px;
    }

    .PersonBox {
        padding-left: 15px;
    }

    .CompanyHeader {
        font-weight: bold;
    }

    .ContactButton {
		background: none!important;
		border: none;
		padding: 0!important;
		/*input has OS specific font-family*/
		color: rgb(80, 92, 109) !important;
		/* text-decoration: underline; */
		cursor: pointer;
	}

    .ContactButton:hover {
        background: none!important;
		border: none;
		padding: 0!important;
		/*input has OS specific font-family*/
		color: rgb(80, 92, 109) !important;
		text-decoration: underline;
		cursor: pointer;
    }
</style>