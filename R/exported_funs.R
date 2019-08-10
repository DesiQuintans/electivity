
#' Ivlev's electivity, E
#'
#' Bounded between -1.0 (avoidance), 0 (random feeding), and +1.0 (preference).
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
#'
#' @section Source:
#' Lechowicz, M.J., 1982. The sampling characteristics of electivity indices.
#' Oecologia 52, 22–30. https://doi.org/10.1007/BF00349007
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
#' Bounded between +0.1 (avoidance), +1.0 (random feeding), and infinity (preference).
#'
#' @param r (Numeric) Resource utilisation.
#' @param p (Numeric) Resource availability.
#' @param log10 (Logical) If `TRUE`, transform the value with `log10()`.
#'
#' @return A numeric vector.
#' @export
#'
#' @examples
#' data(moth_distrib)
#' ivlev_forage(moth_distrib$r, moth_distrib$p, log10 = FALSE)
#' ivlev_forage(moth_distrib$r, moth_distrib$p, log10 = TRUE)
#'
#' @md
ivlev_forage <- function(r, p, log10 = FALSE) {
    Epr <- apply(data.frame(r = r, p = p), 1,
                 function(x) {
                     r <- x["r"]
                     p <- x["p"]

                     r / p
                 })

    if (log10 == TRUE) {
        return(log10(Epr))
    } else {
        return(Epr)
    }
}



#' Jacob's modified electivity, D
#'
#' Bounded between +0.1 (avoidance), +1.0 (random feeding), and infinity (preference).
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



#' Jacob's modified forage ratio, Q
#'
#' When logged (which is Jacob's recommendation), bounded between negative and
#' positive infinity.
#'
#' @param r (Numeric) Resource utilisation.
#' @param p (Numeric) Resource availability.
#' @param log10 (Logical) If TRUE, return the value as Log10.
#'
#' @return A numeric vector.
#' @export
#'
#' @examples
#' data(moth_distrib)
#' jacob_forage(moth_distrib$r, moth_distrib$p, log10 = TRUE)
#' jacob_forage(moth_distrib$r, moth_distrib$p, log10 = FALSE)
jacob_forage <- function(r, p, log10 = FALSE) {
    q <- apply(data.frame(r = r, p = p), 1,
               function(x) {
                   r <- x["r"]
                   p <- x["p"]

                   (r * (1 - p)) / (p * (1 - r))
               })

    if (log10 == TRUE) {
        return(log10(q))
    } else {
        return(q)
    }
}



#' Strauss' linear index, L
#'
#' Bounded between -1.0 (avoidance), 0 (random feeding), and +1.0 (preference).
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
#' These two functions calculate the same value; alpha and W are identical.
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
#'
#' chesson_alpha(moth_distrib$r, moth_distrib$p)
chesson_alpha <- function(r, p, na.rm = TRUE) {
    apply(data.frame(r = r, p = p, sigma = sum(r / p, na.rm = na.rm)), 1,
          function(x) {
              r <- x["r"]
              p <- x["p"]
              sigma <- x["sigma"]

              (r / p)/sigma
          })
}


#' @rdname chesson_alpha
#' @examples vs_select_coef(moth_distrib$r, moth_distrib$p)
#' @export
vs_select_coef <- chesson_alpha



#' Vanderploeg and Scavia's relativised electivity, E*
#'
#' Bounded between -1.0 (avoidance), 0 (random feeding), and +1.0 (preference).
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
