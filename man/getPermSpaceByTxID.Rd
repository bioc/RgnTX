% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getPermSpaceByTxID.R
\name{getPermSpaceByTxID}
\alias{getPermSpaceByTxID}
\title{Get permutation space by specifying transcript ids}
\usage{
getPermSpaceByTxID(trans_ids = "all", txdb, type = "mature")
}
\arguments{
\item{trans_ids}{A character object. The transcript ids. Default is "all". If it takes the default value "all", the space that users get will be the whole transcriptome.}

\item{txdb}{A TxDb object.}

\item{type}{A character object. Default is "mature". It accepts options "mature", "full", "fiveUTR", "CDS" or "threeUTR", with which one can get corresponding types of transcriptome regions.}
}
\value{
A \code{GRangesList} object.
}
\description{
This function returns 5'UTR/CDS/3'UTR/mRNA/full part of transcriptome regions grouped by corresponding transcript ids.
}
\examples{
trans.ids <- c("170", "782", "974", "1364", "1387")
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
permspace <- getPermSpaceByTxID(trans.ids, txdb)
}
\seealso{
\code{\link{getPermSpaceByType}}, \code{\link{getPermSpaceByFeatures}}
}
