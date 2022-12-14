process TBPROFILER_LOAD_DATABASE {
    debug true

    input:
        val(randomNumber)
        path(resistanceDb)

    script:
        def optionalDb  = resistanceDb ? "--db ${resistanceDb.name}" : ""

        def optionallyLoadLibraryForContainers = (optionalDb != "") ? "cd ${resistanceDb}; ${params.tbprofiler_path} load_library ${resistanceDb.name}; cd ../" : ""

        """

        which ${params.tbprofiler_path}
        ${params.tbprofiler_path} version

        ${optionallyLoadLibraryForContainers}

        """

}

workflow {


    random_num_ch = channel.of(1,2,3,4,5)

    TBPROFILER_LOAD_DATABASE(random_num_ch, params.resistanceDb)

}
