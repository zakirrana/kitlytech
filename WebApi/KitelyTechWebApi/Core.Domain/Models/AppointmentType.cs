using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Domain.Models
{
    public class AppointmentType
    {
        public int Id;
        public string Type { get; set; } 
    }

    public class EventType
    {
       public int Id;
       public string Type;

    }
    public class ReferalStatus
    {
        public int Id { get; set; }
        public string Status { get; set; }
    }

    public class StudyProtocol
    {
        public int Id { get; set; }
        public string protocall { get; set; }
    }
}
