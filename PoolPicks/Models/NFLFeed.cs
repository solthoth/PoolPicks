using System;
using System.Collections.Generic;
using System.Xml;

namespace PoolPicks.Models
{
    public class FootballTeam
    {
        public string Name { get; set; }
        public string Abbr { get; set; }
    }

    public class Game
    {
        public int GameID { get; set; }
        public string Day { get; set; }
        public string Time { get; set; }
        public FootballTeam HomeTeam { get; set; }
        public int HomeScore { get; set; }
        public FootballTeam AwayTeam { get; set; }
        public int AwayScore { get; set; }
    }

    public delegate void ParseInfoHandler(object sender, EventArgs e, int value);
    public delegate void ParseGameHandler(object sender, EventArgs e, Game game);

    public class NFLFeed
    {
        public const string NFLSS_XML = "http://www.nfl.com/liveupdate/scorestrip/ss.xml";
        public event ParseInfoHandler ParseWeek;
        public event ParseInfoHandler ParseYear;
        public event ParseGameHandler ParseGame;
        
        private List<Game> _Games;

        public NFLFeed() { }
        /* Fields/Properties */
        public int Week { get; set; }
        public int Year { get; set; }

        public List<Game> Games
        {
            get
            {
                if (_Games == null)
                {
                    _Games = new List<Game>();
                }
                return _Games;
            }
        }

        /* Private Methods */
        private void ParseXML(XmlDocument feed)
        {
            XmlNodeList xList = feed.DocumentElement.SelectNodes("gms");
            XmlNode xNode = xList[0];//List only returns current week game
            this.Week = Convert.ToInt32(xNode.Attributes["w"].Value);
            OnParseWeek(EventArgs.Empty, this.Week);
            this.Year = Convert.ToInt32(xNode.Attributes["y"].Value);
            OnParseYear(EventArgs.Empty, this.Year);
            XmlNodeList xGames = xNode.ChildNodes;
            foreach (XmlNode xGame in xGames)
            {
                Game CurrentGame = new Game();
                CurrentGame.GameID = Convert.ToInt32(xGame.Attributes["eid"].Value);
                CurrentGame.Day = xGame.Attributes["d"].Value;
                CurrentGame.Time = xGame.Attributes["t"].Value;
                CurrentGame.HomeTeam = new FootballTeam();
                CurrentGame.HomeTeam.Name = xGame.Attributes["hnn"].Value;
                CurrentGame.HomeTeam.Abbr = xGame.Attributes["h"].Value;
                CurrentGame.HomeScore = Convert.ToInt32(xGame.Attributes["hs"].Value);
                CurrentGame.AwayTeam = new FootballTeam();
                CurrentGame.AwayTeam.Name = xGame.Attributes["vnn"].Value;
                CurrentGame.AwayTeam.Abbr = xGame.Attributes["v"].Value;
                CurrentGame.AwayScore = Convert.ToInt32(xGame.Attributes["vs"].Value);
                Games.Add(CurrentGame);
                OnParseGame(EventArgs.Empty, CurrentGame);
            }

        }
        /* Protected Methods */
        protected virtual void OnParseGame(EventArgs e, Game game)
        {
            if (ParseGame != null)
            {
                ParseGame(this, e, game);
            }
        }
        protected virtual void OnParseWeek(EventArgs e, int Week)
        {
            if (ParseWeek != null)
            {
                ParseWeek(this, e, Week);
            }
        }
        protected virtual void OnParseYear(EventArgs e, int Year)
        {
            if (ParseYear != null)
            {
                ParseYear(this, e, Year);
            }
        }

        /* Public Methods*/
        public void LoadFeed()
        {
            Games.Clear();
            XmlDocument xmlFeed = new XmlDocument();
            xmlFeed.Load(NFLSS_XML);
            ParseXML(xmlFeed);
        }
    }
}