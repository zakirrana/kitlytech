using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Domain.Models
{
    public class EventsCombo
    {

        public EventsCombo()
        {
            EventTypes = new List<ReferalEventType>();
            ReferalStatus = new List<ReferalStatu>();
            ReferalStatusReson = new List<SiteReferalStatusReason>();
            ReferalEventStatus = new List<ReferalEventStatu>();
        }
        public List<ReferalEventType> EventTypes { get; set; }
        public List<ReferalStatu> ReferalStatus { get; set; }
        public List<SiteReferalStatusReason> ReferalStatusReson { get; set; }

        public List<ReferalEventStatu> ReferalEventStatus { get; set; }
    }
}
