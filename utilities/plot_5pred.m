function plot_5pred(data,labels,timesteps,finger,num)

global net name list_idx fgr_name l_pred

% label è cell array che ha etichette per tutte le dita
% l è la matrice di etichette dell' esperimento scelto
% l_pred è il vettore riga di predizioni dell' esperimento scelto
%
% d è la matrice di accelerazioni dell'esperimento scelto
% d_fgr è la matrice di accelerazioni per ogni dito

fgr_idx = find(ismember(fgr_name,finger,'rows')==1);
label_num = list_idx(fgr_idx);

h_pred = [];
v_pred = [];
h_true = [];
v_true = [];

l_pred_exp = l_pred{num};
d = data{num}(1:15,:);
l = labels{num};
if isempty(timesteps{num})
    t=1:size(data{num},2);
else
    t = timesteps{num};
end

a = find(l_pred_exp == 'hit');
HITS = size(a,2);
disp(['Number of hits predicted : ', num2str(HITS)])
b = find(l_pred_exp == 'vibration');
VIBS = size(b,2);
disp(['Number of vibrations predicted : ', num2str(VIBS)])

% config figure
fig = figure();
fig.Units ='normalized';
hold on

% trovare il dito su cui è stato fatto l'esperimento num
[in,~] = find(l=='hit');
if isempty(in)
    [in,~] = find(l=='vibration');
end
involved=[];
if ~isempty(in)
    involved = in(1);
end
% plot delle accelerazioni, etichette e predizioni
for j=1:5
    subplot(5,1,j)
    d_fgr = d(3*j-2 : j*3, :); % 3-by-timestep accelerazioni
    px = plot(t,d_fgr(1,:),'r'); % ax
    hold on
    grid on
    py = plot(t,d_fgr(2,:),'g'); % ay
    pz = plot(t,d_fgr(3,:),'b'); % az
    title(name(j,:),'Color',[0.37, 0.37, 0.37])
    xlim([0,t(end)])
    ylim([-3,3])

    if ~isempty(involved) & j==involved
        h_true = find(l(j,:) == 'hit');
        v_true = find(l(j,:) == 'vibration');

        if ~isempty(h_true)
            arH = area(t(h_true),3*ones(size(t(h_true))),'FaceColor','#CCCCFF','FaceAlpha',0.5,'DisplayName','Hit');
            arH.BaseValue = -3;
        elseif ~isempty(v_true)
            arV = area(t(v_true),3*ones(size(t(v_true))), 'FaceColor','#F4C430','FaceAlpha',0.3,'DisplayName','Vibration');
            arV.BaseValue = -3;
        end

    end
    
    if j==label_num
        % predictions
        H_pred = zeros(size(l));
        V_pred = zeros(size(l));
        h_pred = find(l_pred_exp == 'hit');
        v_pred = find(l_pred_exp == 'vibration');
        sz = 8;

        if ~isempty(h_pred)
            H_pred(h_pred) = 2.8;
            %             H_pred
            c = linspace(1,10,length(t(h_pred)));
            pH = scatter(t(h_pred),H_pred(h_pred),sz,'MarkerEdgeColor',[0 .5 .5],...
                'MarkerFaceColor',[0 .7 .7]);
        end
        if ~isempty(v_pred)
            V_pred(v_pred) = 2.9;
            c = linspace(1,10,length(t(v_pred)));
            pV = scatter(t(v_pred),V_pred(v_pred),sz,c,'MarkerEdgeColor','#A52019',...
                'MarkerFaceColor','#FF2400');
        end
    end
end

%legend utilities
PH = ~isempty(h_pred);
VH = ~isempty(v_pred);
ATH = ~isempty(h_true);
ATV = ~isempty(v_true);
sym_legend =0;

if ATH==1
    sym_legend =1;
    if PH==1
        sym_legend = 110;
        if VH ==1
            sym_legend = 111;
        end
    elseif VH==1
        sym_legend = 101;
    end
elseif ATV==1
    sym_legend =2;
    if PH==1
        sym_legend = 210;
        if VH ==1
            sym_legend = 211;
        end
    elseif VH==1
        sym_legend = 201;
    end
end

