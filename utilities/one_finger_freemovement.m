
function [d_fm, l_fm, t_fm] = one_finger_freemovement(finger)
  
init;
fgr_idx = find(ismember(fgr_name,finger,'rows')==1); 

D_fm = D(251:255);
L_fm = L(251:255);
T_fm = T(251:255);

d_fm = cell(5,1);
l_fm = cell(5,1);
t_fm = cell(5,1);

for i=1:5
    d_fm{i} = D_fm{i}(list_idx(fgr_idx)*3 -2 : list_idx(fgr_idx)*3,:);
    l_fm{i} = L_fm{i}(list_idx(fgr_idx),:);
    t_fm{i} = T_fm{i};
end