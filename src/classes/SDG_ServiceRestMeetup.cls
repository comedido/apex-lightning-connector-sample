/**********************************************************************************
* @author       JVN - josep@clappsolutions.com - www.clappsolutions.com
* @date         19 June 2015
* @description  Service class which contains all necessary methods to interact with Meetup.
* @Revision     
**********************************************************************************/
public class SDG_ServiceRestMeetup implements SDG_ServiceMeetup {

    //-- CONSTANTS
    //TODO: Use Custom Settings.
    /**
     * The private key. It belongs to a member.
     */
    private static final String MEETUP_KEY = '383c673c1462711c76265381967174b';

    //TODO: Use Custom Settings.
    /**
     * The meetup's url endpoint.
     */
    private static final String MEETUP_ENDPOINT = 'https://api.meetup.com/2';

    //-- CONSTRUCTOR
    /**
     * It must be instantiated using singleton pattern.
     */
    private SDG_ServiceRestMeetup() { }

    //-- SINGLETON PATTERN
    /**
     * Instance is only instantiate once per request (thread).
     */
    private static SDG_ServiceRestMeetup instance;
    public static SDG_ServiceRestMeetup getInstance() {
        if (instance == null) instance = new SDG_ServiceRestMeetup();
        return instance;
    }

    //-- SERVICE METHODS
    /** {@inheritDoc} */
    public SDG_DtoMeetup.GroupResult findGroup(final String urlname) {
        //-- PREVALIDATIONS
        if (String.isEmpty(urlname)) throw new SDG_Exception.RestMeetupException('"urlname" is empty.');

        //-- HTTP REQUEST
        final String resource = '/groups';
        final RestMethod restMethod = SDG_ServiceRestMeetup.RestMethod.GET;
        final Map<String, String> params = new Map<String, String>();
        params.put('group_urlname', urlname);

        //-- BUILD REQUEST
        HttpRequest request = this.getRestRequest(restMethod, resource, params);

        //-- SEND REQUEST
        final String responseBody = this.sendRequest(request);

        //-- PARSE & RETURN RESPONSE
        return SDG_DtoMeetup.parseGroupResult(responseBody);
    }

    /** {@inheritDoc} */
    public SDG_DtoMeetup.EventResult findEvents(final String groupId) {
        //-- PREVALIDATIONS
        if (String.isEmpty(groupId)) throw new SDG_Exception.RestMeetupException('"group_id" is empty.');

        //-- HTTP REQUEST
        final String resource = '/events';
        final RestMethod restMethod = SDG_ServiceRestMeetup.RestMethod.GET;
        final Map<String, String> params = new Map<String, String>();
        params.put('group_id', groupId);

        //-- BUILD REQUEST
        HttpRequest request = this.getRestRequest(restMethod, resource, params);

        //-- SEND REQUEST
        final String responseBody = this.sendRequest(request);

        //-- PARSE & RETURN RESPONSE
        return SDG_DtoMeetup.parseEventResult(responseBody);
    }

    //-- PRIVATE METHODS
    /**
     * Builds a request based on a resource, rest method and params.
     *
     * @param {@code RestMethod} restMethod
     * @param {@code String} resource
     * @param {@code Map<String, String>} params
     * @return {@code HttpRequest} 
     */
    private HttpRequest getRestRequest(final RestMethod restMethod, final String resource,
                                       final Map<String, String> params) {
        //-- 1. Build endpoint
        String endpoint = MEETUP_ENDPOINT + resource + '?key=' + MEETUP_KEY;

        //Check params
        if (params != null && !params.isEmpty()) {
            for (String paramKey : params.keySet()) {
                endpoint += (
                    '&' + paramKey + '=' + EncodingUtil.urlEncode(
                        String.isEmpty(params.get(paramKey)) ? '' : params.get(paramKey), 'UTF-8'
                    )
                );
            }
        }

        //-- 2. Build request
        HttpRequest r = new HttpRequest();
        r.setMethod(restMethod.name());
        r.setTimeout(60000);
        r.setEndpoint(endpoint);

        //-- 3. Return request
        return r;
    }

    /**
     * Sends a request.
     * 
     * @param {@code request}
     * @param {@code String}
     */
    private String sendRequest(final HttpRequest request) {
        //-- Prevalidations
        if (request == null) throw new SDG_Exception.RestMeetupException('"request" is null.');

        //-- Send request
        //Http
        final Http http = new Http();
        try {
            //Send request
            final HTTPResponse response = http.send(request);

            //-- Check result
            //Response is null
            if (response == null) throw new SDG_Exception.RestMeetupException('"response" is null.');
            
            //Response seems NO VALID
            else if (response.getStatus() != 'OK' && response.getStatusCode() != 200) {
                throw new SDG_Exception.RestMeetupException(
                    'Something went wrong. Status: ' + response.getStatus() +
                    ' Code: ' + response.getStatusCode()
                );
            }

            //Valid response
            else {
                return response.getBody();
            }
        }
        catch (Exception e) {
            System.debug(LoggingLevel.ERROR, e.getMessage());
            throw new SDG_Exception.RestMeetupException(e);
        }
    }

    //-- ENUM
    /**
     * Enumerates all valid REST methods.
     */
    public enum RestMethod {
        GET,
        POST,
        PUT
    }
}