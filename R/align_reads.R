align_reads <- function(fastq_path, output_path, index_path) {
  if (!file.exists(fastq_path)) {
    stop("FASTQ file does not exist.")
  }

  cmd <- paste("bowtie2 -x", index_path, "-U", fastq_path, "-S", output_path)
  system(cmd, intern = FALSE)
}
