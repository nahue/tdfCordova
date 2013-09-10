exports.config =
  plugins:
    uglify:
      mangle: true
      compress:
        true
    cleancss:
      keepSpecialComments: 0
      removeEmpty: true
  files:
    javascripts:
      defaultExtension: 'coffee'
      joinTo:
        'javascripts/app.js': /^app/
        'javascripts/vendor.js': /^vendor/
      order:
        before: [
          'vendor/scripts/jquery-1.9.1.js',
          'vendor/scripts/vendor/BlackBerry-JQM-Init-1.0.0.js',
          'vendor/scripts/vendor/jquery.mobile-1.3.2.js',
          'vendor/scripts/vendor/BlackBerry-JQM-1.0.0.js'
        ]

    stylesheets:
      joinTo:
        'stylesheets/app.css': /^(app|vendor)/
      order:
        before: [
          'vendor/styles/jquery.mobile-1.3.2.css',
          'vendor/styles/BlackBerry-JQM-1.0.0.css'
        ]
    templates:
      defaultExtension: 'dust'
      joinTo: 'javascripts/views.js'