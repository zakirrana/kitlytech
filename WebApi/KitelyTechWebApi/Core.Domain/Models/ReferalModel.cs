using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Domain.Models
{
    public class ReferalModel
    {

        public int ReferalId { get; set; }
        public string ReferalCode { get; set; }
        public int StatusId { get; set; }
        public int StudyId { get; set; }
        public int SiteId { get; set; }
        public string Status { get; set; }
    }
}
