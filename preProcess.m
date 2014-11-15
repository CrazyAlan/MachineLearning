load data_sample.mat;
data_cell = struct2cell(data_train);
for i = 1:677
    data = [data;data_cell{2,1,i}];
end
