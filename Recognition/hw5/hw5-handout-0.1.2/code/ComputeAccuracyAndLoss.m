function [accuracy, loss] = ComputeAccuracyAndLoss(W, b, data, labels)
% [accuracy, loss] = ComputeAccuracyAndLoss(W, b, X, Y) computes the networks
% classification accuracy and cross entropy loss with respect to the data samples
% and ground truth labels provided in 'data' and labels'. The function should return
% the overall accuracy and the average cross-entropy loss.

[outputs] = Classify(W, b, data);

label = zeros(size(labels));
indices = find(labels == max(labels,[],2));
label(indices) = 1;

output = zeros(size(outputs));  
indices1 = find(outputs == max(outputs,[],2));
output(indices1) = 1;
size(output);
size(label);

success = nnz(all(label == output,2));
accuracy = success/length(label);
temp = label.*log(outputs);%+(1-label).*log(1-outputs);
size(temp);
loss = -(sum(temp,2));
end
