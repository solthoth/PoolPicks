using System;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace PoolPicks
{
    public partial class Default : System.Web.UI.Page
    {
        
        [WebMethod(BufferResponse =true)]
        public static string ThisWeekSchedule()
        {
            Global.NFLSSFeed.LoadFeed();
            return new JavaScriptSerializer().Serialize(Global.NFLSSFeed);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
        }
    }
}