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
            eventTypes = new List<ReferalEventType>();
            referalStatus = new List<ReferalStatu>();
            referalStatusReson = new List<SiteReferalStatusReason>();
            referalEventStatus = new List<ReferalEventStatu>();
        }
        public List<ReferalEventType> eventTypes { get; set; }
        public List<ReferalStatu> referalStatus { get; set; }
        public List<SiteReferalStatusReason> referalStatusReson { get; set; }

        public List<ReferalEventStatu> referalEventStatus { get; set; }
    }
}
