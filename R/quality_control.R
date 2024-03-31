quality_control <- function(sequences, qualities, min_quality = 20) {
  good_quality_indices <- sapply(qualities, function(q) {
    mean(as.integer(charToRaw(q)) - 33) >= min_quality
  })

  list(
    sequences = sequences[good_quality_indices],
    qualities = qualities[good_quality_indices]
  )
}
