using Core.Domain;
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
                var data = siterepo.GeReferalDetail(referalId,studyId);
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
