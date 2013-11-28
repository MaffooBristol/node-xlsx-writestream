module.exports = (grunt) ->
    @loadNpmTasks('grunt-benchmark')
    @loadNpmTasks('grunt-contrib-clean')
    @loadNpmTasks('grunt-contrib-coffee')
    @loadNpmTasks('grunt-contrib-watch')
    @loadNpmTasks('grunt-mocha-cli')
    @loadNpmTasks('grunt-mkdir')
    @loadNpmTasks('grunt-release')

    @initConfig
        benchmark:
            options:
                displayResults: true
            all:
                src: ['benchmarks/*.js'],

        coffee:
            all:
                options:
                    bare: true
                expand: true,
                cwd: 'src',
                src: ['*.coffee', '*.litcoffee'],
                dest: 'lib',
                ext: '.js'

        clean:
            all: ['lib', 'tmp']

        mkdir:
            all:
                options:
                    create: ['tmp']

        watch:
            all:
                files: ['src/**.coffee', 'test/**.coffee']
                tasks: ['test']

        mochacli:
            options:
                files: 'test/*_test.coffee'
                compilers: ['coffee:coffee-script']
            spec:
                options:
                    reporter: 'spec'

    @registerTask 'default', ['test', 'benchmark']
    @registerTask 'build', ['clean', 'coffee']
    @registerTask 'package', ['build', 'release']
    @registerTask 'test', ['build', 'mkdir', 'mochacli']
    @registerTask 'bench', ['build', 'benchmark']
