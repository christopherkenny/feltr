% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/refresh.R
\name{felt_refresh_layer}
\alias{felt_refresh_layer}
\title{Refresh an existing layer}
\usage{
felt_refresh_layer(map_id, layer_id, file_names, clean = TRUE)
}
\arguments{
\item{map_id}{character, map identifier from url, from \verb{https://felt.com/map/Readable-Name-map_id}}

\item{layer_id}{character, layer identifier from url, from \code{felt_get_map()}}

\item{file_names}{file names to upload if the original layer was created with a file upload}

\item{clean}{logical, whether to turn the API response into a \link[tibble:tibble]{tibble::tibble}}
}
\value{
a \link[tibble:tibble]{tibble::tibble} with upload information
}
\description{
Refresh an existing layer
}
\examples{
\dontshow{if (has_felt_key()) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
felt_refresh_layer(map_id = 'Rockland-2024-Districts-TBI8sDkmQjuK2GX9CSiHiUA',
                  layer_id = 'rCfurZSFShycXHCBw69CdKB',
                  file_names = fs::path_package('feltr',  'towns.geojson'))
felt_refresh_layer(map_id = 'Rockland-2024-Districts-TBI8sDkmQjuK2GX9CSiHiUA',
                  layer_id = 'eufG5hWKRRSURHE8YcGGXA')
\dontshow{\}) # examplesIf}
}
