#' Areas
#'
#' Returns areas from WEBTRIS API
#'
#' @param areaID area ID. If none provided then returns all.
#'
#' @return data.frame
#' @export
#'
#' @examples webtris_areas()
#' @examples webtris_areas(areaID=3)
webtris_areas <- function(areaID) {
    if (methods::hasArg(areaID)) {
        target_api <- stringr::str_interp("api/v1/areas/${areaID}")
    } else {
        target_api <- "api/v1/areas"
    }
    df <- parse_json(api(path = target_api))$areas

    df <- suppressMessages(readr::type_convert(df))

    return(df)
}

#' Sites
#'
#' @param siteID Numeric site ID. Blank will return all sites.
#'
#' @return dataframe of sites.
#' @export
#'
#' @examples
#' webtris_sites()
#' webtris_sites('3')
webtris_sites <- function(siteID) {
    if (methods::hasArg(siteID)) {
        target_api <- stringr::str_interp("api/v1/sites/${siteID}")
    } else {
        target_api <- "api/v1/sites"
    }
    df <- parse_json(api(path = target_api))$sites

    df <- suppressMessages(readr::type_convert(df))

    return(df)
}


#' Quality
#'
#' @param siteID either a single site ID or a list c(1,2,3). Daily data doesn't support a list of sites.
#' @param start_date either a string in the format ddmmyy or a Date (lubridate)
#' @param end_date either a string in the format ddmmyy or a Date (lubridate)
#' @param daily TRUE or FALSE. If FALSE returns overall. Use FALSE when list of siteIDs.
#'
#' @return data.frame
#' @export
#'
#' @examples
#' webtris_quality('7', start_date='01012017', end_date='01022017', daily=TRUE)
webtris_quality <- function(siteID, start_date, end_date, daily = TRUE) {
    if (daily == TRUE) {
        target_api <- "api/v1/quality/daily"
    } else {
        target_api <- "api/v1/quality/overall"
    }

    # Format dates
    start_date <- dateformatter(start_date)
    end_date <- dateformatter(end_date)


    if (daily == FALSE) {
        # Convert inputted site ids to comma separated
        siteID <- stringr::str_c(siteID, collapse = "%2C")

        # Construct the path manually as httr:build_url() encodes siteID in an unexpected
        # format

        manual_path <- stringr::str_interp("${target_api}?sites=${siteID}&start_date=${start_date}&end_date=${end_date}")


        out <- parse_json(api(path = manual_path))
        out <- as.data.frame(out)


        # correct for remote bug.
        t1 <- as.Date(start_date, format="%d%m%Y")
        t2 <- as.Date(end_date, format="%d%m%Y")
        days <- as.numeric(1 + (t2 - t1))
        cf <- (max(1, days - 1))/days
        out$data_quality <- round(out$data_quality * cf)


    } else {
        path = target_api
        query = list(siteId = siteID, start_date = start_date, end_date = end_date)


       out <- parse_json(api(path = path, query = query))$Qualities
       out <- as.data.frame(out)
    }

    df <- suppressMessages(readr::type_convert(out))

    return(df)
}
