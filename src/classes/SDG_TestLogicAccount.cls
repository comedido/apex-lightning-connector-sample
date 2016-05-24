/**********************************************************************************
* @author       JVN - josep@clappsolutions.com - www.clappsolutions.com
* @date         19 June 2015
* @description  A set of unit tests methods for the corresponding class.
*               Best practice:
*                   - Avoid @SeeAllData=true
*                   - Unit test is UNIT. Don NOT test more than one business logic
*                     within the same test method.
*                   - ALWAYS use "Test.startTest()" and "Test.stopTest()".
*                   - Keep things simple. Only 3 main parts:
*                       - 1. Prepare data
*                       - 2. Do test
*                       - 3. Assertions
* @Revision     
**********************************************************************************/
@IsTest(seeAllData = false)
private class SDG_TestLogicAccount {

    //-- TEST METHODS
    @IsTest static void testRenameContacts() {
        //-- 1. Prepare data
        //Get data preparation instance
        final SDG_TestData testing = SDG_TestData.getInstance();

        //Create accounts
        final List<Account> accountsList = testing.newAccounts(200);
        insert accountsList;

        //Create contacts
        final List<Contact> contactsList = testing.newContacts(accountsList);
        insert contactsList;

        //Deactivate accounts
        for (Account account : accountsList) {
            account.Active__c = false;
        }

        //-- 2. Do test
        Test.startTest();
        update accountsList;
        Test.stopTest();

        //-- 3. Assertions
        final List<Contact> result = [select Id, FirstName, LastName from Contact where Account.Active__c = false];
        System.assertEquals(200, result.size());
        for (Contact contact : result) {
            System.assert(
                contact.FirstName.startsWith(SDG_LogicAccount.INACTIVE_PREFIX),
                'contact.FirstName does not start with "' + SDG_LogicAccount.INACTIVE_PREFIX + '": ' + contact.FirstName
            );
        }
    }
}