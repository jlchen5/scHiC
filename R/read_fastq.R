#' Read FASTQ Data
#'
#' This function reads FASTQ data for single-cell Hi-C analysis.
#'
#' @param fastq_path The path to the FASTQ file.
#' @return A data frame containing the FASTQ data.
#' @export
#' @examples
#' read_fastq_data("path/to/your/fastq")
read_fastq_data <- function(fastq_path) {
  if (!file.exists(fastq_path)) {
    stop("FASTQ file does not exist.")
  }

  con <- file(fastq_path, "r")
  on.exit(close(con))

  read_lines <- function(con) {
    seq <- readLines(con, n = 1)
    readLines(con, n = 3) # Skip next 3 lines
    seq
  }

  sequences <- c()
  qualities <- c()

  while (TRUE) {
    seq <- tryCatch(read_lines(con), error = function(e) NA)
    if (is.na(seq)) break
    sequences <- c(sequences, seq[1])
    qualities <- c(qualities, seq[3])
  }

  list(sequences = sequences, qualities = qualities)
}

library(BiocParallel)

read_fastq_data_parallel <- function(fastq_paths) {
  read_single_fastq <- function(path) {
    if (!file.exists(path)) {
      stop("FASTQ file does not exist: ", path)
    }
    req <- readLines(path)
    list(
      sequences = req[seq(2, length(req), 4)],
      qualities = req[seq(4, length(req), 4)]
    )
  }
  
  bplapply(fastq_paths, read_single_fastq, BPPARAM = MulticoreParam(workers = 4))
}
