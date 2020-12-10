var Dashboard = (function () {
    //const container = document.querySelector('#Dashboard');

    document.addEventListener('DOMContentLoaded', Inicializar);

    async function Inicializar() {
        configurarTema();
        //configurarFloatingLabels();
    }
    //function configurarFloatingLabels() {
    //    $('.floating-select').attr('value', '');
    //    $('.floating-select').on('change', function () { RefreshFloatingLabel(this); });
    //    $('.floating-select').on('focusout', function () { RefreshFloatingLabel(this); });
    //    $('.floating-select').on('mouseover', function () { RefreshFloatingLabel(this); });
    //    $('.floating-select').on('mouseout', function () { RefreshFloatingLabel(this); });
    //    $('.floating-input').attr('value', '');
    //    $('.floating-input').on('input', function () { RefreshFloatingLabel(this); });
    //    $('.floating-input').on('focusout', function () { RefreshFloatingLabel(this); });
    //    $('.floating-input').on('mouseover', function () { RefreshFloatingLabel(this); });
    //    $('.floating-input').on('mouseout', function () { RefreshFloatingLabel(this); });

    //    function RefreshFloatingLabel(elemento) {
    //        if (elemento.value === '')
    //            elemento.setAttribute('value', '');
    //        else
    //            elemento.setAttribute('value', elemento.value);
    //    }
    //}
    //function carregarGraficosTeste() {
    //    var ctx = document.getElementById('myChart');
    //    var myChart = new Chart(ctx, {
    //        type: 'horizontalBar',
    //        data: {
    //            labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
    //            datasets: [{
    //                label: '# of Votes',
    //                data: [12, 19, 3, 5, 2, 3],
    //                backgroundColor: [
    //                    'rgba(255, 99, 132, 0.2)',
    //                    'rgba(54, 162, 235, 0.2)',
    //                    'rgba(255, 206, 86, 0.2)',
    //                    'rgba(75, 192, 192, 0.2)',
    //                    'rgba(153, 102, 255, 0.2)',
    //                    'rgba(255, 159, 64, 0.2)'
    //                ],
    //                borderColor: [
    //                    'rgba(255, 99, 132, 1)',
    //                    'rgba(54, 162, 235, 1)',
    //                    'rgba(255, 206, 86, 1)',
    //                    'rgba(75, 192, 192, 1)',
    //                    'rgba(153, 102, 255, 1)',
    //                    'rgba(255, 159, 64, 1)'
    //                ],
    //                borderWidth: 1
    //            }]
    //        },
    //        options: {
    //            aspectRatio: 1,
    //            scales: {
    //                yAxes: [{
    //                    ticks: {
    //                        beginAtZero: true
    //                    }
    //                }]
    //            }
    //        }
    //    });
        
    //    var ctx2 = document.getElementById('myChart2');
    //    var myChart2 = new Chart(ctx2, {
    //        type: 'doughnut',
    //        data: {
    //            datasets: [{
    //                label: '# of Votes',
    //                data: [12, 19, 3, 5, 2, 3],
    //                backgroundColor: [
    //                    'rgba(255, 99, 132, 0.2)',
    //                    'rgba(54, 162, 235, 0.2)',
    //                    'rgba(255, 206, 86, 0.2)',
    //                    'rgba(75, 192, 192, 0.2)',
    //                    'rgba(153, 102, 255, 0.2)',
    //                    'rgba(255, 159, 64, 0.2)'
    //                ],
    //                borderColor: [
    //                    'rgba(255, 99, 132, 1)',
    //                    'rgba(54, 162, 235, 1)',
    //                    'rgba(255, 206, 86, 1)',
    //                    'rgba(75, 192, 192, 1)',
    //                    'rgba(153, 102, 255, 1)',
    //                    'rgba(255, 159, 64, 1)'
    //                ],
    //                borderWidth: 1
    //            }]
    //        },
    //        options: {
    //            aspectRatio: 2,
    //            scales: {
    //                yAxes: [{
    //                    ticks: {
    //                        beginAtZero: true
    //                    }
    //                }]
    //            }
    //        }
    //    });

    //    var ctx3 = document.getElementById('myChart3');
    //    var myChart3 = new Chart(ctx3, {
    //        type: 'horizontalBar',
    //        data: {
    //            labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
    //            datasets: [{
    //                label: '# of Votes',
    //                data: [12, 19, 3, 5, 2, 3],
    //                backgroundColor: [
    //                    'rgba(255, 99, 132, 0.2)',
    //                    'rgba(54, 162, 235, 0.2)',
    //                    'rgba(255, 206, 86, 0.2)',
    //                    'rgba(75, 192, 192, 0.2)',
    //                    'rgba(153, 102, 255, 0.2)',
    //                    'rgba(255, 159, 64, 0.2)'
    //                ],
    //                borderColor: [
    //                    'rgba(255, 99, 132, 1)',
    //                    'rgba(54, 162, 235, 1)',
    //                    'rgba(255, 206, 86, 1)',
    //                    'rgba(75, 192, 192, 1)',
    //                    'rgba(153, 102, 255, 1)',
    //                    'rgba(255, 159, 64, 1)'
    //                ],
    //                borderWidth: 1
    //            }]
    //        },
    //        options: {
    //            aspectRatio: 1,
    //            scales: {
    //                yAxes: [{
    //                    ticks: {
    //                        beginAtZero: true
    //                    }
    //                }]
    //            }
    //        }
    //    });

    //    var ctx4 = document.getElementById('myChart4');
    //    var myChart4 = new Chart(ctx4, {
    //        type: 'doughnut',
    //        data: {
    //            datasets: [{
    //                label: '# of Votes',
    //                data: [12, 19, 3, 5, 2, 3],
    //                backgroundColor: [
    //                    'rgba(255, 99, 132, 0.2)',
    //                    'rgba(54, 162, 235, 0.2)',
    //                    'rgba(255, 206, 86, 0.2)',
    //                    'rgba(75, 192, 192, 0.2)',
    //                    'rgba(153, 102, 255, 0.2)',
    //                    'rgba(255, 159, 64, 0.2)'
    //                ],
    //                borderColor: [
    //                    'rgba(255, 99, 132, 1)',
    //                    'rgba(54, 162, 235, 1)',
    //                    'rgba(255, 206, 86, 1)',
    //                    'rgba(75, 192, 192, 1)',
    //                    'rgba(153, 102, 255, 1)',
    //                    'rgba(255, 159, 64, 1)'
    //                ],
    //                borderWidth: 1
    //            }]
    //        },
    //        options: {
    //            aspectRatio: 2,
    //            scales: {
    //                yAxes: [{
    //                    ticks: {
    //                        beginAtZero: true
    //                    }
    //                }]
    //            }
    //        }
    //    });
    //}

    function configurarTema() {
        const model = {
            Dash_CorFundo: '#3f3490',
            Dash_Titulo_Cor: '#ffffff',
            Dash_Item_Fundo: '#ffffff',
            Dash_Filtro_Label_Cor: '#000000'
        };

        $('body').append(`
        <style>
            body {
                background-color: ${model.Dash_CorFundo};
            }

            #Dashboard .linha .item.label {
                color: ${model.Dash_Titulo_Cor};
            }

            #Dashboard .linha .item .box-floating .label-floating {
                color: ${model.Dash_Filtro_Label_Cor};
            }

            #Dashboard .linha .item.chart {
                background-color: ${model.Dash_Item_Fundo};
            }

            #Dashboard .linha .item.table {
                background-color: ${model.Dash_Item_Fundo};
            }

            #Dashboard .linha .item.map-box {
                background-color: ${model.Dash_Item_Fundo};
            }

            #Dashboard .linha .item.badge-box {
                background-color: ${model.Dash_Item_Fundo};
            }
        </style>
        `);
    }
})();