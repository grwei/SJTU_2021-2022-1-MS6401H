%% 作业1_2_1（绘制全球分布图）

% Author: 危国锐（313017602@qq.com）
% Date: 2021-10
% Last Modified by: 危国锐（313017602@qq.com）
% Last Modified time: 2021-10-10

%% 环境初始化

clc; clear; close all;

% 预处理
if ~isfile("../bin/hw1_2_1_preprocessing.mat")
    hw1_2_1_preprocessing
end
if ~isfolder("../doc/fig/")
    mkdir ../doc/fig/
end
% 配置搜索路径
mfile_fullpath = mfilename('fullpath'); % the full path and name of the file in which the call occurs, not including the filename extension.
mfile_fullpath_without_filename = mfile_fullpath(1:end-strlength(mfilename));
addpath(mfile_fullpath_without_filename + "../data", genpath(mfile_fullpath_without_filename + "../lib")); % adds the specified folders to the top of the search path for the current MATLAB® session.

%% 1-2-1

for variable_ = ["s","t"]
    hw_1_2_1_diff2(variable_,"A5B7","8594"); % 四个季节平均增量的并列图
    for time_period_ = ["00","13","14","15","16"]
        hw_1_2_1(variable_,time_period_);
        hw_1_2_1_diff(variable_,time_period_,"A5B7","8594") % 逐时间平均区间作图
    end
end

%% 局部函数

function [] = hw_1_2_1(variable_,time_period_)
    arguments
        variable_ char
        time_period_ char
    end

    %% 初始化
    
    load ../bin/hw1_2_1_preprocessing.mat hw1_2_1_preprocessing
    variable_fullname = hw1_2_GetFullName(variable_);
    time_period_fullname = hw1_2_GetFullName(time_period_);
    
    %% 绘图
    
    figure('Name',sprintf("%s Surface %s",time_period_fullname,variable_fullname),'Units','normalized','Position',[0 0 .65 .86])
    TiledChartLayout_t = tiledlayout('flow','TileSpacing','tight','Padding','tight');
    TiledChartLayout_t.TileIndexing = 'columnmajor';
    for decadal_periods = ["5564","6574","7584","8594","95A4","A5B7"]
        nexttile
        % 读取数据
        lon = ncread(sprintf("../data/woa18/woa18_%s_%c%s_01.nc",decadal_periods,variable_,time_period_),'lon');
        lat = ncread(sprintf("../data/woa18/woa18_%s_%c%s_01.nc",decadal_periods,variable_,time_period_),'lat');
        [grid_lon,grid_lat] = ndgrid(lon,lat);
        data = ncread(sprintf("../data/woa18/woa18_%s_%c%s_01.nc",decadal_periods,variable_,time_period_),sprintf("%c_an",variable_),[1 1 1 1],[Inf,Inf,1,Inf],[1 1 1 1]); % Dimensions: lon,lat,depth,time
        % 用原始数据绘制伪彩图(Pseudocolor plot)，在此基础上再选颜色图方案
        m_proj('robinson','clongitude',0);
        m_pcolor(grid_lon,grid_lat,data); 
        caxis([hw1_2_1_preprocessing.(sprintf("%c%s",variable_,time_period_)).(sprintf("min_%u_percentiles",hw1_2_1_preprocessing.(sprintf("%c%s",variable_,time_period_)).percentages_lower)),hw1_2_1_preprocessing.(sprintf("%c%s",variable_,time_period_)).(sprintf("max_%u_percentiles",hw1_2_1_preprocessing.(sprintf("%c%s",variable_,time_period_)).percentages_upper))]); % Hold Color Limits for Multiple Plots
        m_coast('patch',[.7 .7 .7],'edgecolor','none'); % Draws a coastline with a gray fill and no border
        m_grid('tickdir','out','linewi',1,'fontsize',6,'fontname','Times New Roman');
        title(sprintf("\\fontname{Times New Roman} %s",hw1_2_GetFullName(decadal_periods)))
        hold on
        % 绘制等值线
        [cs,h]=m_contour(grid_lon,grid_lat,data,'-k');
        clabel(cs,h,'fontsize',6,'fontname','Times New Roman');
    end
    % 配置公共颜色图
    colormap(m_colmap('jet','step',30));
    cb = colorbar('southoutside','fontname','Times New Roman');
    cb.Layout.Tile = 'east';
    xlabel(cb,sprintf("\\fontname{Times New Roman} %s",hw1_2_GetVariableUnits(variable_)))
    % 公共标题
    title(TiledChartLayout_t,sprintf("\\fontname{Times New Roman} \\fontsize{20} \\bf %s Surface %s",time_period_fullname,variable_fullname));
    set(gcf,'color','w');   % Need to do this otherwise 'print' turns the lakes black
    % 保存图片
    exportgraphics(TiledChartLayout_t,sprintf("../doc/fig/Surface_%s_%s.png",variable_fullname,time_period_fullname),'BackgroundColor','none','ContentType','auto','Resolution',800);
