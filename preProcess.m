%load data_sample.mat;
%data_cell = struct2cell(data_train);
dataIntensity = [];
for i = 1:677
 %   data_cell{1,1,i} = im2double(data_cell{1,1,i});
  %  data_cell{2,1,i} = im2double(data_cell{2,1,i});
    %meanNormalize
    dataIntensity = [dataIntensity;data_cell{2,1,i}(:)];
end

%meanNormalize
mnIntensity = mean(dataIntensity);
stdIntensity = std(dataIntensity);

for i = 1:677
    data_cell{2,1,idata_cell{2,1,i}} = (data_cell{2,1,i} - mnIntensity)/stdIntensity;
end

