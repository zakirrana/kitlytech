//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Core.Domain
{
    using System;
    using System.Collections.Generic;
    
    public partial class StudySiteReferalMapping
    {
        public int Id { get; set; }
        public Nullable<int> StudyId { get; set; }
        public Nullable<int> SiteId { get; set; }
        public Nullable<int> RefrelId { get; set; }
        public Nullable<int> ReferalStatusId { get; set; }
    
        public virtual Study Study { get; set; }
        public virtual SiteMaster SiteMaster { get; set; }
    }
}
