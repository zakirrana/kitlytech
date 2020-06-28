using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Domain.Models
{
    public class EventDetails
    {
        public int Id { get; set; }
        public int EventTypeId { get; set; }
        public string EventType { get; set; }
        public DateTime? EventDate { get; set; }
        public string Comment { get; set; }
        public int ReferalStatusId { get; set; }
        public string ReferalStatus { get; set; }
        public int EventStatusId { get; set; }
        public string EventStatus { get; set; }
        public string IVRNo { get; set; }
        public int ReferalId { get; set; }
        public int ApplicableProtocolid { get; set; }
        public DateTime? CreatedOn { get; set; }

    }
}
