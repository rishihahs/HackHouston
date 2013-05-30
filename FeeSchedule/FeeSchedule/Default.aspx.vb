Imports System.Data

Partial Class _Default
    Inherits System.Web.UI.Page
    Public returnValue As String
    Protected Sub Page_PreInit(sender As Object, e As EventArgs) Handles Me.PreInit
        Dim dvFeesSql As DataView =
    DirectCast(FeesTableSqlDataSource.Select(DataSourceSelectArguments.Empty), DataView)
        Dim dvAlcoholFeesSql As DataView =
DirectCast(AlcoholTableSqlDataSource.Select(DataSourceSelectArguments.Empty), DataView)
        Dim dvDepartmentsSql As DataView =
DirectCast(AlcoholTableSqlDataSource.Select(DataSourceSelectArguments.Empty), DataView)
        For Each Department As String In dvDepartmentsSql(0).Row.

        Next
        returnValue = "var main_fees = " & dvFeesSql(0)(0).ToString() & ";" & vbCrLf & _
            "var alcohol_fees = " & dvAlcoholFeesSql(0)(0).ToString() & ";" & vbCrLf & _
            "var master_fees = main_fees.concat(alcohol_fees);"
    End Sub
End Class
