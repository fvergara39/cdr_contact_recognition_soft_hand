function net = hyperpar_lstm(d_train, l_train, d_val, l_val)
% config network

global netName full_path do_train multiclass parentFolder

full_path = strcat(parentFolder,netName,'\')
status = mkdir(full_path);

if status==1
    disp('New directory created. The training progress of this network will be saved there ..')
end


if multiclass == 1
    classes1 = categories(l_train{1});
    classes2 = categorical(["vibration"]);
    classes = {classes1{1} ; classes1{2};  classes2}
else
    classes = categories(l_train{1})
end

%
%Characterize the network
numClasses = numel(classes);
valData = {d_val, l_val};

%% network_architecture

if do_train ==1
    output_mode = 'sequence';
    lstm_nodes = 30;
    fwnet = 'fc(28)-relu-norm-LSTM(30)-fc(17)-relu-norm-LSTM(15)'; % da far stampare nel file di testo. 
    % utile per ricordarsi le prove fatte
    optimizer = 'sgdm';
    momentum =0.9;
    % lr=0.01;
    gt=2;
    l2reg=0.0001;
    mbs=32;
    epochs =50;
    valpat= Inf;

    layers = [ ...
        sequenceInputLayer(15)
        fullyConnectedLayer(28)
        reluLayer
        layerNormalizationLayer
        lstmLayer(lstm_nodes,'OutputMode',output_mode)
        fullyConnectedLayer(17)
        reluLayer
        layerNormalizationLayer
        lstmLayer(lstm_nodes/2,'OutputMode',output_mode)
        fullyConnectedLayer(numClasses)
        softmaxLayer
        classificationLayer];

    options = trainingOptions(optimizer, ...
        'GradientThreshold',gt, ...
        'MiniBatchSize', mbs,...
        'MaxEpochs',epochs, ...
        'ValidationData',valData, ...
        'ValidationFrequency', 5, ...
        'ValidationPatience',valpat,...
        'Shuffle','every-epoch',...
        'Verbose',0, ...
        'OutputNetwork', 'best-validation-loss', ...
        'Plots','training-progress',...
        'ExecutionEnvironment', 'cpu');

    % print sul file di testo salvato nella cartella della rete
    cd (full_path)
    fileID = fopen( 'options.txt','w');
    fprintf(fileID, ' \n Training options of %s\n', netName);
    fprintf(fileID,'Optimizer: %s \n', optimizer);
    % fprintf(fileID,'Normalization: %s \n', input_norm);
    fprintf(fileID,'Momentum: %f \n',momentum);
    % fprintf(fileID,'InitialLearnRate: %d \n', lr);
    fprintf(fileID,'GradientThreshold: %f \n',gt);
    % fprintf(fileID,'L2Regularization: %f \n',l2reg);
    fprintf(fileID,'MiniBatchSize: %d \n',mbs);
    fprintf(fileID,'ValidationPatience: %d \n',valpat);
    fprintf(fileID,'MaxEpochs: %d \n',epochs);
    fprintf(fileID,' ------------------------------ \n');
    fprintf(fileID,'LSTM hidden units: %d \n', lstm_nodes);
    fprintf(fileID,'Output mode: %s \n', output_mode);
    fprintf(fileID,'Layers: %s \n', fwnet);
    % fprintf(fileID,'Cost [%d,%d] \n', c_nohit,c_hit);

    % Train the network
    net = trainNetwork(d_train ,l_train ,layers,options);
    disp('Saving the trained network ...')
    save(netName,'net');
else
    cd (full_path)
    disp('Loading the trained network ...')
    load (netName,'net')
end
