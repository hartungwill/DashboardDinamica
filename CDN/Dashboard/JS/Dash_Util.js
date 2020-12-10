var Dash_Util = (function () {
    const loadingText = '<i class="fas fa-spinner fa-pulse"></i>';
       
    function invokeVanilla(_url, _type, _dataType, _data, _async, _callback, _errCallback) {
        var request = new XMLHttpRequest();
        request.open(_type, _url, _async);
        request.setRequestHeader("Content-Type", _dataType);
        request.setRequestHeader("X-Requested-With", 'XMLHttpRequest');
        request.timeout = 120000; // Tempo in milliseconds

        request.onload = function () {
            if (this.status >= 200 && this.status < 400) {
                // Successo!
                if (this.response)
                    _callback(JSON.parse(this.response));

            } else {                
                // Servidor atingido, mas retornou erro
                if (this.response)
                    _errCallback(this.response);
            }
        };

        request.onerror = function () {
            // There was a connection error of some sort
            if (this.status)
                _errCallback(this.status);
        };
        request.send(JSON.stringify(_data));
        return request;
    }

    function resetSpin(seletor = '.btn-spinner') {
        const objeto = document.querySelectorAll(seletor);
        for (var i = 0; i < objeto.length; i++) {
            objeto[i].innerHTML = objeto[i].dataset.originalText;
            objeto[i].style.cursor = 'pointer';
            objeto[i].setAttribute('disabled', false)
        }
    }

    function toggleSpin(seletor = '.btn-spinner') {
        var objeto = document.querySelector(seletor);
        //console.log(objeto.id);
        if (objeto.innerHTML !== loadingText) {
            objeto.dataset.originalText = objeto.innerHTML;
            objeto.innerHTML = loadingText;
            objeto.style.cursor = 'no-drop';
            objeto.setAttribute('disabled', true);
        }
    }

    function registerSpin(seletor = '.btn-spinner') {
        const listaObjetos = document.querySelectorAll(seletor);
        for (var i = 0; i < listaObjetos.length; i++) {
            listaObjetos[i].onclick = function () { toggleSpin($(this).id); };
        }
    }

    function calculate(real, meta) {
        var perc = "";
        if (isNaN(meta) || isNaN(real)) {
            perc = " ";
        } else {
            perc = ((real / meta) * 100).toFixed(3);
        }

        return Math.round(perc) || 0;
    }

    function processa_sp_call(sp_call_original, pagina_atual = null) {
        var sp_call = sp_call_original;
        var replace_QtdPorPagina = sp_call.includes('{@QtdPorPagina}');
        var replace_Pagina = sp_call.includes('{@Pagina}');

        if (replace_QtdPorPagina) {
            sp_call = sp_call.replace('{@QtdPorPagina}', Utils_Table.ItensPorPaginaPadrao);
        }

        if (replace_Pagina) {
            if (pagina_atual !== null && pagina_atual !== undefined) {
                sp_call = sp_call.replace('{@Pagina}', pagina_atual);
            } else {
                sp_call = sp_call.replace('{@Pagina}', Utils_Table.PaginaInicialPadrao);
            }
        }

        return sp_call;
    }
    
    return {
        invokeVanilla,
        resetSpin,
        toggleSpin,
        registerSpin,
        calculate,
        processa_sp_call
    };

})();