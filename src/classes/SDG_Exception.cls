/**********************************************************************************
* @author       JVN - josep@clappsolutions.com - www.clappsolutions.com
* @date         19 June 2015
* @description  A set of custom Exception classes.
*               Best practice:
*                   - Use Inner Classes for Exceptions.
*                   - Avoid having a lot of Apex Custom Exception (classes).
*                   - Avoid dispersion. All Exceptions are under [namespace]_Exception.
*                   - Easy to find and mantain.
* @Revision     
**********************************************************************************/
public class SDG_Exception extends Exception {

    //-- CUSTOM EXCEPTION
    /**
     * Custom exception for DtoMeetup unexpected situations.
     */
    public class DtoMeetupException extends Exception {}

    /**
     * Custom exception for ServiceRestMeetup unexpected situations.
     */
    public class RestMeetupException extends Exception {}
}