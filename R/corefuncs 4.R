api <- function(verbose = FALSE, ...) {
    api_url <- "http://webtris.highwaysengland.co.uk/"
    api_url <- httr::modify_url(api_url, ...)
    if (verbose == TRUE) {
        message(stringr::str_interp("Api call: ${api_url}"))
    }
    httr::GET(api_url)
}

parse_json <- function(httrresp) {
    jsonlite::fromJSON(txt = httr::content(httrresp, "text"),
                       simplifyVector = TRUE)
}



dateformatter <- function(date) {
    # If it isn't a date datatype then convert.
    if (!lubridate::is.Date(date)) {
        date <- lubridate::dmy(date)
    }
    day <- stringr::str_pad(lubridate::day(date), 2, pad = "0")
    month <- stringr::str_pad(lubridate::month(date), 2, pad = "0")
    year <- lubridate::year(date)
    return(stringr::str_interp("${day}${month}${year}"))
}

