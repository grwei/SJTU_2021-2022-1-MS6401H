%% 

% Author: 危国锐（313017602@qq.com）
% Date: 2021-10-10
% Last Modified by: 危国锐（313017602@qq.com）
% Last Modified time:

%% 

clc; clear; close all;

% hw1_2_1 海表面温度、盐度的最值
for variable_ = ["t","s"]
    for time_period_ = ["00","13","14","15","16"]
        min_data = +Inf;
        max_data = -Inf;
        for decadal_periods = ["5564","6574","7584","8594","95A4","A5B7"]
            data = ncread(sprintf("../data/woa18/woa18_%s_%c%s_01.nc",decadal_periods,variable_,time_period_),sprintf("%c_an",variable_),[1 1 1 1],[Inf,Inf,1,Inf],[1 1 1 1]); % Dimensions: lon,lat,depth,time
            current_min_data = min(data,[],"all");
            current_max_data = max(data,[],"all");
            if (current_min_data < min_data)
                min_data = current_min_data;
            end
            if (current_max_data > max_data)
                max_data = current_max_data;
            end
        end
        hw1_2_1_pre_treatment.(variable_ + time_period_).min = min_data;
        hw1_2_1_pre_treatment.(variable_ + time_period_).max = max_data;
    end
end

save ../bin/hw1_pre_treatment.mat hw1_2_1_pre_treatment
