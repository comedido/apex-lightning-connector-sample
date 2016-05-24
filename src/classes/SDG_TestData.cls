/**********************************************************************************
* @author       Clapps - info@clappsolutions.com - www.clappsolutions.com
* @date         21 June 2015
* @description  Test class for data initialization.
*               Best practice:
*                   - Code for data initialization easy to reuse.
*                   - Easy to mantain and adapt to any business need.
*                   - No panic when "Required" field is added to any SObject.
* @Revision     
**********************************************************************************/
@IsTest
public class SDG_TestData {

	//-- CONSTRUCTOR
    /**
     * Constructor has been set to private to enforce the use of singleton pattern.
     */
	private SDG_TestData() { }

	//-- SINGLETON PATTERN
    /**
     * Instance is only instantiate once per request (thread).
     */
	private static SDG_TestData instance;
	public static SDG_TestData getInstance() {
		if (instance == null) instance = new SDG_TestData();
		return instance;
	}

	//-- DATA PREPARATION METHODS
	/**
	 * Creates an Account.
	 */
	public Account newAccount(final String variant) {
		return new Account(
			Name = 'Test Account ' + variant,
			Active__c = true
		);
	}

	/**
	 * Creates a List of Accounts.
	 */
	public List<Account> newAccounts(final Integer num) {
		final List<Account> theList = new List<Account>();
		for (Integer i=0; i<num; i++) {
			theList.add(
				this.newAccount(String.valueOf(num))
			);
		}
		return theList;
	}

	/**
	 * Creates a Contact.
	 */
	public Contact newContact(final String variant, final Id accountId) {
		return new Contact(
	        LastName = 'Test Last Name ' + variant,
	        AccountId = accountId
		);
	}

	/**
	 * Creates a List of Contacts.
	 */
	public List<Contact> newContacts(final Integer num, final Id accountId) {
		final List<Contact> theList = new List<Contact>();
		for (Integer i=0; i<num; i++) {
			theList.add(
				this.newContact(String.valueOf(num), accountId)
			);
		}
		return theList;
	}

	/**
	 * Creates one Contact per Account.
	 */
	public List<Contact> newContacts(final List<Account> accountsList) {
		final List<Contact> theList = new List<Contact>();
        for (Integer i=0; i<accountsList.size(); i++) {
            theList.add(
				this.newContact(String.valueOf(i), accountsList.get(i).Id)
            );
        }
		return theList;
	}
}