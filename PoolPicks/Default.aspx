<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="PoolPicks.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        li {
            list-style: none;
        }

        .schedule-list img {
            width: 3em;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--<h1 class="cover-heading">Game Schedules</h1>-->
    <!-- The below is an odd fix that prevents the table from overlapping with the table -->
    <br class="hidden-xs" />
    <br class="hidden-xs" />
    <br class="hidden-xs" />
    <!-- End odd fix -->
    <div ng-app="ScheduleApp" ng-controller="ScheduleCtrl">
        <h3 ng-show="hideContent">Week {{ week }}</h3>
        <div ng-hide="hideContent" class="progress">
            <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%">
                Loading...
            </div>
        </div>
        <table class="table schedule-list">
            <tr ng-repeat="g in games">
                <td>{{ g.Day +'-'+ g.Time }}</td>
                <td class="hidden-xs text-right">{{ g.HomeTeam.Name | uppercase }}</td>
                <td>
                    <img src="http://i.nflcdn.com/static/site/7.1/img/logos/svg/teams-matte-mascot/{{g.HomeTeam.Name}}.svg" />
                    {{ g.HomeScore }}
                </td>
                <td>{{ g.AwayScore }}
                    <img src="http://i.nflcdn.com/static/site/7.1/img/logos/svg/teams-matte-mascot/{{g.AwayTeam.Name}}.svg" />
                </td>
                <td class="hidden-xs text-left">{{ g.AwayTeam.Name | uppercase }}</td>
            </tr>
        </table>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="footer" runat="server">
    <script type="text/javascript" src="Scripts/ScheduleApp.js"></script>
</asp:Content>
