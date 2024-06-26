% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/felt_key.R
\name{set_felt_key}
\alias{set_felt_key}
\alias{felt_set_key}
\title{Add Entry to Renviron}
\usage{
set_felt_key(key, overwrite = FALSE, install = FALSE, r_env = NULL)

felt_set_key(key, overwrite = FALSE, install = FALSE, r_env = NULL)
}
\arguments{
\item{key}{Character. API key to add to add.}

\item{overwrite}{Defaults to FALSE. Boolean. Should existing \code{FELT_KEY} in Renviron be overwritten?}

\item{install}{Defaults to FALSE. Boolean. Should this be added to an environment file, \code{r_env}?}

\item{r_env}{Path to install to if \code{install} is \code{TRUE}.}
}
\value{
key, invisibly
}
\description{
Adds Felt API key to .Renviron.
}
\examples{
example_env <- tempfile(fileext = '.Renviron')
set_felt_key('1234', r_env = example_env)
# r_env should likely be: file.path(Sys.getenv('HOME'), '.Renviron')
}
\concept{key}
