<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="PoolPicks.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="cover-heading">Game Schedules</h1>
    <div id="loadingSchedule" class="progress">
        <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%">
            Loading...
        </div>
    </div>
    <div ng-app="ScheduleApp" ng-controller="ScheduleCtrl">
        <table class="table">
            <tr ng-repeat="g in games">
                <td>{{ g.HomeTeam.Name | uppercase }}
                    <img src="http://i.nflcdn.com/static/site/7.1/img/logos/svg/teams-matte-mascot/{{g.HomeTeam.Name}}.svg" />
                    {{ g.HomeScore }}
                </td>
                <td>{{ g.AwayTeam.Name | uppercase }}
                    <img src="http://i.nflcdn.com/static/site/7.1/img/logos/svg/teams-matte-mascot/{{g.AwayTeam.Name}}.svg" />
                    {{ g.AwayScore }}
                </td>
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
        $()
        var app = angular.module('ScheduleApp', []);
        app.controller('ScheduleCtrl', function ($scope, $http) {
            /* Notes on code below:
                Based on observation, it would seem that using $.ajax won't function
                properly with angular for some reason, using the $http object does
                seem to work just fine.
            */
            $http.post("Default.aspx/ThisWeekSchedule", {}).then(function (response) {
                //On Success
                var nflJson = JSON.parse(response.data.d);
                $scope.games = nflJson.Games;
                console.log(nflJson.Games);
                $("#loadingSchedule").hide();
            },
            function (response) {
                //On Error
                console.log("Failed: " + response);
            });
            /*$.ajax({
                type: "POST",
                url: "Default.aspx/ThisWeekSchedule",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var response = JSON.parse(data.d);
                    $scope.games = response.Games;
                    console.log(response.Games);
                    $("#loadingSchedule").hide();
                },
                error: function (response) {
                    console.log("Failed: "+response);
                }
            });*/
        });
    </script>
</asp:Content>
