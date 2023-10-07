This is an extension for [Microsoft Dynamics 365 Business Central](https://dynamics.microsoft.com/en-us/business-central/overview/). It adds an functionality to build parent-child relations between company contacts. Therefore an new field *Parent Company No.* is added to the contact table where you can enter the related contact no.

![contact card with highlighted field parent company no.](.asset/contact_card.png)

The extension also adds two custom control addins which display the related contacts in a tree. The first one displays all parent and child related contacts for the selected contact in the contact list.

![new control addin in factbox which shows all related contacts](.asset/factbox_all_relations.png)

The second displays the parent relations only.

![new control addin in factbox which shows parent related contacts](.asset/factbox_parent_relations.png)

You can open all related contact cards (company, person) by clicking on them in the tree.

![Factbox click to open contact card](.asset/factbox_select_contact.png)

The custom control addins are written in javascript with the help of the svelte framework. Sources for the addins are provided in this project in the [Addin](./Addin) and [TreeAddin](./TreeAddin) folders.