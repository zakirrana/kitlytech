using Core.Domain;
using Core.Domain.Models;
using Core.Domain.Repository.CommonRepository;
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
    public class SendMailController : ApiController
    {
        private EmailSmsRepository emailrepo = new EmailSmsRepository();
        [HttpPost]
        public string SendAdhokEmail(SendEmailModel mail)
        {

            var result = new DataServiceResult();
            try
            {

                EmailHelper.Send(mail);
                var data = new SendSmsOrEmail();
                data.MessageContent = mail.emailBody;
                data.MessageDate = DateTime.Now.Date;
                data.MessgeType = mail.MessageType;
                data.To = mail.to;
                data.Subject = mail.subject;
                data.From = mail.from;
                data.MessageReciver = mail.reciver;
                emailrepo.SaveEmailSMSEntry(data);
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
        public string GetSendSmsEmailList()
        {
            var result = new DataServiceResult<List<SendSmsOrEmail>>();
            try
            {
                var data = emailrepo.GetSendSmsEmailList();
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
        public string DeleteEmailSmsEntry(int Id)
        {
            var result = new DataServiceResult();
            try
            {
                emailrepo.DeleteEmailSmsEntry(Id);

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
    }
}