if sym_legend ==1
    hL = legend([px, py, pz,arH],{'X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Hit','Location', 'northeast'});
elseif sym_legend ==110
    hL = legend([px, py, pz,arH,pH],{'X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Hit','Predicted hit','Location', 'northeast'});
elseif sym_legend ==111
    hL = legend([px, py, pz,arH,pH,pV],{'X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Hit','Predicted hit','Predicted vibration','Location', 'northeast'});
elseif sym_legend ==101
    hL = legend([px, py, pz,arH,pV],{'X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Hit','Predicted vibration','Location', 'northeast'});
elseif sym_legend ==2
    hL = legend([px, py, pz,arV],{'X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Vibration','Location', 'northeast'});
elseif sym_legend ==210
    hL = legend([px, py, pz,arV,pH],{'X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Vibration','Predicted hit','Location', 'northeast'});
elseif sym_legend ==211
    hL = legend([px, py, pz,arV,pH,pV],{'X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Vibration','Predicted hit','Predicted vibration','Location', 'northeast'});
elseif sym_legend ==201
    hL = legend([px, py, pz,arV,pV],{'X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Vibration','Predicted vibration','Location', 'northeast'});
else
    hL = legend([px, py, pz],{'X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Location', 'northeast'});
end

% Title - axis labels for all the subplots
fontSize = 12;
han=axes(fig,'visible','off');
han.Title.Visible='on';
han.XLabel.Visible='on';
han.YLabel.Visible='on';
ylabel(han,'Accelerations (m/s^2)');
xlabel(han,'Time (s)');

% proprietà della figura
space = ' ';
if ~isempty(involved)
    involved_name = name(involved,:);
end

if ATH==1
    title_exp='Hit experiment for the';
    title1 = [title_exp,space,involved_name];
elseif ATV==1 
    title_exp='Sliding motion experiment for the';
    title1 = [title_exp,space,involved_name];
elseif isempty(involved)
    title_exp='Free movement experiment';
    title1 = title_exp;
elseif another==2
    title1 = 'Free movement experiment';
else
    title1 =' Bo';
end

num = num2str(num);
if num=='1'
    b='st sample';
elseif num=='2'
    b='nd sample';
elseif num=='3'
    b='rd sample';
else
    b='th sample';
end

% title1 = [title_exp,space,finger];
title3 = [num,b];
% title(han,{title1, title2,title3},'FontSize', fontSize);
title(han,{title1,title3},'FontSize', fontSize);
ax = gca;
ax.TitleHorizontalAlignment = 'left';

newPosition = [0.82 0.82 0.1 0.1];
newUnits = 'normalized';
set(hL,'Position', newPosition,'Units', newUnits);

disp('--------')
%% Focus sul dito di interesse
fig = figure();
fig.Units ='normalized';
hold on

% definizione variabili da plottare
d_fgr = d(3*label_num-2 : label_num*3, :,:);
l_fgr = l(label_num,:);

