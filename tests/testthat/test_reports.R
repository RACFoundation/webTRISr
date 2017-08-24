library(testthat)
library(webTRISr)

test_that("Daily report works", {
    x <- webTRISr::webtris_report("7", "01012017", "07012017", "daily", 100, TRUE, FALSE)

    expect_is(x, class = "data.frame")
    expected_cols <- c("Site Name", "Report Date", "Time Period Ending", "Time Interval",
        "0 - 520 cm", "521 - 660 cm", "661 - 1160 cm", "1160+ cm", "0 - 10 mph",
        "11 - 15 mph", "16 - 20 mph", "21 - 25 mph", "26 - 30 mph", "31 - 35 mph",
        "36 - 40 mph", "41 - 45 mph", "46 - 50 mph", "51 - 55 mph", "56 - 60 mph",
        "61 - 70 mph", "71 - 80 mph", "80+ mph", "Avg mph", "Total Volume")
    expect_equivalent(expected_cols, colnames(x))
})




test_that("This report should have 576 rows", {
    x <- webTRISr::webtris_report(c("51", "2", "5"), "01012017", "02012017", "daily",
        10000)
    expect_length(x[[1]], 576)
})
