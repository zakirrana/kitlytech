using Core.Domain.Common;
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

        public List<StudyModel> GeStudiesBySiteId(SiteApiParameter param)
        {


            var Result = dbContext.sp_site_GetStudiesBySiteId(param.siteId, param.search, param.fromRecord,param.toRecord).Select(value => new StudyModel
            {
                Id = value.Id,
                StudyTitle = value.StudyTitle,
                Status = value.Status,
                StatusId = value.StatusId ?? 0,
                StudyCode = value.StudyCode,


            }).ToList();


            return Result;


        }

        public List<ReferalModel> GeReferalByStudyId(SiteApiParameter param)
        {

            var data = dbContext.sp_site_GetReferalsByStudyId(param.siteId, param.studyId, param.search, param.fromRecord, param.toRecord)
                .Select(value => new ReferalModel
                {
                    ReferalId = value.RefrelId ?? 0,
                    ReferalCode = value.ReferalCode,
                    SiteId = value.SiteId ?? 0,
                    Status = value.ReferalStatus,
                    StatusId = value.ReferalStatusId ?? 0,
                    StudyId = value.StudyId ?? 0,

                }).ToList();

            return data;


        }
        public ReferalModel GetReferalDetail(int referalId, int studyId)
        {

            var result = dbContext.sp_site_GetReferalsDetail(referalId, studyId).Select(data => new ReferalModel
            {

                ReferalId = data.Id,
                SiteId = data.SiteId ?? 0,
                ReferalCode = data.ReferalCode,
                FirstName = data.FirstName,
                MiddleName = data.MiddleName,
                LastName = data.LastName,
                HomePhoneNumber = data.HomePhoneNumber,
                State = data.State,
                Zip = data.Zip,
                EmailAddress = data.EmailAddress,
                Country = data.Country,
                City = data.City,
                CellPhoneNumber = data.CellPhoneNumber,
                CareGiversName = data.CareGiversName,
                CareGiverrsPhone = data.CareGiverrsPhone,
                Address = data.Address,
                Status = data.ReferalStatus,
            }).FirstOrDefault();

            return result;


        }
        public List<AppointmentType> GetApintMentTypeCombo()
        {

            var result = dbContext.ReferalApointmentTypes.AsNoTracking().Select(value => new AppointmentType
            {
                Id = value.Id,
                Type = value.ApointMentType
            }).ToList();

            return result;


        }
        public List<AppointmentDetail> GetApintMentDetail(int ReferalId)
        {

            var result = dbContext.sp_site_GetReferalsApointments(ReferalId)
                .Select(value => new AppointmentDetail
                {
                    Id = value.Id,
                    referalId = value.ReferalId ?? 0,
                    ApintMentTypeId = value.AppointmentTypeId ?? 0,
                    ApointMentType = value.ApointMentType,
                    Date = value.ApointmentDate,
                    CreatedOn = value.CreatedOn,
                    Notes = value.Note,
                    EventId = value.EventId ?? 0
                }).ToList();

            return result;


        }
        public AppointmentDetail GetApintMentDetailById(int Id)
        {
            var result = dbContext.ReferalApointments.AsNoTracking().Where(x => x.Id == Id).Select(value => new AppointmentDetail
            {
                Id = value.Id,
                referalId = value.ReferalId ?? 0,
                ApintMentTypeId = value.AppointmentTypeId ?? 0,
                Date = value.ApointmentDate,
                CreatedOn = value.CreatedOn,
                Notes = value.Note
            }).FirstOrDefault();

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

            var result = dbContext.sp_site_GetReferalsEvents(ReferalId)
                .Select(value => new EventDetails
                {
                    Id = value.Id,
                    ApplicableProtocolid = value.ApplicableProtocolid ?? 0,
                    Comment = value.Comment,
                    CreatedOn = value.CreatedOn,
                    EventDate = value.EventDate,
                    EventStatus = value.EventStatus,
                    EventStatusId = value.EventStatusId ?? 0,
                    EventTypeId = value.EventTypeId,
                    EventType = value.EventType,
                    IVRNo = value.IVRNo,
                    ReferalId = value.ReferalId ?? 0,
                    ReferalStatusId = value.ReferalStatusId ?? 0,
                    ReferalStatus = value.ReferalStatus


                }).ToList();

            return result;


        }
        public ReferalEventDetail GetEventDetailById(int Id)
        {

            return dbContext.ReferalEventDetails.AsNoTracking().Where(row => row.Id == Id).FirstOrDefault();


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
            if (value != null)
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
            return dbContext.StudyProtocols.AsNoTracking().Where(row => row.StudyId == studyId).ToList();
        }

    }
}
