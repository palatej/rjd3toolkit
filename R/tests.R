#' @include utils.R
NULL


#' Title
#'
#' @param val
#' @param pval
#' @param dist
#'
#' @return
#' @export
#'
#' @examples
statisticaltest<-function(val, pval, dist=NULL){
  if (pval<0){
    pval=0
  }else if (pval>1){
    pval=1
  }
  return (structure(list(value=val, pvalue=pval), distribution=dist, class=c("JD3_TEST", "JD3")))
}

#' Title
#'
#' @param test
#' @param details
#'
#' @return
#' @export
#'
#' @examples
print.JD3_TEST<-function(test, details=F){
  cat('Value: ', test$value, '\n')
  cat('P-Value: ', sprintf('%.4f', test$pvalue), '\n')
  if (details){
    dist=attr(test, "distribution")
    if (! is.null(dist)){
      cat('[', dist, ']\n')
    }
  }
}



#' Title
#'
#' @param data
#' @param k
#' @param lag
#' @param nhp
#' @param sign If 1, only positive auto-corrrelations are considered in the test. If -1, only negative auto-correlations are considered. If 0, all auto-correlations are integrated in the test.
#' @param mean Mean correction. If true, the auto-correlations are computed as usual. If false, we consider that the (known) mean is 0 and that the series has been corrected for it.
#'
#' @return
#' @export
#'
#' @examples
ljungbox<-function(data, k, lag=1, nhp=0, sign=0, mean=T){
  jtest<-.jcall("demetra/stats/r/Tests", "Ldemetra/stats/StatisticalTest;", "ljungBox",
                as.numeric(data), as.integer(k), as.integer(lag), as.integer(nhp), as.integer(sign), as.logical(mean))
  return (jd2r_test(jtest))
}

#' Title
#'
#' @param data
#'
#' @return
#' @export
#'
#' @examples
bowmanshenton<-function(data){
  jtest<-.jcall("demetra/stats/r/Tests", "Ldemetra/stats/StatisticalTest;", "bowmanShenton",as.numeric(data))
  return (jd2r_test(jtest))
}

#' Title
#'
#' @param data
#'
#' @return
#' @export
#'
#' @examples
doornikhansen<-function(data){
  jtest<-.jcall("demetra/stats/r/Tests", "Ldemetra/stats/StatisticalTest;", "doornikHansen",as.numeric(data))
  return (jd2r_test(jtest))
}

#' Title
#'
#' @param data
#' @param k
#' @param sample
#'
#' @return
#' @export
#'
#' @examples
jarquebera<-function(data, k=0, sample=T){
  jtest<-.jcall("demetra/stats/r/Tests", "Ldemetra/stats/StatisticalTest;", "jarqueBera",
                as.numeric(data), as.integer(k), as.logical(sample))
  return (jd2r_test(jtest))
}

#' Runs test around the mean or the median
#'
#' @param data Data being tested
#' @param mean If True, runs around the mean. Otherwise, runs around the median
#' @param number If True, test the number of runs. Otherwise, test the lengths of the runs
#'
#' @return
#' @export
#'
#' @examples
testofruns<-function(data, mean=T, number=T){
  jtest<-.jcall("demetra/stats/r/Tests", "Ldemetra/stats/StatisticalTest;", "testOfRuns",
                as.numeric(data), as.logical(mean), as.logical(number))
  return (jd2r_test(jtest))
}

#' Up and down runs test
#'
#' @param data
#' @param number If True, test the number of runs. Otherwise, test the lengths of the runs
#'
#' @return
#' @export
#'
#' @examples
testofupdownruns<-function(data, number=T){
  jtest<-.jcall("demetra/stats/r/Tests", "Ldemetra/stats/StatisticalTest;", "testOfUpDownsRuns",
                as.numeric(data), as.logical(number))
  return (jd2r_test(jtest))
}

#' Title
#'
#' @param data
#' @param nar
#' @param n
#'
#' @return
#' @export
#'
#' @examples
autocorrelations.inverse<-function(data, nar=30, n=15){
  return (.jcall("demetra/stats/r/Tests", "[D", "inverseAutocorrelations",
                as.numeric(data), as.integer(nar), as.integer(n)))
}

#' Title
#'
#' @param data
#' @param mean
#' @param n
#'
#' @return
#' @export
#'
#' @examples
autocorrelations.partial<-function(data, mean=T, n=15){
  return (.jcall("demetra/stats/r/Tests", "[D", "partialAutocorrelations",
                 as.numeric(data), as.logical(mean), as.integer(n)))
}

#' Title
#'
#' @param data
#' @param mean
#' @param n
#'
#' @return
#' @export
#'
#' @examples
autocorrelations<-function(data, mean=T, n=15){
  return (.jcall("demetra/stats/r/Tests", "[D", "autocorrelations",
                 as.numeric(data), as.logical(mean), as.integer(n)))
}
