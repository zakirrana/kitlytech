using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Domain.Common
{
    public class SiteApiParameter
    {
      public int ? siteId { get; set; }
       public int ? studyId { get; set; }
        public int fromRecord { get; set; }
       public int toRecord { get; set; }
       public string search { get; set; }
    }
}
