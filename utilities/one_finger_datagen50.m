% Creazione del dataset relativo a un singolo dito FINGER
% FINGER :
%   'Thumb'
%   'Index'
%   'Medium'
%   'Ring'
%   'Little'

function [d, l, t] = one_finger_datagen50 (finger)

init;
% Creazione D, L e T con 50 hit (per un dito)
fgr_idx = find(ismember(fgr_name,finger,'rows')==1); 

d = cell(50,1);
l = cell(50,1);
t = cell(50,1);

for i=1:50
    d{i,1} = D{50*(fgr_idx-1)+i,1} (3*list_idx(fgr_idx)-2 : list_idx(fgr_idx)*3,:);
    l{i,1} = L{50*(fgr_idx-1)+i,1} (list_idx(fgr_idx),:);
    t{i,1} = T{50*(fgr_idx-1)+i,1};
end
