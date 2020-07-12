using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Domain.Repository.CommonRepository
{
    public class EmailSmsRepository
    {
        
        private CTMEntities dbContext;
        public EmailSmsRepository()
        {            
            this.dbContext = new CTMEntities();
            dbContext.Configuration.LazyLoadingEnabled = false;
        }
        public void SaveEmailSMSEntry(SendSmsOrEmail model)
        {
            var repo = new AllRepository<SendSmsOrEmail>();
            if (model.Id == 0)
            {                
                model.CreatedOn = DateTime.Now.Date;
                repo.InsertModel(model);
            }
            else
            {
                repo.UpdateModel(model);

            }
            repo.Save();

        }
        public List<SendSmsOrEmail> GetSendSmsEmailList()
        {
            List<SendSmsOrEmail> result = new List<SendSmsOrEmail>();
            return dbContext.SendSmsOrEmails.ToList();           

        }
        public void DeleteEmailSmsEntry(int Id)
        {
            var repo = new AllRepository<ReferalEventDetail>();
            if (Id > 0)
            {
                repo.DeleteModel(Id);
            }

            repo.Save();
        }
    }
}
