daily_parser <- function(response) {
    httr::content(response, as = "text") %>% jsonlite::fromJSON(simplifyVector = TRUE) %>%
        purrr::pluck("Rows")
}


#' Annual total parser
#'
#' @param response a httr response
#'
#' @return parsed response from httr
#' @importFrom magrittr %>%
#'
#'
annual_totals_parser <- function(response) {
    # Annual report totals
    pre_process <- httr::content(response, as = "text") %>% jsonlite::fromJSON() %>%
        purrr::pluck("AnnualReportBody") %>% dplyr::select(c("Year", "SiteId", "AnnualReportAverages",
        "AnnualReportTotals")) %>% jsonlite::flatten()

    col_names <- colnames(pre_process) %>% stringr::str_replace("AnnualReport",
        "")

    colnames(pre_process) <- col_names

    return(pre_process)
}

annual_monthly_parser <- function(response) {
    pre_processed <- httr::content(response, as = "text") %>% jsonlite::fromJSON() %>%
        purrr::pluck("AnnualReportBody") %>% dplyr::select(c("Year", "SiteId", "AnnualReportMonthlyDataRows"))


    years <- as.list(pre_processed$Year)
    siteIDS <- as.list(pre_processed$SiteId)
    MonthlyData <- pre_processed$AnnualReportMonthlyDataRows


    extract_nested_monthly_data <- function(y, s, m) {
        data.frame(year = y, siteId = s, m, stringsAsFactors = FALSE)
    }

    purrr::pmap(list(y = years, s = siteIDS, m = MonthlyData), extract_nested_monthly_data) %>%
        purrr::map(jsonlite::flatten) %>% purrr::map_df(dplyr::bind_rows)
}

monthly_summary_aggregation_parser <- function(response) {
    pre_processed <- httr::content(response, as = "text") %>% jsonlite::fromJSON() %>%
        purrr::pluck("MonthCollection") %>% dplyr::select(c("Month", "SiteId", "Summary Aggregations")) %>%
        jsonlite::flatten()

    col_names <- colnames(pre_processed) %>% stringr::str_replace("Summary Aggregations.",
        "")

    colnames(pre_processed) <- col_names

    return(pre_processed)
}

monthly_daily_flow_parser <- function(response) {
    pre_processed <- response %>% httr::content(as = "text") %>% jsonlite::fromJSON() %>%
        purrr::pluck("MonthCollection") %>% dplyr::select(c("Month", "SiteId", "Days"))


    d_months <- as.list(pre_processed$Month)
    d_ids <- as.list(pre_processed$SiteId)
    d_days <- pre_processed$Days
    d_days_ag <- pre_processed$`Daily Aggregations`


    extract_nested_day_data <- function(m, i, d) {
        data.frame(Month = m, SiteId = i, d, stringsAsFactors = FALSE)
    }

    df <- purrr::pmap(list(m = d_months, i = d_ids, d = d_days), extract_nested_day_data) %>%
        purrr::map_df(dplyr::bind_rows)

    return(df)
}

monthly_daily_aggregate_parser <- function(response) {

    pre_processed <- response %>% httr::content(as = "text") %>% jsonlite::fromJSON() %>%
        purrr::pluck("MonthCollection") %>% dplyr::select(c("Month", "SiteId", "Daily Aggregations"))


    d_months <- as.list(pre_processed$Month)
    d_ids <- as.list(pre_processed$SiteId)
    d_days_ag <- pre_processed$`Daily Aggregations`


    extract_nested_day_data <- function(m, i, d) {
        data.frame(Month = m, SiteId = i, d, stringsAsFactors = FALSE)
    }

    df <- purrr::pmap(list(m = d_months, i = d_ids, d = d_days_ag), extract_nested_day_data) %>%
        purrr::map_df(dplyr::bind_rows)

    df
}

monthly_hourly_aggregate_parser <- function(response) {
    pre_processed <- response %>% httr::content(as = "text") %>% jsonlite::fromJSON() %>%
        purrr::pluck("MonthCollection") %>% dplyr::select(c("Month", "SiteId", "Hourly Aggregations"))


    d_months <- as.list(pre_processed$Month)
    d_ids <- as.list(pre_processed$SiteId)
    d_days_ag <- pre_processed$`Hourly Aggregations`


    extract_nested_day_data <- function(m, i, d) {
        data.frame(Month = m, SiteId = i, d, stringsAsFactors = FALSE)
    }

    df <- purrr::pmap(list(m = d_months, i = d_ids, d = d_days_ag), extract_nested_day_data) %>%
        purrr::map_df(dplyr::bind_rows)

    df
}
