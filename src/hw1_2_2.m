%% 

% Author: 危国锐（313017602@qq.com）
% Date: 2021-10
% Last Modified by: 危国锐（313017602@qq.com）
% Last Modified time:

%% 环境初始化

clc; clear; close all;

% 预处理
if ~isfile("../bin/hw1_pre_treatment.mat")
    hw1_pre_treatment
end
if ~isfolder("../doc/fig/")
    mkdir ../doc/fig/
end
% 配置搜索路径
mfile_fullpath = mfilename('fullpath'); % the full path and name of the file in which the call occurs, not including the filename extension.
mfile_fullpath_without_filename = mfile_fullpath(1:end-strlength(mfilename));
addpath(mfile_fullpath_without_filename + "../data", genpath(mfile_fullpath_without_filename + "../lib")); % adds the specified folders to the top of the search path for the current MATLAB® session.

%% 1-2-2

for HW1_2_2_LON_TARGET = [-25,-170]
    hw1_pre_treatment(HW1_2_2_LON_TARGET);
    for variable_ = ["s","t"]
        for time_period_ = ["00","13","14","15","16"]
            hw_1_2_2(variable_,time_period_);
            hw_1_2_2_diff(variable_,time_period_,"A5B7","8594")
        end
    end
end

%% 局部函数

function [] = hw_1_2_2(variable_,time_period_)
    arguments
        variable_ char
        time_period_ char
    end

    %% 初始化
    
    load ../bin/hw1_pre_treatment.mat hw1_2_2_pre_treatment
    variable_fullname = hw1_2_GetFullName(variable_);
    time_period_fullname = hw1_2_GetFullName(time_period_);
    
    %% 绘图
    
    figure('Name',sprintf("%s %s: %gE Vertical Section",time_period_fullname,variable_fullname,hw1_2_2_pre_treatment.block1.lon_value),'Units','normalized','Position',[0 0 .65 .86])
    TiledChartLayout_t = tiledlayout('flow','TileSpacing','tight','Padding','tight');
    TiledChartLayout_t.TileIndexing = 'columnmajor';
    for decadal_periods = ["5564","6574","7584","8594","95A4","A5B7"]
        ax = nexttile;
        % 读取数据
        depth = ncread(sprintf("../data/woa18/woa18_%s_%c%s_01.nc",decadal_periods,variable_,time_period_),'depth');
        lat = ncread(sprintf("../data/woa18/woa18_%s_%c%s_01.nc",decadal_periods,variable_,time_period_),'lat');
        [grid_lat,grid_depth] = ndgrid(lat,depth);
        data = squeeze(ncread(sprintf("../data/woa18/woa18_%s_%c%s_01.nc",decadal_periods,variable_,time_period_),sprintf("%c_an",variable_),[hw1_2_2_pre_treatment.block1.lon_index 1 1 1],[1,Inf,Inf,Inf],[1 1 1 1])); % Dimensions: lon,lat,depth,time
        % 用原始数据绘制伪彩图(Pseudocolor plot)，在此基础上再选颜色图方案
        s = pcolor(grid_lat,grid_depth,data);
        s.EdgeColor = 'flat';
        caxis([hw1_2_2_pre_treatment.block1.(sprintf("%c%s",variable_,time_period_)).(sprintf("min_%u_percentiles",hw1_2_2_pre_treatment.block1.(sprintf("%c%s",variable_,time_period_)).percentages_lower)),hw1_2_2_pre_treatment.block1.(sprintf("%c%s",variable_,time_period_)).(sprintf("max_%u_percentiles",hw1_2_2_pre_treatment.block1.(sprintf("%c%s",variable_,time_period_)).percentages_upper))]); % Hold Color Limits for Multiple Plots
        title(sprintf("\\fontname{Times New Roman} %s",hw1_2_GetFullName(decadal_periods)))
        hold on
        % 绘制等值线
        [cs,h]=contour(grid_lat,grid_depth,data,'-k');
        clabel(cs,h,'fontsize',6,'fontname','Times New Roman');
        axis ij
        ax.FontName = "Times New Roman";
    end
    % 配置公共颜色图
    colormap(m_colmap('jet','step',30));
    cb = colorbar('southoutside','fontname','Times New Roman');
    cb.Layout.Tile = 'east';
    xlabel(cb,sprintf("\\fontname{Times New Roman} %s",hw1_2_GetVariableUnits(variable_)))
    % 公共标题、轴标签
    title(TiledChartLayout_t,sprintf("\\fontname{Times New Roman} \\fontsize{20} \\bf %s %s: Vertical Section",time_period_fullname,variable_fullname),sprintf("\\fontname{Times New Roman} \\fontsize{16} \\bf %g degrees East",hw1_2_2_pre_treatment.block1.lon_value))
    xlabel(TiledChartLayout_t,"\fontname{Times New Roman} Latitude (degrees North)")
    ylabel(TiledChartLayout_t,"\fontname{Times New Roman} Depth (m)")
    set(gcf,'color','w');   % Need to do this otherwise 'print' turns the lakes black
    % 保存图片
    exportgraphics(TiledChartLayout_t,sprintf("../doc/fig/Vertical_Section_%gE_%s_%s.png",hw1_2_2_pre_treatment.block1.lon_value,variable_fullname,time_period_fullname),'BackgroundColor','none','ContentType','auto','Resolution',800);
end

