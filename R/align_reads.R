align_reads <- function(fastq_paths, output_path, index_path, aligner_cmd = "bowtie2", aligner_options = "") {
  sapply(fastq_paths, function(fastq_path) {
    cmd <- sprintf("%s -x %s -U %s -S %s %s", aligner_cmd, index_path, fastq_path, output_path, aligner_options)
    message("Executing: ", cmd)
    system(cmd, intern = FALSE)
  })
}
