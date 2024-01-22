%% Plot sui dati di test per paragonare le predizioni e i target in concomitanza delle accelerazioni

% Dtest 250x1 cell, ogni cella è 3xn.Time
% Ltest 250x1 cell, ogni cella è 1xn.Time
% Lpred 250x1 cell, ogni cella è 1xn.Time
% t numero del timestep a cui si vuole fare la predizione. Se t=0 la
% predizione viene fatta per tutti gli istanti dell'esperimento exp

function plot_predl(dati, etichette, tempi, exp)

global net finger fgr_idx list_idx fgr_name
fig = figure();
fig.Units ='normalized';
hold on

h_true=[];
v_true=[];
h_pred=[];
v_pred=[];

% definizione variabili da plottare
predizioni = classify(net,dati{exp});

fgr_idx = find(ismember(fgr_name,finger,'rows')==1);
label_num = list_idx(fgr_idx);
d_fgr = dati{exp}(3*label_num-2:3*label_num, :); 
t=tempi{exp};
l=etichette{exp}(list_idx(fgr_idx),:);

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

% display delle labels
H_pred = zeros(size(predizioni));
H_true = zeros(size(l));
V_pred = zeros(size(predizioni));
V_true = zeros(size(l));

% display delle predizioni
h_pred = find(predizioni == 'hit');
v_pred = find(predizioni == 'vibration');
sz = 10;

if ~isempty(h_pred)
    H_pred(h_pred) = 2.85;
    size(h_pred)
    c = linspace(1,10,length(t(h_pred)));
    pH = scatter(t(h_pred),H_pred(h_pred),sz,'MarkerEdgeColor',[0 .5 .5],...
        'MarkerFaceColor',[0 .7 .7]);
end

sz = 10;

if ~isempty(v_pred)
    V_pred(v_pred) = 2.93;
    c = linspace(1,10,length(t(v_pred)));
    size(v_pred)
    pV = scatter(t(v_pred),V_pred(v_pred),sz,c,'MarkerEdgeColor','#A52019',...
        'MarkerFaceColor','#FF2400');
end

% % display delle vere labels
h_true = find(l == 'hit');
v_true = find(l == 'vibration');


if ~isempty(h_true)
    H_true(h_true) = 3;
    %     scatter(Time(h_true),H_true(h_true),'*','Color','#CCCCFF','LineWidth',1)
    atH = area(t(h_true),3*ones(size(t(h_true))), ...  % area ombreggiata per i true hit
        'FaceColor','#CCCCFF','FaceAlpha',0.5);
    atH.BaseValue = -3;
    hold on
end
if ~isempty(v_true)
    V_true(v_true) = 3;
    %     scatter(Time(v_true),V_pred(v_true),'^','Color','r','LineWidth',3)
    atV = area(t(v_true),3*ones(size(t(v_true))), ...  % area ombreggiata per i true hit
        'FaceColor','#F4C430','FaceAlpha',0.3);
%     #D2B48C, #FF9933 , #F4C430
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
num = num2str(exp);
% if num(1)=='1' & size(num,2)==1
%     b='st test sample';
% elseif num(1,:)=='2' & size(num,2)==1
%     b='nd test sample';
% elseif num(1,:)=='3' & size(num,2)==1
%     b='rd test sample';
% else
%     b='th test sample';
% end
title1 = ['Predictions on the',space,finger];
title3 = ['Sample',space,num];

% if another==1 | another==0
%     name_another = name(which_finger,:);
if  ATH==1
    title2 = ['Hit experiment for the',space,finger];
elseif ATV==1
    title2=['Sliding motion experiment for the',space,finger];
else
    title2='Free movement experiment';
end

title({title1,title2, title3},'FontSize', fontSize);
hold off


