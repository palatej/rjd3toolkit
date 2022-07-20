#' @include utils.R
NULL
#> NULL


#' Java Utility Functions
#'
#' These functions are used in all JDemetra+ 3.0 packages to easily interact between R and Java objects.
#'
#' @param jtest,s,period,startYear,startPeriod,length,ldt,dt,jparams,start,end,y,m,d,year,month,day,type,p,code,prefix,r,span,rspan,rslt,name,jobj,jrslt,jobjRef,subclasses,result parameters.
#'
#' @name jd3_utilities
NULL
#> NULL

#' @export
#' @rdname jd3_utilities
jd2r_test<-function(jtest){
  if (is.jnull(jtest))
    return (NULL)
  else{
    desc<-.jcall(jtest, "S", "getDescription")
    val<-.jcall(jtest, "D", "getValue")
    pval<-.jcall(jtest, "D", "getPvalue")
    return (statisticaltest(val, pval, desc))
  }
}

#' @export
#' @rdname jd3_utilities
ts_r2jd<-function(s){
  if (is.null(s)){
    return (NULL)
  }
  freq<-frequency(s)
  start<-start(s)
  .jcall("demetra/timeseries/r/TsUtility", "Ldemetra/timeseries/TsData;", "of",
         as.integer(freq), as.integer(start[1]), as.integer(start[2]), as.double(s))
}

#' @export
#' @rdname jd3_utilities
tsdomain_r2jd<-function(period, startYear, startPeriod, length){
  .jcall("demetra/timeseries/r/TsUtility", "Ldemetra/timeseries/TsDomain;", "of",
         as.integer(period), as.integer(startYear), as.integer(startPeriod), as.integer(length))
}

#' @export
#' @rdname jd3_utilities
ts_jd2r<-function(s){
  if (is.null(s)){
    return (NULL)
  }
  jx<-.jcall(s, "Ldemetra/data/DoubleSeq;", "getValues")
  x<-.jcall(jx, "[D", "toArray")
  if (is.null(x)) return (NULL)
  if (length(x) == 0) return (NULL)
  pstart<-.jcall("demetra/timeseries/r/TsUtility", "[I", "startPeriod", s)
  ts(x,start=pstart[2:3], frequency=pstart[1])
}

#' @export
#' @rdname jd3_utilities
matrix_jd2r<-function(s){
  if (is.jnull(s)){
    return (NULL)
  }
  nr<-.jcall(s, "I", "getRowsCount")
  nc<-.jcall(s, "I", "getColumnsCount")
  d<-.jcall(s, "[D", "toArray")
  return (array(d, dim=c(nr, nc)))
}

#' @export
#' @rdname jd3_utilities
matrix_r2jd<-function(s){
  if (is.null(s))
    return (.jnull("demetra/math/matrices/Matrix"))
  if (!is.matrix(s)){
    s<-matrix(s, nrow=length(s), ncol=1)
  }
  sdim<-dim(s)
  return (.jcall("demetra/math/matrices/Matrix","Ldemetra/math/matrices/Matrix;", "of", as.double(s), as.integer(sdim[1]), as.integer(sdim[2])))
}

# Delete this duplicated function?
# jd2r_test<-function(jtest){
#   if (is.jnull(jtest))
#     return (NULL)
#   else{
#     desc<-.jcall(jtest, "S", "getDescription")
#     val<-.jcall(jtest, "D", "getValue")
#     pval<-.jcall(jtest, "D", "getPvalue")
#     return (list(value=val, pvalue=pval, distribution=desc))
#   }
# }

#' @export
#' @rdname jd3_utilities
j2r_ldt<-function(ldt){
  if (is.jnull(ldt))
    return (NULL)
  dt<-.jcall(ldt, "Ljava/time/LocalDate;", "toLocalDate")
  return (as.Date(.jcall(dt, "S", "toString")))
}

#' @export
#' @rdname jd3_utilities
j2r_dt<-function(dt){
  if (is.jnull(dt))
    return (NULL)
  return (as.Date(.jcall(dt, "S", "toString")))
}

#' @export
#' @rdname jd3_utilities
r2j_dt<-function(dt){
  jdt<-.jnew("java/lang/String", as.character(dt))
  return (.jcall("java/time/LocalDate", "Ljava/time/LocalDate;", "parse", .jcast(jdt, "java/lang/CharSequence")))
}

#' @export
#' @rdname jd3_utilities
r2j_ldt<-function(dt){
  jdt<-r2j_dt(dt)
  return (.jcall(jdt, "Ljava/time/LocalDateTime;", "atStartOfDay"))
}

#' @rdname jd3_utilities
#' @export
jd2r_parameters <- function(jparams){
  if (is.jnull(jparams))
    return(NULL)
  param<-.jcastToArray(jparams)
  len <- length(param)
  if (len==0)
    return (NULL)
  param_name <- deparse(substitute(jparams))
  Type <- sapply(param, function(x) .jcall(.jcall(x, "Ldemetra/data/ParameterType;", "getType"), "S", "name"))
  Value <- sapply(param, function(x) .jcall(x, "D", "getValue"))
  data_param <- data.frame(Type = Type, Value = Value)
  rownames(data_param) <- sprintf("%s(%i)",
                                  param_name,
                                  1:len)
  data_param
}

#' @export
#' @rdname jd3_utilities
jdomain<-function(period, start, end){
  if (period == 0)return (.jnull("demetra/timeseries/TsDomain"))
  n<-period*(end[1]-start[1])+end[2]-start[2]
  jdom<-.jcall("demetra/timeseries/r/TsUtility", "Ldemetra/timeseries/TsDomain;", "of"
               , as.integer(period), as.integer(start[1]), as.integer(start[2]), as.integer(n))
  return (jdom)
}
