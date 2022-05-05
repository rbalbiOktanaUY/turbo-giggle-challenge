/**
 * @description       : A handler for Opportunity Trigger
 * @author            : Rodrigo Balbi - Oktana
 * @group             : 
 * @last modified on  : 05-05-2022
 * @last modified by  : Rodrigo Balbi - Oktana
**/
public with sharing class OpportunityTriggerHandler {

    /**
        @description: A set of Account Ids related to the Opportunities
    */
    private Set<Id> accountIds;

    /**
        @description: Main method for running the trigger
    */
    public void run(){
        this.accountIds = new Set<Id>();
        if((Trigger.isAfter && Trigger.isUpdate) || (Trigger.isBefore && Trigger.isDelete)){
            runTriggerInsertOrDelete();
        }
    }

    /**
        @description: Retrieve the Account Ids related to the Opportunities
    */
    private void retriveAccountIds(){
        if(this.accountIds == null){
            this.accountIds = new Set<Id>();
        }
        for(SObject theRecord : Trigger.new){
            Opportunity theOpportunity = (Opportunity)theRecord;
            if(theOpportunity.AccountId != null){
                this.accountIds.add(theOpportunity.AccountId);
            }
        }
    }

    /**
        @description: Retrieves all the Accounts
        @returns: A Map of Account Ids and Accounts
    */
    private Map<Id, Account> retrieveAccounts(){
        Map<Id, Account> accountsRetrieved = new Map<Id, Account>();
        if(this.accountIds != null && !this.accountIds.isEmpty()){
            for(Account theAccount : [
                SELECT Id,
                       Total_Sales_Standard_Wood__c,
                       Total_Sales_Recycled_Wood__c
                FROM Account
                WHERE Id = :this.accountIds
                WITH SECURITY_ENFORCED
            ]){
                accountsRetrieved.put(theAccount.Id, theAccount);
            }
        }
        return accountsRetrieved;
    }

    /**
        @description: Based on the criteria for Opportunity, updates the Account fields
    */
    private void updateAccountFields(){
        Map<Id, Account> accountsRetrieved = retrieveAccounts();
        List<Account> accountsToUpdate = new List<Account>();

        for(SObject theRecord : Trigger.new){
            Opportunity theOpportunity = (Opportunity)theRecord;
            if(theOpportunity.AccountId != null && accountsRetrieved.containsKey(theOpportunity.AccountId)){
                Account theAccount = accountsRetrieved.get(theOpportunity.AccountId);
                Boolean rollUpUpdated = false;
                if(theOpportunity.Wood_Type__c.equals(Constants.WOOD_TYPE_STANDARD)){
                    if(Trigger.isAfter && Trigger.isUpdate){
                        theAccount.Total_Sales_Standard_Wood__c = theAccount.Total_Sales_Standard_Wood__c + 1;
                    } else if(Trigger.isBefore && Trigger.isDelete){
                        theAccount.Total_Sales_Standard_Wood__c = theAccount.Total_Sales_Standard_Wood__c - 1;
                    }
                    rollUpUpdated = true;
                } else if(theOpportunity.Wood_Type__c.equals(Constants.WOOD_TYPE_RECYCLED)){
                    if(Trigger.isAfter && Trigger.isUpdate){
                        theAccount.Total_Sales_Recycled_Wood__c = theAccount.Total_Sales_Recycled_Wood__c + 1;
                    } else if(Trigger.isBefore && Trigger.isDelete){
                        theAccount.Total_Sales_Recycled_Wood__c = theAccount.Total_Sales_Recycled_Wood__c - 1;
                    }
                    rollUpUpdated = true;
                }
                if(rollUpUpdated){
                    accountsToUpdate.add(theAccount);
                }
            }
        }

        if(!accountsToUpdate.isEmpty()){
            update accountsToUpdate;
        }
    }

    /**
        @description: Performs actions when the Trigger is Inserting or
                      Deleting and Opportunity 
    */
    private void runTriggerInsertOrDelete(){
        retriveAccountIds();
        updateAccountFields();
    }
}
