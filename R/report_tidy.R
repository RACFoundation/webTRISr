#' webtris_report
#'
#' @param sites siteId(s) i.e. 7 or '7' or c('7','8', '9')
#' @param start_date in format 'DDMMYYYY' or as a Date object
#' @param end_date in format 'DDMMYYYY' or as a Date object
#' @param report_type options are: "daily", "annual-totals", "annual-monthly", "monthly-summary", "monthly-daily", "monthly-daily-aggregate", "monthly-hourly-aggregate"
#' @param maxrequest Maximum number of rows to return per requiest (optional)
#' @param verbose Prints the API call
#' @param return_raw Return a raw httr response rather than a data frame
#'
#' @return a dataframe or httr object
#' @export
#'
#' @examples
webtris_report <- function(sites, start_date, end_date, report_type, maxrequest = 10000,
    verbose = FALSE, return_raw = FALSE) {

    parsers <- list(daily = quote(daily_parser), `annual-totals` = quote(annual_totals_parser),
        `annual-monthly` = quote(annual_monthly_parser), `monthly-summary` = quote(monthly_summary_aggregation_parser),
        `monthly-daily` = quote(monthly_daily_flow_parser), `monthly-daily-aggregate` = quote(monthly_daily_aggregate_parser),
        `monthly-hourly-aggregate` = quote(monthly_hourly_aggregate_parser))

    report_to_fetch <- stringr::str_split(report_type, pattern = "-")[[1]][1]
    report_to_fetch <- stringr::str_to_title(report_to_fetch)

    raw_data <- reportFetch(sites, start_date, end_date, report_type = report_to_fetch,
        maxrequest, verbose)

    if (return_raw) {
        return(raw_data)
    }

    map_call <- quote(purrr::map_df(.x = raw_data, .f = NULL))

    map_call$.f <- parsers[report_type][[1]]

    df <- eval(map_call)
    df <- suppressMessages(readr::type_convert(df))

    return(df)
}
