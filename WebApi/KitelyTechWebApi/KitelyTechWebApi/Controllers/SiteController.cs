using Core.Domain;
using Core.Domain.Models;
using Core.Domain.Repository.SiteRepository;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Helpers;
using System.Web.Http;

namespace KitelyTechWebApi.Controllers
{
    public class SiteController : ApiController
    {
        private SiteRepository siterepo = new SiteRepository();


        public string GetStudiesBySite(int siteId, string search, int from, int to)
        {


            var result = new DataServiceResult<List<StudyModel>>();
            try
            {
                var data = siterepo.GeStudiesBySiteId(siteId, search, from, to);
                if (data != null)
                {
                    result.Success = true;
                    result.Value = data;

                }

            }
            catch (Exception ex)
            {
                result.Success = false;
                result.ExceptionInfo = new ExceptionInfo(ex);
            }
            return JsonConvert.SerializeObject(result);
        }
        public string GetReferalsByStudy(int siteId, int studyId, string search, int from, int to)
        {


            var result = new DataServiceResult<List<ReferalModel>>();
            try
            {
                var data = siterepo.GeReferalByStudyId(siteId, studyId, search, from, to);
                if (data != null)
                {
                    result.Success = true;
                    result.Value = data;

                }

            }
            catch (Exception ex)
            {
                result.Success = false;
                result.ExceptionInfo = new ExceptionInfo(ex);
            }
            return JsonConvert.SerializeObject(result);
        }
        public string GetReferalsDetail(int referalId, int studyId)
        {
            var result = new DataServiceResult<ReferalModel>();
            try
            {
                var data = siterepo.GetReferalDetail(referalId, studyId);
                if (data != null)
                {
                    result.Success = true;
                    result.Value = data;

                }

            }
            catch (Exception ex)
            {
                result.Success = false;
                result.ExceptionInfo = new ExceptionInfo(ex);
            }
            return JsonConvert.SerializeObject(result);
        }
        public string GetApointmentTypeCombo()
        {
            var result = new DataServiceResult<List<AppointmentType>>();
            try
            {
                var data = siterepo.GetApintMentTypeCombo();
                if (data != null)
                {
                    result.Success = true;
                    result.Value = data;

                }

            }
            catch (Exception ex)
            {
                result.Success = false;
                result.ExceptionInfo = new ExceptionInfo(ex);
            }
            return JsonConvert.SerializeObject(result);
        }
        public string GetApointmentDetail(int referalId)
        {
            var result = new DataServiceResult<List<AppointmentDetail>>();
            try
            {
                var data = siterepo.GetApintMentDetail(referalId);
                if (data != null)
                {
                    result.Success = true;
                    result.Value = data;

                }

            }
            catch (Exception ex)
            {
                result.Success = false;
                result.ExceptionInfo = new ExceptionInfo(ex);
            }
            return JsonConvert.SerializeObject(result);
        }
        public string GetApintMentDetailById(int Id)
        {
            var result = new DataServiceResult<AppointmentDetail>();
            try
            {
                var data = siterepo.GetApintMentDetailById(Id);
                if (data != null)
                {
                    result.Success = true;
                    result.Value = data;

                }

            }
            catch (Exception ex)
            {
                result.Success = false;
                result.ExceptionInfo = new ExceptionInfo(ex);
            }
            return JsonConvert.SerializeObject(result);
        }
        [HttpPost]
        public string SaveApointMentDetail(ReferalApointment model)
        {
            var result = new DataServiceResult<ReferalApointment>();
            try
            {
               
                    //JsonConvert.DeserializeObject<ReferalApointment>(model.ToString());
                if (model != null)
                {
                    if (model.ReferalId == 0)
                    {
                        result.Success = false;
                        result.ResultMessage = "Referal id is required fields";
                    }
                    else if (model.AppointmentTypeId == 0)
                    {
                        result.Success = false;
                        result.ResultMessage = "Please select apointment type";
                    }
                    else if(model.ApointmentDate==null && model.ApointmentDate<DateTime.Now.Date)
                    {
                        result.Success = false;
                        result.ResultMessage = "Apontment date should be greter then current date";
                    }
                    else
                    {
                        model.CreatedOn = DateTime.Now.Date;
                        siterepo.SaveApointMent(model);

                        result.Success = true;
                        result.Value = model;
                    }
                    
                }
                else
                {
                    result.Success = true;
                    result.ResultMessage = "Failed to convert json model";
                }



            }
            catch (Exception ex)
            {
                result.Success = false;
                result.ResultMessage = "Failed to save Data";
                result.ExceptionInfo = new ExceptionInfo(ex);
            }
            return JsonConvert.SerializeObject(result);
        }
        public string DeleteApointMent(int Id)
        {
            var result = new DataServiceResult();
            try
            {
                siterepo.DeleteApointMent(Id);

                result.Success = true;
                result.ResultMessage = "DeletedSuccess fully";



            }
            catch (Exception ex)
            {
                result.Success = false;
                result.ResultMessage = "Failed to delete Data";
                result.ExceptionInfo = new ExceptionInfo(ex);
            }
            return JsonConvert.SerializeObject(result);
        }

