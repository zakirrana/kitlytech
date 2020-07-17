using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Core.Domain
{
    
    /// <summary>
    /// This Data Service Returns the object of this class
    /// </summary>
    [Serializable]
    public class DataServiceResult
    {
        private int _resultCode;
        public bool Success { get; set; }
        public int ResultCode
        {
            get { return _resultCode; }
            set { _resultCode = value; Success = _resultCode == 0; }
        }
        public IEnumerable<string> errors { get; set; }
        public string ResultMessage { get; set; }
        public ExceptionInfo ExceptionInfo { get; set; }
    }


    /// <summary>
    /// Generic information class 
    /// </summary>
    /// <typeparam name="T"></typeparam>
    [Serializable]
    public class DataServiceResult<T> : DataServiceResult
    {
        public DataServiceResult() { }
        public T Value { get; set; }
    }


    [Serializable]
    public class ExceptionInfo
    {
        public ExceptionInfo()
        { }

        public ExceptionInfo(Exception ex)
        {
            Message = ex.Message;
            Source = ex.Source;
            StackTrace = ex.StackTrace;
            FullString = ex.ToString();
        }
      
        public string Message { get; set; }
        public string Source { get; set; }
        public string StackTrace { get; set; }
        public string FullString { get; set; }

        public override string ToString()
        {
            return FullString;
        }
    }
}
