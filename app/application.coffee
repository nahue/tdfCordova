
App =
  proxy: require 'proxy'

  initialize: ->
    console.log navigator.userAgent
    $.when(this.proxy.getFotos()).done (def) ->
      $.each def, (k, v) ->
        $("#lista-categorias-fotos").append("<li><a href='#' title='"+v['nombre']+"' data-id='"+v['id']+"'\>" + v['nombre'] + "</a></li>").listview "refresh"

    $.mobile.page::options.backBtnText = "Volver"

    $("#index").on "click", "ul:jqmData(role='listview') a", (e) ->
      e.preventDefault()
      App.getListaFotos $(this).data('id')

    $(document).on "click", '.setWallpaper', (e) ->
      App.fileDownload $(this).data("image")

    Object.freeze? this

  setWallpaper: (result) ->
    $.mobile.loading "hide"
    blackberry.system.setWallpaper "file://" + result.fullPath
    alert "Se cambio el fondo de pantalla"

  downloadError: (result) ->
    $.mobile.loading "hide"
    alert "Ocurrió un error, intente mas tarde"

  fileDownload: (url) ->
    try
      $.mobile.loading "show",
        textVisible: false
        theme: "c"
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
    $.mobile.loading "show",
      textVisible: false
      theme: "c"

    $.when(this.proxy.getFotosDeCategoria(cat_id)).done (def) ->

      $.when(App.renderTemplate("templates/listarFotos", def)).done (def) ->
        page = @$(def.raw).appendTo("body").page()
        $.mobile.changePage page

        $(page).find("ul:jqmData(role='listview')").on "click", "a", (e) ->
          e.preventDefault()
          App.getFoto $(this).data("id")

  getFoto: (id) ->
    $.mobile.loading "show",
      textVisible: false
      theme: "c"
    $.when(this.proxy.getFoto(id)).done (def) ->
      $.when(App.renderTemplate("templates/verFoto", def)).done (def) ->
        page = @$(def.raw).appendTo("body").page()
        $.mobile.changePage page

module.exports = App
