reportAPI <- function(sites, start_date, end_date, report_type, maxrequest, currentpage,
    verbose) {

    # Format dates
    start_date <- dateformatter(start_date)
    end_date <- dateformatter(end_date)

    sites <- paste0(sites, collapse = ",")

    api_target <- stringr::str_c("api/v1/reports/", stringr::str_to_title(report_type))

    varlist <- list(sites = sites, start_date = start_date, end_date = end_date,
        page = currentpage, page_size = maxrequest)

    return(api(verbose, path = api_target, query = varlist))
}

reportFetch <- function(sites, start_date, end_date, report_type, maxrequest, verbose) {
    currentpage <- 1  #Always start on page 1
    dataincomming = TRUE
    list_of_responses <- list()

    while (dataincomming) {
        data <- reportAPI(sites, start_date, end_date, report_type, maxrequest, currentpage,
            verbose)

        total <- currentpage * maxrequest
        message(stringr::str_interp("Fetched page ${currentpage} of approximately ${total} rows"))

        list_of_responses[currentpage] <- list(data)

        if (nextPage(data)) {
            currentpage <- currentpage + 1
        } else {
            dataincomming <- FALSE
        }
    }
    return(list_of_responses)
}


nextPage <- function(x) {
    stringr::str_detect(httr::content(x, "text"), "nextPage")
}
