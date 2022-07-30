process TBPROFILER_LOAD_DATABASE {

    input:
        val(randomNumber)
        path(resistanceDb)

    output:
        path("results/*")

    script:
        def optionalDb  = resistanceDb ? "--db ${resistanceDb.name}" : ""

        def optionallyLoadLibraryForContainers = (optionalDb != "") ? "cd ${resistanceDb}; ${params.tbprofiler_path} load_library ${resistanceDb.name}; cd ../" : ""

        """
        ${optionallyLoadLibraryForContainers}

        """

}

workflow {


    random_num_ch = channel.of(1,2,3,4,5)

    TBPROFILER_LOAD_DATABASE(random_num_ch, params.resistanceDb)

}
