<script>
    export let contact;
    export let sourceContactNo;

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
            {#if contact.contactNo === sourceContactNo}
                <span class="CompanyHeaderSource">{contact.contactNo} {contact.contactName}</span>
            {:else}
                <span class="CompanyHeader">{contact.contactNo} {contact.contactName}</span>
            {/if}
        {:else}
            <span>{contact.contactName}</span>
        {/if}
    </button>

    {#if contact.hasOwnProperty('persons')}
        {#each contact.persons as person}
            <div class="PersonBox">
                <svelte:self contact={person} sourceContactNo={sourceContactNo}></svelte:self>
            </div>
        {/each}
    {/if}

    {#if contact.hasOwnProperty('children')}
        {#each contact.children as child}
            <div class="ParentBox">
                <svelte:self contact={child} sourceContactNo={sourceContactNo}></svelte:self>
            </div>
        {/each}
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

    .CompanyHeaderSource {
        font-weight: bold;
        color: brown;
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