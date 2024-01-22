%% Plot sui dati nuovi non etichettati, con 15 accelerazioni
% i nomi sono nell'ordine giusto
function plot_unlabelled(Data,Time,exp)

% Data_exp = Data{exp};
% Time_exp = Time{exp};

Data_exp = Data;
Time_exp = Time;

name = char('Ring','Medium ','Index','Thumb','Little');
fig = figure();
fig.Units ='normalized';
hold on

for j=1:5
    % accelerations - plot
    D_exp = Data_exp (3*j-2 : j*3, :);

    subplot(5,1,j)
    px = plot(Time_exp,D_exp(1,:),'r');
    hold on
    grid on
    py = plot(Time_exp,D_exp(2,:),'g');
    pz = plot(Time_exp,D_exp(3,:),'b');
    title(name(j,:),'Color',[0.37, 0.37, 0.37])
    xlim([0,Time_exp(end)])
    ylim([-2,2])
end

% legend
hL = legend([px, py, pz],{'X-axis acceleration','Y-axis acceleration','Z-axis acceleration'});
newPosition = [0.82 0.82 0.1 0.1];
newUnits = 'normalized';
set(hL,'Position', newPosition,'Units', newUnits);

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
