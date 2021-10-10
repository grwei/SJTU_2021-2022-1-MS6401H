%% 

% Author: 危国锐（313017602@qq.com）
% Date: 2021-10-10
% Last Modified by: 危国锐（313017602@qq.com）
% Last Modified time: 2021-10-10

function [] = hw1_2_1_preprocessing()

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
        hw1_2_1_preprocessing.(variable_ + time_period_).min = min_data;
        hw1_2_1_preprocessing.(variable_ + time_period_).max = max_data;
        hw1_2_1_preprocessing.(variable_ + time_period_).percentages_lower = PERCENTAGES_LOWER;
        hw1_2_1_preprocessing.(variable_ + time_period_).percentages_upper = PERCENTAGES_UPPER;
        hw1_2_1_preprocessing.(variable_ + time_period_).(sprintf("min_%u_percentiles",PERCENTAGES_LOWER)) = min_lower_percentiles;
        hw1_2_1_preprocessing.(variable_ + time_period_).(sprintf("max_%u_percentiles",PERCENTAGES_UPPER)) = max_upper_percentiles;
    end
end
save ../bin/hw1_2_1_preprocessing.mat hw1_2_1_preprocessing
