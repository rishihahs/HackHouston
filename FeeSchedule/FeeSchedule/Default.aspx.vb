Imports System.Data

Partial Class _Default
    Inherits System.Web.UI.Page
    Public returnValue As String
    Public totalRows As Integer
    Protected Sub Page_PreInit(sender As Object, e As EventArgs) Handles Me.PreInit
        Dim dvFeesSql As DataView =
            DirectCast(FeesTableSqlDataSource.Select(DataSourceSelectArguments.Empty), DataView)
        Dim dvAlcoholFeesSql As DataView =
            DirectCast(AlcoholTableSqlDataSource.Select(DataSourceSelectArguments.Empty), DataView)
        Dim dvRowCountSql As DataView =
                    DirectCast(RowCountSqlDataSource.Select(DataSourceSelectArguments.Empty), DataView)
        Dim dvDepartmentsSql As DataView =
            DirectCast(DepartmentSqlDataSource.Select(DataSourceSelectArguments.Empty), DataView)
        Dim strDepartments As String = String.Empty
        strDepartments = "["
        Dim rowCount As Integer = dvDepartmentsSql.Count
        For Each drvDepartment As DataRowView In dvDepartmentsSql
            Dim rowDepartment As DataRow = drvDepartment.Row
            strDepartments += "'" & rowDepartment(0).ToString() & "'"
            rowCount -= 1
            If rowCount <> 0 Then strDepartments += ","
        Next
        strDepartments += "]"
        returnValue = "var main_fees = " & dvFeesSql(0)(0).ToString() & ";" & vbCrLf & _
            "var alcohol_fees = " & dvAlcoholFeesSql(0)(0).ToString() & ";" & vbCrLf & _
            "var master_fees = main_fees.concat(alcohol_fees);" & _
            "var all_deps = " & strDepartments
        totalRows = dvRowCountSql(0)(0)
    End Sub
End Class
