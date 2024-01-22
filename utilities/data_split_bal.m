
% The function takes d_hit, l_hit, t_hit, of the 50 experiments related to
% the finger, and it assigns them (in percentage test_perc, val_perc)
% coherently to the three dataset (train, validation, test)


function [d_train, l_train, t_train, d_val, l_val, t_val, d_test, l_test, t_test] = data_split_bal(d, l, t, finger, do_shuffle)

global l_another row_hits
global d_hit_test l_hit_test t_hit_test lh_fgr row_fgr
init
fgr_idx = find(ismember(fgr_name,finger,'rows')==1); 

% individuo i 50 esperimenti di interesse
start_exp = 50*(fgr_idx-1) +1;
end_exp = 50*(fgr_idx-1) + 50;
num_exp = end_exp - start_exp;

d_hit = d(start_exp : end_exp);
l_hit = l(start_exp : end_exp);
t_hit = t(start_exp : end_exp);

% determino il numero di esperimenti per test val e train
num_test = round(num_exp* test_perc)
num_val = round((num_exp - num_test)*val_perc);

% splitto i 50 esperimenti
% size(l_fgr)
d_hit_test = d_hit(1:num_test);
lh_fgr = lh_fgr(1:num_test,1);
row_fgr = row_fgr(1:num_test,:);
d_hit_val = d_hit(num_test+1:num_test+1+num_val);
d_hit_train = d_hit(num_test+num_val+2:end);

l_hit_test = l_hit(1:num_test);
l_hit_val = l_hit(num_test+1:num_test+1+num_val);
l_hit_train = l_hit(num_test+num_val+2:end);

t_hit_test = t_hit(1:num_test);
t_hit_val = t_hit(num_test+1:num_test+1+num_val);
t_hit_train = t_hit(num_test+num_val+2:end);

% creo D L T senza gli esperimenti sul finger
d_no = [d(1:start_exp-1) ; d(end_exp+1:end)];
l_no = [l(1:start_exp-1) ; l(end_exp+1:end)];
t_no = [t(1:start_exp-1) ; t(end_exp+1:end)];
l_another = [l_another(1:start_exp-1) ; l_another(end_exp+1:end)];
row_hits = [row_hits(1:(start_exp-1),:) ; row_hits((end_exp+1):end,:)];

% data splitting degli esperimenti senza gli hit
[d_train, l_train,t_train, d_val, l_val, t_val, d_test, l_test, t_test] = data_split(d_no, l_no, t_no, do_shuffle);

% impilo i dataset dei due tipi di dati.
d_train = [d_train ; d_hit_train];
t_train = [t_train ; t_hit_train];
l_train = [l_train ; l_hit_train];

d_val = [d_val ; d_hit_val];
t_val = [t_val ; t_hit_val];
l_val = [l_val ; l_hit_val];

d_test = [d_test ; d_hit_test];
t_test = [t_test ; t_hit_test];
l_test = [l_test ; l_hit_test];
