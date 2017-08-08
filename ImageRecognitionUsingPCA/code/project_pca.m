clc
clear all
close all

%%

%load the data from the .mat file
load data.mat
train_data = X(:,trainimages);
train_labels = Y(trainimages,:);

%mean of each pixel in the data set
m = mean(train_data,2);

%Deviation of the data from the mean
X_ = train_data - repmat(m,[1 size(train_data,2)]);


%Projection of all data set to Principal Components
covariance = X_'*X_;

[V,D] = eig(covariance);

for i=1:size(train_data,2)
    d(i) = D(i,i);
end

d = d';

[eigen_values,I] = sort(d,'descend');


for i = 1:size(d,1)
    v(:,i) = V(:,I(i,1)); 
end


sum_act = sum(eigen_values);

new_sum = 0;
% Considering the eigen values that contribute to 90% of their sum
for i = 1:size(eigen_values,1)
    new_sum = new_sum + eigen_values(i);
    variation = new_sum/sum_act;
    var(i,1) = eigen_values(i)/sum_act;
    if(variation>0.9)
        E=i;
        break;
    end
end

%Eigen Faces after reducing dimensions
eigenfaces = X_ * v;

for i= 1:2
    figure();
    imshow(reshape(eigenfaces(:,i),231,195));
    title(['Eigenface',num2str(i)]);
end


figure();
bar(var);
xlabel('principal components');
ylabel('Variation in each components');

%% To Reconstruct the faces from the eigen faces

eigenfaces = normc(eigenfaces);
e = eigenfaces(:,1:10);
projected = e'*X_(:,1);
X1 = m + e*projected;


figure();
imshow(reshape(train_data(:,trainimages(1)),231,195));
figure();
imshow(reshape(X1,231,195));
title(['Reconstructed with ',num2str(10), ' eigen faces']);
    



%%

%Classification of the faces using the eigen faces.
eigenfaces=normc(eigenfaces);
e_final = eigenfaces(:,1:E);
projected_data = e_final'*X_;
x_reduced = m*ones(size(train_data,2),1)' + e_final*projected_data;


test_data = X(:,testimages);
test_labels = Y(testimages,:);

for i =1:size(testimages,1)
    for j = 1:size(x_reduced,2)
        err(j,i) = sum((x_reduced(:,j)-test_data(:,i)).^2);
    end
end

[~,i] = min(err);

testedlabels = train_labels(i);


    
no_of_mismatch = find(testedlabels-test_labels~=0);

percentage_error = size(no_of_mismatch,1)*100/size(test_labels,1);





