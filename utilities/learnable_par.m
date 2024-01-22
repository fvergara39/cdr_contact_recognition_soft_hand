% load netName

trainable_par =0;

for i=1:numel(net.Layers)
    if net.Layers(i,1).Name(1,1:2)=='fc'  
        trainable_par = trainable_par + numel(net.Layers(i,1).Weights) + numel(net.Layers(i,1).Bias);
    elseif net.Layers(i,1).Name(1,1:2)=='ls'
        trainable_par = trainable_par + numel(net.Layers(i,1).InputWeights) + numel(net.Layers(i,1).RecurrentWeights) + numel(net.Layers(i,1).Bias);
    end
end

disp(['Number of trainable parameters for ', netName,' : ', num2str(trainable_par)]);