end

function [] = hw_1_2_1_diff(variable_,time_period_,decadal_periods_1,decadal_periods_2)
    arguments
        variable_ char
        time_period_ char
        decadal_periods_1 char
        decadal_periods_2 char
    end

    %% 初始化
    
    variable_fullname = hw1_2_GetFullName(variable_);
    time_period_fullname = hw1_2_GetFullName(time_period_);
    
    %% 绘图
    
    figure('Name',sprintf("%s Surface %s: Diff %s-%s",time_period_fullname,variable_fullname,decadal_periods_2,decadal_periods_1),'Units','normalized','Position',[0 0 .65 .86])
    TiledChartLayout_t = tiledlayout('flow','TileSpacing','tight','Padding','tight');
    TiledChartLayout_t.TileIndexing = 'columnmajor';
    nexttile
    % 读取数据
    lon = ncread(sprintf("../data/woa18/woa18_%s_%c%s_01.nc",decadal_periods_1,variable_,time_period_),'lon');
    lat = ncread(sprintf("../data/woa18/woa18_%s_%c%s_01.nc",decadal_periods_1,variable_,time_period_),'lat');
    [grid_lon,grid_lat] = ndgrid(lon,lat);
    data = ncread(sprintf("../data/woa18/woa18_%s_%c%s_01.nc",decadal_periods_1,variable_,time_period_),sprintf("%c_an",variable_),[1 1 1 1],[Inf,Inf,1,Inf],[1 1 1 1]) ...
         - ncread(sprintf("../data/woa18/woa18_%s_%c%s_01.nc",decadal_periods_2,variable_,time_period_),sprintf("%c_an",variable_),[1 1 1 1],[Inf,Inf,1,Inf],[1 1 1 1]); % Dimensions: lon,lat,depth,time
    % 用原始数据绘制伪彩图(Pseudocolor plot)，在此基础上再选颜色图方案
    m_proj('robinson','clongitude',0);
    m_pcolor(grid_lon,grid_lat,data);
    caxis(prctile(data,[8 92],"all"))
    m_coast('patch',[.7 .7 .7],'edgecolor','none'); % Draws a coastline with a gray fill and no border
    m_grid('tickdir','out','linewi',1,'fontsize',6,'fontname','Times New Roman')
    hold on
    % 绘制等值线
    [cs,h]=m_contour(grid_lon,grid_lat,data,'-k');
    clabel(cs,h,'fontsize',6,'fontname','Times New Roman');
    % 配置颜色图
    colormap(m_colmap('jet','step',30));
    cb = colorbar('southoutside','fontname','Times New Roman');
    cb.Layout.Tile = 'east';
    xlabel(cb,sprintf("\\fontname{Times New Roman} %s",hw1_2_GetVariableUnits(variable_)))
    % 标题
    title(TiledChartLayout_t,sprintf("\\fontname{Times New Roman} \\fontsize{20} \\bf %s Surface %s: Diff %s-%s",time_period_fullname,variable_fullname,decadal_periods_2,decadal_periods_1));
    set(gcf,'color','w');   % Need to do this otherwise 'print' turns the lakes black
    % 保存图片
    exportgraphics(TiledChartLayout_t,sprintf("../doc/fig/Surface_%s_%s_diff_%s_%s.png",variable_fullname,time_period_fullname,decadal_periods_2,decadal_periods_1),'BackgroundColor','none','ContentType','auto','Resolution',500);
