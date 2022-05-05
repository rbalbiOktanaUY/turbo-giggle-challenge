/**
 * @description       : Controller for retrieving Accounts
 * @author            : Rodrigo Balbi - Oktana
 * @group             : 
 * @last modified on  : 05-05-2022
 * @last modified by  : Rodrigo Balbi - Oktana
**/
public with sharing class AccountController {

    /**
        @description: Retrieves all the Accounts
        @returns: A list of AccountWrapper
    */
    @AuraEnabled(cacheable=true)
    public static List<AccountWrapper> getAllAccounts(){
        List<AccountWrapper> allAccountWrappers = new List<AccountWrapper>();
        try {
            for(Account theAccount : [
                    SELECT Id, Name
                    FROM Account
                    WITH SECURITY_ENFORCED
                ]
            ){
                allAccountWrappers.add(new AccountWrapper(theAccount));
            }
        } catch(Exception theException){
            throw theException;
        }
        return allAccountWrappers;
    }

    /**
        @description: A Wrapper for Account
    */
    public class AccountWrapper{
        @AuraEnabled
        public Id accountId {get;set;}
        @AuraEnabled
        public String accountName {get;set;}
        @AuraEnabled
        public String recordUrl {get;set;}

        public AccountWrapper(Account theAccount){
            this.accountId = theAccount.Id;
            this.accountName = theAccount.Name != null ? theAccount.Name : '';
            this.recordUrl = '/'+theAccount.Id;
        }
    }
}