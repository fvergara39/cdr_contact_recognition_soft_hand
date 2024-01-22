function [d_train, l_train, t_train, d_val, l_val, t_val, d_test, l_test, t_test] = dataset_gen(finger,window_size, num)
init
do_shuffle = 1;
% preparazione dataset
if num<65
    [d, l, t] = one_finger_datagen50(finger);
    if num==55
        [d_fm, l_fm, t_fm] = one_finger_freemovement(finger);
        [d_train, l_train, t_train, d_val, l_val, t_val, d_test, l_test, t_test] = data_split(d, l, t, do_shuffle);
        [d_train, l_train, t_train, d_val, l_val, t_val, d_test, l_test, t_test] = balanced_data(d_train, l_train, t_train, d_val, l_val, t_val, d_test, l_test, t_test,d_fm,l_fm, t_fm);
    elseif num==60
        [d_fm, l_fm, t_fm] = one_finger_freemovement(finger);
        [d_v, l_v, t_v] = one_finger_vibration(finger);
        [d_train, l_train, t_train, d_val, l_val, t_val, d_test, l_test, t_test] = data_split(d, l, t, do_shuffle);
        [d_train, l_train, t_train, d_val, l_val, t_val, d_test, l_test, t_test] = balanced_data(d_train, l_train, t_train, d_val, l_val, t_val, d_test, l_test, t_test, d_fm,l_fm, t_fm);
        [d_train, l_train, t_train, d_val, l_val, t_val, d_test, l_test, t_test] = balanced_data(d_train, l_train, t_train, d_val, l_val, t_val,d_test, l_test, t_test,d_v,l_v, t_v);
    elseif num==50
        %     do_shuffle=0;
        [d_train, l_train, t_train, d_val, l_val, t_val, d_test, l_test, t_test] = data_split(d, l, t, do_shuffle);
    end

    if window_size>1
        [d_train, l_train, t_train] = window_gen(d_train, l_train, t_train, window_size);
        [d_val, l_val, t_val] = window_gen(d_val, l_val, t_val, window_size);
        [d_test, l_test, t_test] = window_gen(d_test, l_test, t_test, window_size);
    end
else
    global lh_fgr
    [d, l, t] = all_fingers_datagen250 (finger);
%     size(lh_fgr)
    if num==250
        [d_train, l_train, t_train, d_val, l_val, t_val, d_test, l_test, t_test] = data_split_bal(d, l, t, finger, do_shuffle);
    elseif num==255
        [d_fm, l_fm, t_fm] = all_fingers_freemovement(finger);
        [d_train, l_train, t_train, d_val, l_val, t_val, d_test, l_test, t_test] = data_split_bal(d, l, t, finger, do_shuffle);
        [d_train, l_train, t_train, d_val, l_val, t_val, d_test, l_test, t_test] = balanced_data(d_train, l_train, t_train, d_val, l_val, t_val, d_test, l_test, t_test,d_fm,l_fm, t_fm);
    elseif num==280
        global row_vibs lv_another row_vfgr lv_fgr another
        [d_fm, l_fm, t_fm] = all_fingers_freemovement(finger);
%         size(lh_fgr)
        [d_v, l_v, t_v,d_fgr, l_fgr, t_fgr] = all_fingers_vibration(finger);
%         size(lh_fgr)
        [d_train, l_train, t_train, d_val, l_val, t_val, d_test, l_test, t_test] = data_split_bal(d, l, t, finger, do_shuffle);
%         size(lh_fgr)
        another=2;
        [d_train, l_train, t_train, d_val, l_val, t_val, d_test, l_test, t_test] = balanced_data(d_train, l_train, t_train, d_val, l_val, t_val, d_test, l_test, t_test,d_fm,l_fm, t_fm);
%         size(lh_fgr)
%         size(d_fgr)
        another=0;
        [d_train, l_train, t_train, d_val, l_val, t_val, d_test, l_test, t_test] = balanced_data(d_train, l_train, t_train, d_val, l_val, t_val,d_test, l_test, t_test,d_fgr,l_fgr, t_fgr);
%         size(lh_fgr)
%         size(d_v)
        [d_train, l_train, t_train, d_val, l_val, t_val, d_test, l_test, t_test] = balanced_data(d_train, l_train, t_train, d_val, l_val, t_val,d_test, l_test, t_test,d_v,l_v, t_v);
        
    end

    if window_size>1
        disp(['Preparing dataset for moving window of width ', num2str(window_size),'...'])
        [d_train, l_train, t_train] = window_gen(d_train, l_train, t_train, window_size);
        [d_val, l_val, t_val] = window_gen(d_val, l_val, t_val, window_size);
        [d_test, l_test, t_test] = window_gen(d_test, l_test, t_test, window_size);
        disp('Done.')
    end    
end