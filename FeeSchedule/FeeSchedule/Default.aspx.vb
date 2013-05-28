Imports System.Data

Partial Class _Default
    Inherits System.Web.UI.Page
    Public returnValue As String
    Protected Sub Page_PreInit(sender As Object, e As EventArgs) Handles Me.PreInit
        Dim dvSql As DataView =
    DirectCast(FeesTableSqlDataSource.Select(DataSourceSelectArguments.Empty), DataView)
        'For Each drvSql As DataRowView In dvSql
        returnValue = "var master_fees = " & dvSql(0)(0).ToString() & ";"
        'Next
        'DataBind()
    End Sub
End Class
