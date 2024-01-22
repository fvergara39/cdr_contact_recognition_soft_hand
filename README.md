# Addestramento di reti neurali per il riconoscimento del contatto su una mano robotica
## Contenuti:
* [1. Requisiti](#1-requisiti)
* [2. Preparazione dell'ambiente](#2-preparazione-dell-ambiente)
* [3. Scelta degli iperparametri](#3-scelta-degli-iperparametri)
* [4. Addestramento e Valutazione della rete](#4-addestramento-e-valutazione-della-rete)
* [5. Salvataggio delle performance](#5-salvataggio-delle-performance)
* [6. Funzioni per il plot](#6-funzioni-per-il-plot)

## 1) Requisiti
L'addestramento delle reti neurali (sia MLP che LSTM) richiedono l'installazione del toolbox di MATLAB Deep Learning Toolbox.
Il progetto è stato svolto sulla versione di MATLAB 2022a.

## 2) Preparazione dell'ambiente
- Entrare nel file init.m della directory principale e andare in fondo, per modificare il valore della variabile do_train. Se si vogliono addestrare nuove reti, mettere la variabile a 1.
- Nella cartella second_part, aprire net2_gen per modificare il path (variabile parentFolder) di salvataggio delle reti MLP. Oppure nella cartella lstm_part, modificare il path nel file lstm_gen per
il salvatagigo delle LSMT. 
- Se si vogliono usare i nuovi dati, andare nella cartella "acquisizione" e modificare i path nello script net2_test
 
- Aprire lo script main.m. 
- Posizionarsi nella prima sezione se si vuole usare il dataset originale. Andare alla sezione successiva se si vogliono usare i dati di test finale.
- Modificando propriamente le variabili che vi si presentano, scegliere quale problema di classificazione si vuole che la rete risolva ( 250 - binario /255 - binario con free movmeents /280 - multiclasse), 
e il dito su cui si vuole addestrare la rete.
- Decidere la larghezza della finestra temporale e il nome che la rete avrà (la rete, le sue performance e le sue 'training options' verranno salvati all'interno di 
una cartella omonima, con path che verrà stampato a video durante la creazione della stessa).

## 3) Scelta degli iperparametri
- Tra le funzioni della cartella "utilities", aprire "hyperpar_net" o "hyperpar_lstm" a seconda del tipo di rete che si vuole addestrare. 
Il training della nuova rete può essere determinato andando alla seconda sezione del file chiamata "network architecture" per modificare la variabile "layers" 
(l'architettura) e le opzioni di addestramento subito sotto in "options".

## 4) Addestramento e Valutazione della rete
- Runnando la sezione scelta del file main.m, si avvia il training della rete. Al termine di questo, viene automaticamente eseguita anche la valutazione 
delle performance (matrice di confusione, calcolo delle metriche, numero di iperparametri e plot).
- Nel caso in cui si voglia solo valutare una rete già addestrata, mettere a 0 il valore della variabile do_train in init.m ed eseguire la sezione del file main.m
mettendo a netName, il nome della rete di interesse e a window_size, la larghezza della finestra temporale con cui essa era stata addestrata. Se non ci si ricorda, 
aprire il layer "sequenceInput" della rete. La dimensione di questa, diviso il numero di features (15), sarà la window_size.

## 5) Salvataggio delle performance
Ogni volta che viene valutata una rete, gli indici di performance veongono scritti in un file di testo "metrics.txt" e le sue opzioni di training in "options.txt".
Ad ogni valutazione sulla medesima rete, le matrici di confusione vengono aggiunte in nuove pagine del file results.pdf per tener traccia della stocasticità del comportamento della rete. 

## 6) Funzioni principali per il plot
- plot_data : plotta i dati e le labels a window_size unitario, senza predizioni. Vengono visualizzate le accelerazioni di tutte e cinque le dita (utile se si vuole plottare il dataset raw) 
- plot_single : come sopra ma con focus sul solo dito di interesse
- plot_5pred e plot_all: plotta i dati, labels e predizioni solo sul dito di interesse, per qualsiasi window_size
- lo script allType_plots integra plot_all che, integrati insieme consentono di osservare anche le labels sulle altre dita. (stessa cosa per allType_plots_test nel caso dei nuovi dati)
)



