
#' Ivlev's electivity, E
#'
#' @param r (Numeric) Resource utilisation.
#' @param p (Numeric) Resource availability.
#'
#' @return A numeric vector.
#' @export
#'
#' @examples
#' data(moth_distrib)
#' ivlev_electivity(moth_distrib$r, moth_distrib$p)
ivlev_electivity <- function(r, p) {
    apply(data.frame(r = r, p = p), 1,
          function(x) {
              r <- x["r"]
              p <- x["p"]

              (r - p) / (r + p)
          })
}



#' Ivlev's forage ratio, E'
#'
#' @param r (Numeric) Resource utilisation.
#' @param p (Numeric) Resource availability.
#'
#' @return A numeric vector.
#' @export
#'
#' @examples
#' data(moth_distrib)
#' ivlev_forage(moth_distrib$r, moth_distrib$p)
ivlev_forage <- function(r, p) {
    apply(data.frame(r = r, p = p), 1,
          function(x) {
              r <- x["r"]
              p <- x["p"]

              r / p
          })
}



#' Jacob's modified electivity, D
#'
#' @param r (Numeric) Resource utilisation.
#' @param p (Numeric) Resource availability.
#'
#' @return A numeric vector.
#' @export
#'
#' @examples
#' data(moth_distrib)
#' jacob_electivity(moth_distrib$r, moth_distrib$p)
jacob_electivity <- function(r, p) {
    apply(data.frame(r = r, p = p), 1,
          function(x) {
              r <- x["r"]
              p <- x["p"]

              (r - p) / ((r + p) - (2 * (r * p)))
          })
}



#' Jacob's modified forage ratio, Q (log10)
#'
#' @param r (Numeric) Resource utilisation.
#' @param p (Numeric) Resource availability.
#' @param log (Logical) If TRUE, return the value as Log10.
#'
#' @return A numeric vector.
#' @export
#'
#' @examples
#' data(moth_distrib)
#' jacob_forage(moth_distrib$r, moth_distrib$p, log = TRUE)
#' jacob_forage(moth_distrib$r, moth_distrib$p, log = FALSE)
jacob_forage <- function(r, p, log = TRUE) {
    q <- apply(data.frame(r = r, p = p), 1,
               function(x) {
                   r <- x["r"]
                   p <- x["p"]

                   (r * (1 - p)) / (p * (1 - r))
               })

    if (log == TRUE) {
        return(log10(q))
    } else {
        return(q)
    }
}



#' Strauss' linear index, L
#'
#' @param r (Numeric) Resource utilisation.
#' @param p (Numeric) Resource availability.
#'
#' @return A numeric vector.
#' @export
#'
#' @examples
#' data(moth_distrib)
#' strauss_linear(moth_distrib$r, moth_distrib$p)
strauss_linear <- function(r, p) {
    apply(data.frame(r = r, p = p), 1,
          function(x) {
              r <- x["r"]
              p <- x["p"]

              r - p
          })
}



#' Chesson's alpha, or Vanderploeg and Scavia's selectivity coefficient (W)
#'
#' @param r (Numeric) Resource utilisation.
#' @param p (Numeric) Resource availability.
#' @param na.rm (Logical) If `TRUE`, `NA`s will be ignored when calculating the
#'    selectivity coefficient (W).
#'
#' @return A numeric vector.
#' @export
#'
#' @examples
#' data(moth_distrib)
#' chesson_alpha(moth_distrib$r, moth_distrib$p)
#'
#' \dontrun{
#' vs_select_coef(moth_distrib$r, moth_distrib$p)
#' }
chesson_alpha <- vs_select_coef <- function(r, p, na.rm = TRUE) {
    apply(data.frame(r = r, p = p, sigma = sum(r / p, na.rm = na.rm)), 1,
          function(x) {
              r <- x["r"]
              p <- x["p"]
              sigma <- x["sigma"]

              (r / p)/sigma
          })
}

#' @name vs_select_coef
#'
#' @usage vs_select_coef(r, p, na.rm = TRUE)
#'
#' @rdname chesson_alpha
"vs_select_coef"



#' Vanderploeg and Scavia's relativised electivity, E*
#'
#' @param r (Numeric) Resource utilisation.
#' @param p (Numeric) Resource availability.
#' @param na.rm (Logical) If `TRUE`, `NA`s will be ignored when calculating the
#'    selectivity coefficient (W).
#'
#' @return A numeric vector.
#' @export
#'
#' @examples
#' data(moth_distrib)
#' vs_electivity(moth_distrib$r, moth_distrib$p)
#'
#' @md
vs_electivity <- function(r, p, na.rm = TRUE) {
    W <- vs_select_coef(r, p, na.rm = na.rm)

    apply(data.frame(W = W, n = length(W)), 1,
          function(x) {
              W <- x["W"]
              n <- x["n"]

              (W - (1 / n)) / (W + (1 / n))
          })
}
