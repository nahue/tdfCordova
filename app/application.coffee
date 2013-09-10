
App =
  fotos =



  initialize: ->
    #template = require 'views/templates/listarFotos'
    #console.log(dust.loadSource template)
    proxy = require 'proxy'

    $.when(proxy.getFotos()).done (def) ->
      console.log def
      $.each def, (k, v) ->
        $("#lista-categorias-fotos").append("<li><a href='#' title='"+v['nombre']+"' data-id='"+v['id']+"'\>" + v['nombre'] + "</a></li>").listview "refresh"


    #$.mobile.defaultPageTransition = "cover"
    #$.mobile.loader::options.textVisible = true
    #$.mobile.button::options.mini = true
    $.mobile.page::options.backBtnText = "Volver"

    #var compiled = dust.compile(document.getElementById('listarFotos').innerHTML, "listarFotos");
    #console.log(compiled);
    #listaCategoriasFotos = $("#lista-categorias-fotos")
    #$.each this.fotos, (k, v) ->
    #  listaCategoriasFotos.append "<li><a href=\"\" title=\"" + k + "\">" + k + "</a></li>"

    #listaCategoriasFotos.listview "refresh"
    $("#index").on "click", "ul:jqmData(role='listview') a", (e) ->
      e.preventDefault()
      App.getListaFotos $(this).data('id')

    $(document).on "click", '.setWallpaper', (e) ->
      App.fileDownload $(this).data("image")

    Object.freeze? this



  #FastClick.attach(document.body);
  #
  #    fotos = {
  #        Paisajes: [],
  #        Lugares: []
  #    }
  #
  setWallpaper: (result) ->

    console.log("isFile: " + result.isFile)
    console.log("isDirectory: " + result.isDirectory)
    console.log("name: " + result.name)
    console.log("fullPath: " + result.fullPath)

    $.mobile.loading "hide"
    blackberry.system.setWallpaper "file://" + result.fullPath
    alert "Se cambio el fondo de pantalla"

  downloadError: (result) ->
    $.mobile.loading "hide"

    #
    #        console.log("Error code: " + result.code);
    #        console.log("Source: " + result.source);
    #        console.log("Target: " + result.target);
    #        console.log("HTTP status: " + result.http_status);
    alert "Ocurrió un error, intente mas tarde"

  fileDownload: (url) ->
    try
      $.mobile.loading "show",
        textVisible: false
        theme: "c"
      console.log url
      blackberry.io.filetransfer.download url, "/accounts/1000/shared/camera/fondoTDF.jpg", this.setWallpaper, this.downloadError
    catch e
      alert "Exception in fileDownload: " + e

  renderTemplate: (template, data) ->
    tpl = require template
    dust.loadSource tpl

    def = $.Deferred
    dust.render template, data, (err, out) ->
      def.raw = out
      def.resolve

    def

  getListaFotos: (cat_id) ->
    #listaFotos = (categoria item for item in @.fotos)
    #listaFotos = (this.fotos cat for cat in categoria)
    $.mobile.loading "show",
      textVisible: false
      theme: "c"

    proxy = require 'proxy'

    $.when(proxy.getFotosDeCategoria(cat_id)).done (def) ->

      $.when(App.renderTemplate("templates/listarFotos", def)).done (def) ->
        page = @$(def.raw).appendTo("body").page()
        $.mobile.changePage page

        $(page).find("ul:jqmData(role='listview')").on "click", "a", (e) ->
          e.preventDefault()
          App.getFoto $(this).data("id")
          #console.log(blackberry.system.setWallpaper($(this).attr('href')));
          # filepicker options
          #App.fileDownload $(this).data("image")

          #$.when(this.renderTemplate("templates/verFoto", listaFotos)).done (def) ->

  getFoto: (id) ->
    proxy = require 'proxy'
    $.mobile.loading "show",
      textVisible: false
      theme: "c"
    $.when(proxy.getFoto(id)).done (def) ->
      $.when(App.renderTemplate("templates/verFoto", def)).done (def) ->
        page = @$(def.raw).appendTo("body").page()
        $.mobile.changePage page





#$(document).on "pageinit", "#index", ->
#  App.initialize()
module.exports = App
