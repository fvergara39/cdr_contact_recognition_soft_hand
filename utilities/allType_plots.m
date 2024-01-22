% PLOTS
global another which_finger label_num 
fgr_idx = find(ismember(fgr_name,finger,'rows')==1);
label_num = list_idx(fgr_idx);

%% definizione degli esperimenti per ogni tipo di contatto
Hit_plots=[];
Vib_plots=[];
NoHit_plots=[];
NoVib_plots=[];
No_plots = [];

for i=1:size(l_test,1)
    if ~isempty(find(l_test{i}=='hit'))
        Hit_plots= [Hit_plots;i];
    elseif ~isempty(find(l_test{i}=='vibration'))
        Vib_plots= [Vib_plots;i];
    else
        No_plots = [No_plots;i];        
    end
end
sup_H = find(No_plots==Hit_plots(1,1)-1);
NoHit_plots = No_plots(1:sup_H);
NoVib_plots = No_plots(sup_H+2:end);

%% colpo sul dito di interesse
which_finger = label_num;
another=0;
num_exp = Hit_plots((length(Hit_plots)));
plot_all(d_test,l_test,t_test, num_exp)

%% altro dito
another=1;
num_exp = NoHit_plots(randi(length(NoHit_plots)))
which_finger = row_hits(num_exp,1);
d_another=cell(size(NoHit_plots));
for k =1:size(NoHit_plots,1)
    d_another{k} = d_test{NoHit_plots(k)};
end
% [d_mov, l_mov, t_mov] = window_gen(d_another, l_another, cell(size(l_another)), window_size);
plot_all(d_another,l_another,cell(size(l_another)), num_exp)

%% free movement
another=2;
plot_all(d_test,l_test,t_test, 51)

%% sliding motion sul dito di interesse
which_finger = label_num;
another=0;
num_exp = Vib_plots((length(Vib_plots)));
plot_all(d_test,l_test,t_test, num_exp)

%% sliding motion su altro dito
another=1;
num_exp = randi(length(NoVib_plots))
which_finger = row_vibs(num_exp,2);
dv_another=cell(size(NoVib_plots));
for k =1:size(NoVib_plots,1)
    dv_another{k} = d_test{NoVib_plots(k)};
end
% [d_mov, l_mov, t_mov] = window_gen(dv_another, lv_another, cell(size(lv_another)), window_size);
plot_all(dv_another,lv_another,cell(size(lv_another)), num_exp)

