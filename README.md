---
output:
  md_document:
    variant: markdown_github
---

<!-- README.md is generated from README.Rmd. Please edit that file -->



# webTRISr

A R package for the WebTRIS Traffic Flow API, from Highways England. 

Feedback and contirubtions welcome - please raise and issue or pull request. 


## Installation 


```r
install.packages('devtools')
devtools::install_github('departmentfortransport/webTRISr')
```

## Examples
### Reports
Reports can be downloaded, as data frames, using `webtris_report()`

```r
webtris_report(sites=c('7', '24'), 
               start_date = '01012017', end_date = '01022017', 
               report_type = 'monthly-summary')
```


Note the data is cut here for easy printing, more variables are returned by the api. 

```
#> Fetched page 1 of approximately 10000 rows
```



|Month         |SiteId |ADT24Hour | ADT24HourLargeVehiclesPercentage|AWT24Hour | AWT24HourLargeVehiclesPercentage|
|:-------------|:------|:---------|--------------------------------:|:---------|--------------------------------:|
|January 2017  |7      |1671      |                             11.1|1938      |                             12.3|
|February 2017 |7      |1852      |                             11.8|2119      |                             13.1|
|January 2017  |24     |37132     |                             14.4|39949     |                             16.7|
|February 2017 |24     |40529     |                             14.2|42703     |                             16.6|


  


  



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


  


  

