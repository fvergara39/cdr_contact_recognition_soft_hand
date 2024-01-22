% Split the data DATA in
% TEST = DATA*perc_test
% VALIDATION = (DATA - TEST)*perc_val

function [XTrain, YTrain,TTrain, XVal, YVal, TVal, XTest, YTest, TTest] = data_split(data, labels, times, do_shuffle)

global l_another row_hits
init
num_test = round(size(data,1)*test_perc);
num_val = round(test_perc*(1-val_perc)*size(data,1));

% Test data-set : 20% of the training dataset
if do_shuffle == 1
    num_test = round(size(data,1)*test_perc);
    shuffle_test = randperm(size(data,1),num_test);

    XTrain = data;
    YTrain = labels;
    TTrain = times;

    XTest = XTrain(shuffle_test,:);
    YTest = YTrain(shuffle_test);
    TTest = TTrain(shuffle_test);

    if size(data,1)==200
        l_another = l_another(shuffle_test,:);
        row_hits = row_hits(shuffle_test,:);
    elseif size(data,1)==25
        
    end

    XTrain(shuffle_test,:) = [];
    YTrain(shuffle_test) = [];
    TTrain(shuffle_test) = [];

    % Validation data-set : 20% of the training dataset
    num_val = round(size(XTrain,1)*val_perc);
    shuf_val = randperm(size(XTrain,1),num_val);

    XVal = XTrain(shuf_val,:);
    YVal = YTrain(shuf_val);
    TVal = TTrain(shuf_val);

    XTrain(shuf_val,:) = [];
    YTrain(shuf_val) = [];
    TTrain(shuf_val) = [];

elseif do_shuffle ==0
    XTest = data(1:num_test);
    YTest = labels(1:num_test);
    TTest = times(1:num_test);

    XVal = data(num_test+1:num_test+num_val);
    YVal = labels(num_test+1:num_test+num_val);
    TVal = times(num_test+1:num_test+num_val);

    XTrain = data(num_test+num_val+1:end);
    YTrain = labels(num_test+num_val+1:end);
    TTrain = times(num_test+num_val+1:end);
end

