var Graficos = (function () {
    const container = document.querySelector('#Dashboard');
    let arrElementos;
    let LeftElements = [];
    let RightElements = [];
    const boxPrefix = 'box-';
    const loadingDiv = '<div class="fa-3x loading text-center" style="flex-grow: 1;"><i class="fas fa-circle-notch fa-spin"></i><p>Carregando</p></div>';
    //let ID_Dashboard = Dashboard_ID;
    //const ID_Dashboard = 3;

    function inicializar() {
        getElementos()
            .then(montarEsqueletoPagina)
            .then(carregarDadosDoBanco)
            .then(configurarFloatingLabels);

        //$('option').mousedown(function (e) {
        //    e.preventDefault();

        //    var select = this;
        //    var scroll = select.scrollTop;

        //    e.target.selected = !e.target.selected;

        //    setTimeout(function () { select.scrollTop = scroll; }, 0);
        //    Graficos.ddlChange(select.parentElement.id)
        //    $(select).focus();
        //}).mousemove(function (e) { e.preventDefault() });			

    }

    function getElementos() {
        return new Promise((resolve, reject) => {

            Dash_Util.invokeVanilla(Dashboard_Actions.ListaElementosAsync, 'POST', 'application/json', dataListaElementosAsync, true, function (result) {
                if (result !== null && result.length > 0) {
                    arrElementos = result;
                    resolve();
                } else {
                    const msgError = 'Dashboard - Erro ao listar os Elementos - Nenhum item encontrado.';
                    console.warn(msgError);
                    reject(msgError);
                }
            });

        });
    }
    function montarEsqueletoPagina() {
        return new Promise((resolve, reject) => {
            let html = '';
            for (var i = 0; i < arrElementos.length; i++) {
                if (i === 0)
                    html += '<div class="linha">';
                if (i > 0 && arrElementos[i].Linha !== arrElementos[i - 1].Linha)
                    html += '</div><div class="linha">';

                html += renderizarMockupItem(arrElementos[i]);

                if (i === arrElementos.length - 1)
                    html += '</div>';
            }
            container.insertAdjacentHTML('beforeend', html);
            resolve();
        });
    }

    function renderizarMockupItem(elemento) {
        switch (elemento.ConteudoPrimario) {
            case 'label':
                return `<div class="item label" data-idelemento="${elemento.IDElemento}">
                            <h1>${elemento.Titulo}</h1>
                        </div>`;
            case 'filtro':
                if (elemento.ConteudoSecundario == 'dropdown') {
                    return `<div class="item filtro" data-idelemento="${elemento.IDElemento}">
                            <div class="box-floating">
                                <select id="${elemento.IDComponente}" class="${elemento.Html}" data-concatena="${elemento.ConcatenaFiltros}" onchange="Graficos.ddlChange('${elemento.IDComponente}')" >
                                    <option value="0">Carregando...</option>
                                </select>
                                <label class="label-floating">${elemento.Titulo}</label>
                            </div>
                        </div>`;
                } else if (elemento.ConteudoSecundario == 'multiple') {
                    return `<div class="item filtro" data-idelemento="${elemento.IDElemento}">
                            <div class="box-multiple">
                                <label>${elemento.Titulo}</label>
                                <select ${elemento.ConteudoSecundario} id="${elemento.IDComponente}" class="${elemento.Html}" data-concatena="${elemento.ConcatenaFiltros}" onchange="Graficos.ddlChange('${elemento.IDComponente}')" >
                                    <option value="0">Carregando...</option>
                                </select>                            
                            </div>
                        </div>`;
                }
                break;
            case 'chart':
                return `<div class="item chart" data-idelemento="${elemento.IDElemento}" id="${boxPrefix}${elemento.IDComponente}">
                            ${loadingDiv}
                        </div>`;
            case 'custom':
                return `<div class="item" data-idelemento="${elemento.IDElemento}"></div>`;
            case 'table':
                return `<div class="item table" data-idelemento="${elemento.IDElemento}"  id="${boxPrefix}${elemento.IDComponente}">
                            ${loadingDiv}
                        </div>`;
            case 'relatorio':
                return `<div class="item table" data-idelemento="${elemento.IDElemento}" id="${boxPrefix}${elemento.IDComponente}">
                           ${loadingDiv}
                        </div>`;
            case 'map':
                return `<div class="item map-box" data-idelemento="${elemento.IDElemento}" id="${boxPrefix}${elemento.IDComponente}">
                            <div><h5 class="titulo">${elemento.Titulo}</h5></div>
                            <div class="map" id="${elemento.IDComponente}">
                                ${loadingDiv}
                            </div>
                        </div>`;
            case 'badge':
                return `<div class="item badge-box" data-idelemento="${elemento.IDElemento}" id="${boxPrefix}${elemento.IDComponente}">
                           ${loadingDiv}
                        </div>`;
        }
    }

    function carregarDadosDoBanco(arrElementosParaAtualizar) {
        return new Promise((resolve, reject) => {
            if (!arrElementosParaAtualizar)
                arrElementosParaAtualizar = arrElementos;
            const arrPromises = [];
            for (let i = 0; i < arrElementosParaAtualizar.length; i++) {
                if (Loaders[arrElementosParaAtualizar[i].ConteudoPrimario]) {
                    arrPromises.push(Loaders[arrElementosParaAtualizar[i].ConteudoPrimario](arrElementosParaAtualizar[i]));
                }
            }

            Promise.all(arrPromises).then(() => {
                resolve();
            });
        });
    }
    function configurarFloatingLabels() {
        return new Promise((resolve, reject) => {
            //$('.floating-select').attr('value', '');
            $('.floating-select').on('change', function () { RefreshFloatingLabel(this); });
            $('.floating-select').on('focusout', function () { RefreshFloatingLabel(this); });
            $('.floating-select').on('mouseover', function () { RefreshFloatingLabel(this); });
            $('.floating-select').on('mouseout', function () { RefreshFloatingLabel(this); });


            //$('.floating-input').attr('value', '');
            $('.floating-input').on('input', function () { RefreshFloatingLabel(this); });
            $('.floating-input').on('focusout', function () { RefreshFloatingLabel(this); });
            $('.floating-input').on('mouseover', function () { RefreshFloatingLabel(this); });
            $('.floating-input').on('mouseout', function () { RefreshFloatingLabel(this); });

            // tentativa de javascript puro
            //const floatingSelect = document.querySelectorAll('.floating-select');
            //for (var i = 0; i < floatingSelect.length; i++) {
            //    console.log(floatingSelect[i]);
            //    floatingSelect[i].value = '';
            //    //floatingSelect[i].addEventListener("change", RefreshFloatingLabel(floatingSelect[i]));
            //    //floatingSelect[i].addEventListener("focusout", RefreshFloatingLabel(floatingSelect[i]));
            //    //floatingSelect[i].addEventListener("mouseover", RefreshFloatingLabel(floatingSelect[i]));
            //    //floatingSelect[i].addEventListener("mouseout", RefreshFloatingLabel(floatingSelect[i]));
            //    floatingSelect[i].onchange = function () { RefreshFloatingLabel(floatingSelect[i]); }
            //    floatingSelect[i].onfocusout = function () { RefreshFloatingLabel(floatingSelect[i]); }
            //    floatingSelect[i].onmouseover = function () { RefreshFloatingLabel(floatingSelect[i]); }
            //    floatingSelect[i].onmouseout = function () { RefreshFloatingLabel(floatingSelect[i]); }
            //}

            //const floatingInput = document.querySelectorAll('.floating-input');
            //for (var i = 0; i < floatingInput.length; i++) {
            //    console.log(floatingInput[i]);
            //    floatingInput[i].value = '';
            //    //floatingInput[i].addEventListener("input", RefreshFloatingLabel(this));
            //    //floatingInput[i].addEventListener("focusout", RefreshFloatingLabel(this));
            //    //floatingInput[i].addEventListener("mouseover", RefreshFloatingLabel(this));
            //    //floatingInput[i].addEventListener("mouseout", RefreshFloatingLabel(this));
            //    //floatingInput[i].onchange = function () { RefreshFloatingLabel(this); }
            //    floatingInput[i].onfocusout = function () { RefreshFloatingLabel(floatingInput[i]); }
            //    floatingInput[i].onmouseover = function () { RefreshFloatingLabel(floatingInput[i]); }
            //    floatingInput[i].onmouseout = function () { RefreshFloatingLabel(floatingInput[i]); }
            //}
            resolve();
        });
    }

    function RefreshFloatingLabel(elemento) {
        if (elemento.value == '')
            //elemento.value = '';
            elemento.setAttribute('value', '');
        else
            //elemento.value = elemento.value;
            elemento.setAttribute('value', elemento.value);
    }

    function ExecuteDynamic(elemento) {
        return new Promise((resolve, reject) => {
            if (!elemento.SP_Call) {
                console.warn('Procedure nâo encontrada para o elemento', elemento.IDComponente);
                reject();
            }

            let sp_call = Dash_Util.processa_sp_call(elemento.SP_Call);
            if (elemento.ConcatenaFiltros) {
                let parametros = '';
                const filtros = getValoresFiltrosString(elemento);// Valida se é filtro
                if (filtros) {
                    parametros += filtros.length > 0 ? ',' + filtros : ''; // loop de valores dos filtros
                    sp_call += parametros;
                }
            }
            console.log(sp_call);
            const dataDynamic = {
                SP_Call: sp_call
            };
            Dash_Util.invokeVanilla(Dashboard_Actions.ExecuteDynamicAsync, 'POST', 'application/json', dataDynamic, true, function (resultDynamic) {
                if (resultDynamic !== null && resultDynamic.length > 0) {
                    if (resultDynamic !== null && resultDynamic.length > 0) {
                        resolve(resultDynamic);
                    } else {
                        console.warn('Dashboard - Erro ao listar os Elementos - Nenhum item encontrado.');
                        reject();
                    }
                    resolve();
                } else {
                    console.warn('Dashboard - Erro ao listar os Elementos - Nenhum item encontrado.');
                    reject();
                }
            });
        });
    }
    function GetExternalHTML(url) {
        return new Promise((resolve, reject) => {
            var xhr = new XMLHttpRequest();

            xhr.onload = function () {
                resolve(new DOMParser().parseFromString(this.response, 'text/html').querySelector('body').firstChild);
            };

            xhr.open("GET", url, true);
            xhr.setRequestHeader('Content-type', 'text/html');
            xhr.send();
        });
    }

    //FILTROS   
    function getValoresFiltrosObject() {
        const arrFiltros = container.querySelectorAll('.item.filtro select');
        const data = {};

        for (let i = 0; i < arrFiltros.length; i++) {
            data[arrFiltros[i].id] = arrFiltros[i].value;
        }

        return data;
    }

    function getValoresFiltrosString(elemento) {

        if (elemento.ConteudoPrimario === 'filtro') { // Se filtro, pega filtros em cascata
            let valueFiltros = []; // zera variável global de filtros
            valueFiltros = getFiltroCascata(elemento.IDComponente);
            return valueFiltros;
        } else {
            const arrFiltros = container.querySelectorAll('.item.filtro select');
            const data = [];
            for (let i = 0; i < arrFiltros.length; i++)
                if (arrFiltros[i].value) {
                    let values = getSelectValues(arrFiltros[i]);
                    data.push(`'${values}'`);
                }
                else {
                    data.push(0);
                }

            return data.join(',');
        }
    }

    function getSelectValues(select) {
        let result = [];
        let options = select && select.options;
        let opt;

        for (let i = 0, iLen = options.length; i < iLen; i++) {
            opt = options[i];

            if (opt.selected) {
                result.push(opt.value || opt.text);
            }
        }
        return result.join('|');
    }

    function getFiltroCascata(IDFiltro) {
        var valueFiltros = []; // zera variável global de filtros
        valueFiltros = getValoresFiltrosByFiltro(IDFiltro, valueFiltros);// pegar filtros dos elementos anteriores

        return valueFiltros;
    }

    function getValoresFiltrosByFiltro(IDFiltro, valueFiltros) {
        var elementoAnterior = null;

        if (document.getElementById(IDFiltro) &&
            document.getElementById(IDFiltro).parentElement &&
            document.getElementById(IDFiltro).parentElement.parentElement &&
            document.getElementById(IDFiltro).parentElement.parentElement.previousSibling) {

            elementoAnterior = document.getElementById(IDFiltro).parentElement.parentElement.previousSibling;

            if (elementoAnterior) {
                var elementoAtual = elementoAnterior.getElementsByClassName('floating-select')[0];
                if (elementoAtual) {
                    if (elementoAtual.value) {
                        valueFiltros.unshift(elementoAtual.value);
                    } else {
                        valueFiltros.unshift(0);
                    }
                    getValoresFiltrosByFiltro(elementoAtual.id, valueFiltros);
                    return valueFiltros;
                }
            }
        }
    }

    function getFiltroAnterior(IDFiltro) {
        let elementoAnterior = null;

        if (document.getElementById(IDFiltro) &&
            document.getElementById(IDFiltro).parentElement &&
            document.getElementById(IDFiltro).parentElement.parentElement &&
            document.getElementById(IDFiltro).parentElement.parentElement.previousSibling) {

            elementoAnterior = document.getElementById(IDFiltro).parentElement.parentElement.previousSibling;

            if (elementoAnterior) {
                let elementoAtual = elementoAnterior.getElementsByClassName('floating-select')[0];
                if (elementoAtual) {
                    return elementoAtual;
                } else {
                    elementoAtual = elementoAnterior.getElementsByClassName('multiple-select')[0];
                    if (elementoAtual) {
                        return elementoAtual;
                    }
                }
            }
        }
    }

    function getFiltroProximo(IDFiltro) {
        let elementoProximo = null;

        if (document.getElementById(IDFiltro) &&
            document.getElementById(IDFiltro).parentElement &&
            document.getElementById(IDFiltro).parentElement.parentElement &&
            document.getElementById(IDFiltro).parentElement.parentElement.nextSibling) {

            elementoProximo = document.getElementById(IDFiltro).parentElement.parentElement.nextSibling;

            //console.log('===================vv');
            //console.log('ElementoPróximo');
            //console.log(elementoProximo);
            //console.log('===================^^');

            if (elementoProximo) {
                let elementoAtual = elementoProximo.querySelector('select');
                if (elementoAtual) {
                    return elementoAtual;
                }
            }
        }
    }

    function getFiltroProximaLinha(IDFiltro) {
        let elementoProximo = null;

        if (document.getElementById(IDFiltro).parentElement.parentElement.parentElement.nextSibling && // linha
            document.getElementById(IDFiltro).parentElement.parentElement.parentElement.nextSibling.firstChild &&  // Div item filtro
            document.getElementById(IDFiltro).parentElement.parentElement.parentElement.nextSibling.firstChild.querySelector('select')) {

            elementoProximo = document.getElementById(IDFiltro).parentElement.parentElement.parentElement.nextSibling.firstChild;

            //console.log('===================vv');
            //console.log('ElementoPróximo');
            //console.log(elementoProximo);
            //console.log('===================^^');

            if (elementoProximo) {
                let elementoAtual = elementoProximo.querySelector('select');
                if (elementoAtual) {
                    return elementoAtual;
                }
            }
        }
    }

    function mostrarLoadingItens(arrElementosParaAtualizar) {
        return new Promise((resolve, reject) => {
            arrElementosParaAtualizar.forEach(elemento => {
                const divItem = document.querySelector(`.item[data-idelemento="${elemento.IDElemento}"]`);
                const newDivItem = renderizarMockupItem(elemento);
                if (divItem) {
                    divItem.innerHTML = newDivItem;
                }

                resolve();
            });
        });
    }

    function mostrarLoadingFiltros(arrElementosParaAtualizar) {
        return new Promise((resolve, reject) => {
            arrElementosParaAtualizar.forEach(elemento => {
                document.getElementById(elemento.IDComponente).innerHTML = '</option><option value="0">Carregando...</option>';

                resolve();
            });
        });
    }

    function filtraFiltros(elemento) {
        //console.log(LeftElements);

        if (elemento.ConteudoPrimario !== 'filtro') {
            return false;
        } else if (elemento.ConcatenaFiltros !== true) {
            return false;
        } else {
            for (let i = 0; i < LeftElements.length; i++) {
                //console.log(LeftElements[i].id);
                //console.log(elemento.IDComponente);
                //console.log('===================^^ ');
                if (LeftElements[i] !== undefined && LeftElements[i].id === elemento.IDComponente) {
                    return false;
                } else {
                    return true;
                }
            }
        }
        //return true;
    }

    function ddlChange(IDComponente) {
        return new Promise((resolve, reject) => {
            //LeftElements = [];
            RightElements = [];
            let arrGraficosParaAtualizar = arrElementos.filter(elemento => elemento.ConcatenaFiltros === true && elemento.ConteudoPrimario !== 'filtro');

            //let filtroDOM = document.getElementById(IDComponente);

            //if (!filtroDOM.getAttribute('data-last-select')) {
            //    filtroDOM.setAttribute('data-last-select', filtroDOM.value);
            //    //filtroDOM.setAttribute('data-last-select', filtroDOM.value);
            //} 

            //if (!filtroDOM.getAttribute('value')) {
            //    if (filtroDOM.getAttribute('data-last-select')) {
            //        let lastValue = filtroDOM.getAttribute('data-last-select');
            //        //console.log('lastValue');
            //        //console.log(lastValue);
            //        filtroDOM.setAttribute('value', lastValue);
            //    }                
            //} 

            // LeftElements
            //let nivelAnterior = getFiltroAnterior(IDComponente);
            //while (nivelAnterior) {
            //    LeftElements.push(nivelAnterior);
            //    //q
            //    //let lastValue = nivelAnterior.getAttribute('data-last-select');
            //    //console.log(lastValue);
            //    //nivelAnterior.setAttribute('value', lastValue);

            //    //console.log(nivelAnterior);
            //    nivelAnterior = getFiltroAnterior(nivelAnterior.id);
            //    //console.log(nivelAnterior);
            //}

            let nivelProximo = getFiltroProximo(IDComponente);
            let nivelAtual = '';
            //console.log(nivelProximo);
            while (nivelProximo) {
                RightElements.push(nivelProximo);

                nivelAtual = getFiltroProximo(nivelProximo.id);

                if (nivelAtual === undefined) {
                    nivelProximo = getFiltroProximaLinha(nivelProximo.id);
                } else {
                    nivelProximo = nivelAtual;
                }
            }

            let arrFiltrosParaAtualizar = [];
            //arrFiltrosParaAtualizar = arrFiltrosParaAtualizar.filter(filtraFiltros);
            //arrFiltrosParaAtualizar.filter(item => LeftElements.filter(left => left.id === item.IDComponente).length <= 0);
            //arrFiltrosParaAtualizar.filter(item => LeftElements.filter(left => left.id === item.IDComponente).length <= 0);

            RightElements.forEach((filtro) => {
                arrFiltrosParaAtualizar.push(arrElementos.filter(elemento => elemento.IDComponente == filtro.id)[0]);
            });

            //console.log('===================vv');
            //console.log('Elementos arrFiltrosParaAtualizar');
            //console.log(arrFiltrosParaAtualizar);
            //console.log('===================^^');

            //console.log('===================vv');
            ////console.log('Elementos à esquerda');
            ////console.log(LeftElements);
            //console.log('Elementos arrFiltrosParaAtualizar');
            //console.log(arrFiltrosParaAtualizar);
            ////console.log('Elementos à direita');
            ////console.log(RightElements);
            //console.log('===================^^');

            if (arrFiltrosParaAtualizar !== undefined && arrFiltrosParaAtualizar.length > 0) {
                mostrarLoadingItens(arrGraficosParaAtualizar)
                    .then(() => carregarDadosDoBanco(arrFiltrosParaAtualizar))
                    .then(() => carregarDadosDoBanco(arrGraficosParaAtualizar))
                    .then(configurarFloatingLabels);

            } else {
                mostrarLoadingItens(arrGraficosParaAtualizar)
                    .then(() => carregarDadosDoBanco(arrGraficosParaAtualizar))
                    .then(configurarFloatingLabels);
            }

            resolve();
        });
    }

    function GeraRelatorio(caminhoArquivo, botao) {
        const seletorBotao = `#${botao.id}`;
        Dash_Util.toggleSpin(seletorBotao);

        const data = {
            'CaminhoRelatorio': caminhoArquivo
        };

        Dash_Util.invokeVanilla(Dashboard_Actions.GetRelatorioAsync, 'POST', 'application/json', data, true, function (result) {
            if (result !== null && result.length > 0) {
                Dash_Util.resetSpin(seletorBotao);
                location.href = result;
            } else {
                const msgError = 'Dashboard - Erro ao listar os Elementos - Nenhum item encontrado.';
                console.warn(msgError);
            }
        });
    }

    return {
        ddlChange,
        GeraRelatorio,
        ExecuteDynamic,
        GetExternalHTML,
        boxPrefix,
        RefreshFloatingLabel,
        container,
        getFiltroProximo,
        getFiltroProximaLinha,
        inicializar,
        mostrarLoadingItens,
        montarEsqueletoPagina,
        renderizarMockupItem
    };

})();