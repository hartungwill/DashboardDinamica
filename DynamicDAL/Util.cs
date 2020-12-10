using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Configuration;
using System.Data.SqlClient;

namespace DynamicDAL
{
    public class Util
    {

        private static string ConnectionString
        {
            get
            {
                return ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            }
        }

        public static SqlConnection DapperConnection
        {
            get
            {
                return new SqlConnection(ConnectionString);
            }
        }

    }
}
