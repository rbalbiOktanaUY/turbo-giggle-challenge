/**
 * @description       : Trigger for Opportunity
 * @author            : Rodrigo Balbi - Oktana
 * @group             : 
 * @last modified on  : 05-05-2022
 * @last modified by  : Rodrigo Balbi - Oktana
**/
trigger OpportunityTrigger on Opportunity (after insert, before delete) {
    OpportunityTriggerHandler theHandler = new OpportunityTriggerHandler();
    theHandler.run();
}