% Plot
px = plot(t,d_fgr(1,:),'r');
hold on
grid on
py = plot(t,d_fgr(2,:),'g');
pz = plot(t,d_fgr(3,:),'b');
% display del time-step scelto
% x = xline(time(:,ts),'-','LineWidth',2);
% legend ('X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Time Step','Location','best')
legend ('X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Location','best')
ylim([-3,3])
xlim([0,t(end)])
% set(gca, 'YTicklabel', [" ", "nothing", "hit/vibration"].', 'Fontsize', 11)
xlabel('Time (s)');
ylabel('Accelerations (m/s^2)');

% etichette e predizioni
H_pred = zeros(size(l_pred_exp));
H_true = zeros(size(l_fgr));
V_pred = zeros(size(l_pred_exp));
V_true = zeros(size(l_fgr));

% display delle predizioni
h_pred = find(l_pred_exp == 'hit');
v_pred = find(l_pred_exp == 'vibration');
sz = 10;

if ~isempty(h_pred)
    H_pred(h_pred) = 2.85;
    c = linspace(1,10,length(t(h_pred)));
    pH = scatter(t(h_pred),H_pred(h_pred),sz,'MarkerEdgeColor',[0 .5 .5],...
        'MarkerFaceColor',[0 .7 .7]);
end

if ~isempty(v_pred)
    V_pred(v_pred) = 2.93;
    c = linspace(1,10,length(t(v_pred)));
    pV = scatter(t(v_pred),V_pred(v_pred),sz,c,'MarkerEdgeColor','#A52019',...
        'MarkerFaceColor','#FF2400');
end

% display delle vere labels
if label_num==involved
    h_true = find(l_fgr == 'hit');
    v_true = find(l_fgr == 'vibration');
else
    h_true=[];
    v_true=[];
end

if ~isempty(h_true)
    H_true(h_true) = 3;
    %     scatter(Time(h_true),H_true(h_true),'*','Color','#CCCCFF','LineWidth',1)
    atH = area(t(h_true),3*ones(size(t(h_true))), ...  % area ombreggiata per i true hit
        'FaceColor','#CCCCFF','FaceAlpha',0.3);
    atH.BaseValue = -3;
    hold on
end
if ~isempty(v_true)
    V_true(v_true) = 3;
    %     scatter(Time(v_true),V_pred(v_true),'^','Color','r','LineWidth',3)
    atV = area(t(v_true),3*ones(size(t(v_true))), ...  % area ombreggiata per i true hit
        'FaceColor','#F4C430','FaceAlpha',0.3);
    atV.BaseValue = -3;
    hold on
end

PH = ~isempty(h_pred);
VH = ~isempty(v_pred);
ATH = ~isempty(h_true);
ATV = ~isempty(v_true);

if PH ==1
    legend ('X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Predicted hit','Location', 'northeast');
    if VH ==1
        legend ('X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Predicted hit','Predicted vibration','Location', 'northeast');
        if ATH ==1
            legend ('X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Predicted hit','Predicted vibration','True hit','Location', 'northeast');
            if ATV ==1
                legend ('X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Predicted hit','Predicted vibration','True hit','True vibration','Location', 'northeast');
            end
        else
            if ATV ==1
                legend ('X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Predicted hit','Predicted vibration','True vibration','Location', 'northeast');
            end
        end
    else
        if ATH ==1
            legend ('X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Predicted hit','True hit','Location', 'northeast');
            if ATV ==1
                legend ('X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Predicted hit','True hit','True vibration','Location', 'northeast');
            end
        else
            if ATV ==1
                legend ('X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Predicted hit','True vibration','Location', 'northeast');
            end
        end
    end
elseif PH ~=1
    if VH ==1
        legend ('X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Predicted vibration','Location', 'northeast');
        if ATH ==1
            legend ('X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Predicted vibration','True hit','Location', 'northeast');
            if ATV ==1
                legend ('X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Predicted vibration','True hit','True vibration','Location', 'northeast');
            end
        elseif ATH ~=1
            if ATV ==1
                legend ('X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Predicted vibration','True vibration','Location', 'northeast');
            end
        end
    elseif VH~=1
        if ATH ==1
            legend ('X-axis acceleration','Y-axis acceleration','Z-axis acceleration','True hit','Location', 'northeast');
            if ATV ==1
                legend ('X-axis acceleration','Y-axis acceleration','Z-axis acceleration','True hit','True vibration','Location', 'northeast');
            end
        elseif ATH~= 1
            if ATV ==1
                legend ('X-axis acceleration','Y-axis acceleration','Z-axis acceleration','True vibration','Location', 'northeast');
            end
        end
    end
end


% proprietà della figura
space = ' ';
fontSize = 9;
num = num2str(num);
b='th sample';
title1 = ['Predictions on the',space,finger];

if ATH==1
    title_exp='Hit experiment for the';
    title2 = [title_exp,space,involved_name];
elseif ATV==1 
    title_exp='Sliding motion experiment for the';
    title2 = [title_exp,space,involved_name];
elseif isempty(involved)
    title_exp='Free movement experiment';
    title2 = title_exp;
else
    title2 =' Experiment on another finger';
end

num = num2str(num);
if num=='1'
    b='st sample';
elseif num=='2'
    b='nd sample';
elseif num=='3'
    b='rd sample';
else
    b='th sample';
end

title3 = [num,b];

title({title1,title2, title3},'FontSize', fontSize);

hold off