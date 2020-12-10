using Dashboard.Util;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DTO;
using System.Threading.Tasks;
using System.Net.Http;

namespace Dashboard.Controllers
{
    public class DashboardController : Controller
    {
        #region Variáveis
        private int IDUsuario = 1987; // Usuário logado da sessão/cookie
        #endregion

        #region Actions
        // GET: Dashboard
        public ActionResult Index(int id)
        {
            ViewBag.ID_Dashboard = id;
            return View();
        }
        #endregion
        
        #region Jsonresult (AJAX)

        [HttpPost]
        [Route("Canvas_Lista_Clip_Modelo")]
        public JsonResult Canvas_Lista_Clip_Modelo(int? IDTemplate_Usuario, int? IDTemplate)
        {
            string procedure = "sp_FT_Lista_Clip_Modelo";

            object parametros = new
            {
                IDUsuario,
                IDTemplate_Usuario,
                IDTemplate
            };

            return Json(Utility.execToJson(procedure, parametros), JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        [Route("ListaElementosAsync")]
        public async Task<JsonResult> ListaElementosAsync(int? ID_Dashboard)
        {
            try
            {
                var retorno = await DynamicDAL.Dapper.ListaElementosAsync(IDUsuario, ID_Dashboard);
                return Json(retorno, JsonRequestBehavior.AllowGet);
            }
            catch (Exception exc)
            {
                Response.StatusCode = 500;
                return Json(exc.Message, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        [Route("ExecuteDynamicAsync")]
        public async Task<JsonResult> ExecuteDynamicAsync(string SP_Call)
        {
            try
            {
                var retorno = await DynamicDAL.Dapper.ExecuteDynamicAsync(SP_Call);
                return Json(retorno, JsonRequestBehavior.AllowGet);
            }
            catch (Exception exc)
            {
                Response.StatusCode = 500;
                return Json(exc.Message, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        [Route("GetRelatorioAsync")]
        public JsonResult GetRelatorioAsync(string CaminhoRelatorio)
        {
            try
            {
                return Json(CaminhoRelatorio, JsonRequestBehavior.AllowGet);
            }
            catch (Exception exc)
            {
                Response.StatusCode = 500;
                return Json(exc.Message, JsonRequestBehavior.AllowGet);
            }
        }

        #endregion
    }
}