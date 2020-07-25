using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Domain.Common
{
    public class SiteApiParameter
    {
      public int ? SiteId { get; set; }
       public int ? StudyId { get; set; }
        public int FromRecord { get; set; }
       public int ToRecord { get; set; }
       public string Search { get; set; }
    }
}
