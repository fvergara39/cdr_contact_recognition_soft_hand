% Training evaluation

function Y_pred = net_evaluation (net)

global full_path d_test l_test finger netName

% size (d_test)
% size (l_test)

Y_test = l_test;
% Y_pred = classify(net, d_test);
for i=1:size(Y_test,1)
    Y_pred{i,1} = classify(net,d_test{i,1});
end
% Y_pred = l_pred;
y_pred = [];
y_test = [];

for i=1:size(Y_test,1)
    y_pred = [y_pred , classify(net,d_test{i})];
    y_test = [y_test , Y_test{i}];
end
% size(y_pred)
% size(y_test)
C = confusionmat(y_test,y_pred);

cm = confusionchart(y_test,y_pred,'Title','Confusion matrix','RowSummary','row-normalized','ColumnSummary','column-normalized');
full_path
cd (full_path)
exportgraphics(cm,'results.pdf','Append',true)
exportgraphics(cm,'results.jpeg')

test_accuracy = sum(y_pred == y_test)/numel(y_test);
disp(' _________Evaluation on test set _________')
% A = ['Test Accuracy = (TP + TN) / (TP + FP + TN + FN) = ', num2str(test_accuracy)];
A = ['Test Accuracy = ', num2str(test_accuracy*100)];
notA = ['Test Accuracy = ', 1-num2str(test_accuracy)];

TN = C(1,1);
TP = C(2,2);
FP = sum(C(1,:)) - C(1,1);
FN = sum(C(:,1)) - C(1,1);

precision = (TP / (TP + FP))*100; %positive predicted value
notprecision = (1-precision/100)*100;
% B = ['Precision = TP / (TP + FP) = ', num2str(precision)];
B = ['Precision = ', num2str(precision)];
notB = ['Precision Complementary = ', num2str(notprecision)];

recall = (TP / (TP + FN))*100; %true positive rate
notrecall = (1-recall/100)*100;
% C = ['Recall = TP / (TP + FN) = ', num2str(recall)];
C = ['Recall = ', num2str(recall)];
notC = ['Recall Complementary = ', num2str(notrecall)];

F1 =  2*(precision*recall)/(precision+recall);
f1score = ['F1 score = ', num2str(F1)];

FPR =  (FP)/(FP+TN)*100;
fpr = ['False Positive Rate = ', num2str(FPR)];

FNR =  (FN)/(FN+TP)*100;
fnr = ['False Negative Rate = ', num2str(FNR)];

disp(A)
disp(f1score)
disp(B)
disp(C)
disp(fnr)
disp(fpr)

cd (full_path)
fileID = fopen( 'metrics.txt','w');
fprintf(fileID, '\n Metrics for the model %s \n', netName);
fprintf(fileID, ' _________Evaluation on test set ________\n');
fprintf(fileID,'Test Accuracy = %s \n', num2str(test_accuracy*100));
fprintf(fileID,'F1 score = %s \n', num2str(F1));
fprintf(fileID,'Precision =  %s \n', num2str(precision));
fprintf(fileID,'Recall = %s \n', num2str(recall));
fprintf(fileID,'False Negative Rate = %s \n', num2str(FNR));
fprintf(fileID,'False Positive Rate = %s \n', num2str(FPR));
