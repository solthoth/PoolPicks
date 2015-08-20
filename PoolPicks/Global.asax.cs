using System;
using PoolPicks.Models;

namespace PoolPicks
{
    public class Global : System.Web.HttpApplication
    {
        public static NFLFeed NFLSSFeed { get; set; }

        protected void Application_Start(object sender, EventArgs e)
        {
            //Setup NFL feed on application start
            NFLSSFeed = new NFLFeed();
        }
    }
}