%% Ricerca degli esperimenti rilevanti nel dataset originale

global l_pred d_test l_test t_test which_finger experiment another label_num
finger
fgr_idx = find(ismember(fgr_name,finger,'rows')==1)
label_num = list_idx(fgr_idx)

%% esperimento di freemovement
if type_prob>=255
    another=2;
    exp = 51;
    experiment=255;
    plot_all(d_test,l_test,t_test,exp)
end
%% esperimento di hit sul dito interessato
which_finger = label_num;
another=0;

th_fgr = T(row_fgr(:,2));
dh_fgr = D(row_fgr(:,2));
int = L(row_fgr(:,2),1);    
[d_mov, l_mov, t_mov] = window_gen(dh_fgr, lh_fgr, th_fgr, window_size);

    for idx_h=row_fgr(1,1):row_fgr(end,1)
        % idx_h = randi(length(row_fgr));
        experiment= idx_h;
        plot_all(d_mov,l_mov,t_mov,idx_h+1-row_fgr(end,1))
    end
lh_fgr = cell(size(int));
for k=1:size(lh_fgr,1)
    Int = int{k,1};
    lh_fgr{k,1} = Int(row_fgr(1,1),:);
end
[d_mov, l_mov, t_mov] = window_gen(dh_fgr, lh_fgr, th_fgr, window_size);

for idx_h=row_fgr(1,2):row_fgr(end,2)
    % idx_h = randi(length(row_fgr));
    experiment= idx_h;
    plot_all(d_mov,l_mov,t_mov,idx_h+1-row_fgr(1,2))
end
clear d_mov l_mov t_mov
%% esperimento di hit su un altro dito
another =1;
U = unique(row_hits(:,1));

