/**********************************************************************************
* @author       JVN - josep@clappsolutions.com - www.clappsolutions.com
* @date         15 September 2015
* @description  Controller class for Meetup Lightning page.
* @Revision     
**********************************************************************************/
public with sharing class SDG_CtrlMeetupLightning {

	//-- CONSTANTS
	/**
	 * Barcelona SDG group name. TODO: use custom setting.
	 */
	private static final String SDG_BARCELONA_GROUP_NAME = 'Barcelona-Salesforce-Developer-Group';

	//-- CONSTRUCTOR
	/**
	 * Default constructor.
	 */
	public SDG_CtrlMeetupLightning() {
		
	}

	//-- AURA METHODS
	/**
	 * Finds the Barcelona Salesforce Dev Group.
	 * 
	 * @return {@code String} the Barcelona SDG group (JSON format). Null otherwise.
	 */
    @AuraEnabled
    public static String findBarcelonaSdgGroup() {
        SDG_DtoMeetup.GroupResult groupResult = SDG_ServiceRestMeetup.getInstance().findGroup(SDG_BARCELONA_GROUP_NAME);

        return (
        	groupResult != null && groupResult.results != null && !groupResult.results.isEmpty() ?
        		JSON.serialize(groupResult.results[0]) :
        		''
        );
    }

	/**
	 * Finds the events on a Meetup group.
	 * 
	 * @param groupId {@code String} the id of the group.
	 * @return {@code String} the events from the group (JSON format). Null otherwise.
	 */
    @AuraEnabled
    public static String findEvents(final String groupId) {
        SDG_DtoMeetup.EventResult eventResult = SDG_ServiceRestMeetup.getInstance().findEvents(groupId);

        return (
        	eventResult != null && eventResult.results != null && !eventResult.results.isEmpty() ?
        		JSON.serialize(eventResult.results) :
        		''
        );
    }
}