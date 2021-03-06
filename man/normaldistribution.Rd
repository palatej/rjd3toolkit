% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/distributions.R
\name{normaldistribution}
\alias{normaldistribution}
\alias{randomsT}
\alias{densityT}
\alias{cdfT}
\title{The Student Distribution}
\usage{
randomsT(df, n)

densityT(df, x)

cdfT(df, x)
}
\arguments{
\item{df}{degrees of freedom.}

\item{n}{number of observations.}

\item{x}{vector of quantiles.}
}
\description{
Density, (cumulative) distribution function and random generation for Student distribution.
}
\examples{
# T with 2 degrees of freedom.
z<-densityT(2, .01*seq(-100, 100, 1))
# T with 2 degrees of freedom. 100 randoms
z<-randomsT(2, 100)
}
