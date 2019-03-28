namespace DataAccess.Model
{
    public class Payload
    {
        public int Status { get; set; }
        public string ViewString { get; set; }

        public Payload(int status, string viewString)
        {
            Status = status;
            ViewString = viewString;
        }
    }
}