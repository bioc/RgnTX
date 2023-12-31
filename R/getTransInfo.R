#' Get transcript information
#' @export getTransInfo
#' @importFrom GenomicFeatures mapToTranscripts
#' @importFrom GenomicRanges strand GRanges width start ranges mcols
#'
#' @description Generate a data frame object that contains information about input genomic feature set and its mapping results over the transcriptome.
#'
#' @usage getTransInfo(A, txdb)
#'
#' @param A Genomic feature set, which should be a \code{GRanges} object.
#' @param txdb A TxDb object.
#'
#' @return
#' A \code{data.frame} object containing the following components:
#' \itemize{
#' \item \bold{\code{index_trans:}} The label of transcripts.
#' \item \bold{\code{index_features:}} The label of genomic features.
#' \item \bold{\code{seqnames:}} The chr name.
#' \item \bold{\code{features_pos:}} The starting coordinate of each genomic feature.
#' \item \bold{\code{width_features:}} The width of each genomic feature.
#' \item \bold{\code{strand:}} The strand type of each genomic feature.
#' \item \bold{\code{trans_ID:}} The ids of the transcripts that each feature can be mapped to.
#' }
#'
#' @examples
#' library(TxDb.Hsapiens.UCSC.hg19.knownGene)
#' file <- system.file(package="RgnTX", "extdata/m6A_sites_data.rds")
#' m6A_sites_data <- readRDS(file)
#' txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
#' getTransInfo(A = m6A_sites_data[1:100], txdb)
getTransInfo <- function(A, txdb) {
    trans <- mapToTranscripts(A, txdb)
    methyl <- A
    A.width <- width(A)
    sample_methyl_pos <- start(ranges(methyl))
    sample_methyl_seqnames <- data.frame(seqnames(methyl))[[1]]
    trans_metadata <- mcols(trans)

    index_trans <- seq_len(length(trans))
    index_methyl <- data.frame(trans)[, "xHits"]
    seqnames <- sample_methyl_seqnames[data.frame(trans)[, "xHits"]]
    methyl_pos <- sample_methyl_pos[data.frame(trans)[, "xHits"]]
    strand <- data.frame(trans)[, "strand"]
    trans_ID <- data.frame(trans)[, "transcriptsHits"]

    trans_info <- data.frame(
        index_trans = index_trans, index_features = index_methyl,
        seqnames = seqnames, start_features = methyl_pos, width_features = A.width[index_methyl],
        strand = strand, trans_ID = trans_ID
    )
    return(trans_info)
}
