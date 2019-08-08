#' Algorithms for electivity indices and measures of resource use versus availability.
#'
#' This package is essentially Lechowicz (1982) turned into an R package. It includes
#' all algorithms that were described therein plus the example data that
#' was provided for moth resource utilisation.
#'
#' Lechowicz, M.J., 1982. The sampling characteristics of electivity indices.
#' Oecologia 52, 22–30. https://doi.org/10.1007/BF00349007
#'
#' Users are encouraged to read the original paper before deciding which algorithm
#' is most useful for them. Lechowicz recommended Vanderploeg and Scavia's E* index
#' (implemented in this package as `vs_electivity()`) as "the single best, but not
#' perfect, electivity index" because "E* embodies a measure of the feeder's
#' perception of a food's value as a function of both its abundance and the
#' abundance of other food types present." In practice, he found that all indices
#' returned nearly identical rank orders of preferred hosts except for Strauss'
#' linear index (L).
#'
#' @section Author:
#' Desi Quintans (@eco_desi)
#'
#' @section URL:
#' \url{https://github.com/DesiQuintans/electivity/}
#'
#' @docType package
#' @name electivity
#'
#' @md
NULL
