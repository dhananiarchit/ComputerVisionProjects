function [W, b] = Train(W, b, train_data, train_label, learning_rate)
% [W, b] = Train(W, b, train_data, train_label, learning_rate) trains the network
% for one epoch on the input training data 'train_data' and 'train_label'. This
% function should returned the updated network parameters 'W' and 'b' after
% performing backprop on every data sample.


% This loop template simply prints the loop status in a non-verbose way.
% Feel free to use it or discard it
tolerance = 1e-5;

for i = 1:size(train_data,1)
    X = train_data(i,:)
    [Y, act_h, act_a] = Forward(W, b, X);
    [grad_W, grad_b] = Backward(W, b, X, Y, act_h, act_a);
    
    while diff>=tolerance
        
        [W_, b_] = UpdateParameters(W, b, grad_W, grad_b, learning_rate);
        [grad_W, grad_b] = Backward(W, b, X, Y, act_h, act_a);
        diffW_ = W_ - W;
        diffb_ = b_ - b;
        
        diff = sqrt(diffW_^2 + diffb_^2);
    end
    if mod(i, 100) == 0
        fprintf('\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b')
        fprintf('Done %.2f %%', i/size(train_data,1)*100)
    end
end
fprintf('\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b')


end
