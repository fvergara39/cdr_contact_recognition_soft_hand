% Creazione del dataset relativo a un singolo dito FINGER
% FINGER :
%   'Thumb'
%   'Index'
%   'Medium'
%   'Ring'
%   'Little'

function [d, l, t] = all_fingers_datagen250 (finger)

global l_another row_hits row_fgr lh_fgr fgr_name D L T list_idx name
% init;
% Creazione D, L e T con 50 hit (per un dito)
fgr_idx = find(ismember(fgr_name,finger,'rows')==1);  %n.accelerazione

d = D(1:250);
l = cell(250,1);
t = cell(250,1);
l_another = cell(250,1);
row_hits = zeros(250,2);

for i=1:250
%     d{i,1} = D{i,1} (:,:); % seleziono tutte le accelerazioni
    l{i,1} = L{i,1} (list_idx(fgr_idx),:);
    [row,~]=find(L{i,1}=='hit',1);
    l_another{i,1} = L{i,1}(row,:);
    row_hits(i,1) = row;
    row_hits(i,2) =i;
    t{i,1} = T{i,1};
end

fgr_idx = find(ismember(name,finger,'rows')==1);  %numero di dito - 1
a_hit=find(row_hits(:,1)~=fgr_idx); % 2,3,4,5
hit=find(row_hits(:,1)==fgr_idx); % 1
row_fgr = row_hits(hit,:);
lh_fgr =l_another(hit,:);
% size(lh_fgr)
% row_hits = row_hits(a_hit,:);
% l_another = l_another(a_hit,:);

% diventano
% row_fgr = [50x2]
% l_fgr = [50x1]
% NO  row_hits = [200x2]
% NO  l_another = [200x1]