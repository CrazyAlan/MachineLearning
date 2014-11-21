clear all;
load dataNorm.mat;

TRAIN_SAMPLE = 100;

dataInt = []; %Intensity
t = [];

%Convert Struct data to Matrix

for i = 1:TRAIN_SAMPLE
    dataInt = [dataInt; data_train(i).intensity(:)];
    t = [t;data_train(i).region(:)];
end

dataInt = [dataInt dataInt(:,1).^2];

B = mnrfit(dataInt,t+1); %t+1, positive lable

result = mnrval(B,dataInt);

lable = result(:,2)>0.5;    % 1 is foreground

%Caculate Accuracy
LF = sum(t(find(lable == 1)) == 1);
TF = sum(t == 1);
TB = numel(t) - TF;
LB = numel(t) - LF;
accuracy = 0.5*(LF/TF + LB/TB)
