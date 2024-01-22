% The function takes a cell-array of d_fv, l_fv, t_fv, and assigns it
% coherently to the three dataset (train, validation, test), according to
% test_perc and train_perc determinated in the file init

function [d_train, l_train, t_train, d_val, l_val, t_val, d_test, l_test, t_test] = balanced_data(d_train, l_train, t_train, d_val, l_val, t_val, d_test, l_test, t_test, d_fv,l_fv, t_fv)

global row_vibs row_vfgr l_vibs lv_fgr another
init

num_test = round(test_perc * size(d_fv,1));
num_val = round((size(d_fv,1) - num_test)*val_perc);
num_train = round(size(d_fv,1) -num_test-num_val);

d_train = [d_train; d_fv(1:num_train)];
l_train = [l_train; l_fv(1:num_train)];
t_train = [t_train; t_fv(1:num_train)];

d_val = [d_val; d_fv(num_train+1:num_train+num_val)];
l_val = [l_val; l_fv(num_train+1:num_train+num_val)];
t_val = [t_val; t_fv(num_train+1:num_train+num_val)];

d_test = [d_test; d_fv(num_train+num_val+1:end)];
l_test = [l_test; l_fv(num_train+num_val+1:end)];
t_test = [t_test; t_fv(num_train+num_val+1:end)];

if size(d_fv,1)==20
    row_vibs = row_vibs(num_train+num_val+1:end,:);
    l_vibs = l_vibs(num_train+num_val+1:end,:);
elseif size(d_fv,1)==5 & another~=2
    row_vfgr = row_vfgr(num_train+num_val+1:end,:);
    lv_fgr = lv_fgr(num_train+num_val+1:end,:);
end