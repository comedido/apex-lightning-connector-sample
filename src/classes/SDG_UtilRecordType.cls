/**********************************************************************************
* @author       JVN - josep@clappsolutions.com - www.clappsolutions.com
* @date         19 June 2015
* @description  Class that contains util methods for RecordType.
*               Best practice:
*                   - Use Singleton Pattern.
*                   - Use UTIL clases.
*                   - For example, for RecordTypes, CustomSettings, etc.
* @Revision     
**********************************************************************************/
public class SDG_UtilRecordType {

    //-- ATTRIBUTES
    /**
     * Map which stores all RecordTypes group by SObject name.
     */
    public final Map<String, Map<String, Id>> rtsIdByDeveloperName;

    //-- CONSTRUCTOR
    /**
     * Constructor has been set to private to enforce the use of singleton pattern.
     */
    private SDG_UtilRecordType() {
        //RecordType Maps
        this.rtsIdByDeveloperName = new Map<String, Map<String, Id>>();

        //We don't use RecordTypeInfo Class because we need DeveloperName
        //Iterate over all active RecordTypes.
        for (RecordType rt : [select Id, DeveloperName, SobjectType
                              from RecordType
                              where IsActive = true]) {
            Map<String, Id> byDevNameMap = this.rtsIdByDeveloperName.get(rt.SobjectType);
            if (byDevNameMap == null) {
                byDevNameMap = new Map<String, Id>();
                this.rtsIdByDeveloperName.put(rt.SobjectType, byDevNameMap);
            }
            byDevNameMap.put(rt.DeveloperName, rt.Id);
        }
    }

    //-- SINGLETON PATTERN
    /**
     * Typical singleton pattern implementation.
     */
    private static SDG_UtilRecordType instance;
    public static SDG_UtilRecordType getInstance() {
        if (instance == null) instance = new SDG_UtilRecordType();
        return instance;
    }

    //-- PUBLIC METHODS
    /**
     * Returns the Id of a RecordType.
     *
     * @param sobjectType {String} Internal name (NOT the label) of the SObject from which
     *                             you want to retrieve the RecordType.
     * @param rtDeveloperName {String} the developerName of the RecordType.
     * @return {Id} the Id of the Recordtype.
     */
    public Id getRtId(final String sobjectType, final String rtDeveloperName) {
        final Id rtId;
        try {
            rtId = this.rtsIdByDeveloperName.get(sobjectType).get(rtDeveloperName);
        } catch(Exception e) {
            rtId = null;
        }

        return rtId;
    }
}