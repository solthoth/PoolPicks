using System;
using PoolPicks.Models;

namespace PoolPicks
{
    public partial class Default : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            NFLFeed feed = new NFLFeed();
            feed.LoadFeed();
        }
    }
}