/**
 * @description       : Component for displaying a list of accounts and retrieving Contacts
 * @author            : Rodrigo Balbi - Oktana
 * @group             : 
 * @last modified on  : 05-05-2022
 * @last modified by  : Rodrigo Balbi - Oktana
**/
import { LightningElement, wire, api, track } from 'lwc';
import getAllAccounts from '@salesforce/apex/AccountController.getAllAccounts';
import getContactsRelatedToAccount from '@salesforce/apex/ContactController.getContactsRelatedToAccount';
export default class AccountList extends LightningElement {
    accounts;
    errorMessage;
    hasError;
    isLoading;
    @track currentRecordSelected;
    hasRecordSelected = false;
    displayColumns = [
        {label: 'Account Name', fieldName: 'accountName'}
    ];
    contactList = [];
    hasContacts;
    hasContactError;
    contactError;

    /**
        @description: Constructor for LWC and listening to the event dispatched when an account is selected
    */
    constructor(){
        super();
        this.template.addEventListener('accountselected', this.handleOnClickEvent.bind(this));
    }

    /**
        @description: Retrieving all Accounts when the LWC loads
    */
    connectedCallback() {
        this.isLoading = true;
        this.hasError = false;
        getAllAccounts()
        .then(
            (response) => {
                this.accounts = response;
            }
        )
        .catch(
            (error) => {
                this.hasError = true;
                this.errorMessage = error;
            }
        )
        .finally(
            () => {
                this.isLoading = false;
            }
        )
    }

    /**
        @description: Handling event when an Account is selected
    */
    handleOnClickEvent(event){
        this.currentRecordSelected = [];
        this.hasContactError = false;
        this.contactError = '';
        const accountInfo = event.detail;
        this.currentRecordSelected.push(accountInfo.accountId);
        this.hasRecordSelected = true;
        this.retrieveContacts();
    }

    /**
        @description: Call to Apex method for retrieving the Contacts related to an Account
    */
    retrieveContacts() {
        this.isLoading = true;
        if(this.currentRecordSelected != null && this.currentRecordSelected != [] && this.hasRecordSelected){
            getContactsRelatedToAccount({accountIds: this.currentRecordSelected})
            .then(
                (response) => {
                    this.contactList = response;
                    this.hasContacts = response.length > 0;
                    if(!this.hasContacts){
                        this.hasContactError = true;
                        this.contactError = 'There are no contact to display';
                    }
                }
            )
            .catch(
                (error) => {
                    this.hasContactError = true;
                    this.contactError = error;
                }
            )
            .finally(
                () => {
                    this.isLoading = false;
                }
            )
        }
        this.isLoading = false;
    }
}