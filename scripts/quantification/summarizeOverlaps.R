library(GenomicRanges)
library(GenomicFeatures)
library(GenomicAlignments)

setwd("/Temporary\ Files/RNASeq/datasets/ngscourse.org")

# Extract transcript database information from GTF file
txdb <- makeTranscriptDbFromGFF(file = "f005_chr21_genome_annotation.gtf", format = "gtf")

# Define the features, in this case genes
eByg <- exonsBy(txdb, by = "gene")

# Create list of BAM files to work with
bamdir <- "bam_sorted_indexed"
fls <- BamFileList(dir(bamdir, ".bam$", full = TRUE)) #GenomicAlignment
names(fls) <- basename(names(fls))

# Count reads mapping to genes 
genehits <- summarizeOverlaps(features = eByg, reads = fls, mode = "Union")

# Extract the count matrix and label the samples
counts <- assays(genehits)$counts
counts <- as.data.frame(counts)
names(counts) <- c("g031_case", "g032_case",  "g033_case", "g034_cont", "g035_cont", "g036_cont")
head(counts)

# Write count table to file. 
#write.table(counts, file="count_matrix.txt")
