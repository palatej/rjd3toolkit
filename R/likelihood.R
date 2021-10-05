#' Title
#'
#' @param nobs
#' @param neffectiveobs
#' @param nparams
#' @param ll
#' @param adjustedll
#' @param aic
#' @param aicc
#' @param bic
#' @param bicc
#' @param ssq
#'
#' @return
#' @export
#'
#' @examples
likelihood<-function(nobs, neffectiveobs=NA, nparams=0, ll, adjustedll=NA, aic, aicc, bic, bicc, ssq){

  if (is.na(neffectiveobs)) neffectiveobs=nobs
  if (is.na(adjustedll)) adjustedll=ll

  return (structure(list(nobs=nobs, neffectiveobs=neffectiveobs, nparams=nparams,
                         ll=ll, adjustedll=adjustedll,
                         aic=aic, aicc=aicc, bic=bic, bicc=bicc, ssq=ssq),
                    class = "JD3_LIKELIHOOD"))
}
