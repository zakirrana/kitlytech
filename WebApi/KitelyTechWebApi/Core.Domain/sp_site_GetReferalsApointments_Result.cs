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
    
    public partial class sp_site_GetReferalsApointments_Result
    {
        public int Id { get; set; }
        public Nullable<int> AppointmentTypeId { get; set; }
        public Nullable<System.DateTime> ApointmentDate { get; set; }
        public string Note { get; set; }
        public Nullable<int> ReferalId { get; set; }
        public Nullable<System.DateTime> CreatedOn { get; set; }
        public string ApointMentType { get; set; }
        public Nullable<int> EventId { get; set; }
    }
}
