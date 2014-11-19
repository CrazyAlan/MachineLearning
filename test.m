clear all;
load dataNorm.mat;
clear dataLoc;
clear t;


TRAIN_SAMPLE = size(data_train,2);

dataLoc = [];
t = [];

%Convert Struct data to Matrix

for i = 1:TRAIN_SAMPLE
    %row col
    [row,col] = find(data_train(i).region == data_train(i).region);
    row = row./size(data_train(i).region,1);
    col = col./size(data_train(i).region,2);
   % dataLoc = [dataLoc; row col];
    data_train(i).loc = [row col];
   % t = [t;data_train(i).region(:)];
end

 
