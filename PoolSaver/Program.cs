using PoolPicks.Models;

namespace PoolSaver
{
    using System;
    class Program
    {
        private int GameWeek { get; set; }
        private int GameYear { get; set; }

        public void run()
        {
            //Parse RSS Feed
            NFLFeed feed = new NFLFeed();
            feed.ParseGame += Feed_ParseGame;
            feed.ParseWeek += Feed_ParseWeek;
            feed.ParseYear += Feed_ParseYear;
            feed.LoadFeed();
            // Games are saved as they are parsed
        }

        private void SaveGame(Game game)
        {
            Console.WriteLine("Game saved!");
        }

        private void Feed_ParseYear(object sender, EventArgs e, int value)
        {
            GameYear = value;
        }

        private void Feed_ParseWeek(object sender, EventArgs e, int value)
        {
            GameWeek = value;
        }

        private void Feed_ParseGame(object sender, EventArgs e, Game game)
        {
            Console.WriteLine("Game found [{0} at {1}]",game.AwayTeam.Abbr, game.HomeTeam.Abbr);
            SaveGame(game);
        }

        static void Main(string[] args)
        {
            Console.WriteLine("Program starting...");
            Program program = new Program();
            program.run();
            Console.WriteLine("Done.");
            Console.Read();
        }
    }
}
