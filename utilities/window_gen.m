% finestra mobile a due step
% d,l,t : dati, etichette e time-steps
% n : larghezza della window

function [d_mov, l_mov, t_mov] = window_gen(d, l, t, window_size)

numCell = size(d,1);

d_mov = cell(numCell,1);
l_mov = cell(numCell,1);
t_mov = cell(numCell,1);

for i=1: numCell
%     d_mov{i}=zeros(3*n,size(d{i},2)-(n-1));
    for p=1:window_size
        d_tp = d{i,1}(:, p:end-(window_size-p));
        d_mov{i,1} = [d_mov{i} ; d_tp] ;
    end
    l_mov{i,1} = l{i,1}(:,window_size:end);
    t_mov{i,1} = t{i,1}(:,window_size:end);
end