        public string GetEventDetails(int referalId)
        {
            var result = new DataServiceResult<List<EventDetails>>();
            try
            {
                var data = siterepo.GetEventDetail(referalId);
                if (data != null)
                {
                    result.Success = true;
                    result.Value = data;

                }

            }
            catch (Exception ex)
            {
                result.Success = false;
                result.ExceptionInfo = new ExceptionInfo(ex);
            }
            return JsonConvert.SerializeObject(result);
        }
        public string GetEventDetailById(int Id)
        {
            var result = new DataServiceResult<ReferalEventDetail>();
            try
            {
                var data = siterepo.GetEventDetailById(Id);
                if (data != null)
                {
                    result.Success = true;
                    result.Value = data;

                }

            }
            catch (Exception ex)
            {
                result.Success = false;
                result.ExceptionInfo = new ExceptionInfo(ex);
            }
            
            return JsonConvert.SerializeObject(result);
        }
        public string GetEventDetailByApintmentId(int apointmentId)
        { 
            var result = new DataServiceResult<ReferalEventDetail>();
            try
            {
                var data = siterepo.GetEventDetailByApintmentId(apointmentId);
                if (data != null)
                {
                    result.Success = true;
                    result.Value = data;

                }

            }
            catch (Exception ex)
            {
                result.Success = false;
                result.ExceptionInfo = new ExceptionInfo(ex);
            }
            return JsonConvert.SerializeObject(result);
        }
        [HttpPost]
        public string SaveEventsDetail(ReferalEventDetail model,int siteId,int studyId)
        {
            var result = new DataServiceResult<ReferalEventDetail>();
            try
            {
                
                if (model != null)
                {

                    if (model.EventTypeId == 0)
                    {
                        result.Success = false;
                        result.ResultMessage = "Event type is required";
                    }
                    else if (model.EventStatusId == 0)
                    {
                        result.Success = false;
                        result.ResultMessage = "Event status is required";
                    }
                    else if (model.EventDate == null)
                    {
                        result.Success = false;
                        result.ResultMessage = "Event date is required";
                    }
                    else if (model.ReferalStatusId == 0)
                    {
                        result.Success = false;
                        result.ResultMessage = "Refere status is required";
                    }
                    else if (model.ReferalId == 0)
                    {
                        result.Success = false;
                        result.ResultMessage = "Referal id is required";
                    }
                    else if (model.ReferalStatusResonId == 0)
                    {
                        result.Success = false;
                        result.ResultMessage = "Referal status resion is required";
                    }
                    else
                    {
                        model.CreatedOn = DateTime.Now.Date;
                        siterepo.SaveEvents(model, siteId, studyId);

                        result.Success = true;
                        result.Value = model;
                    }
                }
                else
                {

                    result.Success = false;
                    result.ResultMessage = "model is null";
                }



            }
            catch (Exception ex)
            {
                result.Success = false;
                result.ResultMessage = "Failed to save Data";
                result.ExceptionInfo = new ExceptionInfo(ex);
            }
            return JsonConvert.SerializeObject(result);
        }
        public string DeleteEvent(int Id)
        {
            var result = new DataServiceResult();
            try
            {
                siterepo.DeleteEvent(Id);

                result.Success = true;
                result.ResultMessage = "Deleted Successfully";



            }
            catch (Exception ex)
            {
                result.Success = false;
                result.ResultMessage = "Failed to delete Data";
                result.ExceptionInfo = new ExceptionInfo(ex);
            }
            return JsonConvert.SerializeObject(result);
        }
        [HttpGet]
        public string GetEventcombos()
        {
            var result = new DataServiceResult<EventsCombo>();
            try
            {
                var data = siterepo.GetEventsCombo();
                if (data != null)
                {
                    result.Success = true;
                    result.Value = data;

                }

            }
            catch (Exception ex)
            {
                result.Success = false;
                result.ExceptionInfo = new ExceptionInfo(ex);
            }
            //to emit reference loop
            var setting = new JsonSerializerSettings
            {
                Formatting = Newtonsoft.Json.Formatting.Indented, // Just for humans
                ReferenceLoopHandling = ReferenceLoopHandling.Ignore
            };
            return JsonConvert.SerializeObject(result);
        }

        public string GetApplicableProtocol(int studyId)
        {
            var result = new DataServiceResult<List<Core.Domain.StudyProtocol>>();
            try
            {
                var data = siterepo.GetApplicableProtocol(studyId);
                if (data != null)
                {
                    result.Success = true;
                    result.Value = data;

                }
            }
            catch (Exception ex)
            {
                result.Success = false;
                result.ExceptionInfo = new ExceptionInfo(ex);
            }
            return JsonConvert.SerializeObject(result);
        }
      
    }
}
