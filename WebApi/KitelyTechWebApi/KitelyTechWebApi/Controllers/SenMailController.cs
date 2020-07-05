using Core.Domain;
using Core.Domain.Models;
using Core.Domain.Utility;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace KitelyTechWebApi.Controllers
{
    public class SenMailController : ApiController
    {
        [HttpPost]
        public string SendAdhokEmail(SendEmailModel mail)
        {
            
                var result = new DataServiceResult();
                try
                {

                    EmailHelper.Send(mail);
                    result.Success = true;
                    result.ResultMessage = "Mail send successfully";
                                 
                }
                catch (Exception ex)
                {
                    result.Success = false;
                result.ResultMessage = "Mail sending failed";
                result.ExceptionInfo = new ExceptionInfo(ex);
                }
                return JsonConvert.SerializeObject(result);
           
        }
    }
}
