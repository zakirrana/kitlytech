using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Domain.Models
{
    public class StudyList
    {
        public int Id { get; set; }
        public string StudyTitle { get; set; }
        public int StatusId { get; set; }
      
        public CommonAudit Audit { get; set; }
        public string Status { get; set; }
    }
}
