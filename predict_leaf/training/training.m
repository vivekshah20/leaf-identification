function training()
addpath(genpath('.\predict_leaf'));
%% edit this link
data=xlsread('.\predict_leaf\training\training.xlsx');
%%
[l br]=size(data);
obs=data(:,1:(br-1));
[r1 c1]=size(obs);
maxi=max(obs);
mini=min(obs);
for i=1:r1
    for j=1:c1
        obs(i,j)=(obs(i,j)-mini(1,j))/(maxi(1,j)-mini(1,j));
    end
end
group=data(:,br);
c=cvpartition(group,'HoldOut',0.2);
idx1=training(c);
idx2=test(c);
datatrain=obs(idx1,:);
grptrain=group(idx1,:);
testdata=obs(idx2,:);
testgrp=group(idx2,:);
X=datatrain;
Y=grptrain;
num_labels=10;
lambda = 0.01;
[all_theta] = oneVsAll(X, Y, num_labels, lambda);
pred = predictOneVsAll(all_theta, testdata);
result=pred;
count=(result==testgrp);
right=sum(count==1);
wrong=size(testgrp,1)-right;
percentage=(right/size(testgrp,1))*100
normalize=[mini;maxi];
%% edit these links
xlswrite('.\predict_leaf\predict\theta.xlsx',all_theta);
xlswrite('.\predict_leaf\predict\normalization_para.xlsx',normalize);
end
