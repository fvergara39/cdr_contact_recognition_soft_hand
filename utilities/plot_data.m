
%% Plot sui dati originali, con 15 accelerazioni e 5 etichette ad ogni istante

% Accelerations plot for all the fingers and display the 'hit' or
% 'vibration' time-interval
function plot_data(Data,Labels,Time_steps,exp)

global name finger fgr_idx list_idx fgr_name
Time = Time_steps{exp}; % time-steps vector

fig = figure();
fig.Units ='normalized';
hold on

for j=1:5
    % accelerations - plot
    D_exp = Data{exp} (3*j-2 : j*3, :);

    subplot(5,1,j)
    px = plot(Time,D_exp(1,:),'r');
    hold on
    grid on
    py = plot(Time,D_exp(2,:),'g');
    pz = plot(Time,D_exp(3,:),'b');
    title(name(j,:),'Color',[0.37, 0.37, 0.37])
    xlim([0,Time(end)])
    ylim([-2,2])

    % label
    L_exp = Labels{exp};
    H_times = find(L_exp(j,:) == 'hit');
    V_times = find(L_exp(j,:) == 'vibration');
    if ~isempty(H_times)
        arH = area(Time(H_times),2*ones(size(Time(H_times))),'FaceColor','#CCCCFF','FaceAlpha',0.5,'DisplayName','Hit');
        arH.BaseValue = -2;
        hL = legend([px, py, pz,arH,],{'X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Hit'});
        newPosition = [0.82 0.82 0.1 0.1];
        newUnits = 'normalized';
        set(hL,'Position', newPosition,'Units', newUnits);
    elseif ~isempty(V_times)
        arV = area(Time(V_times),2*ones(size(Time(V_times))), 'FaceColor','#F4C430','FaceAlpha',0.3,'DisplayName','Vibration');
        arV.BaseValue = -2;
        hL = legend([px, py, pz,arV],{'X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Vibration'});
        newPosition = [0.82 0.82 0.1 0.1];
        newUnits = 'normalized';
        set(hL,'Position', newPosition,'Units', newUnits);
    end
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
