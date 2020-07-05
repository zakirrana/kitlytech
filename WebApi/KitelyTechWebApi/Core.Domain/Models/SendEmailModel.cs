using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Domain.Models
{
    public class SendEmailModel
    {

        public string to { get; set; }
        public string from { get; set; }
        public string emailBody { get; set; }

        public string subject { get; set; }
        public string bcc { get; set; }
        public string cc { get; set; }
        public bool isHtml { get; set; }
    }
}
