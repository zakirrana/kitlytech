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
        }
        public IEnumerable<Study> GetStudiesAll()
        {
            return this.istudyobject.GetModel();
        }

        public List<StudyModel> GeStudiesBySiteId(int siteId, string serach, int from, int to)
        {
            List<StudyModel> result = new List<StudyModel>();
            var data = dbContext.sp_site_GetStudiesBySiteId(siteId, serach, from, to).ToList();
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
        public List<ReferalModel> GeReferalByStudyId(int siteId, int studyId, string serach, int from, int to)
        {
            List<ReferalModel> result = new List<ReferalModel>();
            var data = dbContext.sp_site_GetReferalsByStudyId(siteId, studyId, serach, from, to).ToList();
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
            var data = dbContext.ReferalApointmentTypes.ToList();
            if (data != null && data.Count > 0)
            {
                foreach (var value in data)
                {
                    AppointmentType objetype = new AppointmentType();
                    objetype.Id = value.Id;
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
                    result.Add(objapt);

                }
            }
            return result;


        }
    }
}
