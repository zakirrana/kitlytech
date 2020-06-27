using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Domain.Models
{
    public class CommonAudit
    {
        public Nullable<int> CreatedBy { get; set; }
        public Nullable<System.DateTime> CreatedOn { get; set; }
        public Nullable<int> ModyfiedBy { get; set; }
        public Nullable<System.DateTime> ModifiedOn { get; set; }
    }
}
