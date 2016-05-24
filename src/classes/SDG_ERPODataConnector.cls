/**********************************************************************************
* @author       Aaron Dominguez - aaron@clappsolutions.com - www.clappsolutions.com
* @date         20 May 2016
* @description  Connection Class to ERP OData data source.
* @Revision     
**********************************************************************************/
public with sharing class SDG_ERPODataConnector extends DataSource.Connection {

	private DataSource.ConnectionParams connectionInfo;
	
	public SDG_ERPODataConnector(DataSource.ConnectionParams connectionParams) {

		this.connectionInfo = connectionParams;
	}

	override public List<DataSource.Table> sync() {

		List<DataSource.Table> tables = new List<DataSource.Table>();
		List<DataSource.Column> columns;

		columns = new List<DataSource.Column>();

		//Standard fields
		columns.add(DataSource.Column.text('ExternalId', 255));
		columns.add(DataSource.Column.url('DisplayUrl'));

		//Custom fields
		columns.add(DataSource.Column.text('CategoryName', 80));
		columns.add(DataSource.Column.text('Description', 255));

		//Define table
		tables.add(DataSource.Table.get('Categories', 'CategoryName', columns));

		return tables;
	}

	override public DataSource.TableResult query(DataSource.QueryContext context) {

		if (context.tableSelection.columnsSelected.size() == 1
		    && context.tableSelection.columnsSelected.get(0).aggregation == DataSource.QueryAggregation.COUNT) {

			List<Map<String,Object>> rows = getRows(context);

			List<Map<String,Object>> response = DataSource.QueryUtils.filter(context, getRows(context));
			List<Map<String, Object>> countResponse = new List<Map<String, Object>>();
			Map<String, Object> countRow = new Map<String, Object>();

			countRow.put(context.tableSelection.columnsSelected.get(0).columnName,response.size());
			countResponse.add(countRow);
			return DataSource.TableResult.get(context,countResponse);
		}
		else {

			List<Map<String,Object>> filteredRows = DataSource.QueryUtils.filter(context, getRows(context));
			List<Map<String,Object>> sortedRows = DataSource.QueryUtils.sort(context, filteredRows);
			List<Map<String,Object>> limitedRows = DataSource.QueryUtils.applyLimitAndOffset(context,sortedRows);
			return DataSource.TableResult.get(context, limitedRows);
		}
	}

	override public List<DataSource.TableResult> search(DataSource.SearchContext context) {

		List<DataSource.TableResult> results = new List<DataSource.TableResult>();
		for(DataSource.TableSelection tableSelection : context.tableSelections) {

			results.add(DataSource.TableResult.get(tableSelection,getRows(context)));
		}
		return results;
	}

	private List<Map<String,Object>> getRows(DataSource.ReadContext context) {

		List<Map<String, Object>> rows = new List<Map<String, Object>>();

		DataSource.QueryContext myContext = (DataSource.QueryContext)context;
		DataSource.Filter filter = myContext.tableSelection.filter;
		
		List<SDG_ERPODataReader.Category> categories;
		try{
			categories = SDG_ERPODataReader.retrieveCategories();
		}catch(Exception e) {
			system.debug(LoggingLevel.ERROR,'@@@@ERROR: '+e.getStackTraceString());
		}

		for(SDG_ERPODataReader.Category category : categories) {
			rows.add(new Map<String,Object>
											{
												'ExternalId' => category.externalId,
												'DisplayUrl' => 'www.clappsolutions.com',
												'CategoryName' => category.name,
												'Description' => category.description
											});
		}

		return rows;
	}
}