# scHiC 
The `scHiC` package is designed for processing single-cell Hi-C data from raw FASTQ files to Hi-C contact matrices. This document provides detailed instructions on how to install and use this package, as well as a comprehensive API reference.

## Installation

To install the `scHiC` package, you will need to have R and Bioconductor installed. Use the following commands in R to install the package:

```r
# Install devtools if not already installed
if (!requireNamespace("devtools", quietly = TRUE))
    install.packages("devtools")

# Install scHiC from GitHub
devtools::install_github("jlchen5/scHiC")

# Ensure you have also installed the necessary dependencies:

if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install(c("GenomicRanges", "Biostrings", "Rsamtools", "BiocParallel"))
```
## Quick Start
To get started with the scHiC package, load it and read some sample FASTQ data:

```r
library(scHiC)

# Paths to your FASTQ files
fastq_paths <- c("path/to/your/sample1.fastq", "path/to/your/sample2.fastq")

# Read and preprocess FASTQ data
data <- read_fastq_data_parallel(fastq_paths)

# Perform quality control
qc_data <- quality_control(data)

# Align reads using Bowtie2 (make sure Bowtie2 is installed and configured)
align_reads(fastq_paths, "path/to/output.sam", "path/to/bowtie2/index")

# Build contact matrix
contact_matrix <- build_contact_matrix("path/to/output.sam")

```

Functions
read_fastq_data_parallel
This function reads and preprocesses FASTQ files in parallel.

### Arguments:

fastq_paths: A character vector of paths to FASTQ files.
Returns:

A list of lists, each containing sequences and qualities extracted from one FASTQ file.
Example:
~~~
fastq_paths <- c("sample1.fastq", "sample2.fastq")
data <- read_fastq_data_parallel(fastq_paths)

~~~


quality_control
Performs quality control on sequence data.

### Arguments:

- data: A list containing sequences and qualities.
- min_quality: The minimum mean quality score required (default: 20).
- min_length: The minimum sequence length required (default: 50).
Returns:

A list of the same structure as input but containing only the sequences and qualities that passed the quality control.
Example:

~~~
qc_data <- quality_control(data)
~~~
align_reads
Aligns reads to a reference genome using an external tool such as Bowtie2.

### Arguments:

- fastq_paths: A character vector of paths to FASTQ files.
- output_path: Path where the output SAM file will be saved.
- aligner_cmd: Command template to use for alignment, e.g., "bowtie2 -x %s -U %s -S %s".
- aligner_options: Additional options for the aligner (default: "").
- Returns:

None. Output is written directly to the file specified by output_path.
Example:

~~~
align_reads(fastq_paths, "output.sam", "path/to/bowtie2/index")
~~~
build_contact_matrix
Builds a Hi-C contact matrix from aligned read data.

Arguments:

bam_path: Path to the BAM file containing aligned read data.
resolution: Resolution of the contact matrix (default: 1e6).
Returns:

A contact matrix as a Matrix object.
Example:
~~~
contact_matrix <- build_contact_matrix("output.sam")
~~~

## Contributing
Contributions to the scHiC package are welcome. Please refer to the repository's issues and pull requests sections on GitHub to contribute or report problems.

## License
This package is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.


