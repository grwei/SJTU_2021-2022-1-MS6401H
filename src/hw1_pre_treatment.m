%% 

% Author: 危国锐（313017602@qq.com）
% Date: 2021-10-10
% Last Modified by: 危国锐（313017602@qq.com）
% Last Modified time:

function [] = hw1_pre_treatment(HW1_2_2_LON_TARGET_1,HW1_2_2_LON_TARGET_2)
% degree East

arguments
    HW1_2_2_LON_TARGET_1 double = -25
    HW1_2_2_LON_TARGET_2 double = -170
end

%% hw1_2_1 海表面温度、盐度的最值，和指定百分位数的最值

PERCENTAGES_LOWER = 5;
PERCENTAGES_UPPER = 95;
for variable_ = ["t","s"]
    for time_period_ = ["00","13","14","15","16"]
        min_data = +Inf;
        min_lower_percentiles = +Inf;
        max_data = -Inf;
        max_upper_percentiles = -Inf;
        for decadal_periods = ["5564","6574","7584","8594","95A4","A5B7"]
            data = ncread(sprintf("../data/woa18/woa18_%s_%c%s_01.nc",decadal_periods,variable_,time_period_),sprintf("%c_an",variable_),[1 1 1 1],[Inf,Inf,1,Inf],[1 1 1 1]); % Dimensions: lon,lat,depth,time
            current_min_data = min(data,[],"all");
            current_max_data = max(data,[],"all");
            current_percentiles = prctile(data,[PERCENTAGES_LOWER, PERCENTAGES_UPPER],"all");
            if (current_min_data < min_data)
                min_data = current_min_data;
            end
            if (current_max_data > max_data)
                max_data = current_max_data;
            end
            if (current_percentiles(1) < min_lower_percentiles)
                min_lower_percentiles = current_percentiles(1);
            end
            if (current_percentiles(2) > max_upper_percentiles)
                max_upper_percentiles = current_percentiles(2);
            end
        end
        hw1_2_1_pre_treatment.(variable_ + time_period_).min = min_data;
        hw1_2_1_pre_treatment.(variable_ + time_period_).max = max_data;
        hw1_2_1_pre_treatment.(variable_ + time_period_).percentages_lower = PERCENTAGES_LOWER;
        hw1_2_1_pre_treatment.(variable_ + time_period_).percentages_upper = PERCENTAGES_UPPER;
        hw1_2_1_pre_treatment.(variable_ + time_period_).(sprintf("min_%u_percentiles",PERCENTAGES_LOWER)) = min_lower_percentiles;
        hw1_2_1_pre_treatment.(variable_ + time_period_).(sprintf("max_%u_percentiles",PERCENTAGES_UPPER)) = max_upper_percentiles;
    end
end

%% hw1_2_2 海表面温度、盐度的最值，和指定百分位数的最值

% 常量定义
PERCENTAGES_LOWER = 5;
PERCENTAGES_UPPER = 95;
% HW1_2_2_LON_TARGET_1 = -170; % degree East
% HW1_2_2_LON_TARGET_2 = -25;

for variable_ = ["t","s"]
    for time_period_ = ["00","13","14","15","16"]
        hw1_2_2_pre_treatment.block1.(variable_ + time_period_).percentages_lower = PERCENTAGES_LOWER;
        hw1_2_2_pre_treatment.block1.(variable_ + time_period_).percentages_upper = PERCENTAGES_UPPER;
        [hw1_2_2_pre_treatment.block1.lon_value,hw1_2_2_pre_treatment.block1.lon_index,hw1_2_2_pre_treatment.block1.(variable_ + time_period_).min_data,hw1_2_2_pre_treatment.block1.(variable_ + time_period_).max_data,hw1_2_2_pre_treatment.block1.(variable_ + time_period_).(sprintf("min_%u_percentiles",PERCENTAGES_LOWER)),hw1_2_2_pre_treatment.block1.(variable_ + time_period_).(sprintf("max_%u_percentiles",PERCENTAGES_UPPER))] = hw1_2_2_GetVerticalSectionMinMaxPercentiles(HW1_2_2_LON_TARGET_1,variable_,time_period_,PERCENTAGES_LOWER,PERCENTAGES_UPPER);
        hw1_2_2_pre_treatment.block2.(variable_ + time_period_).percentages_lower = PERCENTAGES_LOWER;
        hw1_2_2_pre_treatment.block2.(variable_ + time_period_).percentages_upper = PERCENTAGES_UPPER;
        [hw1_2_2_pre_treatment.block2.lon_value,hw1_2_2_pre_treatment.block2.lon_index,hw1_2_2_pre_treatment.block2.(variable_ + time_period_).min_data,hw1_2_2_pre_treatment.block2.(variable_ + time_period_).max_data,hw1_2_2_pre_treatment.block2.(variable_ + time_period_).(sprintf("min_%u_percentiles",PERCENTAGES_LOWER)),hw1_2_2_pre_treatment.block2.(variable_ + time_period_).(sprintf("max_%u_percentiles",PERCENTAGES_UPPER))] = hw1_2_2_GetVerticalSectionMinMaxPercentiles(HW1_2_2_LON_TARGET_2,variable_,time_period_,PERCENTAGES_LOWER,PERCENTAGES_UPPER);
    end
end

save ../bin/hw1_pre_treatment.mat hw1_2_1_pre_treatment hw1_2_2_pre_treatment

end

%% 局部函数

function [lon_actual_value,lon_actual_index,min_data,max_data,min_lower_percentiles,max_upper_percentiles] = hw1_2_2_GetVerticalSectionMinMaxPercentiles(lon_target_,variable_,time_period_,percentages_lower_,percentages_upper_)
    arguments
        lon_target_ double
        variable_ char
        time_period_ char
        percentages_lower_ double
        percentages_upper_ double
    end

    min_data = +Inf;
    min_lower_percentiles = +Inf;
    max_data = -Inf;
    max_upper_percentiles = -Inf;
    for decadal_periods = ["5564","6574","7584","8594","95A4","A5B7"]
        % 确定实际经度
        lon = ncread(sprintf("../data/woa18/woa18_%s_%c%s_01.nc",decadal_periods,variable_,time_period_),'lon');
        [~,lon_actual_index] = min(abs(lon - lon_target_)); % 查找最接近目标经度的索引
        lon_actual_value = lon(lon_actual_index); % 实际经度值
        % 确定数据及其指定分位数的最值
        data = ncread(sprintf("../data/woa18/woa18_%s_%c%s_01.nc",decadal_periods,variable_,time_period_),sprintf("%c_an",variable_),[lon_actual_index 1 1 1],[1,Inf,Inf,Inf],[1 1 1 1]); % Dimensions: lon,lat,depth,time
        current_min_data = min(data,[],"all");
        current_max_data = max(data,[],"all");
        current_percentiles = prctile(data,[percentages_lower_, percentages_upper_],"all");
        if (current_min_data < min_data)
            min_data = current_min_data;
        end
        if (current_max_data > max_data)
            max_data = current_max_data;
        end
        if (current_percentiles(1) < min_lower_percentiles)
            min_lower_percentiles = current_percentiles(1);
        end
        if (current_percentiles(2) > max_upper_percentiles)
            max_upper_percentiles = current_percentiles(2);
        end
    end
end
