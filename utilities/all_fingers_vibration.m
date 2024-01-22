
function [d_nv, l_nv, t_nv,d_fgr, l_fgr, t_fgr] = all_fingers_vibration(finger)

global row_vibs lv_another row_vfgr lv_fgr
init
fgr_idx = find(ismember(fgr_name,finger,'rows')==1); 

a=0;

if list_idx(fgr_idx) == 3 % medium
    a =256-255;
elseif list_idx(fgr_idx) == 5 % little
    a =261-266;
elseif list_idx(fgr_idx) == 2 % index
    a=266-255;
elseif list_idx(fgr_idx) == 1 % thumb
    a=271-255;
elseif list_idx(fgr_idx) == 4 % ring
    a=276-255;
end

%% Order of slinding experiments
% Medium
% Little
% Index
% Thumb
% Ring
D_v= D(256:280);
L_v= L(256:280);
T_v= T(256:280);

vibs = size(D_v,1); % [25,1]
d_v = cell(vibs,1);
l_v = cell(vibs,1);
t_v = cell(vibs,1);
lv_another = cell(25,1);
row_vibs = zeros(25,2);

for i=1:vibs
    d_v{i,1} = D_v{i,1};
    l_v{i,1} = L_v{i,1}(list_idx(fgr_idx),:);
    [row,~]=find(L_v{i,1}=='vibration',1);
    lv_another{i,1} = L_v{i,1}(row,:);
    row_vibs(i,2) = row;
    row_vibs(i,1) =i+255;
    t_v{i,1} = T_v{i,1};
end

% dataset delle vibrazioni sul dito di interesse
d_fgr = d_v(a:a+4);
l_fgr = l_v(a:a+4);
t_fgr = t_v(a:a+4);
% 
% dataset delle vibrazioni sulle dita rimanenti (non ci sono labels
% 'vibration')
d_v(a:a+4) = cell(5,1);
l_v(a:a+4) = cell(5,1);
t_v(a:a+4) = cell(5,1);
% 
for j=1:size(d_v,1)
    if isempty(d_v{j})
        d_nv=d_v(~cellfun('isempty',d_v));
        l_nv=l_v(~cellfun('isempty',l_v));
        t_nv=t_v(~cellfun('isempty',t_v));
    end
end


fgr_idx = find(ismember(name,finger,'rows')==1);  %numero di dito - 1
a_vib=find(row_vibs(:,2)~=fgr_idx); % 2,3,4,5
vib=find(row_vibs(:,2)==fgr_idx); % 1
row_vfgr = row_vibs(vib,:);
lv_fgr =lv_another(vib,:);
row_vibs = row_vibs(a_vib,:);
lv_another = lv_another(a_vib,:);