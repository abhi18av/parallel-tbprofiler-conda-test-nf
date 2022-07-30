# README

This pipeline is minimal reproducible test case for running different versions of `tb-profiler` in parallel using `conda/mamba`.

### Problem with `v4.1.1` in a parallel usage setting

The core problem with `v4.1.1` was that, when there were many tasks (using tb-profiler) being run in parallel, the import of custom DB gave rise to a race condition as these tasks were trying to use the `tb-profiler load_library` functionality to add the custom database.

```bash


picard.PicardException: /home/xbs-nf-EarlyMGIT/xbs-nf/work/conda/xbs-nf-env-1-d99876e5fea88a1c4bd18887d111ae27/share/tbprofiler/resistance_db_who.dict already exists. Delete this file and try again, or specify a different output file.
at picard.sam.CreateSequenceDictionary.doWork(CreateSequenceDictionary.java:220)
at picard.cmdline.CommandLineProgram.instanceMain(CommandLineProgram.java:308)
at

```

This problem can be reproduced locally by relying upon the following command (assuming `nextflow` and `conda`) are installed.

```sh
$ nextflow run https://github.com/abhi18av/parallel-tbprofiler-conda-test-nf -profile tbprofiler411

```
