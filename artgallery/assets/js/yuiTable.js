/**
* File    : YUITable.js
* Purpose : Generate YUI Data Table.
* Created : 08/11/2017
* Author  : Mohit Dadu
*/

var myDataSource = new YAHOO.util.DataSource(jsdata);
var myConfigs = {
    paginator : new YAHOO.widget.Paginator({ rowsPerPage: 20 }),
    sortedBy : { key: "Id", dir: YAHOO.widget.DataTable.CLASS_ASC },
};

myDataSource.responseType = YAHOO.util.DataSource.TYPE_JSARRAY;
myDataSource.responseSchema = {
    fields: ["Id","Name","Description", "Status", "CreatedOn"]
};

var myColumnDefs = [
    { key: "Id", label: "Id", sortable:true },
    { key: "Name", label: "Name", sortable:true },
    // { key: "Address", label: "Address", sortable:true },
    { key: "Description", label: "Description", sortable:true },
    { key: "Status", label: "Public", sortable:true },
    { key: "CreatedOn", label: "Added On", sortable:true, sortOptions: { defaultDir: YAHOO.widget.DataTable.CLASS_DESC } },
];

// Defer instantiation
YAHOO.util.Event.addListener(window, "load", function() {
    var myDataTable = new YAHOO.widget.DataTable("myContainer", myColumnDefs, myDataSource, myConfigs );
});
