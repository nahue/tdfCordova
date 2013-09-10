(function($){
    //FastClick.attach(document.body);
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
                imagePath: 'http://www.centralinfo.com.ar/fotosTdf/3.jpg',
                thumbPath: 'http://www.centralinfo.com.ar/fotosTdf/icono/3.jpg',
                descripcion: '@pepeCarioca'
            }]
        },
        Otoño: {
            fotos: [{
                nombre: "Foto 4",
                imagePath: 'http://www.centralinfo.com.ar/fotosTdf/4.jpg',
                thumbPath: 'http://www.centralinfo.com.ar/fotosTdf/icono/4.jpg',
                descripcion: '@mauriceMoss'
            },{
                nombre: "Foto 5",
                imagePath: 'http://www.centralinfo.com.ar/fotosTdf/5.jpg',
                thumbPath: 'http://www.centralinfo.com.ar/fotosTdf/icono/5.jpg',
                descripcion: '@nchaves'
            },{
                nombre: "Foto 6",
                imagePath: 'http://www.centralinfo.com.ar/fotosTdf/6.jpg',
                thumbPath: 'http://www.centralinfo.com.ar/fotosTdf/icono/6.jpg',
                descripcion: '@yosacoFotos'
            }]
        }
    }

    function setWallpaper(result){
        /*

        console.log("isFile: " + result.isFile);
        console.log("isDirectory: " + result.isDirectory);
        console.log("name: " + result.name);
        console.log("fullPath: " + result.fullPath);
*/
        $.mobile.loading( 'hide');
        blackberry.system.setWallpaper('file://' + result.fullPath);
        alert("Se cambio el fondo de pantalla");

    }

    function downloadError(result) {
        $.mobile.loading( 'hide');

        /*
        console.log("Error code: " + result.code);
        console.log("Source: " + result.source);
        console.log("Target: " + result.target);
        console.log("HTTP status: " + result.http_status);*/
        alert("Ocurrió un error, intente mas tarde");
    }

    function fileDownload(url) {
        try {
            $.mobile.loading("show",{text:'Cargando...', textVisible:true, theme: 'b'});

            blackberry.io.filetransfer.download(url, "/accounts/1000/shared/camera/fondoTDF.jpg", setWallpaper, downloadError);
        } catch(e) {
            alert("Exception in fileDownload: " + e);
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
        listaFotos.categoria = categoria;


        $.mobile.loading("show",{text:'Cargando...', textVisible:true, theme: 'b'});


        $.when(renderTemplate('listarFotos', listaFotos)).done(function(def){
            var page = $(def.raw).appendTo('body').page();
            $.mobile.changePage(page);
            //$('#lista-fotos').listview('refresh');

            $('#listpage').on('click',"ul:jqmData(role='listview') a",function(e){
                e.preventDefault();
                //console.log(blackberry.system.setWallpaper($(this).attr('href')));
                // filepicker options
                fileDownload($(this).data('image'));
                /*
                var details = {
                    mode: blackberry.invoke.card.FILEPICKER_MODE_PICKER,
                    viewMode: blackberry.invoke.card.FILEPICKER_VIEWER_MODE_GRID,
                    sortBy: blackberry.invoke.card.FILEPICKER_SORT_BY_NAME,
                    sortOrder: blackberry.invoke.card.FILEPICKER_SORT_ORDER_DESCENDING
                };

                blackberry.invoke.card.invokeFilePicker(details, function(path) {
                    blackberry.system.setWallpaper('file://' + path);
                    showToast('Wallpaper changed!');
                });
                */
            });
        });
    }


    $(document).on("mobileinit", function () {
        $.mobile.defaultPageTransition = "slide";
        $.mobile.loader.prototype.options.textVisible = true;
        $.mobile.button.prototype.options.mini = true;
    });

    $(document).on('pageinit','#index',function(){
        $.mobile.defaultPageTransition = "slide";
        $.mobile.loader.prototype.options.textVisible = true;
        $.mobile.button.prototype.options.mini = true;
        $.mobile.page.prototype.options.backBtnText = "Volver";


        //var compiled = dust.compile(document.getElementById('listarFotos').innerHTML, "listarFotos");
        //console.log(compiled);

        var listaCategoriasFotos = $('#lista-categorias-fotos');
        $.each(fotos,function(k,v){
            listaCategoriasFotos.append('<li><a href="" title="'+k+'">' + k + '</a></li>')
        });

        listaCategoriasFotos.listview('refresh');

        $("#index").on("click", "ul:jqmData(role='listview') a", function (e) {
            e.preventDefault();
            getListaFotos($(this).text());
        });
    });
})(jQuery);