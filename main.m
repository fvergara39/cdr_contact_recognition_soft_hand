%% Fase di training e valutazione sui dati originali
global netName

init
type_prob= 280; % 250 255 280

% net basic settings
mlp=0; % 0 : lstm ; 1 : mlp
ens = 0; 
netName = 'LSTM280_2';

% data_prep
finger = 'Ring';
window_size = 2;

% test
if ens ==1
%     ensemble;
%     plots_case_ensemble_test
elseif mlp==1
    net2_gen
    learnable_par
    allType_plots
%     plots_case
elseif mlp==0
    window_size=1;
    lstm_gen
    learnable_par
    allType_plots
%     plots_case
end

%% Fase di test su nuovi dati
% configurazione
init
type_prob = 280;
mlp = 1; % lstm o mlp
ensemble = 0;
data_prep
finger = 'Ring';

netName = 'MLP280_2w';
window_size = 2;

% test
if ensemble ==1
    net2_test
    learnable_par
    ensemble_test
    plots_case_ensemble_test
else
    if mlp==0
        window_size=1;
    end
    net2_test
    learnable_par
    allType_plots_test
end

%% Fase di training e valutazione sui dati originali con singolo dito (mlp)
init
type_prob= 50; % 50, 55, 60
finger = 'Ring';

netName = 'MLP50_1w';
window_size = 1;

net1_gen
learnable_par
