/**
 * @description       : Component for displaying a list of accounts
 * @author            : Rodrigo Balbi - Oktana
 * @group             : 
 * @last modified on  : 04-27-2022
 * @last modified by  : Rodrigo Balbi - Oktana
**/
import { LightningElement, wire, api, track } from 'lwc';
import getAllAccounts from '@salesforce/apex/AccountController.getAllAccounts';
export default class AccountList extends LightningElement {
    accounts;
    errorMessage;
    hasError;
    isLoading;

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

}