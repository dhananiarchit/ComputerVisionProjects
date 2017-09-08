function [W, b] = InitializeNetwork(layers)
% InitializeNetwork([INPUT, HIDDEN, OUTPUT]) initializes the weights and biases
% for a fully connected neural network with input data size INPUT, output data
% size OUTPUT, and HIDDEN number of hidden units.
% It should return the cell arrays 'W' and 'b' which contain the randomly
% initialized weights and biases for this neural network.
W = {};
b = {};
for i = 2:length(layers)
    W{i-1} = randn(layers(i),layers(i-1));
    W{i-1} = W{i-1}.*sqrt(2/layers(i-1));
    b{i-1} = zeros(layers(i),1);
%     b{i-1} = b{i-1}./sum(b{i-1});
end
end
