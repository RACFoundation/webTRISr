# webTRISr

[![Build Status](https://travis-ci.org/RACFoundation/webTRISr.svg?branch=master)](https://travis-ci.org/RACFoundation/webTRISr)
[![CRAN](http://www.r-pkg.org/badges/version-ago/webTRISr)](https://cran.r-project.org/package=webTRISr)
[![](https://cranlogs.r-pkg.org/badges/webTRISr)](https://cran.r-project.org/package=webTRISr)

A R package for the WebTRIS Traffic Flow API, from Highways England.

Feedback and contributions welcome - please raise an issue or pull request.


## Installation

```r
install.packages('webTRISr')
```

or


```r
install.packages('devtools')
devtools::install_github('RACFoundation/webTRISr')
```

## Examples
### Reports
Reports can be downloaded, as data frames, using `webtris_report()`

```r
webtris_report(sites=c('7', '24'),
               start_date = '01012017', end_date = '01022017',
               report_type = 'monthly-summary')
```


```
#> Fetched page 1 of approximately 10000 rows
```



|Month         |SiteId |ADT24Hour | ADT24HourLargeVehiclesPercentage|AWT24Hour | AWT24HourLargeVehiclesPercentage|ADT18Hour | ADT18HourLargeVehiclesPercentage|AWT18Hour | AWT18HourLargeVehiclesPercentage|ADT16Hour | ADT16HourLargeVehiclesPercentage|AWT16Hour | AWT16HourLargeVehiclesPercentage|ADT12Hour | ADT12HourLargeVehiclesPercentage|AWT12Hour | AWT12HourLargeVehiclesPercentage|
|:-------------|:------|:---------|--------------------------------:|:---------|--------------------------------:|:---------|--------------------------------:|:---------|--------------------------------:|:---------|--------------------------------:|:---------|--------------------------------:|:---------|--------------------------------:|:---------|--------------------------------:|
|January 2017  |7      |1671      |                             11.1|1938      |                             12.3|1623      |                             10.4|1883      |                             11.5|1601      |                             10.4|1860      |                             11.5|1454      |                             10.2|1686      |                             11.4|
|February 2017 |7      |1852      |                             11.8|2119      |                             13.1|1800      |                               11|2060      |                             12.4|1773      |                               11|2031      |                             12.4|1615      |                               11|1846      |                             12.5|
|January 2017  |24     |37132     |                             14.4|39949     |                             16.7|35542     |                             13.1|38199     |                             15.3|34427     |                             12.9|37085     |                             15.1|29073     |                             12.9|31366     |                             15.2|
|February 2017 |24     |40529     |                             14.2|42703     |                             16.6|38807     |                             12.9|40825     |                             15.3|37562     |                             12.8|39595     |                             15.2|31535     |                             12.8|33112     |                             15.3|









All reports currently provided by the API are availble by changing the `report_type` argument. At present these options are: "daily", "annual-totals", "annual-monthly", "monthly-summary", "monthly-daily", "monthly-daily-aggregate", and "monthly-hourly-aggregate".

### Areas


```r
webtris_areas()
```


|Id |Name                            |Description                     | XLongitude|  XLatitude| YLongitude|  YLatitude|
|:--|:-------------------------------|:-------------------------------|----------:|----------:|----------:|----------:|
|1  |A1 Darrington to Dishforth DBFO |A1 Darrington to Dishforth DBFO | -1.2548718| 53.6827769| -1.4461635| 54.1543464|
|2  |A19 DBFO                        |A19 DBFO                        | -1.1123656| 54.1535047| -1.4906831| 54.9749529|
|3  |A1M DBFO                        |A1M DBFO                        | -0.2339609| 52.3604247| -0.3283727| 52.5347699|
|4  |A249 DBFO                       |A249 DBFO                       |  0.7725873| 51.3280254|  0.6602573| 51.4419403|
|5  |A30/A35 DBFO                    |A30/A35 DBFO                    | -2.2118659| 50.6913012| -3.4654564| 50.8130964|
|6  |A417/A419 DBFO                  |A417/A419 DBFO                  | -1.7172151| 51.5279008|  -2.166667| 51.8570205|








### Sites

```r
webtris_sites()
```


|Id |Name                                                                                         |Description |  Longitude|   Latitude|Status   |
|:--|:--------------------------------------------------------------------------------------------|:-----------|----------:|----------:|:--------|
|1  |MIDAS site at M4/2295A2 priority 1 on link 105009001; GPS Ref: 502816;178156; Westbound      |M4/2295A2   | -0.5203796| 51.4930115|Inactive |
|2  |MIDAS site at A1M/2259B priority 1 on link 126046101; GPS Ref: 514029;294356; Southbound     |A1M/2259B   | -0.3202755| 52.5351578|Active   |
|3  |MIDAS site at M5/7482B priority 1 on link 109001601; GPS Ref: 388120;253057; Northbound      |M5/7482B    | -2.1751383| 52.1756518|Active   |
|4  |MIDAS site at M3/2173A priority 1 on link 103009101; GPS Ref: 442770;118058; Westbound       |M3/2173A    | -1.3923737| 50.9603586|Active   |
|5  |MIDAS site at M25/5764B priority 1 on link 199056702; GPS Ref: 558308;188775; Anti-clockwise |M25/5764B   |  0.2831616| 51.5756168|Active   |
|6  |MIDAS site at M27/9273A priority 1 on link 103009302; GPS Ref: 448516;111110; Eastbound      |M27/9273A   | -1.3114861| 50.8974292|Active   |








### Quality

```r
webtris_quality(siteID = '2', start_date = '01012017', end_date = '01022017')
```


```
#> Warning: attributes are not identical across measure variables;
#> they will be dropped
```



|Date       |Quality |
|:----------|:-------|
|1483228800 |100     |
|1483315200 |100     |
|1483401600 |100     |
|1483488000 |100     |
|1483574400 |100     |
|1483660800 |100     |
