module.exports = (grunt) ->

  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'

    coffeelint:
      app: ['chrome/**/*.coffee']

    coffee:
      default:
        options:
          join: true
        files:
          'build/chrome/background.js' : ['chrome/background.coffee']
          'build/chrome/content.js' : ['chrome/content.coffee']


    watch:
      options:
        atBegin: true
      coffee:
        files: ['chrome/**/*.coffee']
        tasks: ['coffeelint', 'coffee']
      less:
        files: ['chrome/**/*.less']
        tasks: ['less']
      cson:
        files: ['chrome/**/*.cson']
        tasks: ['cson']


    compress:
      chrome:
        options:
          archive: 'build/<%= pkg.name %>.zip'
        expand: true
        cwd: 'build/chrome/'
        src: ['**/*']


    bump:
      options:
        files: ['package.json']
        updateConfigs: ['pkg']
        commitFiles: ['-a']
        pushTo: 'origin'


    less:
      default:
        files:
          'build/chrome/content.css': 'chrome/content.less'


    cson:
      default:
        files:
          'build/chrome/manifest.json': 'chrome/manifest.cson'



    changelog:
      options: {}


    update_json:
      options:
        src: 'package.json'
        indent: '\t'
      chrome:
        dest: 'build/chrome/manifest.json'
        fields: 'version'


    copy:
      default:
        files: [
          {
            expand: true
            cwd: 'chrome/'
            src: ['**/*.{png,gif,jpg}']
            dest: 'build/chrome/'
          }
        ]


  require('load-grunt-tasks') grunt


  grunt.registerTask 'default', [
    'watch'
  ]


  # Constructs the code, runs tests and if everyting is OK, creates a minified
  # version ready for production. This task is intended to be run manually.
  grunt.registerTask 'build', 'Bumps version and builds JS.', (version_type) ->
    version_type = 'patch' unless version_type in ['patch', 'minor', 'major']
    grunt.task.run [
      "bump-only:#{version_type}"
      'copy'
      'coffeelint'
      'coffee'
      'less'
      'cson'
      'update_json'
      'compress'
      'changelog'
      'bump-commit'
    ]
