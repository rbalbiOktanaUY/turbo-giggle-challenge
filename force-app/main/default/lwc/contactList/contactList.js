/**
 * @description       : LWC for displaying Contacts
 * @author            : Rodrigo Balbi - Oktana
 * @group             : 
 * @last modified on  : 05-05-2022
 * @last modified by  : Rodrigo Balbi - Oktana
**/
import { LightningElement, api } from 'lwc';

export default class ContactList extends LightningElement {
    @api listContactsRelated;
    @api hasContacts;
    @api hasError;
    @api errorMessage;
    displayColumns = [
        {label: 'Contact Name', fieldName: 'contactName'}
    ];
}