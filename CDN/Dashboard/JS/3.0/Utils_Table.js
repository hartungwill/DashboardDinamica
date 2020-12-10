var Utils_Table = (function () {

    //const txtNext = 'Próximo &gt;&gt;';
    //const txtPrevious = '&lt;&lt; Anterior';
    const txtNext = 'Próximo';
    const txtPrevious = 'Anterior';
    const ItensPorPaginaPadrao = 6;
    const PaginaInicialPadrao = 1;
    const ItensVisiveisPadrao = 15;
    var tableData = {};

    function newTable() {
        return {
            TR: []
        };
    }

    function addPaginator(nomeTabela, paginaInicial, itensPorPagina, sp_call = null) {

        var $table = document.getElementById(nomeTabela);
        // number of rows of the table
        var $rowCount = $table.rows.length;
        // get the first cell's tag name (in the first row)
        var $firstRow = $table.rows[0].firstElementChild.tagName;
        // boolean var to check if table has a head row
        var $hasHead = ($firstRow === "TH");
        // an array to hold each row
        var $tr = [];
        // loop counters, to start count from rows[1] (2nd row) if the first row has a head tag
        var $i, $ii, $j = ($hasHead) ? 1 : 0;
        //$th = ($hasHead ? $table.rows[(0)].outerHTML : "");
        // count the number of pages
        var $pageCount = Math.ceil($rowCount / itensPorPagina);
        // if we had one page only, then we have nothing to do ..
        if ($pageCount > 1) {

            tableData[nomeTabela] = newTable();

            // assign each row outHTML (tag name & innerHTML) to the array
            for ($i = $j, $ii = 0; $i < $rowCount; $i++ , $ii++) {
                $tr[$ii] = $table.rows[$i].outerHTML;
                //Table_TR[$ii] = $table.rows[$i].outerHTML;
                tableData[nomeTabela].TR[$ii] = $table.rows[$i].outerHTML;
            }
            // create a div block to hold the buttons
            $table.insertAdjacentHTML("afterend", `<div class='btn-paginator' id='${nomeTabela}-buttons'></div`);
            // the first sort, default page is the first one
            if (sp_call !== null && sp_call !== undefined) {
                configuraPaginator(nomeTabela, paginaInicial, itensPorPagina, 0, sp_call);
            } else {
                Utils_Table.sortAuto(paginaInicial, nomeTabela, $pageCount, itensPorPagina);
            }
        }
    }

    function sortAuto($p, nomeTabela, pageCount, itensPorPagina) {

        var $s = ((itensPorPagina * $p) - itensPorPagina);
        var table = document.getElementById(nomeTabela);
        var i;
        var $rows = '';

        for (i = $s; i < ($s + itensPorPagina) && i < tableData[nomeTabela].TR.length; i++) {
            $rows += tableData[nomeTabela].TR[i];
        }

        table.tBodies[0].innerHTML = $rows;
        document.getElementById(`${nomeTabela}-buttons`).innerHTML = pageButtonsAuto(pageCount, $p, i, nomeTabela, itensPorPagina);
        document.getElementById(`${nomeTabela}-${$p}`).setAttribute("class", "active");
    }

    function pageButtonsAuto($pCount, $cur, $i, nomeTabela, itensPorPagina) {
        var $prevDis = ($cur == 1) ? "disabled" : "";
        var $nextDis = ($cur == $pCount) ? "disabled" : "";
        var $buttons = `<input type='button' id='${nomeTabela}-${$i}' value='${txtPrevious}' onclick='Utils_Table.sortAuto(${($cur - 1)},"${nomeTabela}",${$pCount},${itensPorPagina})' ${$prevDis}>`;

        for ($i = 1; $i <= $pCount; $i++) { // lógica do [...]
            //$buttons += `<input type='button' id='${nomeTabela}-${$i}' value='${$i}' onclick='Utils_Table.sortAuto(${$i},"${nomeTabela}",${$pCount},${itensPorPagina})'>`;
            $buttons += `<input type='button' id='${nomeTabela}-${$i}' value='${$i}' onclick='Utils_Table.sortAuto(${$i},"${nomeTabela}",${$pCount},${itensPorPagina})'>`;
        }

        $buttons += `<input type='button' id='${nomeTabela}-${$i}' value='${txtNext}' onclick='Utils_Table.sortAuto(${($cur + 1)},"${nomeTabela}",${$pCount},${itensPorPagina})' ${$nextDis}>`;
        return $buttons;
    }

    function sortDB($p, nomeTabela, pageCount, itensPorPagina, sp_call_original) {
        let sp_call = Dash_Util.processa_sp_call(sp_call_original, $p);
        let table = document.getElementById(nomeTabela);
        let $firstRow = table.rows[0].firstElementChild.tagName;
        let $hasHead = ($firstRow === "TH");
        // holds the first row if it has a (<TH>) & nothing if (<TD>)
        let th = ($hasHead ? table.rows[(0)].outerHTML : "");
        document.getElementById(`${nomeTabela}-buttons`).innerHTML = `<div  class="fa-3x loading text-center" style="flex-grow: 1;">
                                                                        <i class="fas fa-circle-notch fa-spin"></i>
                                                                        <p>Carregando</p>
                                                                    </div>`;
        table.tHead.innerHTML = '';
        table.tBodies[0].innerHTML = '';
        let html = '';

        const dataDynamic = {
            SP_Call: sp_call
        };

        Dash_Util.invokeVanilla(Dashboard_Actions.ExecuteDynamicAsync, 'POST', 'application/json', dataDynamic, true, function (resultDynamic) {

            if (resultDynamic !== null && resultDynamic.length > 0) {
                const qtdItensVisiveis = ItensVisiveisPadrao || resultDynamic[0].length;
                html += Loaders.getTBodyHTML(resultDynamic, qtdItensVisiveis);
            } else {
                let colspan = 0;
                html += `<tbody><tr><td style="padding: 0 !important;" colspan="${colspan}" >Não existem resultados disponíveis!</td></tr></tbody>`;
            }

            table.tHead.innerHTML = th;
            table.tBodies[0].innerHTML = html;

            configuraPaginator(nomeTabela, $p, itensPorPagina, pageCount, sp_call_original);
        });
    }

    function configuraPaginator(nomeTabela, pagina, itensPorPagina, pageCount, sp_call_original) {
        let table = document.getElementById(nomeTabela);
        let linhasAtual = table.tBodies[0].rows.length;

        document.getElementById(`${nomeTabela}-buttons`).innerHTML = pageButtonsDB(pagina, nomeTabela, itensPorPagina, linhasAtual);

        let buttons = table.nextElementSibling.getElementsByTagName('input');
        configuraCliquePaginator(buttons[0], pagina - 1, nomeTabela, pageCount, itensPorPagina, sp_call_original); // Anterior
        configuraCliquePaginator(buttons[1], pagina + 1, nomeTabela, pageCount, itensPorPagina, sp_call_original); // Próximo
    }

    function configuraCliquePaginator(button, pagina, nomeTabela, pageCount, itensPorPagina, sp_call_original) {

        button.addEventListener("click", function () {
            sortDB((pagina), nomeTabela, pageCount, itensPorPagina, sp_call_original);
            this.removeEventListener('click', arguments.callee, false);
        });
    }

    function pageButtonsDB($cur, nomeTabela, itensPorPagina, linhasAtual) {
        let $prevDis = ($cur == 1) ? "disabled" : "";
        let $nextDis = (linhasAtual < itensPorPagina) ? "disabled" : "";
        let $buttons = `<input type='button' id='${nomeTabela}-prev' value='${txtPrevious}' ${$prevDis}>`;
        $buttons += `<input type='button' id='${nomeTabela}-next' value='${txtNext}' ${$nextDis}>`;
        return $buttons;
    }

    var GerenciaItensOcultos = (function () {
        $(document).ready(function () {
            $('#Dashboard').on('click', '.table-custom td[data-acao="true"]', function () {
                const elementoClick = $(this);
                const elementoPai = elementoClick.closest('tr')
                const elementosOcultos = elementoPai.find('td:hidden');

                if ($(this).hasClass('expandir')) {
                    ExibirElementosOcultos(elementoPai, elementosOcultos);

                    $(this).removeClass('expandir');
                    $(this).addClass('recolher');
                } else {
                    RemoverElementos(elementoPai);

                    $(this).removeClass('recolher');
                    $(this).addClass('expandir');
                }

            });

        });

        function RemoverElementos(elementoPai) {
            const nextElement = $(elementoPai).next(); // referencia ao proximo elemento do tr clicado 

            // verifica se o proximo elemento eh a lista de itens ocultos. Se sim, remove
            if (nextElement.is('tr') && nextElement.hasClass('child')) {

                nextElement.fadeOut(200, function () {
                    nextElement.remove();
                });

            }
        }

        function ExibirElementosOcultos(elementoPai, elementosOcultos) {
            if (elementosOcultos.length <= 0)
                return;

            // cria lista dos itens ocultos para exibi-los
            var html = `
              <tr class="child">
                  <td class="child" colspan="${ItensVisiveisPadrao}">
                      <div class="grid grid-template-columns-2 child-titulo"> </div>
                  </td>
              </tr>`;

            // append da lista
            $(html).insertAfter(elementoPai);

            // referencia ao proximo elemento criado apos o insertAfter()
            const elementoCriado = elementoPai.next();

            // append elementos
            $.each(elementosOcultos, function (i, v) {
                elementoCriado.find('td.child > div').append(
                    `<span class="child-titulo">${$(v).attr('data-label')}</span>
                     <span class="child-valor">${$(v).text()}</span>`);
            });
        }

    })();

    return {
        addPaginator,
        sortAuto,
        sortDB,
        PaginaInicialPadrao,
        ItensPorPaginaPadrao,
        ItensVisiveisPadrao
    };

})();