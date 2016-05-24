/**********************************************************************************
* @author       JVN - josep@clappsolutions.com - www.clappsolutions.com
* @date         19 June 2015
* @description  A set of definition methods to interact with Meetup.
*               Best practice:
*                   - Only use interfaces when they are necessary.
*					- Focus on productivity.
*					- In Apex, you:
*						- Will never have to implement persistence layer.
*						- Will never have more than one logic implementation.
*						- May have the need of having more than one implementation for a service.
*							- i.e.: rest/soap, v1/v2/vN, etc.
* @Revision     
**********************************************************************************/
public interface SDG_ServiceMeetup {

    //-- SERVICE METHODS
    /**
     * Finds a Meetup Group.
     * 
     * @param {@code String} urlname
     * @return {@code SDG_DtoMeetup.GroupResult} 
     */
    SDG_DtoMeetup.GroupResult findGroup(final String urlname);

    /**
     * Finds a Meetup Events.
     * 
     * @param {@code String} groupId
     * @return {@code SDG_DtoMeetup.EventResult} 
     */
	SDG_DtoMeetup.EventResult findEvents(final String groupId);
}