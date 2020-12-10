using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DTO
{
    public class DashboardDinamicaDTO
    {
        public class Elemento
        {
            public int IDElemento { get; set; }
            public int IDDashboard { get; set; }
            public int Linha { get; set; }
            public string IDComponente { get; set; }
            public string ConteudoPrimario { get; set; }
            public string ConteudoSecundario { get; set; }
            public string Titulo { get; set; }
            public string SP_Call { get; set; }
            public bool? ConcatenaFiltros { get; set; }
            public string Html { get; set; }
        }
    }
}
