<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<!DOCTYPE HTML>
<html>
  <head runat="server">
    <title>City-Wide Fee Schedule</title>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
    <link href="assets/css/bootstrap.min.css" media="screen" rel="stylesheet" type="text/css">
    <link href="assets/css/jquery-ui-1.10.2.custom.min.css" media="screen" rel="stylesheet" type="text/css">
    <link href="assets/css/stream.css" media="screen" rel="stylesheet" type="text/css">
    <link href="assets/css/custom.css" media="screen" rel="stylesheet" type="text/css">
    <script src="assets/js/jquery.min.js" type="text/javascript"></script>
    <script src="assets/js/jquery-ui-1.10.2.custom.min.js" type="text/javascript"></script>
    <script src="vendors/mustache.js" type="text/javascript"></script>
    <script src="filter.js" type="text/javascript"></script><%--    <script src="data/top_movies_data.js" type="text/javascript"></script>--%>
    <script type="text/javascript"> 
        <%=returnValue%>
    </script>
    <script src="stream.js" type="text/javascript"></script>
  </head>
  <body runat="server">
      <asp:SqlDataSource ID="FeesTableSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:HackHou2008ConnectionString %>" SelectCommand="GetJSON" SelectCommandType="StoredProcedure">
          <SelectParameters>
              <asp:Parameter DefaultValue="feestable" Name="table_name" Type="String" />
          </SelectParameters>
      </asp:SqlDataSource>
        <asp:SqlDataSource ID="AlcoholTableSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:HackHou2008ConnectionString %>" SelectCommand="GetJSON" SelectCommandType="StoredProcedure">
          <SelectParameters>
              <asp:Parameter DefaultValue="alcoholfees" Name="table_name" Type="String" />
              <asp:Parameter DefaultValue="Alcohol" Name="department" Type="String" />
          </SelectParameters>
      </asp:SqlDataSource>
    <form id="form2" runat="server">
        <div class="container">
          <h1 class="title">City Fee Schedule</h1>
              <div class="sidebar col-span-3">
                <div class="row">
                  <h4 class="col-span-6"> Fees (<span id="total_movies">1905</span>)</h4>
                </div>
                <div>
                  <input type="text" id="searchbox" placeholder="Search...">
                  <span class="glyphicon glyphicon-search search-icon"></span>
                </div>
        
                <div class="criteria" id="genre_criteria">
                  <h4>Responsible Department</h4>
                  <div class="checkbox">
                    <label>
                      <input type="checkbox" value='All' id="all_genre"> All
                    </label>
                  </div>
                </div>
              </div>
              <div class="movies content col-span-9" id="movies">
              </div>
              <script id="template" type="text/html">
                <div class="col-span-4 movie">
                    <div class="thumbnail">
                    <span class="label label-success rating">{{AMOUNT}}</span>
                    <div class="caption">
                        <h4>{{Name}}</h4>
                        <div class="detail">
                                <dl>
                                  <dt>Description</dt>
                                  <dd>{{Description}}</dd>
                                  <dt>Responsible Department</dt>
                                  <dd>{{ResponsibleDepartment}}</dd>
                                  <dt>Statutory Authority</dt>
                                  <dd>{{StatutoryAuthority}}</dd>
                                </dl>
                            </div>
                        </div>
                    </div>
                </div>
              </script>
              <script id="genre_template" type="text/html">
                <div class="checkbox">
                  <label>
                    <input type="checkbox" value="{{genre}}"> {{genre}}
                  </label>
                </div>
              </script>
            </div>
        </form>
    </body>
  </html>

