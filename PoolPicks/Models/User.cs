using System.ComponentModel.DataAnnotations;

namespace PoolPicks.Models
{
    public class User
    {
        public int UserID { get; set; }
        [Required, StringLength(1000), Display(Name = "Email")]
        public string Email { get; set; }
        [Required, StringLength(1000), Display(Name = "Username")]
        public string Username { get; set; }
    }
}