% global window_size net finger fgr_name list_idx d_test l_test t_test
% fig = figure();
% fig.Units ='normalized';
% hold on
% 
% % definizione variabili da plottare
% 
% d_test_exp = d_test{exp}(1:3,:);
% if size(t_test,1)==1
%     time = t_test;
% else
%     time = t_test{exp};
% end
% L_exp = l_test{exp};
% l_pred_exp = l_pred{exp};
% 
% % Plot
% px = plot(time,d_test_exp(1,:),'r');
% hold on
% grid on
% py = plot(time,d_test_exp(2,:),'g');
% pz = plot(time,d_test_exp(3,:),'b');
% % display del time-step scelto
% % x = xline(time(:,ts),'-','LineWidth',2);
% % legend ('X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Time Step','Location','best')
% legend ('X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Location','best')
% ylim([-3,3])
% xlim([0,3])
% % set(gca, 'YTicklabel', [" ", "nothing", "hit/vibration"].', 'Fontsize', 11)
% xlabel('Time (s)');
% ylabel('Accelerations (m/s^2)');
% 
% % display delle predizioni
% H_pred = zeros(size(l_pred_exp));
% H_true = zeros(size(L_exp));
% V_pred = zeros(size(l_pred_exp));
% V_true = zeros(size(L_exp));
% 
% % display delle predizioni
% h_pred = find(l_pred_exp == 'hit');
% v_pred = find(l_pred_exp == 'vibration');
% sz = 10;
% 
% if ~isempty(h_pred)
%     H_pred(h_pred) = 2.85;
%     c = linspace(1,10,length(time(h_pred)));
%     pH = scatter(time(h_pred),H_pred(h_pred),sz,'MarkerEdgeColor',[0 .5 .5],...
%               'MarkerFaceColor',[0 .7 .7]);
% end
% 
% sz = 10;
% 
% if ~isempty(v_pred)
%     V_pred(v_pred) = 2.93;
%     c = linspace(1,10,length(time(v_pred)));
%     pV = scatter(time(v_pred),V_pred(v_pred),sz,c,'MarkerEdgeColor','#A52019',...
%               'MarkerFaceColor','#FF2400');
% end
% 
% % display delle vere labels
% h_true = find(L_exp == 'hit');
% v_true = find(L_exp == 'vibration');
% if ~isempty(h_true)
%     H_true(h_true) = 3;
% %     scatter(Time(h_true),H_true(h_true),'*','Color','#CCCCFF','LineWidth',1)
%     atH = area(time(h_true),3*ones(size(time(h_true))), ...  % area ombreggiata per i true hit
%         'FaceColor','#CCCCFF','FaceAlpha',0.3);
%     atH.BaseValue = -3;
%     hold on
% end
% if ~isempty(v_true)
%     V_true(v_true) = 3;
% %     scatter(Time(v_true),V_pred(v_true),'^','Color','r','LineWidth',3)
%     atV = area(time(v_true),3*ones(size(time(v_true))), ...  % area ombreggiata per i true hit
%         'FaceColor','#CCCCFF','FaceAlpha',0.3);
%     atV.BaseValue = -3;
%     hold on
% end
% 
% PH = ~isempty(h_pred);
% VH = ~isempty(v_pred);
% ATH = ~isempty(h_true);
% ATV = ~isempty(v_true);
% 
% if PH ==1
%     legend ('X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Predicted hit','Location', 'northeast');
%     if VH ==1
%         legend ('X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Predicted hit','Predicted vibration','Location', 'northeast');
%         if ATH ==1
%             legend ('X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Predicted hit','Predicted vibration','True hit','Location', 'northeast');
%             if ATV ==1
%                 legend ('X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Predicted hit','Predicted vibration','True hit','True vibration','Location', 'northeast');
%             end
%         else
%             if ATV ==1
%                 legend ('X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Predicted hit','Predicted vibration','True vibration','Location', 'northeast');
%             end
%         end
%     else
%         if ATH ==1
%             legend ('X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Predicted hit','True hit','Location', 'northeast');
%             if ATV ==1
%                 legend ('X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Predicted hit','True hit','True vibration','Location', 'northeast');
%             end
%         else
%             if ATV ==1
%                 legend ('X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Predicted hit','True vibration','Location', 'northeast');
%             end
%         end
%     end
% elseif PH ~=1
%     if VH ==1
%         legend ('X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Predicted vibration','Location', 'northeast');
%         if ATH ==1
%             legend ('X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Predicted vibration','True hit','Location', 'northeast');
%             if ATV ==1
%                 legend ('X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Predicted vibration','True hit','True vibration','Location', 'northeast');
%             end
%         elseif ATH ~=1
%             if ATV ==1
%                 legend ('X-axis acceleration','Y-axis acceleration','Z-axis acceleration','Predicted vibration','True vibration','Location', 'northeast');
%             end
%         end
%     elseif VH~=1
%         if ATH ==1
%             legend ('X-axis acceleration','Y-axis acceleration','Z-axis acceleration','True hit','Location', 'northeast');
%                 if ATV ==1
%                     legend ('X-axis acceleration','Y-axis acceleration','Z-axis acceleration','True hit','True vibration','Location', 'northeast');
%                 end
%         elseif ATH~= 1
%             if ATV ==1
%                 legend ('X-axis acceleration','Y-axis acceleration','Z-axis acceleration','True vibration','Location', 'northeast');
%             end
%         end
%     end 
% end
% 
% 
% % proprietà della figura
% if ATH==1 && row==0
%     title_exp='Hit experiment for the';
% elseif ATH==1 && row~=0
%     title_exp='Hit experiment on another finger';
% elseif ATV==1 && row==0
%     title_exp='Sliding motion experiment for the';
% elseif ATV==1 && row~=0
%     title_exp='Sliding motion experiment for another finger';
% else
%     title_exp='Free movement experiment for the';
% end
% 
% fontSize = 9;
% space = ' ';
% num = num2str(exp);
% b='th sample';
% title1 = [title_exp,space,finger];
% % title2 = ['Time window width : ', space, num2str(window_size)];
% title3 = [num,b];
% title({title1, title3},'FontSize', fontSize);
% 
% 
% hold off