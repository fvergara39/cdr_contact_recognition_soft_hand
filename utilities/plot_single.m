%% Plot sui dati originali, con 5 accelerazioni e 1 etichetta ad ogni istante per un solo dito

% Accelerations plot for all the fingers and display the 'hit' or
% 'vibration' time-interval

function plot_single(D,L,T,exp,finger)

init
name = char('Ring','Medium ','Index','Thumb','Little');
fgr_idx = find(ismember(fgr_name,finger,'rows')==1);

t_exp = T{exp}; % time-steps vector
d_exp = D{exp} (3*list_idx(fgr_idx)-2 : list_idx(fgr_idx)*3,:);
l_exp = L{exp} (list_idx(fgr_idx),:);
fig = figure();
fig.Units ='normalized';
hold on


px = plot(t_exp,d_exp(1,:),'r');
hold on
grid on
py = plot(t_exp,d_exp(2,:),'g');
pz = plot(t_exp,d_exp(3,:),'b');
title(finger,'Color',[0.37, 0.37, 0.37])
xlim([0,5])
ylim([-2,3])

% label
H_times = find(l_exp == 'hit');
V_times = find(l_exp == 'vibration');
if ~isempty(H_times)
    arH = area(t_exp(H_times),3*ones(size(t_exp(H_times))),'FaceColor','#CCCCFF','FaceAlpha',0.3,'DisplayName','Hit');
    arH.BaseValue = -2;
    hL = legend([px, py, pz,arH,],{'X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Hit'});
    newPosition = [0.82 0.82 0.1 0.1];
    newUnits = 'normalized';
    set(hL,'Position', newPosition,'Units', newUnits);
elseif ~isempty(V_times)
    arV = area(t_exp(V_times),3*ones(size(t_exp(V_times))), 'FaceColor','#884DA7','FaceAlpha',0.1,'DisplayName','Vibration');
    arV.BaseValue = -2;
    hL = legend([px, py, pz,arV],{'X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Vibration'});
    newPosition = [0.82 0.82 0.1 0.1];
    newUnits = 'normalized';
    set(hL,'Position', newPosition,'Units', newUnits);
else
    hL = legend([px, py, pz],{'X-axis acceleration','Y-axis acceleration','Z-axis acceleration'});
end

% Title - axis labels for all the subplots
han=axes(fig,'visible','off');
han.Title.Visible='on';
han.XLabel.Visible='on';
han.YLabel.Visible='on';
ylabel(han,'Accelerations (m/s^2)');
xlabel(han,'Time (s)');
title(han,['Accelerations for the experiment n° ', num2str(exp)]);
ax = gca;
ax.TitleHorizontalAlignment = 'left';
