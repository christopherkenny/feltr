# inject into a function to avoid manually copying components of a list
# to avoid API changes breaking fn
# @param ... a list to break apart with !!!, e.g. `!!!args` for list `args`
req_injected <- function(req, ...) {
  rlang::inject(httr2::req_body_multipart(.req = req, ...))
}
