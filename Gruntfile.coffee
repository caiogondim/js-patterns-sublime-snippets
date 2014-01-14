module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-lintspaces'

  grunt.initConfig(
    lintspaces:
      all:
        src: ['*'],
        options:
          editorconfig: '.editorconfig'
  )

  grunt.registerTask 'test', ['lintspaces']
