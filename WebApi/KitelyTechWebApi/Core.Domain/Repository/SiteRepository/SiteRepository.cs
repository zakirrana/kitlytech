using Core.Domain.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Domain.Repository.SiteRepository
{
    public class SiteRepository
    {
        private _IAllRepository<Study> istudyobject;
        private CTMEntities dbContext;
        public SiteRepository()
        {
            this.istudyobject = new AllRepository<Study>();
            this.dbContext = new CTMEntities();
            dbContext.Configuration.LazyLoadingEnabled = false;
        }
        public IEnumerable<Study> GetStudiesAll()
        {
            return this.istudyobject.GetModel();
        }

        public List<StudyModel> GeStudiesBySiteId(int siteId, string search, int from, int to)
        {
            List<StudyModel> result = new List<StudyModel>();
            var data = dbContext.sp_site_GetStudiesBySiteId(siteId, search, from, to).ToList();
            if (data != null && data.Count > 0)
            {
                foreach (var value in data)
                {
                    StudyModel objstudy = new StudyModel();
                    objstudy.Id = value.Id;
                    objstudy.StudyTitle = value.StudyTitle;
                    objstudy.Status = value.Status;
                    objstudy.StatusId = value.StatusId ?? 0;
                    objstudy.StudyCode = value.StudyCode;
                    objstudy.Audit.CreatedBy = value.CreatedBy;
                    objstudy.Audit.CreatedOn = value.CreatedOn;
                    objstudy.Audit.ModifiedOn = value.ModifiedOn;
                    objstudy.Audit.ModyfiedBy = value.ModyfiedBy;
                    result.Add(objstudy);

                }
            }
            return result;


        }
       
        public List<ReferalModel> GeReferalByStudyId(int siteId, int studyId, string search, int from, int to)
        {
            List<ReferalModel> result = new List<ReferalModel>();
            var data = dbContext.sp_site_GetReferalsByStudyId(siteId, studyId, search, from, to).ToList();
            if (data != null && data.Count > 0)
            {
                foreach (var value in data)
                {
                    ReferalModel objref = new ReferalModel();
                    objref.ReferalId = value.RefrelId ?? 0;
                    objref.ReferalCode = value.ReferalCode;
                    objref.SiteId = value.SiteId ?? 0;
                    objref.Status = value.ReferalStatus;
                    objref.StatusId = value.ReferalStatusId ?? 0;
                    objref.StudyId = value.StudyId ?? 0;
                    result.Add(objref);

                }
            }
            return result;


        }
        public ReferalModel GetReferalDetail(int referalId, int studyId)
        {
            ReferalModel result = new ReferalModel();
            var data = dbContext.sp_site_GetReferalsDetail(referalId, studyId).FirstOrDefault();
            if (data != null)
            {

                ReferalModel objref = new ReferalModel();
                objref.ReferalId = data.Id;
                objref.StudyId = data.StudyId ?? 0;
                objref.SiteId = data.SiteId??0;
                objref.ReferalCode = data.ReferalCode;
                objref.FirstName = data.FirstName;
                objref.MiddleName = data.MiddleName;
                objref.LastName = data.LastName;
                objref.HomePhoneNumber = data.HomePhoneNumber;
                objref.State = data.State;
                objref.Zip = data.Zip;
                objref.EmailAddress = data.EmailAddress;
                objref.Country = data.Country;
                objref.City = data.City;
                objref.CellPhoneNumber = data.CellPhoneNumber;
                objref.CareGiversName = data.CareGiversName;
                objref.CareGiverrsPhone = data.CareGiverrsPhone;
                objref.Address = data.Address;
                objref.Status = data.ReferalStatus;

                result = objref;


            }
            return result;


        }
        public List<AppointmentType> GetApintMentTypeCombo()
        {
            List<AppointmentType> result = new List<AppointmentType>();
            var data = dbContext.ReferalApointmentTypes.AsNoTracking().ToList();
            if (data != null && data.Count > 0)
            {
                foreach (var value in data)
                {
                    AppointmentType objetype = new AppointmentType();
                    objetype.Id = value.Id;
                    objetype.Type = value.ApointMentType;
                    result.Add(objetype);

                }
            }
            return result;


        }
        public List<AppointmentDetail> GetApintMentDetail(int ReferalId)
        {
            List<AppointmentDetail> result = new List<AppointmentDetail>();
            var data = dbContext.sp_site_GetReferalsApointments(ReferalId).ToList();
            if (data != null && data.Count > 0)
            {
                foreach (var value in data)
                {
                    AppointmentDetail objapt = new AppointmentDetail();
                    objapt.Id = value.Id;
                    objapt.referalId = value.ReferalId??0;
                    objapt.ApintMentTypeId = value.AppointmentTypeId ?? 0;
                    objapt.ApointMentType = value.ApointMentType;
                    objapt.Date = value.ApointmentDate;
                    objapt.CreatedOn = value.CreatedOn;
                    objapt.Notes = value.Note;
                    objapt.EventId = value.EventId??0;
                    result.Add(objapt);

                }
            }
            return result;


        }
        public AppointmentDetail GetApintMentDetailById(int Id)
        {
            AppointmentDetail result = new AppointmentDetail();
            var value = dbContext.ReferalApointments.AsNoTracking().Where(x=>x.Id==Id).FirstOrDefault();
            if (value != null)
            {
                result.Id = value.Id;
                result.referalId = value.ReferalId ?? 0;
                result.ApintMentTypeId = value.AppointmentTypeId ?? 0;
                result.Date = value.ApointmentDate;
                result.CreatedOn = value.CreatedOn;
                result.Notes = value.Note;
            }
            return result;


        }
        public void SaveApointMent(ReferalApointment model)
        {
            var repo = new AllRepository<ReferalApointment>();
            if (model.Id == 0)
            {
                repo.InsertModel(model);
            }
            else
            {
                repo.UpdateModel(model);
               
            }
            repo.Save();
        }
        public void DeleteApointMent(int Id)
        {
            var repo = new AllRepository<ReferalApointment>();
            if (Id > 0)
            {
                repo.DeleteModel(Id);
            }
           
            repo.Save();
        }
        public List<EventDetails> GetEventDetail(int ReferalId)
        {
            List<EventDetails> result = new List<EventDetails>();
            var data = dbContext.sp_site_GetReferalsEvents(ReferalId).ToList();
            if (data != null && data.Count > 0)
            {
                foreach (var value in data)
                {
                    EventDetails objevt = new EventDetails();
                    objevt.Id = value.Id;
                    objevt.ApplicableProtocolid = value.ApplicableProtocolid??0;
                    objevt.Comment = value.Comment;
                    objevt.CreatedOn = value.CreatedOn;
                    objevt.EventDate = value.EventDate;
                    objevt.EventStatus = value.EventStatus;
                    objevt.EventStatusId = value.EventStatusId??0;
                    objevt.EventTypeId = value.EventTypeId;
                    objevt.EventType = value.EventType;
                    objevt.IVRNo = value.IVRNo;
                    objevt.ReferalId = value.ReferalId??0;
                    objevt.ReferalStatusId = value.ReferalStatusId ?? 0;
                    objevt.ReferalStatus = value.ReferalStatus;
                    
                    result.Add(objevt);

                }
            }
            return result;


        }
        public ReferalEventDetail GetEventDetailById(int Id)
        {
           
            return dbContext.ReferalEventDetails.AsNoTracking().Where(row=>row.Id==Id).FirstOrDefault();
           

        }
        public List<ReferalEventDetail> GetEventDetailByApintmentId(int apointmentId)
        {

            return dbContext.ReferalEventDetails.AsNoTracking().Where(row => row.ApointMentId == apointmentId).ToList();


        }
        public void SaveEvents(ReferalEventDetail model, int siteId, int studyId)
        {
            var repo = new AllRepository<ReferalEventDetail>();
            if (model.Id == 0)
            {
                repo.InsertModel(model);
            }
            else
            {
                repo.UpdateModel(model);

            }
            repo.Save();
            var value = dbContext.StudySiteReferalMappings.AsNoTracking().Where(row => row.RefrelId == model.ReferalId && row.SiteId == siteId && row.StudyId == studyId).FirstOrDefault();
            if(value!=null)
            {
                value.ReferalStatusId = model.ReferalStatusId;
                dbContext.Entry(value).State = System.Data.Entity.EntityState.Modified;
                dbContext.SaveChanges();
            }
        }
        public void DeleteEvent(int Id)
        {
            var repo = new AllRepository<ReferalEventDetail>();
            if (Id > 0)
            {
                repo.DeleteModel(Id);
            }

            repo.Save();
        }

        public EventsCombo GetEventsCombo()
        {
           
            var eventcombos = new EventsCombo();
            eventcombos.referalStatus = dbContext.ReferalStatus.AsNoTracking().ToList();
            eventcombos.referalStatusReson = dbContext.SiteReferalStatusReasons.AsNoTracking().ToList();
            eventcombos.eventTypes = dbContext.ReferalEventTypes.AsNoTracking().ToList();
            eventcombos.referalEventStatus = dbContext.ReferalEventStatus.AsNoTracking().ToList();
            return eventcombos;

        }

        public List<StudyProtocol> GetApplicableProtocol(int studyId)
        {
            return dbContext.StudyProtocols.AsNoTracking().Where(row=>row.StudyId==studyId).ToList();
        }

       
    }
}
