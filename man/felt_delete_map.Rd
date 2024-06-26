% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/delete.R
\name{felt_delete_map}
\alias{felt_delete_map}
\title{Delete an existing map}
\usage{
felt_delete_map(map_id)
}
\arguments{
\item{map_id}{character, map identifier from url, from \verb{https://felt.com/map/Readable-Name-map_id}}
}
\value{
response code
}
\description{
Delete an existing map
}
\examples{
\dontshow{if (has_felt_key()) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
map <- felt_create_map(title = 'feltr example')
felt_delete_map(map_id = map$id)
\dontshow{\}) # examplesIf}
}
\concept{map}
