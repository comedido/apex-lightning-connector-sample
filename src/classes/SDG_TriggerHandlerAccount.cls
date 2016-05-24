/**********************************************************************************
* @author       JVN - josep@clappsolutions.com - www.clappsolutions.com
* @date         19 June 2015
* @description  Trigger handler Class for the corresponding entity.
*               Best practice:
*                   - User singleton pattern.
*                   - Order of execution control.
*                   - Correct use of Trigger.new, Trigger.old, Trigger.newMap, Trigger.oldMap
*                   - Easy to know WHEN something is happening.
*                   - Easy to learn, use and mantain.
*                   - Chaos-avoider
* @Revision     
**********************************************************************************/
public class SDG_TriggerHandlerAccount {

    //-- CONSTRUCTOR
    /**
     * It must be instantiated using singleton pattern.
     */
    private SDG_TriggerHandlerAccount() {
        this.logicAccount = SDG_LogicAccount.getInstance();
    }

    //-- ATTRIBUTES
    //Logic link
    private SDG_LogicAccount logicAccount;

    //-- SINGLETON PATTERN
    /**
     * Instance is only instantiate once per request (thread).
     */
    private static SDG_TriggerHandlerAccount instance;
    public static SDG_TriggerHandlerAccount getInstance() {
        if (instance == null) instance = new SDG_TriggerHandlerAccount();
        return instance;
    }

    //-- HANDER METHODS
    /**
     * Handles before insert event.
     *
     * @param {@code List<Account>} newList
     */
    public void onBeforeInsert(final List<Account> newList) {
        
    }

    /**
     * Handles after insert event.
     *
     * @param {@code List<Account>} newList
     * @param {@code Map<Id, Account>} newMap
     */
    public void onAfterInsert(final List<Account> newList, final Map<Id, Account> newMap) {

    }

    /**
     * Handles before update event.
     *
     * @param {@code List<Account>} oldList
     * @param {@code Map<Id, Account>} oldMap
     * @param {@code List<Account>} newList
     * @param {@code Map<Id, Account>} newMap
     */
    public void onBeforeUpdate(final List<Account> oldList, final Map<Id, Account> oldMap,
                               final List<Account> newList, final Map<Id, Account> newMap) {
        this.logicAccount.renameContacts(newMap, oldMap);
    }

    /**
     * Handles after update event.
     *
     * @param {@code List<Account>} oldList
     * @param {@code Map<Id, Account>} oldMap
     * @param {@code List<Account>} newList
     * @param {@code Map<Id, Account>} newMap
     */
    public void onAfterUpdate(final List<Account> oldList, final Map<Id, Account> oldMap,
                              final List<Account> newList, final Map<Id, Account> newMap) {

    }

    /**
     * Handles before delete event.
     *
     * @param {@code List<Account>} oldList
     * @param {@code Map<Id, Account>} oldMap
     */
    public void onBeforeDelete(final List<Account> oldList, final Map<Id, Account> oldMap) {

    }

    /**
     * Handles before delete event.
     *
     * @param {@code List<Account>} oldList
     * @param {@code Map<Id, Account>} oldMap
     */
    public void onAfterDelete(final List<Account> oldList, final Map<Id, Account> oldMap) {

    }

    /**
     * Handles after undelete event.
     *
     * @param {@code List<Account>} newList
     */
    public void onAfterUndelete(final List<Account> newList) {

    }    
}