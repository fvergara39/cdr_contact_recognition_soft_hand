% %% Init 
% clear all
close all
clc
global D L T finger name fgr_name list_idx
global d_test l_test t_test l_pred window_size finger type_prob 
global netName full_path do_train multiclass parentFolder net name list_idx
global d_hit_test l_hit_test t_hit_test
global l_another row_hits 
global lv_another row_vibs row_vfgr lv_fgr another
global row_fgr lh_fgr experiment
% Determine where your m-file's folder is.
folder = fileparts(which(mfilename)); 
% Add that folder plus all subfolders to the path.
addpath(genpath(folder));

% experimental data
load dati_285_prove.mat
load data_rel.mat

% Order of 'hit' experiments
fgr_name = char('Little','Ring','Medium','Index','Thumb'); 

% Name - in ordine delle imu
name = char('Ring','Medium ','Index','Thumb','Little');
% Order of accelerations
list_idx = [5, ...%Little   
            1, ...%Ring
            2, ...%Medium
            3, ...%Index
            4];   %Thumb

% config - dataset split
test_perc = 0.2;
val_perc = 0.2;

rng("default");

do_shuffle = 1;
do_train = 0;

