%% 环境初始化

clc; clear; close all;

% 配置搜索路径
mfile_fullpath = mfilename('fullpath'); % the full path and name of the file in which the call occurs, not including the filename extension.
mfile_fullpath_without_filename = mfile_fullpath(1:end-strlength(mfilename));
addpath(mfile_fullpath_without_filename + "../data", genpath(mfile_fullpath_without_filename + "../lib")); % adds the specified folders to the top of the search path for the current MATLAB® session.

%% 常量定义

SOURCE_FILENAME = ["shortrad.cdf";"longrad.cdf";"netheat.cdf";"precip.cdf";"emp.cdf"];
VAR_NAME = ["shortrad";"longrad";"netheat";"precip";"emp"];
VAR_UNIT = ["W/m^2";"W/m^2";"W/m^2";"mm/(3hrs)";"mm/(3hrs)"];
FIG_TITLE = ["net short wave radiation";"outgoing longwave radiation";"constrained new outgoing heat flux";"precipitation rate";"constrained evaporation minus precipitation"];

%% 1-1
for idx_ = 1:length(SOURCE_FILENAME)
    source_full_path = mfile_fullpath_without_filename + "../data/" + SOURCE_FILENAME(idx_);
    hw1_1(source_full_path,VAR_NAME(idx_),VAR_UNIT(idx_),FIG_TITLE(idx_));
end

%% 局部函数

function [] = hw1_1(source_full_path,var_name,var_unit,fig_title)
%1-1
    arguments
        source_full_path char
        var_name char
        var_unit char
        fig_title char
    end
    %% 常量定义
    
    MONTH_NAME_SHORT = ["Jan";"Feb";"Mar";"Apr";"May";"Jun";"Jul";"Aug";"Sep";"Oct";"Nov";"Dec"];
    
    %% 读入数据
    
    ncdisp(source_full_path)
    lon = ncread(source_full_path,'X',1,Inf,1);
    lat = ncread(source_full_path,'Y',1,Inf,1);
    [grid_lon,grid_lat] = meshgrid(lon,lat);
    data_ = ncread(source_full_path,var_name,[1,1,1],[Inf,Inf,Inf],[1,1,1]);
    data_(data_ == ncreadatt(source_full_path,var_name,'missing_value')) = NaN;
    
    %% 绘图
    
    figure('Name',var_name,'Units','normalized','Position',[0 0 1 1])
    TiledChartLayout_t = tiledlayout('flow','TileSpacing','tight','Padding','tight');
    TiledChartLayout_t.TileIndexing = 'columnmajor';
    for month_ = 1:12
        nexttile
        % 用原始数据绘制伪彩图(Pseudocolor plot)，在此基础上才能绘制颜色图
        m_proj('robinson','clongitude',(var_name == "longrad") * 180); % longrad.cdf 中的经度(lon) 是 0~360 degree East, 其余都是 -180 ~ 180 degree East.
        m_pcolor(grid_lon,grid_lat,data_(:,:,month_).');
        m_coast('patch',[.7 .7 .7],'edgecolor','none'); % Draws a coastline with a gray fill and no border
        m_grid('tickdir','out','linewi',1,'fontsize',6,'fontname','Times New Roman');
        title('\fontname{Times New Roman}' + string(MONTH_NAME_SHORT(month_)))
        hold on
        % 绘制等值线
        [cs,h]=m_contour(lon,lat,data_(:,:,month_).','-k');
        clabel(cs,h,'fontsize',6,'fontname','Times New Roman');
    end
    % 配置公共颜色图
    colormap(m_colmap('jet','step',10));
    cb = colorbar('southoutside','fontname','Times New Roman');
    cb.Layout.Tile = 'east';
    xlabel(cb,'\fontname{Times New Roman}' + string(var_unit))
    % 公共标题
    title(TiledChartLayout_t,'\fontname{Times New Roman} \fontsize{16} \bf' + string(fig_title));
    set(gcf,'color','w');   % Need to do this otherwise 'print' turns the lakes black
    % 保存图片
    exportgraphics(TiledChartLayout_t,'../doc/' + string(fig_title) + ".png",'BackgroundColor','none','ContentType','auto','Resolution',600);
end
