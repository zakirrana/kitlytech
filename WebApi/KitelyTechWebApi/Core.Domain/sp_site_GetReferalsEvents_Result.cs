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
    
    public partial class sp_site_GetReferalsEvents_Result
    {
        public int Id { get; set; }
        public int EventTypeId { get; set; }
        public Nullable<System.DateTime> EventDate { get; set; }
        public string Comment { get; set; }
        public Nullable<int> ReferalStatusId { get; set; }
        public Nullable<int> EventStatusId { get; set; }
        public string IVRNo { get; set; }
        public Nullable<int> ReferalId { get; set; }
        public Nullable<int> ApplicableProtocolid { get; set; }
        public Nullable<System.DateTime> CreatedOn { get; set; }
        public string EventType { get; set; }
        public string EventStatus { get; set; }
        public string ReferalStatus { get; set; }
        public string ProtocolText { get; set; }
    }
}