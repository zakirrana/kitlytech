﻿using Core.Domain;
using Core.Domain.Models;
using Core.Domain.Repository.SiteRepository;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
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
        public string SaveApointMentDetail(string model)
        {
            var result = new DataServiceResult<ReferalApointment>();
            try
            {
                var dataModel = JsonConvert.DeserializeObject<ReferalApointment>(model);
                if (dataModel != null)
                {
                    siterepo.SaveApointMent(dataModel);

                    result.Success = true;
                    result.Value = dataModel;
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
        public string SaveEventsDetail(string model,int siteId,int studyId)
        {
            var result = new DataServiceResult<ReferalEventDetail>();
            try
            {
                var dataModel = JsonConvert.DeserializeObject<ReferalEventDetail>(model);
                if (dataModel != null)
                {
                    siterepo.SaveEvents(dataModel,siteId,studyId);

                    result.Success = true;
                    result.Value = dataModel;
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
