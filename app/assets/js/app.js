(function($){
/*
    fotos = {
        Paisajes: [],
        Lugares: []
    }
*/
    var fotos = {
        Verano: {
            fotos: [{
                nombre: "Foto 1",
                url: 'http://placehold.it/144x144'
            }]
        },
        Otoño: {
            fotos: [{
                nombre: "Foto 2",
                url: 'http://placehold.it/144x144'
            },{
                nombre: "Foto 3",
                url: 'http://placehold.it/144x144'
            }]
        }
    }


    function renderTemplate(template, data){
        var def = $.Deferred;

        dust.render(template, data, function(err, out){
            def.raw = out;
            def.resolve;
        });

        return def;
    }

    function getListaFotos(categoria) {
        var listaFotos = eval('fotos.'+categoria);
        console.log(listaFotos);

        $.when(renderTemplate('listarFotos', listaFotos)).done(function(def){
            var page = $(def.raw).appendTo('body').page();
            $.mobile.changePage(page);
            //$('#lista-fotos').listview('refresh');
        });
    }

    $(document).on('pageinit','#index',function(){

        //var compiled = dust.compile(document.getElementById('listarFotos').innerHTML, "listarFotos");
        //console.log(compiled);

        /*
        $.when(renderTemplate('listPage', fotos)).done(function(def){
            var page = $(def.raw).appendTo('#contenido');
            //$('#lista-fotos').listview('refresh');
        });
    */
        var listaCategoriasFotos = $('#lista-categorias-fotos');
        $.each(fotos,function(k,v){
            listaCategoriasFotos.append('<li><a href="" title="'+k+'">' + k + '</a></li>')
        });

        listaCategoriasFotos.listview('refresh');

        $(document).on("click", "ul:jqmData(role='listview') a", function (e) {
            e.preventDefault();
            getListaFotos($(this).text());
        });
    });
})(jQuery);