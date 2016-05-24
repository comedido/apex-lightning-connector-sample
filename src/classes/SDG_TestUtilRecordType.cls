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
@IsTest
private class SDG_TestUtilRecordType {

    //-- TEST METHODS
    @IsTest static void testGetRtId() {
        //-- 1. Prepare data

        //-- 2. Do test
        Test.startTest();
        Test.stopTest();

        //-- 3. Assertions
    }
}