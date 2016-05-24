/**********************************************************************************
* @author       JVN - josep@clappsolutions.com - www.clappsolutions.com
* @date         19 June 2015
* @description  Logic class for the corresponding entity.
*               Best practice:
*                   - Use Singleton Pattern.
*                   - ONLY implement logic in Logic clases.
*                   - For complex logics, use Helpers.
*                   - Use System.Limits class.
* @Revision     
**********************************************************************************/
public with sharing class SDG_LogicAccount {

    //-- CONSTANTS
    /**
     * Prefix to be added to a Contact when Account is not active.
     */
    public static final String INACTIVE_PREFIX = '[ACC INACTIVE]';

    //-- SINGLETON PATTERN
    /**
     * Instance is only instantiate once per request (thread).
     */
    private static SDG_LogicAccount instance;
    public static SDG_LogicAccount getInstance() {
        if (instance == null) instance = new SDG_LogicAccount();
        return instance;
    }

    //-- LOGIC METHODS
    /**
     * When an account is deactivated, rename the contacts by adding an 'inactive' prefix.
     * 
     * @param newMap {@code Map<Id, Account>} 
     * @param oldMap {@code Map<Id, Account>} 
     */
    public void renameContacts(final Map<Id, Account> newMap, final Map<Id, Account> oldMap) {
        //Contacts to update
        final List<Contact> contactsToUpdate = new List<Contact>();

        //Iterate over all Accounts
        //ONLY for demo porpuses. HERE you should query&iterate over Contact.
        for (Account account : [select Id, Active__c,
                                       (select Id, FirstName from Contacts)
                                from Account
                                where Id IN :newMap.keySet()]) {
            //Get curr account, NOT the one from DDBB
            Account currAccount = newMap.get(account.Id);

            //Iterate over all conctacts
            for (Contact contact : account.Contacts) {
                //Only if account IS NOT active and the value has changed
                if (!currAccount.Active__c && currAccount.Active__c != oldMap.get(account.Id).Active__c) {
                    contact.FirstName = (INACTIVE_PREFIX + contact.FirstName);
                    contactsToUpdate.add(contact);
                }
            }
        }

        //Update contacts
        if (!contactsToUpdate.isEmpty()) update contactsToUpdate;
    }

    /**
     * 
     * 
     * @param newMap {@code Map<Id, Account>} 
     * @param oldMap {@code Map<Id, Account>} 
     */
    public void changeOwner(final List<Account> newList, final Map<Id, Account> newMap) {
        //Group Accounts by Type
        final Map<String, List<Account>> accountsByType = new Map<String, List<Account>>();
        for (Account account : newList) {
            List<Account> theList = accountsByType.get(account.Type);
            if (theList == null) {
                theList = new List<Account>();
                accountsByType.put(account.Type, theList);
            }
            theList.add(account);
        }

        //Group opps by
        final Map<String, List<Opportunity>> oppsByType = new Map<String, List<Opportunity>>();
        for (Opportunity opp : [select Id, Type
                                from Opportunity
                                where Type IN :accountsByType.keySet() AND AccountId IN :newMap.keySet()]) {
            List<Opportunity> theList = oppsByType.get(opp.Type);
            if (theList == null) {
                theList = new List<Opportunity>();
                oppsByType.put(opp.Type, theList);
            }
            theList.add(opp);
        }

        //Logic here
    }

    //-- PRIVATE METHODS
    /**
     * 
     *
     * @return {@code Integer}
     */
    private static Integer getLimitQueryRows() {
        return Limits.getLimitQueryRows() - Limits.getQueryRows();
    }
}