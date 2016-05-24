/**********************************************************************************
* @author       Aaron Dominguez - aaron@clappsolutions.com - www.clappsolutions.com
* @date         20 May 2016
* @description  Reader Class to ERP OData data source.
* @Revision     
**********************************************************************************/
public class SDG_ERPODataReader {
    
    //-- CONSTANTS
    private static final String ENDPOINT_URL = 'http://services.odata.org/V2/Northwind/Northwind.svc/Categories';
    private static final String HTTP_GET_METHOD = 'GET';
    private static final List<String> HEADER_CONTENT_TYPE = new List<String>{'content-type','application/atom+xml'};
    private static final String HEADER_ACCEPT = 'Accept';
    private static final String XMLREADER_ENTRY = 'entry';
    private static final String XMLREADER_CONTENT = 'content';
    private static final String XMLREADER_PROPERTIES = 'properties';
    private static final String XMLREADER_CATEGORY = 'category';
    private static final String XMLREADER_IDFIELD = 'CategoryID';
    private static final String XMLREADER_CATFIELD = 'CategoryName';
    private static final String XMLREADER_DESCFIELD = 'Description';

	//-- CONSTRUCTOR
    public SDG_ERPODataReader() {}

    //-- PUBLIC METHODS

    public static List<Category> retrieveCategories() {
    	Http http = new Http();

    	HttpRequest reqCat = new HttpRequest();
    	reqCat.setEndpoint(ENDPOINT_URL);
    	reqCat.setMethod(HTTP_GET_METHOD);
    	reqCat.setHeader(HEADER_CONTENT_TYPE.get(0), HEADER_CONTENT_TYPE.get(1));
    	reqCat.setHeader(HEADER_ACCEPT, HEADER_CONTENT_TYPE.get(1));

    	HttpResponse resCat = http.send(reqCat);
    	String bodyCat = resCat.getBody();

    	Dom.Document doc = new Dom.Document();
        doc.load(bodyCat);

        //Retrieve the root element for this document.
        Dom.XMLNode xmlRoot = doc.getRootElement();
        
        List<Category> categories = new List<Category>();

        // Loop through the child elements
        for(Dom.XMLNode child : xmlRoot.getChildElements()) {          
           if(child.getName() == XMLREADER_ENTRY ) {
           		for(Dom.XMLNode child2 : child.getChildElements()) {
           			if(child2.getName() == XMLREADER_CONTENT) {
           				for(Dom.XMLNode child3 : child2.getChildElements()) {
           					if(child3.getName() == XMLREADER_PROPERTIES) {
           						Category category = new Category();
           						for(Dom.XMLNode child4 : child3.getChildElements()) {           							
           							if(child4.getName() == XMLREADER_IDFIELD) {           								
							           	category.externalId = child4.getText();
							        }else if(child4.getName() == XMLREADER_CATFIELD) {
           								category.name = child4.getText();
       								}else if(child4.getName() == XMLREADER_DESCFIELD) {
       									category.description = child4.getText();
       								}
       								categories.add(category);
           						}
           					}
           				}
           			}
           		}           		
            }           
        }
        return categories;
    }

    //-- DTO
    public class Category {
    	public String externalId {get; set;}
    	public String name {get; set;}
    	public String description {get; set;}
    }
    
}