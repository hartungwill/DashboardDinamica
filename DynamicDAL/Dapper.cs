using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using System.Data;
using DTO;

namespace DynamicDAL
{
    public class Dapper
    {
        public static async Task<dynamic> ExecuteDynamicQuery(string procedure, object parametros)
        {
            return (await Util.DapperConnection.QueryAsync<dynamic>(procedure,
                parametros,
                commandType: CommandType.StoredProcedure, 
                commandTimeout: 9999)).ToList();
        }

        public static async Task<List<DashboardDinamicaDTO.Elemento>> ListaElementosAsync(int? ID_Usuario, int? ID_Dashboard)
        {
            var query = await Util.DapperConnection.QueryMultipleAsync("proc_Dash_Elemento_Modelo", new
            {
                ID_Usuario,
                ID_Dashboard
            }, commandType: CommandType.StoredProcedure, commandTimeout: 9999);

            return (await query.ReadAsync<DashboardDinamicaDTO.Elemento>()).ToList();
        }
        public static async Task<dynamic> ExecuteDynamicAsync(string SP_Call)
        {
            var query = (await Util.DapperConnection.QueryAsync<dynamic>(SP_Call
                , new { }
                , commandType: CommandType.Text, commandTimeout: 9999)).ToList();

            return query;
        }
    }
}
