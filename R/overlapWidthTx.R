#' Evaluation function
#' @export overlapWidthTx
#' @importFrom IRanges countOverlaps
#' @importFrom regioneR overlapRegions
#'
#' @description Evaluation function. This function returns the sum of widths of each overlap between two region sets,  i.e., the total number of overlapping nucleotides between two input region sets.
#'
#' @usage overlapWidthTx(A, B, ...)
#'
#' @param A Region set 1. A \code{Granges} or \code{GRangesList} object.
#' @param B Region set 2. A \code{Granges} or \code{GRangesList} object.
#' @param ... Any additional parameters needed.
#'
#' @return A \code{numeric} object.
#'
#' @seealso \code{\link{overlapCountsTx}}, \code{\link{distanceTx}}
#'
#' @examples
#' library(TxDb.Hsapiens.UCSC.hg19.knownGene)
#' txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
#' trans.ids <- c("170", "782", "974", "1364", "1387")
#' A <- randomizeTx(
#'     txdb, trans.ids, random_num = 20,
#'     random.length = 100
#' )
#' B <- randomizeTx(
#'     txdb, trans.ids = trans.ids, random_num = 20,
#'     random_length = 100
#' )
#'
#' overlapWidthTx(A, B)
overlapWidthTx <- function(A, B, ...) {
    A_B <- getFormatCorrect(A, B)
    A <- A_B[[1]]
    B <- A_B[[2]]
    if (length(A$transcriptsHits) != 0 & length(B$transcriptsHits) != 0) {

        map.df <- data.frame(findOverlaps(A, B))

        A.id <- A$transcriptsHits[map.df[, 1]]
        B.id <- B$transcriptsHits[map.df[, 2]]

        # Filter out wrong mapping Filter out ranges are not on the same transcript.

        overlapRegions.frame <- overlapRegions(A, B)[A.id == B.id, ]

    } else {

        overlapRegions.frame <- overlapRegions(A, B)

    }

    frame1 <- overlapRegions.frame[overlapRegions.frame[, "type"] == "AleftB", ]
    level1 <- frame1[, "endA"] - frame1[, "startB"] + 1

    frame2 <- overlapRegions.frame[overlapRegions.frame[, "type"] == "ArightB", ]
    level2 <- frame2[, "endB"] - frame2[, "startA"] + 1

    frame3 <- overlapRegions.frame[overlapRegions.frame[, "type"] == "AinB", ]
    level3 <- frame3[, "endA"] - frame3[, "startA"] + 1

    frame4 <- overlapRegions.frame[overlapRegions.frame[, "type"] == "BinA", ]
    level4 <- frame4[, "endB"] - frame4[, "startB"] + 1

    frame5 <- overlapRegions.frame[overlapRegions.frame[, "type"] == "equal", ]
    level5 <- frame5[, "endB"] - frame5[, "startB"] + 1

    level <- sum(sum(level1), sum(level2), sum(level3), sum(level4), sum(level5))

    return(level)
}
