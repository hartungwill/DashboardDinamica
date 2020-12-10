using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Dashboard.Util
{
    public class Utility
    {
        public static string execToJson(string procedure, object parametros)
        {
            var retornoBD = DynamicDAL.Dapper.ExecuteDynamicQuery(procedure, parametros);
            var json = JsonConvert.SerializeObject(retornoBD, Formatting.Indented);
            return json;
        }
    }
}