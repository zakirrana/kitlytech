using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Domain.Models
{
    public class AppointmentDetail
    {
        public int Id { get; set; }
        public int ApintMentTypeId { get; set; }
        public string ApointMentType { get; set; }
        public DateTime ? Date { get; set; }
        public string Notes { get; set; }
        public int referalId { get; set; }
        public DateTime ? CreatedOn { get; set; }
        public int EventId { get; set; }
       
    }
}
