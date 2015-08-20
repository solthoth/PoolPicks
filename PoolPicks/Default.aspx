<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="PoolPicks.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="cover-heading">Game Schedules</h1>
    <div ng-app="ScheduleApp" ng-controller="ScheduleCtrl">
        <table class="table">
            <tr ng-repeat="g in games track by $index">
                <td>{{ g.HomeTeam.Name + ' ' + g.HomeScore }}</td>
                <td>{{ g.AwayTeam.Name + ' ' + g.AwayScore }}</td>
            </tr>
        </table>
    </div>
    <p class="lead">
        <a href="Users/SignIn.aspx" class="btn btn-lg btn-default">Sign In</a>
    </p>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server">
    <form runat="server">
        <asp:ScriptManager runat="server" EnablePageMethods="true" />
    </form>
    <script type="text/javascript">
        var app = angular.module('ScheduleApp', []);
        app.controller('ScheduleCtrl', function ($scope, $http) {
            $.ajax({
                type: "POST",
                url: "Default.aspx/ThisWeekSchedule",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $scope.games = response.games;
                    console.log(response.games);
                }
            });
        });
    </script>
</asp:Content>
