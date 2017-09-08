clear all
addpath('../data/');

load faces_data.mat
load faces_labels.mat
data = data';

a = size(data,1);
b = size(labels,2);
layers = [a 1000 500 100 50 10 b];
[W,b] = InitializeNetwork(layers);

[accuracy, loss] = ComputeAccuracyAndLoss(W, b, data, labels);

