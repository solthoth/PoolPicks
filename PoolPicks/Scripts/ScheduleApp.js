var app = angular.module('ScheduleApp', []);
app.controller('ScheduleCtrl', function ($scope, $http) {
    $scope.hideContent = false;
    /* Notes on code below:
        Based on observation, it would seem that using $.ajax won't function
        properly with angular for some reason, using the $http object does
        seem to work just fine.
    */
    $http.post("Default.aspx/ThisWeekSchedule", {})
        .then(function (response) {
            /* On Success */
            var nflJson = JSON.parse(response.data.d);
            $scope.week = nflJson.Week;
            $scope.year = nflJson.Year;
            $scope.games = nflJson.Games;
            //console.log(nflJson.Games);
            /* Set variable to true to hide progress bar */
            $scope.hideContent = true;
        },
        function (response) {
            /* On Error */
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