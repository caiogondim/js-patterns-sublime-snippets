module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-lintspaces'
  grunt.loadNpmTasks 'grunt-bump'

  grunt.initConfig(
    lintspaces:
      all:
        src: ['*'],
        options:
          editorconfig: '.editorconfig'
    bump:
      options:
        pushTo: 'origin'
  )

  grunt.registerTask 'test', ['lintspaces']
