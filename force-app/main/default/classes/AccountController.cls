/**
 * @description       : Controller for retrieving Accounts
 * @author            : Rodrigo Balbi - Oktana
 * @group             : 
 * @last modified on  : 04-27-2022
 * @last modified by  : Rodrigo Balbi - Oktana
**/
public with sharing class AccountController {
    
    @AuraEnabled(cacheable=true)
    public static List<Account> getAllAccounts(){
        List<Account> allAccounts = new List<Account>();
        try {
            allAccounts.addAll(
                [
                    SELECT Id, Name
                    FROM Account
                    WITH SECURITY_ENFORCED
                ]
            );
        } catch(Exception theException){
            throw theException;
        }
        return allAccounts;
    }
}