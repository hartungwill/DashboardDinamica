var Loaders = (function () {
    var Config = (function () {
        const hover = {
            mode: 'nearest',
            intersect: true
        };

        function tooltip(percentualConvert = false) {
            if (percentualConvert) {
                return {
                    callbacks: {
                        label: function (tooltipItem, data) {
                            return data['datasets'][0]['data'][tooltipItem['index']] + '%';
                        }
                    }
                };
            } else {
                return {
                    mode: 'index',
                    intersect: false
                };
            }
        }

        function scales(stacked = false, displayTicks = true, displayGridLines = false) {
            return {

                xAxes: [{
                    ticks: {
                        maxBarThickness: 150,
                        display: displayTicks,
                        beginAtZero: true
                    },
                    gridLines: {
                        display: displayGridLines
                    },
                    stacked: stacked
                }],
                yAxes: [{
                    ticks: {
                        display: displayTicks,
                        beginAtZero: true
                    },
                    gridLines: {
                        display: displayGridLines
                    }
                }]

            };
        }

        return {
            scales,
            hover,
            tooltip
        };

    })();

    $(document).ready(function () {
        Chart.pluginService.register({
            beforeDraw: function (chart) {
                if (chart.config.options.elements.center) {
                    //Get ctx from string
                    var ctx = chart.chart.ctx;

                    //Get options from the center object in options
                    var centerConfig = chart.config.options.elements.center;
                    var fontStyle = centerConfig.fontStyle || 'Arial';
                    var txt = centerConfig.text;
                    var color = centerConfig.color || '#000';
                    var sidePadding = centerConfig.sidePadding || 20;
                    var sidePaddingCalculated = (sidePadding / 100) * (chart.innerRadius * 2)
                    //Start with a base font of 30px
                    ctx.font = "30px " + fontStyle;

                    //Get the width of the string and also the width of the element minus 10 to give it 5px side padding
                    var stringWidth = ctx.measureText(txt).width;
                    var elementWidth = (chart.innerRadius * 2) - sidePaddingCalculated;

                    // Find out how much the font can grow in width.
                    var widthRatio = elementWidth / stringWidth;
                    var newFontSize = Math.floor(30 * widthRatio);
                    var elementHeight = (chart.innerRadius * 2);

                    // Pick a new font size so it will not be larger than the height of label.
                    var fontSizeToUse = Math.min(newFontSize, elementHeight);

                    //Set font settings to draw it correctly.
                    ctx.textAlign = 'center';
                    ctx.textBaseline = 'middle';
                    var centerX = ((chart.chartArea.left + chart.chartArea.right) / 2);
                    var centerY = ((chart.chartArea.top + chart.chartArea.bottom) / 2);
                    ctx.font = fontSizeToUse + "px " + fontStyle;
                    ctx.fillStyle = color;

                    //Draw text in center
                    ctx.fillText(txt, centerX, centerY);
                }
            }
        });
    });

    const filtro = function (elemento) {
        return new Promise(async (resolve, reject) => {
            let resultDynamic = await Graficos.ExecuteDynamic(elemento);
            document.getElementById(elemento.IDComponente).innerHTML = getFiltroHTML(resultDynamic, elemento);

            Graficos.RefreshFloatingLabel(document.getElementById(elemento.IDComponente));
            resolve();
        });

        function getFiltroHTML(resultDynamic, elemento) {
            const arrDados = [];

            var html = '';

            for (let i = 0; i < resultDynamic.length; i++) {
                const obj = {
                    'key': resultDynamic[i][0].Value,
                    'value': resultDynamic[i][1].Value
                };
                arrDados.push(obj);
            }

            if (elemento.ConteudoSecundario == 'dropdown') {
                html += '<option value="" disabled selected></option>';
            }


            for (let i = 0; i < arrDados.length; i++) {
                html += `<option value="${arrDados[i].key}">${arrDados[i].value}</option>`;
            }
            return html;
        }
    };

    const chart = function (elemento) {
        return new Promise(async (resolve, reject) => {
            let resultDynamic = await Graficos.ExecuteDynamic(elemento);

            if (elemento.Html) {
                document.getElementById(`${Graficos.boxPrefix}${elemento.IDComponente}`).innerHTML = `<div><h5 class="titulo">${elemento.Titulo}</h5></div><canvas style="${elemento.Html}" id="${elemento.IDComponente}"></canvas><div id=${elemento.IDComponente}-Legenda class="chart-legenda"></div>`;
            } else {
                document.getElementById(`${Graficos.boxPrefix}${elemento.IDComponente}`).innerHTML = `<div><h5 class="titulo">${elemento.Titulo}</h5></div><canvas id="${elemento.IDComponente}"></canvas><div id=${elemento.IDComponente}-Legenda class="chart-legenda"></div>`;
            }

            let ctx = document.getElementById(elemento.IDComponente);

            // Carrega as configurações com base no tipo do gráfico (concantena nome e executa function)
            let config = window["Loaders"][`${elemento.ConteudoSecundario}Config`](resultDynamic, elemento);

            var chart = new Chart(ctx, config);
            renderLegendaGraficos(chart, elemento);
            resolve();
        });
    };

    const table = function (elemento) {
        return new Promise(async (resolve, reject) => {
            let resultDynamic = await Graficos.ExecuteDynamic(elemento);

            document.getElementById(`${Graficos.boxPrefix}${elemento.IDComponente}`).innerHTML = getTableHTML(resultDynamic, elemento);

            if (elemento.ConteudoSecundario == 'paginadoBD') {
                Utils_Table.addPaginator(elemento.IDComponente, Utils_Table.PaginaInicialPadrao, Utils_Table.ItensPorPaginaPadrao, elemento.SP_Call);
            } else if (elemento.ConteudoSecundario == 'paginadoAuto') {
                Utils_Table.addPaginator(elemento.IDComponente, Utils_Table.PaginaInicialPadrao, Utils_Table.ItensPorPaginaPadrao);
            }

            resolve();
        });

        function getTableHTML(resultDynamic, elemento) {
            var html = '';

            const qtdItensVisiveis = Utils_Table.ItensVisiveisPadrao || resultDynamic[0].length;

            if (resultDynamic !== null && resultDynamic.length > 0) {
                html += `<h5 class="titulo">${elemento.Titulo}</h5>`;
                html += `<table class='table-custom' id="${elemento.IDComponente}">`;
                html += '<thead>';
                html += '<tr>';

                for (var j = 0; j < resultDynamic[0].length; j++) {

                    html += `<th ${j >= qtdItensVisiveis ? `data-show="false"` : `data-show="true"`}>` + // oculta as colunas
                        `${resultDynamic[0][j].Key}` +
                        `</th>`;
                }

                html += '</tr>';
                html += '</thead>';
                html += '<tbody>';
                html += getTBodyHTML(resultDynamic, qtdItensVisiveis);
                html += '<tbody>';

                html += '</tbody>';
                html += '</table>';
            } else {
                html += '<thead></thead><tbody><tr><td style="padding: 0 !important;">Não existem resultados disponíveis!</td></tr></tbody>';
            }

            return html;
        }
    };

    const custom = function (elemento) {
        return new Promise(async (resolve, reject) => {
            const html = await Graficos.GetExternalHTML(elemento.Html);
            Graficos.container.querySelector(`[data-idelemento="${elemento.IDElemento}"]`).appendChild(html);
            eval(Graficos.container.querySelector(`[data-idelemento="${elemento.IDElemento}"]`).querySelector('script').innerText);
            resolve();
        });
    };

    const relatorio = function (elemento) {
        return new Promise(async (resolve, reject) => {
            let resultDynamic = await Graficos.ExecuteDynamic(elemento);

            document.getElementById(`${Graficos.boxPrefix}${elemento.IDComponente}`).innerHTML = getRelatorioHTML(resultDynamic, elemento);;

            resolve();
        });

        function getRelatorioHTML(resultDynamic, elemento) {
            var html = '';

            if (resultDynamic !== null && resultDynamic.length > 0) {
                html += `<h5 class="titulo">${elemento.Titulo}</h5>`;

                for (var linha = 0; linha < resultDynamic.length; linha++) {

                    var corFonte = '';
                    var corFundo = '';
                    var descricao = '';
                    var caminhoArquivo = '';

                    for (var coluna = 0; coluna < resultDynamic[linha].length; coluna++) {
                        let valorAtual = resultDynamic[linha][coluna].Value;

                        switch (coluna) {

                            case 0: // Descrição
                                descricao = valorAtual;
                                break;

                            case 1: // Cor Primária: fonte
                                corFonte = valorAtual;
                                break;

                            case 2: // Cor Secundária: Fundo
                                corFundo = valorAtual;
                                break;

                            case 3: // Dados
                                caminhoArquivo = valorAtual;
                                break;
                        }
                    }

                    html += `<button type="button" id="${elemento.IDComponente}-${linha}" class="button-relatorio btn-spinner" style="background: ${corFundo}; color: ${corFonte};" onclick="Graficos.GeraRelatorio('${caminhoArquivo}', this);">`;
                    html += `<i class="fas fa-file-excel mr-2" aria-hidden="true"></i>${descricao}</button>`;
                }
            }

            return html;
        }
    };

    const map = function (elemento) {
        return new Promise(async (resolve, reject) => {
            let resultDynamic = await Graficos.ExecuteDynamic(elemento);
            initializeMap(resultDynamic, elemento);

            resolve();
        });

        function setMapOnAll(map, markers) {
            for (let i = 0; i < markers.length; i++) {
                markers[i].setMap(map);
            }
        }

        function initializeMap(resultDynamic, elemento) {

            let initLatLng = new google.maps.LatLng(-15.0000, -49.6388);
            let markers = [];
            let mapa = new google.maps.Map(document.getElementById(`${elemento.IDComponente}`), {
                zoom: 4,
                //draggable: false,
                disableDefaultUI: true, // Esconde controles para habilitar individualmente
                zoomControl: true,
                mapTypeControl: false,
                scaleControl: false,
                streetViewControl: false,
                fullscreenControl: false,
                center: initLatLng
            });

            // Início do loop
            for (let linha = 0; linha < resultDynamic.length; linha++) {
                let image = '';
                let latitude = '';
                let longitude = '';

                for (let coluna = 0; coluna < resultDynamic[linha].length; coluna++) {
                    switch (coluna) {

                        case 0: // Descrição
                            break;

                        case 1: // Image
                            image = resultDynamic[linha][coluna].Value;
                            break;

                        case 2: // Latitude
                            latitude = resultDynamic[linha][coluna].Value;
                            break;

                        case 3: // Longitude
                            longitude = resultDynamic[linha][coluna].Value;
                            break;
                    }
                }

                codeLatLong(mapa, image, latitude, longitude, markers);
            }

            if (markers) {
                setMapOnAll(mapa, markers);
            }

            mapa.panTo(initLatLng); //centraliza mapa
        }

        function codeLatLong(map, image, lat, long, markers) {
            let position = new google.maps.LatLng(lat, long);

            let marker = new google.maps.Marker({
                map: map,
                icon: image,
                position: position
            });

            markers.push(marker);
        }
    };

    const badge = function (elemento) {
        return new Promise(async (resolve, reject) => {
            let resultDynamic = await Graficos.ExecuteDynamic(elemento);

            document.getElementById(`${Graficos.boxPrefix}${elemento.IDComponente}`).innerHTML = getBadgeHTML(resultDynamic, elemento);

            resolve();
        });

        function getBadgeHTML(resultDynamic, elemento) {
            var html = '';

            let valorAtual;
            let valorReal = '';
            let valorMeta = '';
            let valorPerc = '';
            let corReal = '';
            let corMeta = '';
            let corPerc = '';
            let descricaoReal = '';
            let descricaoMeta = '';
            let descricaoPerc = '';

            for (let linha = 0; linha < resultDynamic.length; linha++) { // Linhas
                for (let coluna = 0; coluna < resultDynamic[linha].length; coluna++) { // Colunas
                    valorAtual = resultDynamic[linha][coluna].Value;

                    switch (coluna) {

                        case 0: // Descrição
                            colunaAtual = valorAtual;

                            if (linha === 0) { // 1ª linha - Meta
                                descricaoMeta = valorAtual;
                            } else if (linha === 1) { // 2ª linha - Real
                                descricaoReal = valorAtual;
                            } else if (linha === 2) { // 3ª linha - Percentual
                                descricaoPerc = valorAtual;
                            }
                            break;

                        case 1: // Cor Primária: fonte
                            if (linha === 0) { // 1ª linha - Meta
                                corMeta = valorAtual;
                            } else if (linha === 1) { // 2ª linha - Real
                                corReal = valorAtual;
                            } else if (linha === 2) { // 3ª linha - Percentual
                                corPerc = valorAtual;
                            }
                            break;

                        case 2: // Cor Secundária: fundo (não utilizada)
                            break;

                        default: // Dados
                            if (linha === 0) { // 1ª linha - Meta - Valor a ser considerado 100%
                                valorMeta = valorAtual;
                            } else if (linha === 1) { // Valor a ser calculado
                                valorReal = valorAtual;
                            } else if (linha === 2) { //Percentual
                                valorPerc = valorAtual;
                            }
                            break;
                    }
                }
            }

            var percentual = !isNaN(valorReal) && !isNaN(valorMeta) && !valorPerc ? Dash_Util.calculate(valorReal, valorMeta) : valorPerc;
            //var restante = ((100 - percentual) < 0) ? 0 : (100 - percentual);

            // Titulo
            html += `<div>
                        <h5 class="titulo">${elemento.Titulo}</h5>
                    </div>`;

            //Box
            html += `<div>
                        <div class="meta" style="color:${corReal};">${valorReal}</div>
                        <div class="real" style="color:${corMeta};">${descricaoMeta}:${valorMeta} (<text style="color:${corPerc};">${percentual}%</text>)</div>
                    </div>`;

            // Legenda
            html += `<div id="${elemento.IDComponente}-Legenda" class="chart-legenda">
                        <ul>
                            <li>
                                <span style="background-color: ${corMeta};"></span>
                                    ${descricaoMeta}
                            </li>
                            <li>
                                <span style="background-color: ${corReal};"></span>
                                    ${descricaoReal}
                            </li>
                        </ul>
                    </div>`;

            return html;
        }
    };

    function renderLegendaGraficos(chart, elemento) {
        // array com graficos que irao possuir Legenda Customizada (legendCallback)
        const arrGraficosLegendasCustomizada = ["doughnut"];

        if (arrGraficosLegendasCustomizada.includes(elemento.ConteudoSecundario)) {
            $(`#${Graficos.boxPrefix}${elemento.IDComponente}`).find(`#${elemento.IDComponente}-Legenda`).append(chart.generateLegend());
        } else {
            $(`#${Graficos.boxPrefix}${elemento.IDComponente}`).find(`#${elemento.IDComponente}-Legenda`).append(chart.generateLegend());
        }
    }

    function calcAspectRatio(IDComponente, TipoSecundario) {
        var elementoAtual = document.getElementById(IDComponente).parentElement.parentElement;
        var qtd = elementoAtual.querySelectorAll('.item').length;
        var dimensao = getDimensaoTela();

        if (qtd === 1) {
            if (dimensao == 'mobile') {
                return 2;
            } else {
                if (TipoSecundario === 'bar') {
                    return 2;
                } else {
                    return 4;
                }
            }

        } else if (qtd === 2) {
            return 2;
        } else if (qtd > 2 && qtd < 4) {
            return 2;
        } else if (qtd >= 4) {
            if (TipoSecundario == 'doughnutCustom') {
                return 1.5;
            } else if (TipoSecundario == 'doughnut') {
                return 1;
            } else {
                return 1;
            }
        } else {
            return 2;
        }
    }

    function getDimensaoTela() {
        let width = window.innerWidth;
        let dimensao = 'desktop';

        switch (true) {
            case (width >= 768):
                dimensao = 'desktop';
                break;

            case (width <= 767): // sm e xs
                dimensao = 'mobile';
                break;

            case (width >= 768 && width <= 991):
                dimensao = 'md';
                break;

            case (width >= 576 && width <= 767):
                dimensao = 'sm';
                break;

            case (width <= 575):
                dimensao = 'xs';
                break;
        }

        return dimensao.toLowerCase();
    }

    function newLegendaPercentual(legenda, valor) { // Novo objeto de legenda (para o percentual)
        return {
            key: legenda.key,
            value: `${valor}%`,
            backgroundColor: legenda.backgroundColor,
            fontColor: legenda.fontColor
        };
    }

    function newDataSet(tipo) {
        switch (tipo) {
            case 'stacked':
                return {
                    type: {},
                    label: [],
                    backgroundColor: {},
                    stack: {},
                    borderColor: {},
                    data: [],
                    fill: false,
                    lineTension: 0,
                    dataReal: [],
                    fontColor: {}
                };
            case 'stackedGroup':
                return {
                    type: {},
                    label: [],
                    backgroundColor: {},
                    stack: {},
                    borderColor: {},
                    data: [],
                    fill: false,
                    lineTension: 0,
                    dataReal: [],
                    pointRadius: 0,
                    fontColor: {}
                };
            case 'custom':
                return {
                    type: {},
                    label: [],
                    backgroundColor: {},
                    borderColor: {},
                    data: [],
                    fill: false,
                    lineTension: 0,
                    dataReal: [],
                    fontColor: {}
                };
            case 'doughnut':
                return {
                    label: '',
                    legenda: {},
                    data: [],
                    backgroundColor: [],
                    borderColor: [],
                    borderWidth: 0,
                    fontColor: {}
                };

            case 'doughnutCustom':
                return {
                    label: '',
                    legenda: {},
                    data: [],
                    backgroundColor: [],
                    borderColor: [],
                    borderWidth: 0,
                    fontColor: {}
                };

            case 'line':
                return {
                    type: tipo,
                    label: [],
                    backgroundColor: {},
                    borderColor: {},
                    data: [],
                    fill: false,
                    //lineTension: 1,
                    dataReal: [],
                    fontColor: {}
                };

            default:
                return {
                    type: tipo,
                    label: [],
                    backgroundColor: {},
                    borderColor: {},
                    data: [],
                    fill: false,
                    lineTension: 0,
                    dataReal: [],
                    maxBarThickness: 100,
                    fontColor: {}
                };
        }
    }

    function getDataset(resultDynamic, elemento, singleDataSet = false) {
        var chartData = {
            labels: [],
            datasets: {}
        };

        for (let i = 0; i < resultDynamic.length; i++) { // Linhas

            if (singleDataSet) {
                i = 0;
            } else {
                chartData.datasets[i] = newDataSet(elemento.ConteudoSecundario);
            }

            for (let coluna = 0; coluna < resultDynamic[i].length; coluna++) { // Colunas
                let keyAtual = resultDynamic[i][coluna].Key;
                let valorAtual = resultDynamic[i][coluna].Value;

                switch (coluna) {

                    case 0: // Descrição
                        chartData.datasets[i].label.push(valorAtual);
                        break;

                    case 1: // Cor Primária: ponto, fonte
                        chartData.datasets[i].fontColor = valorAtual;
                        break;

                    case 2: // Cor Secundária: linha, barra, area
                        chartData.datasets[i].borderColor = valorAtual;
                        chartData.datasets[i].backgroundColor = valorAtual;
                        break;

                    default: // Dados
                        if ((valorAtual === 'line' || valorAtual === 'bar')) { // Tipo do DataSet para os gráficos agrupados
                            chartData.datasets[i].type = valorAtual;

                            if (elemento.ConteudoSecundario == 'stacked' || elemento.ConteudoSecundario == 'stackedGroup') {
                                if (valorAtual === 'line') {
                                    delete chartData.datasets[i].stack;
                                } else {
                                    chartData.datasets[i].stack = valorAtual;
                                }
                            }

                        } else {
                            if (chartData.labels.indexOf(keyAtual) === -1) // Se não existir no array, Título da Coluna
                                chartData.labels.push(keyAtual);

                            chartData.datasets[i].data.push(valorAtual);
                        }
                        break;
                }

            }
        }
        return chartData;
    }

    function getTBodyHTML(resultDynamic, qtdItensVisiveis) {
        var html = '';
        const ocultarBtnVerMais = resultDynamic[0].length > qtdItensVisiveis ? true : false;

        for (var linha = 0; linha < resultDynamic.length; linha++) {
            html += '<tr>';

            for (var coluna = 0; coluna < resultDynamic[linha].length; coluna++) {
                html += `<td ${coluna >= qtdItensVisiveis ? `data-show="false"` : `data-show="true"`}` + // oculta as colunas
                    `${coluna == 0 ? `class="expandir" data-acao="true"` : ``}` +  // add btn expandir na primeira coluna
                    `${coluna == (qtdItensVisiveis - 1) ? `last-visible-element="true"` : ``}` +  // add btn expandir na primeira coluna
                    `data-label="${resultDynamic[linha][coluna].Key}">${resultDynamic[linha][coluna].Value}` +
                    `</td>`;
            }

            // remove btn expandir
            if (ocultarBtnVerMais == false) {
                html = html.replace(`class="expandir"`, ``);
                html = html.replace(`data-acao="true"`, ``);
            }

            html += '</tr>';
        }

        return html;
    }

    //Charts
    function pieConfig(resultDynamic, elemento) {
        var arrData = [];
        var arrLabels = [];
        var arrCorFonte = [];
        var arrCorFundo = [];

        for (let i = 0; i < resultDynamic.length; i++) { // Linhas

            for (let coluna = 0; coluna < resultDynamic[i].length; coluna++) { // Colunas
                let valorAtual = resultDynamic[i][coluna].Value;

                if (coluna === 0) { // Descrição
                    arrLabels.push(valorAtual);
                } else if (coluna === 1) { // Cor da Fonte
                    arrCorFonte.push(valorAtual);

                } else if (coluna === 2) { // Cor do Fundo
                    arrCorFundo.push(valorAtual);

                } else { // Dado
                    arrData.push(valorAtual);
                }
            }
        }

        var config = {
            type: elemento.ConteudoSecundario,
            data: {
                datasets: [{
                    data: arrData,
                    backgroundColor: arrCorFundo,
                    label: elemento.Titulo
                }],
                labels: arrLabels
            },
            options: {
                title: {
                    display: true,
                    position: 'top',
                    //text: elemento.Titulo,
                    fontSize: 18
                },
                tooltips: {
                    enabled: false
                },
                layout: {
                    padding: {
                        bottom: 40
                    }
                },
                legend: {
                    display: false
                },
                responsive: true,
                aspectRatio: calcAspectRatio(elemento.IDComponente, elemento.ConteudoSecundario),
                onResize: function (chart, size) {
                    chart.aspectRatio = calcAspectRatio(elemento.IDComponente, elemento.ConteudoSecundario); // recalcula a dimensao do grafico
                },
                plugins: {
                    datalabels: {
                        display: true,
                        anchor: 'end',
                        align: 'end',
                        color: function (context) {
                            return arrCorFonte[context.dataIndex] || '#000';
                        }
                    }
                }
            }
        };

        return config;
    }

    function lineConfig(resultDynamic, elemento) {
        var lineBarChartData = getDataset(resultDynamic, elemento);
        lineBarChartData.datasets = Object.keys(lineBarChartData.datasets).map(i => lineBarChartData.datasets[i]);

        if (typeof getCustomConfig === "function")
            return getCustomConfig(lineBarChartData, elemento, elemento.ConteudoSecundario, 'center', 'top');
        else
            return getCommonConfig(lineBarChartData, elemento, elemento.ConteudoSecundario, 'center', 'top');
    }

    function horizontalBarConfig(resultDynamic, elemento) {
        var horizontalBarChartData = getDataset(resultDynamic, elemento);
        horizontalBarChartData.datasets = Object.keys(horizontalBarChartData.datasets).map(i => horizontalBarChartData.datasets[i]);

        if (typeof getCustomConfig === "function")
            return getCustomConfig(horizontalBarChartData, elemento, elemento.ConteudoSecundario, 'end', 'left');
        else
            return getCommonConfig(horizontalBarChartData, elemento, elemento.ConteudoSecundario, 'end', 'left');
    }

    function barConfig(resultDynamic, elemento) {
        var barChartData = getDataset(resultDynamic, elemento);
        barChartData.datasets = Object.keys(barChartData.datasets).map(i => barChartData.datasets[i]);

        if (typeof getCustomConfig === "function")
            return getCustomConfig(barChartData, elemento, elemento.ConteudoSecundario);
        else
            return getCommonConfig(barChartData, elemento, elemento.ConteudoSecundario);
    }

    function customConfig(resultDynamic, elemento) {
        var barChartData = getDataset(resultDynamic, elemento);
        barChartData.datasets = Object.keys(barChartData.datasets).map(i => barChartData.datasets[i]);

        if (typeof getCustomConfig === "function")
            return getCustomConfig(barChartData, elemento, 'bar');
        else
            return getCommonConfig(barChartData, elemento, 'bar');
    }

    function stackedConfig(resultDynamic, elemento) {
        var chartData = getDataset(resultDynamic, elemento);
        chartData.datasets = Object.keys(chartData.datasets).map(i => chartData.datasets[i]);

        if (typeof getCustomConfig === "function")
            return getCustomConfig(chartData, elemento, 'bar', 'center', 'center', true);
        else
            return getCommonConfig(chartData, elemento, 'bar', 'center', 'center', true);
    }

    function stackedGroupConfig(resultDynamic, elemento) {
        var chartData = getDataset(resultDynamic, elemento);
        chartData.datasets = Object.keys(chartData.datasets).map(i => chartData.datasets[i]);

        if (typeof getCustomConfig === "function")
            return getCustomConfig(chartData, elemento, 'bar', 'center', 'center', true);
        else
            return getCommonConfig(chartData, elemento, 'bar', 'center', 'center', true);
    }

    function doughnutConfig(resultDynamic, elemento) {
        let valorAtual;
        let colunaAtual;
        let vReal;
        let vMeta;
        let colunas = [];
        let isFirstBar = true;

        var donutBarChartData = {
            labels: [],
            datasets: {}
        };

        donutBarChartData.datasets[0] = newDataSet(elemento.ConteudoSecundario);

        for (let j = 0; j < resultDynamic.length; j++) { // Linhas
            for (let coluna = 0; coluna < resultDynamic[j].length; coluna++) { // Colunas
                valorAtual = resultDynamic[j][coluna].Value;

                switch (coluna) {

                    case 0: // Descrição
                        colunaAtual = valorAtual;
                        donutBarChartData.datasets[0].legenda[colunaAtual] = {
                            key: {},
                            value: {},
                            backgroundColor: {},
                            fontColor: {}
                        };

                        donutBarChartData.datasets[0].legenda[colunaAtual].key = valorAtual;
                        donutBarChartData.labels.push(valorAtual);
                        colunas.push(colunaAtual);
                        break;

                    case 1: // Cor Primária: ponto, fonte
                        donutBarChartData.datasets[0].legenda[colunaAtual].fontColor = valorAtual;
                        break;

                    case 2: // Cor Secundária: linha, barra, area
                        donutBarChartData.datasets[0].legenda[colunaAtual].backgroundColor = valorAtual;
                        donutBarChartData.datasets[0].backgroundColor.push(valorAtual);
                        break;

                    default: // Dados
                        donutBarChartData.datasets[0].data.push(valorAtual);
                        donutBarChartData.datasets[0].legenda[colunaAtual].value = valorAtual;

                        if (j === 0) { // Valor a ser considerado 100% sempre em primeiro
                            vReal = valorAtual;
                        } else { // Valor a ser calculado
                            vMeta = valorAtual;
                        }

                        break;
                }
            }
        }

        var percentual = Dash_Util.calculate(vReal, vMeta);
        var restante = ((100 - percentual) < 0) ? 0 : (100 - percentual);

        //==========================vv // Substitui valores nas 'legendas'(box) para o percentual
        //for (var IDlegenda = 0; IDlegenda < colunas.length; IDlegenda++) {
        //    if (IDlegenda == 0) {
        //        donutBarChartData.datasets[0].legenda[colunas[IDlegenda]] = newLegendaPercentual(donutBarChartData.datasets[0].legenda[colunas[IDlegenda]], percentual)
        //    } else {
        //        donutBarChartData.datasets[0].legenda[colunas[IDlegenda]] = newLegendaPercentual(donutBarChartData.datasets[0].legenda[colunas[IDlegenda]], restante)
        //    }
        //}
        //==========================^^
        // Substitui valores no 'data' pelo percentual
        donutBarChartData.datasets[0].labels = colunas;
        donutBarChartData.datasets[0].data = [percentual, restante];
        donutBarChartData.datasets[0].customData = `${Math.round(percentual)}%`;

        //Tradução de Array para objeto
        donutBarChartData.datasets[0].legenda = Object.keys(donutBarChartData.datasets[0].legenda).map(i => donutBarChartData.datasets[0].legenda[i])
        donutBarChartData.datasets = Object.keys(donutBarChartData.datasets).map(i => donutBarChartData.datasets[i])

        var config = getCommonConfig(donutBarChartData, elemento, elemento.ConteudoSecundario);

        return config;
    }

    function doughnutCustomConfig(resultDynamic, elemento) {
        return doughnutConfig(resultDynamic, elemento);
    }

    function getCommonConfig(chartData, elemento, tipoGrafico, anchor = 'center', align = 'center', stacked = false, corLegenda = 'black') {

        switch (elemento.ConteudoSecundario) {
            case 'line':
                return {
                    type: elemento.ConteudoSecundario,
                    data: chartData,
                    options: {
                        aspectRatio: calcAspectRatio(elemento.IDComponente, elemento.ConteudoSecundario),
                        responsive: true,
                        title: {
                            display: false
                        },
                        legend: {
                            display: false
                        },
                        tooltips: Config.tooltip(),
                        hover: Config.hover,
                        scales: Config.scales(stacked),
                        plugins: {
                            datalabels: {
                                display: 'auto',
                                //anchor: anchor,
                                //align: align,
                                clamp: true,
                                backgroundColor: function (context) {
                                    return context.dataset.backgroundColor;
                                },
                                borderRadius: 4,
                                color: function (context) {
                                    return context.dataset.fontColor;
                                }
                                //padding: {
                                //    bottom: -50
                                //}
                            }
                        }
                    }
                };


            case 'doughnutCustom':
                return {
                    type: 'doughnut',
                    data: chartData,
                    options: {
                        aspectRatio: calcAspectRatio(elemento.IDComponente, elemento.ConteudoSecundario),
                        responsive: true,
                        title: {
                            display: false
                        },
                        legend: {
                            display: false,
                            reverse: true
                        },
                        tooltips: Config.tooltip(true),
                        scales: Config.scales(stacked, false),
                        legendCallback: function (chart) {
                            const legenda = chart.data.datasets[0].legenda;
                            return `
                                    <div class="legenda cima">
                                        ${legenda.map(item => `
                                            <div class="item" style="background-color: ${item.backgroundColor}; color: ${item.fontColor};">
                                                <div class="titulo">${item.key}</div>
                                                <div class="valor">${item.value}</div>
                                            </div>`).join(``)}
                                    </div>`;
                        },
                        plugins: {
                            datalabels: {
                                display: false
                            }
                        },
                        elements: {
                            center: {
                                text: chartData.datasets[0].customData,
                                color: '#666', // Default is #000000
                                fontStyle: 'Arial', // Default is Arial
                                sidePadding: 20 // Defualt is 20 (as a percentage)
                            }
                        },
                    }
                };

            case 'doughnut':
                return {
                    type: elemento.ConteudoSecundario,
                    data: chartData,
                    options: {
                        cutoutPercentage: 80,
                        aspectRatio: calcAspectRatio(elemento.IDComponente, elemento.ConteudoSecundario),
                        responsive: true,
                        title: {
                            display: false
                        },
                        legend: {
                            display: false
                        },
                        tooltips: Config.tooltip(true),
                        scales: Config.scales(stacked, false),
                        plugins: {
                            datalabels: {
                                formatter: function (value, context) {
                                    return value <= 0 ? '' : `${value}%`;
                                },
                                anchor: anchor,
                                align: align,
                                labels: {
                                    title: {
                                        color: corLegenda
                                    }
                                }
                            }
                        }
                    }
                };

            case 'custom':
                return {
                    type: tipoGrafico,
                    data: chartData,
                    options: {
                        aspectRatio: calcAspectRatio(elemento.IDComponente, elemento.ConteudoSecundario),
                        responsive: true,
                        title: {
                            display: false
                        },
                        legend: {
                            display: false
                        },
                        tooltips: Config.tooltip(),
                        hover: Config.hover,
                        scales: Config.scales(stacked),
                        plugins: {
                            datalabels: {
                                display: function (context) {
                                    if (context.dataset.type === 'bar') {
                                        return context.dataset.data[context.dataIndex] !== 0;
                                    } else if (context.dataset.type === 'line') {
                                        return context.dataset.data[context.dataIndex] !== 0;
                                    } else {
                                        return false;
                                    }
                                },
                                anchor: anchor,
                                align: align,
                                labels: {
                                    title: {
                                        //color: corLegenda
                                        color: function (context) {
                                            return context.dataset.fontColor;
                                        }
                                    }
                                },
                                formatter: function (value, context) {
                                    if (context.dataset.type === 'line') {
                                        return `${value}%`;
                                    }
                                },
                                backgroundColor: function (context) {
                                    return context.dataset.backgroundColor;
                                },
                                borderRadius: 4,
                                color: function (context) {
                                    return context.dataset.fontColor;
                                }
                            }
                        }
                    }
                };

            default:
                return {
                    type: tipoGrafico,
                    data: chartData,
                    options: {
                        aspectRatio: calcAspectRatio(elemento.IDComponente, elemento.ConteudoSecundario), // aqui
                        responsive: true,
                        //maintainAspectRatio: true,
                        title: {
                            display: false
                        },
                        legend: {
                            display: false
                        },
                        tooltips: Config.tooltip(),
                        hover: Config.hover,
                        scales: Config.scales(stacked, false),
                        plugins: {
                            datalabels: {
                                display: function (context) {
                                    if (context.dataset.type === 'bar') {
                                        return context.dataset.data[context.dataIndex] !== 0;
                                    } else {
                                        return false;
                                    }
                                },
                                anchor: anchor,
                                align: align,
                                labels: {
                                    title: {
                                        color: corLegenda
                                    }
                                }
                            }
                        }
                    }
                };
        }
    }

    return {
        filtro,
        chart,
        table,
        custom,
        map,
        badge,
        horizontalBarConfig,
        doughnutConfig,
        pieConfig,
        barConfig,
        lineConfig,
        customConfig,
        stackedConfig,
        stackedGroupConfig,
        doughnutCustomConfig,
        relatorio,
        getDimensaoTela,
        getTBodyHTML
    };
})();