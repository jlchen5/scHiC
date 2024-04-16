quality_control <- function(data, min_quality = 20, min_length = 50) {
  qc_passed <- mapply(function(seq, qual) {
    qual_scores <- as.integer(charToRaw(qual)) - 33
    mean(qual_scores) >= min_quality && nchar(seq) >= min_length && all(qual_scores >= min_quality)
  }, data$sequences, data$qualities, SIMPLIFY = TRUE)
  
  list(
    sequences = data$sequences[qc_passed],
    qualities = data$qualities[qc_passed]
  )
}
