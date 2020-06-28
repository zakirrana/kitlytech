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

        
       public string FirstName { get; set; }
       public string MiddleName { get; set; }
       public string LastName { get; set; }
       public string EmailAddress { get; set; }
       public string HomePhoneNumber { get; set; }
       public string CellPhoneNumber { get; set; }
       public string Address { get; set; }
        public string City { get; set; }
        public string Zip { get; set; }
        public string State { get; set; }
        public string Country { get; set; }
        public string CareGiversName { get; set; }
        public string CareGiverrsPhone { get; set; }

    }
}
