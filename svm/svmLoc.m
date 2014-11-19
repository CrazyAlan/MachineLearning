%{
clear all;
load ../../dataNorm.mat;
clear dataLoc;
clear t;
%}

TRAIN_SAMPLE = 100;

dataLoc = [];
t = [];

%Convert Struct data to Matrix

for i = 1:TRAIN_SAMPLE
    %row col
    dataLoc = [dataLoc; data_train(i).loc];
    t = [t;data_train(i).region(:)];
end

%Feature Vector (1,r,g,b,r2,g2,b2,r*g,r*b,g*b)

%dataLoc = repmat(dataLoc,1,3); % don't need bias 1

dataLoc = [dataLoc dataLoc(:,1).^2 dataLoc(:,2).^2 dataLoc(:,1).*dataLoc(:,2)];

s = sprintf('-s 2 -t 0 -v 5');

accuracy = svmtrain(t,dataLoc,s)


