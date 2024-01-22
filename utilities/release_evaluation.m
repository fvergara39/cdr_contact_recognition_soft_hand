% release_evaluation

% copia incolla da net evaluation ma confronta anche i timestep dove c'è
% release e vedi cosa c'è nella predizione
% load data_release.mat
% load ('MLP280_5w.mat','net')
load('LSTM280_2','net')
load data_rel.mat
% [D_rel,L_rel,T_rel]=window_gen(D_rel,L_rel,T_rel,5);

l_pred = classify(net,D_rel);

l_rel{1}= L_rel{1}(4,:); % thumb
l_rel{2} =L_rel{2}(3,:); % index
l_rel{3} = L_rel{3}(2,:); % medium
l_rel{4}= L_rel{4}(1,:); % ring
l_rel{5} =L_rel{5}(5,:); % little
l_rel{6} = L_rel{6}(3,:); % index
l_rel{7}= L_rel{7}(5,:); % little
l_rel{8} =L_rel{8}(2,:); % medium
l_rel{9} = L_rel{9}(1,:); % ring
l_rel{10} = L_rel{10}(4,:); % thumb
%
y_pred =[];
y_test = [];
for i=1:numel(l_pred)
    y_pred = [y_pred, l_pred{i}];
    y_test = [y_test, l_rel{i}];
end

C = confusionmat(y_test,y_pred);

truerow_nohit = [C(1,1)/sum(C(1,:))]*100;
truerow_hit = [C(2,2)/sum(C(2,:))]*100;
truerow_rel = [C(3,1)/sum(C(3,:))]*100;
truerow_vib = [C(4,4)/sum(C(4,:))]*100;

truecol_nohit = [C(1,1)/sum(C(:,1))]*100;
truecol_hit = [C(2,2)/sum(C(:,2))]*100;
truecol_rel = [C(3,1)/sum(C(:,3))]*100;
if truecol_rel == Inf
    truecol_rel =0;
end
truecol_vib = [C(4,4)/sum(C(:,4))]*100;

diy_Cm = table([C(1,1);C(2,1);C(3,1);C(4,1);truecol_nohit], ...
    [C(1,2);C(2,2);C(3,2);C(4,2);truecol_hit], ...
    [C(1,3);C(2,3);C(3,3);C(4,3);truecol_rel], ...
[C(1,4);C(2,4);C(3,4);C(4,4);truecol_vib], ...
[truerow_nohit;truerow_hit ;truerow_rel ;truerow_vib; 0], ...
'VariableNames',{'Pred No hit','Pred Hit','Pred Release','Pred Vibration','Row-normalized TPR (%)'}, ...
'RowNames',{'No hit','Hit','Release','Vibration','Column-normalizer TRP (%)'});

display(diy_Cm)

cm = confusionchart(y_test,y_pred,'Title','Confusion matrix','RowSummary','row-normalized','ColumnSummary','column-normalized');