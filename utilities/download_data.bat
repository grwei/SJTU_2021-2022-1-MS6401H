@REM 批量下载 WOA18 数据
@REM 313017602@qq.com
@echo off

set DIR="../bat_download/an"
mkdir %DIR%

@REM salinity
FOR %%i IN (5564,6574,7584,8594,95A4,A5B7) DO (
    FOR %%j IN (00,13,14,15,16) DO (
        IF NOT EXIST "%DIR%/woa18_%%i_s%%j_01.nc" (
            @REM curl "https://www.ncei.noaa.gov/thredds-ocean/fileServer/ncei/woa/salinity/%%i/1.00/woa18_%%i_s%%j_01.nc" -o "%DIR%/woa18_%%i_s%%j_01.nc"
            curl "https://www.ncei.noaa.gov/thredds-ocean/ncss/ncei/woa/salinity/%%i/1.00/woa18_%%i_s%%j_01.nc?var=s_an&addLatLon=true&accept=netcdf" -o "%DIR%/woa18_%%i_s%%j_01.nc"
        )
    )
)

@REM temperature
FOR %%i IN (5564,6574,7584,8594,95A4,A5B7) DO (
    FOR %%j IN (00,13,14,15,16) DO (
        IF NOT EXIST "%DIR%/woa18_%%i_t%%j_01.nc" (
            @REM curl "https://www.ncei.noaa.gov/thredds-ocean/fileServer/ncei/woa/temperature/%%i/1.00/woa18_%%i_t%%j_01.nc" -o "%DIR%/woa18_%%i_t%%j_01.nc"
            curl "https://www.ncei.noaa.gov/thredds-ocean/ncss/ncei/woa/temperature/%%i/1.00/woa18_%%i_t%%j_01.nc?var=t_an&addLatLon=true&accept=netcdf" -o "%DIR%/woa18_%%i_t%%j_01.nc"
        )
    )
)