for a=1:length(U)
    which_finger=U(a);
    %     idx_ah = randi(length(row_hits)
    tot_idx_ah = row_hits(find(row_hits(:,1)==which_finger),2);
    tah_fgr = T(tot_idx_ah);
    dah_fgr = D(tot_idx_ah,1);
    int = L(tot_idx_ah,1);
    lah_fgr = cell(size(int));
    for k=1:size(lah_fgr,1)
        Int = int{k};
        lah_fgr{k} = Int(which_finger,:);
    end

    [d_mov, l_mov, t_mov] = window_gen(dah_fgr, lah_fgr, tah_fgr, window_size);
    disp(['The finger of the hit is ', num2str(which_finger)])
    disp(['The finger undestudy is ', num2str(label_num)])
%
    for r=1:length(tot_idx_ah)
        idx_ah=tot_idx_ah(r);
        experiment= idx_ah;
        plot_all(d_mov,l_mov,t_mov,r)
    end

end
clear d_mov l_mov t_mov
%% 
if type_prob==280
    %% esperimento di sliding motion sul dito interessato
    which_finger = label_num;
    another=0;

    tv_fgr = T(row_vfgr(:,1));
    dv_fgr = D(row_vfgr(:,1));
    int = L(row_vfgr(:,1),1);
    lv_fgr = cell(size(int));
    for k=1:size(int,1)
        Int = int{k,1};
        lv_fgr{k,1} = Int(which_finger,:);
    end

    [d_mov, l_mov, t_mov] = window_gen(dv_fgr, lv_fgr, tv_fgr, window_size);

    for idx_v=row_vfgr(1,1):row_vfgr(end,1)
        % idx_h = randi(length(row_fgr));
        experiment= idx_v;
        plot_all(d_mov,l_mov,t_mov,idx_v+1-row_vfgr(end,1))
    end

clear d_mov l_mov t_mov

    %% esperimento di sliding motion su un altro dito
    another =1;
    which_finger = 4;

% U = unique(row_vibs(:,2));
% 
% for a=1:length(U)
%     which_finger=U(a);
%     %     idx_ah = randi(length(row_hits)
%     tot_idx_av = row_vibs(find(row_vibs(:,1)==which_finger),1);

    tav_fgr = T([277,278],:);
    dav_fgr = D([277,278],1);

%     int = L{tot_idx_av};

    lav_fgr = L([277,278],1);
    for i=1:numel(lav_fgr)
        lav_fgr{i} = lav_fgr{i}(which_finger,:);
    end
%     for k=1:size(int,1)
%         Int = int;
%         lav_fgr{k} = Int(which_finger,:);
%     end
% 

    [d_mov, l_mov, t_mov] = window_gen(dav_fgr, lav_fgr, tav_fgr, window_size);

%     disp(['The finger of the sliding motion is ', num2str(which_finger)])
%     disp(['The finger undestudy is ', num2str(label_num)])
%

%     for r=1:length(tot_idx_av)
%         idx_av=tot_idx_av(r);
%         experiment= idx_av;
        plot_all(d_mov,l_mov,t_mov,1)
%     end

end
    
    
    
    
    
    
    
    
    
%     another=1;
%     idx_av = randi(size(row_vibs,1));
%     which_finger = row_vibs(idx_av,2);
%     experiment= row_vibs(idx_av,1);
%     t_vibs = T(row_vibs(:,1),1);
%     d_vibs = D(row_vibs(:,1),1);
%     int = L(row_vibs(:,1),1);
%     l_vibs = cell(size(int));
%     for q=1:size(l_vibs,1)
%         Int = int{q};
%         l_vibs{q} = Int(which_finger,:);
%     end
%     %     size(l_vibs{1})
%     [d_mov, l_mov, t_mov] = window_gen(d_vibs, l_vibs, t_vibs, window_size);
%     plot_all(d_mov,l_mov,t_mov,randi(size(l_mov,1)))
%     clear d_mov l_mov t_mov

% end
% esperimento di freemovement
% [d_mov, l_mov, t_mov] = window_gen(df_test, lf_test, tf_test, window_size);
% idx_fm =randi(length(d_mov));
% l_pred = classify(net,d_mov);
% l_test = l_mov;
% t_test = tf_test;
% plot_all_eval(idx_fm)
% plot_eval(idx_fm)
% clear l_pred l_test d_test l_test t_test d_mov l_mov t_mov





































% finger
% fgr_idx = find(ismember(fgr_name,finger,'rows')==1);
% fgr_idxVibs = find(ismember(fgr_nameVibs,finger,'rows')==1);
%
% % esperimento di hit sul dito interessato
% HITS = (50*(fgr_idx-1))+1: (50*(fgr_idx-1)+50);
%
% % esperimento di hit su un altro dito
% all = 1:250;
% another_HITS = all(all<50*(fgr_idx-1)+1 | all>50*(fgr_idx-1)+50);
%
% % esperimento di freemovement
% FM = 251:255;
%
% % esperimento di vibrazione sul dito interessato
% all_vibs = 256: 280;
% VIBS = all_vibs(fgr_idxVibs*5-4: fgr_idxVibs*5);
%
% % esperimento di vibrazione su un altro dito
% another_VIBS = [all_vibs(:,1:fgr_idxVibs*5-5),all_vibs(:,fgr_idxVibs*5+1:end)];
%
% t_hit=zeros(1,size(HITS,2));
% t_ahit=zeros(1,size(another_HITS,2));
% t_fm=zeros(1,size(FM,2));
% t_vib = zeros(1,size(VIBS,2));
% t_avib = zeros(1,size(another_VIBS,2));
%
% for j=1:size(HITS,2)
%     t_hit(j)=size(D{HITS(j)},2);
% end
% for k=1:size(another_HITS,2)
%     t_ahit(k)=size(D{another_HITS(k)},2);
% end
% if type_prob>250
%     for j=1:size(FM,2)
%         t_fm(j)=size(D{FM(j)},2);
%     end
% end
% if type_prob ==280
%     for h=1:size(VIBS,2)
%         t_vib(h)=size(D{VIBS(h)},2);
%     end
%     for g=1:size(another_VIBS,2)
%         t_avib(g)=size(D{another_VIBS(g)},2);
%     end
% end
%
% %% Ricerca degli esprimenti rilevanti nel dataset di test
% timesteps_test = zeros(size(d_test));
% for i=1:size(d_test,1)
%     timesteps_test(i,1)=size(d_test{i},2);
% end
%
% % esperimento di hit sul dito interessato
% % ref = (window_size -3)*2;
% % hits = find(ismember(timesteps_test,(t_hit'-ref*ones(size(t_hit')))==1));
% hits = find((ismember(timesteps_test,t_hit'))==1);
% hit = hits(randi(length(hits)));
% plot_all_eval (hit)
% plot_eval(hit)
%
% % esperimento di hit su un altro dito
% % hits_another = find(ismember(timesteps_test,t_ahit'-ref*ones(size(t_ahit')))==1);
% hits_another = find((ismember(timesteps_test,t_ahit'))==1);
% hit_another = hits_another(randi(length(hits_another)));
% plot_all_eval (hit_another)
% plot_eval(hit_another)
%
% % esperimento di freemovement
% if type_prob>250
%     %     fms = find(ismember(timesteps_test,t_fm'-ref*ones(size(t_fm')))==1);
%     %     fms = find((ismember(timesteps_test,t_fm'))==1);
%     %     fm = fms(randi(length(fms)));
%     fm=51;
%     plot_all_eval (fm)
%     plot_eval(fm)
%
%     % esperimento di vibrazione sul dito interessato
%     if type_prob==280
%         %         vibs = find(ismember(timesteps_test,t_vib'-ref*ones(size(t_vib')))==1);
%         vibs = find((ismember(timesteps_test,t_vib'))==1);
%         vib = vibs(randi(length(vibs)));
%         plot_all_eval (vib)
%         plot_eval(vib)
%
%         % esperimento di vibrazione su un altro dito
%         %         vibs_another = find(ismember(timesteps_test,t_avib'-ref*ones(size(t_avib')))==1);
%         vibs_another = find((ismember(timesteps_test,t_avib'))==1);
%         vib_another = vibs_another(randi(length(vibs_another)));
%         plot_all_eval (vib_another)
%         plot_eval(vib_another)
%     end
% end
%
