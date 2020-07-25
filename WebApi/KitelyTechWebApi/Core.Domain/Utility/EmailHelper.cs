using Core.Domain.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Threading.Tasks;

namespace Core.Domain.Utility
{
    public static class EmailHelper
    {
        public static string smtp;
        public static string username;
        public static string password;
        public static string port;

        static EmailHelper()
        {
            smtp = System.Configuration.ConfigurationSettings.AppSettings["smtp"];
            username = System.Configuration.ConfigurationSettings.AppSettings["smtpuser"];
            password = System.Configuration.ConfigurationSettings.AppSettings["smtppass"];
            port = System.Configuration.ConfigurationSettings.AppSettings["smtpport"];
        }
        public static void Send(SendEmailModel email)
        {
            try
            {
                MailMessage message = new MailMessage();
                SmtpClient smtpclient = new SmtpClient();
                message.From = new MailAddress(email.From);
                foreach (var to in email.To.Split(new[] { ";" }, StringSplitOptions.RemoveEmptyEntries))
                {
                    message.To.Add(new MailAddress(to));
                }

                message.Subject = email.Subject;
                message.IsBodyHtml = email.IsHtml; //to make message body as html  
                message.Body = email.EmailBody;
                smtpclient.Port = Convert.ToInt32(port);
                smtpclient.Host = smtp; //for gmail host  
                smtpclient.EnableSsl = true;
                smtpclient.UseDefaultCredentials = true;
                smtpclient.Credentials = new NetworkCredential(username, password);
                smtpclient.DeliveryMethod = SmtpDeliveryMethod.Network;
                smtpclient.Send(message);
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }


    }
    public enum MessageType
    {
        Email=1,
        SMS=2       
    }
}
