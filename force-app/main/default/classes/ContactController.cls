/**
 * @description       : A controller for Contacts
 * @author            : Rodrigo Balbi - Oktana
 * @group             : 
 * @last modified on  : 05-05-2022
 * @last modified by  : Rodrigo Balbi - Oktana
**/
public with sharing class ContactController {

    /**
        @description: Retrieves all the Contacts related to an Account
        @parameter accountIds: A list of Account Ids
        @returns: A list of ContactWrapper
    */
    @AuraEnabled(cacheable=true)
    public static List<ContactWrapper> getContactsRelatedToAccount(List<Id> accountIds){
        List<ContactWrapper> allContactWrappers = new List<ContactWrapper>();
        if(accountIds != null){
            try {
                for(Contact theContact : [
                        SELECT Id, AccountId, Name
                        FROM Contact
                        WHERE AccountId = :accountIds
                        WITH SECURITY_ENFORCED
                    ]
                ){
                    allContactWrappers.add(new ContactWrapper(theContact));
                }
            } catch(Exception theException){
                throw theException;
            }
        }
        return allContactWrappers ;
    }

    /**
        @description: A Wrapper for Contact
    */
    public class ContactWrapper{
        @AuraEnabled
        public Id contactId {get;set;}
        @AuraEnabled
        public String contactName {get;set;}
        @AuraEnabled
        public String recordUrl {get;set;}

        public ContactWrapper(Contact theContact){
            this.contactId = theContact.Id;
            this.contactName = theContact.Name != null ? theContact.Name : '';
            this.recordUrl = '/'+theContact.Id;
        }
    }
}
