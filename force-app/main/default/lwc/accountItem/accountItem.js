/**
 * @description       : LWC For displaying an Account and Dispatching the event when it is selected
 * @author            : Rodrigo Balbi - Oktana
 * @group             : 
 * @last modified on  : 05-05-2022
 * @last modified by  : Rodrigo Balbi - Oktana
**/
import { LightningElement, api } from 'lwc';

export default class AccountItem extends LightningElement {
    @api item;

    /**
        @description: Dispatching the event when the Account is selected (clicked)
    */
    handleClick(){
        const onClickEvent = new CustomEvent(
            'accountselected', {detail: this.item, bubbles: true}
        );
        this.dispatchEvent(onClickEvent);
    }
}