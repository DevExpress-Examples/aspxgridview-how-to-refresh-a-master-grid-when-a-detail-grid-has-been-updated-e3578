<%@ Page Language="vb" AutoEventWireup="true" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<%@ Register Assembly="DevExpress.Web.v15.1, Version=15.1.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ASPxGridView - How to refresh a master grid when a detail grid has been updated</title>

    <script type="text/javascript">
        var command = "";
        function OnBeginCallback(s, e) {
            s.isError = false;
            command = e.command;
        }

        function OnEndCallback(s, e) {
            if ((command == "ADDNEWROW" || command == "UPDATEEDIT") && !s.isError) {
                mainGrid.Refresh();
            }
        }
        function OnCallbackError(s, e) {
            s.isError = true;
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div>
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" KeyFieldName="Id" AutoGenerateColumns="False" ClientInstanceName="mainGrid"
            DataSourceID="mainSource">
            <SettingsDetail ShowDetailRow="true" />

            <Columns>
                <dx:GridViewDataComboBoxColumn FieldName="ProductId" Caption="Product" VisibleIndex="1">
                    <PropertiesComboBox DataSourceID="productSource" TextField="Name" ValueField="Id"
                        DropDownHeight="150px">
                    </PropertiesComboBox>
                </dx:GridViewDataComboBoxColumn>
                <dx:GridViewDataTextColumn FieldName="Quantity" VisibleIndex="1">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Price" ReadOnly="True" VisibleIndex="2">
                    <PropertiesTextEdit DisplayFormatString="c" />
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Total" ReadOnly="True" VisibleIndex="3">
                </dx:GridViewDataTextColumn>
                <dx:GridViewDataTextColumn FieldName="Id" ReadOnly="True" VisibleIndex="4">
                </dx:GridViewDataTextColumn>
            </Columns>
            <Templates>
                <DetailRow>
                    <dx:ASPxGridView ID="gridProducts" ClientInstanceName="gridProducts" runat="server"
                        DataSourceID="productSource" KeyFieldName="Id" Width="300px">
                         <ClientSideEvents EndCallback="OnEndCallback" BeginCallback="OnBeginCallback" CallbackError="OnCallbackError" />
                        <Columns>
                            <dx:GridViewCommandColumn VisibleIndex="0" ShowNewButton="True" ShowEditButton="True"/>
                            <dx:GridViewDataColumn FieldName="Name" VisibleIndex="0">
                            </dx:GridViewDataColumn>
                            <dx:GridViewDataTextColumn FieldName="Price" VisibleIndex="1">
                                <PropertiesTextEdit DisplayFormatString="c" />
                            </dx:GridViewDataTextColumn>
                        </Columns>
                        <SettingsEditing Mode="Inline" />
                        <SettingsBehavior AllowDragDrop="false" />
                    </dx:ASPxGridView>
                </DetailRow>
            </Templates>
        </dx:ASPxGridView>
        <asp:ObjectDataSource ID="mainSource" runat="server" SelectMethod="GetItems" TypeName="OrderItemsProvider"
            UpdateMethod="ItemUpdate" InsertMethod="ItemInsert" DeleteMethod="ItemDelete">
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="productSource" runat="server" SelectMethod="GetProducts"
            TypeName="OrderItemsProvider" UpdateMethod="ProductUpdate" InsertMethod="ProductInsert">
        </asp:ObjectDataSource>
    </div>
    </form>
</body>
</html>