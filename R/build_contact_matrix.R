build_contact_matrix <- function(bam_path, resolution = 1e6) {
  library(GenomicRanges)
  library(Rsamtools)
  
  # 读取BAM文件
  param <- ScanBamParam(what = c("rname", "pos"))
  bam_data <- scanBam(bam_path, param = param)
  reads <- bam_data[[1]]
  
  # 使用分辨率创建bins
  bins <- cut(reads$pos, breaks = seq(0, max(reads$pos), by = resolution), labels = FALSE, include.lowest = TRUE)
  
  # 构建稀疏接触矩阵
  contact_matrix <- Matrix::sparseMatrix(i = bins, j = bins, x = rep(1, length(bins)), dims = c(max(bins), max(bins)))
  
  return(contact_matrix)
}
