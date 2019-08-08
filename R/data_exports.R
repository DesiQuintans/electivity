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
#' @format A dataframe with 19 rows and 6 variables:
#' \describe{
#'    \item{binomen}{Species of tree.}
#'    \item{n_indiv}{Number of randomly sampled trees.}
#'    \item{dbh_cm_sum}{Summed diameters at breast height, in centimeters.}
#'    \item{larva_mean_sum}{Summed numbers of larvae (the means of two counts taken
#'        on June 26-27, 1979 and July 3-4, 1979).}
#'    \item{r}{Relative proportion of larvae feeding on trees (Lechowicz 1982,
#'        Equation 2)}
#'    \item{p}{Estimate of foliage biomass (Lechowicz 1982, Equation 1).}
#' }
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
#' @format A dataframe with 19 rows and 8 variables:
#' \describe{
#'    \item{binomen}{Species of tree.}
#'    \item{E}{Ivlev's electivity index.}
#'    \item{E_prime_i}{Ivlev's forage ratio.}
#'    \item{D_i}{Jacob's modified electivity.}
#'    \item{log_Q_i}{Jacob's modified forage ratio, log10.}
#'    \item{L_i}{Strauss' linear index.}
#'    \item{W_i}{Chesson's alpha, or Vanderploeg and Scavia's selectivity coefficient.}
#'    \item{E_star_i}{Vanderploeg and Scavia's relativised electivity.}
#' }
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