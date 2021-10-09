# 批量下载 WOA18 数据
# 313017602@qq.com

$DIR = "../ps_download/an"
mkdir $DIR # 数据存放的根目录
$DECADAL_PERIODS = ("5564", "6574", "7584", "8594", "95A4", "A5B7")
$TIME_PERIOD = ("00", "13", "14", "15", "16")

# temperature
foreach ($dddd in $DECADAL_PERIODS) {
    foreach ($tt in $TIME_PERIOD) {
        if (-not(Test-Path "$($DIR)/woa18_$($dddd)_t$($tt)_01.nc")) {
            # Invoke-WebRequest -Uri "https://www.ncei.noaa.gov/thredds-ocean/fileServer/ncei/woa/temperature/$($dddd)/1.00/woa18_$($dddd)_t$($tt)_01.nc" -OutFile "$($DIR)/woa18_$($dddd)_t$($tt)_01.nc"
            Invoke-WebRequest -Uri "https://www.ncei.noaa.gov/thredds-ocean/ncss/ncei/woa/temperature/$($dddd)/1.00/woa18_$($dddd)_t$($tt)_01.nc?var=t_an&addLatLon=true&accept=netcdf" -OutFile "$($DIR)/woa18_$($dddd)_t$($tt)_01.nc"
        }
    }
}

# salinity
foreach ($dddd in $DECADAL_PERIODS) {
    foreach ($tt in $TIME_PERIOD) {
        if (-not(Test-Path "$($DIR)/woa18_$($dddd)_s$($tt)_01.nc")) {
            # Invoke-WebRequest -Uri "https://www.ncei.noaa.gov/thredds-ocean/fileServer/ncei/woa/salinity/$($dddd)/1.00/woa18_$($dddd)_s$($tt)_01.nc" -OutFile "$($DIR)/woa18_$($dddd)_s$($tt)_01.nc"
            Invoke-WebRequest -Uri "https://www.ncei.noaa.gov/thredds-ocean/ncss/ncei/woa/salinity/$($dddd)/1.00/woa18_$($dddd)_s$($tt)_01.nc?var=s_an&addLatLon=true&accept=netcdf" -OutFile "$($DIR)/woa18_$($dddd)_s$($tt)_01.nc"
        }
    }
}
