using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Domain.Models
{
    public class SendEmailModel
    {

        public string To { get; set; }
        public string From { get; set; }
        public string EmailBody { get; set; }
        public int MessageType { get; set; }
        public string Subject { get; set; }
        public string Bcc { get; set; }
        public string Cc { get; set; }
        public bool IsHtml { get; set; }
        public string Reciver { get; set; }
    }
}
