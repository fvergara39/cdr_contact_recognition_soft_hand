
function [d_v, l_v, t_v] = one_finger_vibration(finger)
  
init
fgr_idx = find(ismember(fgr_name,finger,'rows')==1); 

if list_idx(fgr_idx) == 3 % medium
    a =256;
elseif list_idx(fgr_idx) == 5 % little
    a =261;
elseif list_idx(fgr_idx) == 2 % index
    a=266;
elseif list_idx(fgr_idx) == 1 % thumb
    a=271;
elseif list_idx(fgr_idx) == 4 % ring
    a=276;
end
%% Order of slinding experiments
% Medium
% Little
% Index
% Thumb
% Ring


D_fm = D(a:a+4);
L_fm = L(a:a+4);
T_fm = T(a:a+4);

d_v = cell(5,1);
l_v = cell(5,1);
t_v = cell(5,1);

for i=1:5
    d_v{i} = D_fm{i}(list_idx(fgr_idx)*3 -2 : list_idx(fgr_idx)*3,:);
    l_v{i} = L_fm{i}(list_idx(fgr_idx),:);
    t_v{i} = T_fm{i};
end