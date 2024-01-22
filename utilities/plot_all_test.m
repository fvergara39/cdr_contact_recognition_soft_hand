%%

function plot_all_test(data,labels,timesteps, num_exp)
global net name finger fgr_idx which_finger another experiment type_prob label_num testing list_idx fgr_name

num=num_exp;

if testing==0
    limit_hit =251;
    limit_fm = 256;
else
    limit_hit= 23;
    limit_fm = 26;
end

h_pred = [];
v_pred = [];
h_true = [];
v_true = [];

l_pred_exp = classify(net,data{num_exp});
d = data{num_exp}(1:15,:);
l = labels{num_exp};
size(l)
t = timesteps{num_exp};

if type_prob==255
    pip = find(l_pred_exp=='hit');
    po = size(pip,2);
%     disp(['Hits predicted in the free movement experiment : ', num2str(po)]);
end
if another==1 & experiment>=limit_fm
    pip1 = find(l_pred_exp=='hit');
    po1 = size(pip1,2);
%     disp(['Hits predicted in the sliding-motion experiment : ', num2str(po1)]);
    pip2 = find(l_pred_exp=='vibration');
    po2 = size(pip2,2);
%     disp(['Vibrations predicted in the sliding-motion experiment : ', num2str(po2)]);
end
if another==1 & experiment<limit_hit
    pip1 = find(l_pred_exp=='hit');
    po1 = size(pip1,2);
%     disp(['Hits predicted in the sliding-motion experiment : ', num2str(po1)]);
end

% size(d)
% size(l)
% size(t)
% size(l_pred_exp)

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

    if j==which_finger & another==1
        h_true = find(l(which_finger,:) == 'hit');
        v_true = find(l(which_finger,:) == 'vibration');

        if ~isempty(h_true)
            arH = area(t(h_true),3*ones(size(t(h_true))),'FaceColor','#CCCCFF','FaceAlpha',0.5,'DisplayName','Hit');
            arH.BaseValue = -3;
        elseif ~isempty(v_true)
            arV = area(t(v_true),3*ones(size(t(v_true))), 'FaceColor','#F4C430','FaceAlpha',0.3,'DisplayName','Vibration');
            arV.BaseValue = -3;
        end
    end
    if j== label_num 
        h_true = find(l(label_num,:) == 'hit');
%         size(H_times)
        v_true = find(l(label_num,:) == 'vibration');
%         size(V_times)

        if ~isempty(h_true)
            arH = area(t(h_true),3*ones(size(t(h_true))),'FaceColor','#CCCCFF','FaceAlpha',0.3,'DisplayName','Hit');
            arH.BaseValue = -3;
        elseif ~isempty(v_true)
            arV = area(t(v_true),3*ones(size(t(v_true))), 'FaceColor','#F4C430','FaceAlpha',0.3,'DisplayName','Vibration');
            arV.BaseValue = -3;
        end

        % predictions
        H_pred = zeros(size(labels));
        V_pred = zeros(size(labels));
        h_pred = find(l_pred_exp == 'hit');
        v_pred = find(l_pred_exp == 'vibration');
        sz = 6;

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
if ATH==1 & another==0
    title_exp='Hit experiment for the';
    title1 = [title_exp,space,finger];
elseif ATH==1 & another==1
    title_exp='Hit experiment on another finger';
    title1 = title_exp;
elseif ATV==1 & another==0
    title_exp='Sliding motion experiment for the';
    title1 = [title_exp,space,finger];
elseif ATV==1 & another==1
    title_exp='Sliding motion experiment on another finger';
    title1 = title_exp;
elseif experiment<limit_fm & experiment>=limit_hit
    title_exp='Free movement experiment';
    title1 = title_exp;
elseif label_num~=which_finger & another~=2
    title_exp='Experiment on another finger';
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
size(d)

d_fgr = d(1:3,:);
% l_fgr = l(list_idx(fgr_idx),:);
l_fgr=l;
size(t)
size(d_fgr)
size(l_fgr)

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
if label_num==which_finger
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
title3 = [num,b];

if another==1 | another==0
    name_another = name(which_finger,:);
    if  label_num==which_finger
        title2 = ['Experiment for the',space,finger];
    elseif label_num~=which_finger
        title2 = ['Experiment on the',' ',name(which_finger,:)];
    elseif ATV==1 & label_num==which_finger
        title2='Sliding motion experiment for the';
    elseif ATV==1 & label_num~=which_finger
        title2 = ['Sliding motion experiment on the',space,name_another];
    end
else
    title2='Free movement experiment';
end

num = num2str(num_exp);
if num=='1'
    b='st sample';
elseif num=='2'
    b='nd sample';
elseif num=='3'
    b='rd sample';
else
    b='th sample';
end

title1 = ['Predictions on the',space,finger];
title3 = [num,b];

title({title1,title2, title3},'FontSize', fontSize);


hold off