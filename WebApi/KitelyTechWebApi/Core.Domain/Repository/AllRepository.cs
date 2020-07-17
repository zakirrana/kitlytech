using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Domain.Repository
{
    public class AllRepository<T> : _IAllRepository<T> where T : class

    {
        private CTMEntities _context;
        private IDbSet<T> dbEntity;

        public AllRepository()
        {
            _context = new CTMEntities();
            dbEntity = _context.Set<T>();
        }
        public void DeleteModel(int modelId)
        {
            T model = dbEntity.Find(modelId);
            dbEntity.Remove(model);
        }

        public IEnumerable<T> GetModel()
        {
            return dbEntity.ToList();
        }

        public T GetModelById(int modelId)
        {
            return dbEntity.Find(modelId);
        }

        public void InsertModel(T model)
        {
            dbEntity.Add(model);
        }

        public void Save()
        {
            _context.SaveChanges();
        }

        public void UpdateModel(T model)        {
            
            _context.Entry(model).State = System.Data.Entity.EntityState.Modified;
        }
    }
}
