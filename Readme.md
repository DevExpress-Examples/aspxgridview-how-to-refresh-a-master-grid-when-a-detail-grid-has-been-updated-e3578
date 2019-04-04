<!-- default file list -->
*Files to look at*:

* [OrderItems.cs](./CS/WebSite/App_Code/OrderItems.cs) (VB: [OrderItems.vb](./VB/WebSite/App_Code/OrderItems.vb))
* [Default.aspx](./CS/WebSite/Default.aspx) (VB: [Default.aspx](./VB/WebSite/Default.aspx))
* [Default.aspx.cs](./CS/WebSite/Default.aspx.cs) (VB: [Default.aspx.vb](./VB/WebSite/Default.aspx.vb))
<!-- default file list end -->
# ASPxGridView - How to refresh a master grid when a detail grid has been updated


<p>This sample demonstrates how to update a primary grid data in response to changes made within a detail grid. By design, ASPxGridView can update its own rendering when processing a callback, but not the rending of outside controls. Thus, to refresh the main grid data, it is necessary to call the <a href="http://documentation.devexpress.com/#AspNet/DevExpressWebASPxGridViewScriptsASPxClientGridView_Refreshtopic"><u>Refresh</u></a> method when the detail grid data has been changed. Handle the detail grid EndCallback event handler for this. To overcome the circularity, also handle the <a href="http://documentation.devexpress.com/#AspNet/DevExpressWebASPxGridViewScriptsASPxClientGridView_BeginCallbacktopic"><u>BeginCallback</u></a> event as follows:</p>

```aspx
<ClientSideEvents EndCallback="OnEndCallback" BeginCallback="OnBeginCallback"/> 

```



```js
var command = "";
function OnBeginCallback(s, e) {
    command = e.command;
}
function OnEndCallback(s, e) {
    if (command == "ADDNEWROW") {
        s.Refresh();
    }
}

```

<p> </p><br />
<p><strong>See also:</strong><br />
<a href="https://www.devexpress.com/Support/Center/p/E164">Automatically refresh the primary grid on changing secondary grid's data</a></p>

<br/>


