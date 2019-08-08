# pack_data_files <- function() {
#     moth_distrib <- utils::read.csv("data/moth_distrib.csv", stringsAsFactors = FALSE)
#     moth_elect   <- utils::read.csv("data/moth_elect.csv", stringsAsFactors = FALSE)
#
#     usethis::use_data(moth_distrib, moth_elect, overwrite = TRUE)
# }

#' Distribution of gypsy moth larvae, Lymantria dispar, feeding in a deciduous forest
#' in southwestern Quebec, Canada.
#'
#' This is Table 2 in the cited source paper.
#'
#' @examples
#' # data(moth_distrib)
#'
#' @section Source:
#' Lechowicz, M.J., 1982. The sampling characteristics of electivity indices.
#' Oecologia 52, 22–30. https://doi.org/10.1007/BF00349007
#'
#' @docType data
#' @keywords data
#' @name moth_distrib
#'
#' @md
"moth_distrib"

#' Electivities of gypsy moth larvae
#'
#' This is Table 3 in the cited source paper.
#'
#' @examples
#' # data(moth_elect)
#'
#' @section Source:
#' Lechowicz, M.J., 1982. The sampling characteristics of electivity indices.
#' Oecologia 52, 22–30. https://doi.org/10.1007/BF00349007
#'
#' @docType data
#' @keywords data
#' @name moth_elect
#'
#' @md
"moth_elect"