end

function [] = hw_1_2_1_diff2(variable_,decadal_periods_1,decadal_periods_2)
    arguments
        variable_ char
        decadal_periods_1 char
        decadal_periods_2 char
    end

    %% 初始化

    persistent caxis_cl;
    variable_fullname = hw1_2_GetFullName(variable_);
    
    %% 绘图
    
    figure('Name',sprintf("Surface %s: Diff2 %s-%s",variable_fullname,decadal_periods_2,decadal_periods_1),...
           'Units','normalized','Position',[0 0 .64 .60])
    TiledChartLayout_t = tiledlayout('flow','TileSpacing','tight','Padding','tight');
    TiledChartLayout_t.TileIndexing = 'columnmajor';
    for time_period_ = ["13","14","15","16"]
        nexttile
        % 读取数据
        lon = ncread(sprintf("../data/woa18/woa18_%s_%c%s_01.nc",decadal_periods_1,variable_,time_period_),'lon');
        lat = ncread(sprintf("../data/woa18/woa18_%s_%c%s_01.nc",decadal_periods_1,variable_,time_period_),'lat');
        [grid_lon,grid_lat] = ndgrid(lon,lat);
        data = ncread(sprintf("../data/woa18/woa18_%s_%c%s_01.nc",decadal_periods_1,variable_,time_period_),sprintf("%c_an",variable_),[1 1 1 1],[Inf,Inf,1,Inf],[1 1 1 1]) ...
             - ncread(sprintf("../data/woa18/woa18_%s_%c%s_01.nc",decadal_periods_2,variable_,time_period_),sprintf("%c_an",variable_),[1 1 1 1],[Inf,Inf,1,Inf],[1 1 1 1]); % Dimensions: lon,lat,depth,time
        % 用原始数据绘制伪彩图(Pseudocolor plot)，在此基础上再选颜色图方案
        m_proj('robinson','clongitude',0);
        m_pcolor(grid_lon,grid_lat,data);
        if time_period_ == "13" % 用首次循环的分位数统一颜色图范围
            caxis(prctile(data,[8 92],"all"));
            caxis_cl = caxis;
        else
            caxis(caxis_cl);
        end
        m_coast('patch',[.7 .7 .7],'edgecolor','none'); % Draws a coastline with a gray fill and no border
        m_grid('tickdir','out','linewi',1,'fontsize',6,'fontname','Times New Roman')
        title(sprintf("\\fontname{Times New Roman} %s",hw1_2_GetFullName(time_period_)))
        hold on
        % 绘制等值线
        [cs,h]=m_contour(grid_lon,grid_lat,data,'-k');
        clabel(cs,h,'fontsize',6,'fontname','Times New Roman');
    end
    % 配置公共颜色图
    colormap(m_colmap('jet','step',30));
    cb = colorbar('southoutside','fontname','Times New Roman');
    cb.Layout.Tile = 'east';
    xlabel(cb,sprintf("\\fontname{Times New Roman} %s",hw1_2_GetVariableUnits(variable_)))
    % 配置公共坐标区
    title(TiledChartLayout_t,sprintf("\\fontname{Times New Roman} \\fontsize{20} \\bf Surface %s: Diff %s-%s",variable_fullname,decadal_periods_2,decadal_periods_1),...
         "\fontname{Times New Roman} \fontsize{16} \bf season-averaged");
    set(gcf,'color','w');   % Need to do this otherwise 'print' turns the lakes black
    % 保存图片
    exportgraphics(TiledChartLayout_t,sprintf("../doc/fig/Surface_%s_diff2_%s_%s.png",variable_fullname,decadal_periods_2,decadal_periods_1),'BackgroundColor','none','ContentType','auto','Resolution',500);
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
