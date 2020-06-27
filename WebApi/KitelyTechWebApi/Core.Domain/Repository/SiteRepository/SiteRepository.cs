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
            this.dbContext= new CTMEntities();
        }
        public IEnumerable<Study> GetStudiesAll()
        {
            return this.istudyobject.GetModel();
        }

        public List<StudyList> GeStudiesBySiteId(int siteId,string serach,int from,int to)
        {
            List<StudyList> result=new List<StudyList>() ;
            var data = dbContext.sp_site_GetStudiesBySiteId(siteId,serach,from,to).ToList();
            if (data != null && data.Count > 0)
            {
                foreach (var value in data)
                {
                    StudyList objstudy = new StudyList();
                    objstudy.Id = value.Id;
                    objstudy.StudyTitle = value.StudyTitle;
                    objstudy.Status = value.Status;
                    objstudy.StatusId = value.StatusId ?? 0;
                    objstudy.Audit.CreatedBy = value.CreatedBy;
                    objstudy.Audit.CreatedOn = value.CreatedOn;
                    objstudy.Audit.ModifiedOn = value.ModifiedOn;
                    objstudy.Audit.ModyfiedBy = value.ModyfiedBy;
                    result.Add(objstudy);

                }
            }
            return result;


        }
       
    }
}