function [] = hw_1_2_2_diff(variable_,time_period_,decadal_periods_1,decadal_periods_2)
    arguments
        variable_ char
        time_period_ char
        decadal_periods_1 char
        decadal_periods_2 char
    end

    %% 初始化

    load ../bin/hw1_pre_treatment.mat hw1_2_2_pre_treatment
    variable_fullname = hw1_2_GetFullName(variable_);
    time_period_fullname = hw1_2_GetFullName(time_period_);
    
    %% 绘图
    
    figure('Name',sprintf("%s %s %g degE Vertical Section: Diff %s-%s",time_period_fullname,variable_fullname,hw1_2_2_pre_treatment.block1.lon_value,decadal_periods_2,decadal_periods_1),'Units','normalized','Position',[0 0 .65 .86])
    TiledChartLayout_t = tiledlayout('flow','TileSpacing','tight','Padding','tight');
    TiledChartLayout_t.TileIndexing = 'columnmajor';
    ax = nexttile;
    % 读取数据
    depth = ncread(sprintf("../data/woa18/woa18_%s_%c%s_01.nc",decadal_periods_1,variable_,time_period_),'depth');
    lat = ncread(sprintf("../data/woa18/woa18_%s_%c%s_01.nc",decadal_periods_1,variable_,time_period_),'lat');
    [grid_lat,grid_depth] = ndgrid(lat,depth);
    data = squeeze(ncread(sprintf("../data/woa18/woa18_%s_%c%s_01.nc",decadal_periods_2,variable_,time_period_),sprintf("%c_an",variable_),[hw1_2_2_pre_treatment.block1.lon_index 1 1 1],[1,Inf,Inf,Inf],[1 1 1 1]) ...
                  - ncread(sprintf("../data/woa18/woa18_%s_%c%s_01.nc",decadal_periods_1,variable_,time_period_),sprintf("%c_an",variable_),[hw1_2_2_pre_treatment.block1.lon_index 1 1 1],[1,Inf,Inf,Inf],[1 1 1 1])); % Dimensions: lon,lat,depth,time
    % 用原始数据绘制伪彩图(Pseudocolor plot)，在此基础上再选颜色图方案
    s = pcolor(grid_lat,grid_depth,data);
    s.EdgeColor = 'flat';
    caxis(prctile(data,[8 92],"all")); % Hold Color Limits for Multiple Plots
    hold on
    % 绘制等值线
    [cs,h] = contour(grid_lat,grid_depth,data,'-k');
    clabel(cs,h,'fontsize',6,'fontname','Times New Roman');
    axis ij
    ax.FontName = "Times New Roman";
    % 配置颜色图
    colormap(m_colmap('jet','step',30));
    cb = colorbar('southoutside','fontname','Times New Roman');
    cb.Layout.Tile = 'east';
    xlabel(cb,sprintf("\\fontname{Times New Roman} %s",hw1_2_GetVariableUnits(variable_)))
    % 标题
    title(TiledChartLayout_t,sprintf("\\fontname{Times New Roman} \\fontsize{20} \\bf %s %s Vertical Section: Diff %s-%s",time_period_fullname,variable_fullname,decadal_periods_2,decadal_periods_1), sprintf("\\fontname{Times New Roman} \\fontsize{16} \\bf %g degrees East",hw1_2_2_pre_treatment.block1.lon_value));
    set(gcf,'color','w');   % Need to do this otherwise 'print' turns the lakes black
    % 保存图片
    exportgraphics(TiledChartLayout_t,sprintf("../doc/fig/Vertical_Section_%gE_%s_%s_diff_%s_%s.png",hw1_2_2_pre_treatment.block1.lon_value,variable_fullname,time_period_fullname,decadal_periods_2,decadal_periods_1),'BackgroundColor','none','ContentType','auto','Resolution',800);
end

function FullName = hw1_2_GetFullName(str_)
    arguments
        str_ string
    end

    switch string(str_)
        case "t"
           FullName = "Temperature";
        case "s"
           FullName = "Salinity";
        case "00"
            FullName = "Annual";
        case "13"
            FullName = "Winter";
        case "14"
            FullName = "Spring";
        case "15"
            FullName = "Summer";
        case "16"
            FullName = "Autumn";
        case "5564"
            FullName = "1955-1964";
        case "6574"
            FullName = "1965-1974";
        case "7584"
            FullName = "1975-1984";
        case "8594"
            FullName = "1985-1994";
        case "95A4"
            FullName = "1995-2004";
        case "A5B7"
            FullName = "2005-2017";
        otherwise
            FullName = "Invalid Arguments!";
    end
end

function VariableUnits = hw1_2_GetVariableUnits(str_)
    arguments
        str_ string
    end

    switch string(str_)
        case "t"
            VariableUnits = "\circ C";
        case "s"
            VariableUnits = "1e-3";
    end
end

function [lon_name] = hw1_2_2_GetIntLonName(int_lon_degree_east_)
    arguments
        int_lon_degree_east_ int8 {mustBeGreaterThanOrEqual(int_lon_degree_east_,-180),mustBeLessThanOrEqual(int_lon_degree_east_,180)}
    end

    if (int_lon_degree_east_ < 0)
        lon_name = sprintf("%uW",abs(int_lon_degree_east_));
    else
        lon_name = sprintf("%uE",abs(int_lon_degree_east_));
    end
end
