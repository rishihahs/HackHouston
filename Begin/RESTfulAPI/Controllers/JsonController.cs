//using RESTfulAPI.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using RESTfulAPI.Services;

namespace RESTfulAPI.Controllers
{
    public class JsonController : ApiController
    {
        private JsonRepository jsonRepository;

        public JsonController()
        {
            this.jsonRepository = new JsonRepository();
        }

        public string Get(string tableName)
        {
            return jsonRepository.GetAllJsons(tableName, null);
        }

        public string Get(string tableName, string department)
        {
            return jsonRepository.GetAllJsons(tableName, department);
        }
    }
}
