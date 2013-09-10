Proxy =
  username: 'tdfAdmin'
  password: 'tdfPassword$$'
  fotos:
    Verano:
      fotos: [
        id: 1
        nombre: "Foto 1"
        imagePath: "http://www.centralinfo.com.ar/fotosTdf/3.jpg"
        thumbPath: "http://www.centralinfo.com.ar/fotosTdf/icono/3.jpg"
        descripcion: "@pepeCarioca"
      ]

    Otono:
      fotos: [
        id: 2
        nombre: "Foto 4"
        imagePath: "http://www.centralinfo.com.ar/fotosTdf/4.jpg"
        thumbPath: "http://www.centralinfo.com.ar/fotosTdf/icono/4.jpg"
        descripcion: "@mauriceMoss"
      ,
        id: 3
        nombre: "Foto 5"
        imagePath: "http://www.centralinfo.com.ar/fotosTdf/5.jpg"
        thumbPath: "http://www.centralinfo.com.ar/fotosTdf/icono/5.jpg"
        descripcion: "@nchaves"
      ,
        id: 4
        nombre: "Foto 6"
        imagePath: "http://www.centralinfo.com.ar/fotosTdf/6.jpg"
        thumbPath: "http://www.centralinfo.com.ar/fotosTdf/icono/6.jpg"
        descripcion: "@yosacoFotos"
      ]

  make_base_auth: (user, password) ->
    tok = user + ':' + password
    hash = btoa(tok)
    return "Basic " + hash

  getFotos: ->
    $.ajax
      url: 'http://tdfApi.centralinfo.com.ar/api/v1/categorias'

  getFotosDeCategoria: (cat_id) ->
    $.ajax
      url: 'http://tdfApi.centralinfo.com.ar/api/v1/categorias/'+cat_id+'/fotos'

  getFoto: (id) ->
    $.ajax
      url: "http://tdfApi.centralinfo.com.ar/api/v1/fotos/#{id}"

module.exports = Proxy