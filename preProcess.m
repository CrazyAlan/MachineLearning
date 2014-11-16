load data_sample.mat;
dataIntensity = [];
dataRGB = [];
for i = 1:677
    data_train(i).intensity = im2double(data_train(i).intensity);
    data_train(i).rgbimage = im2double(data_train(i).rgbimage);
    %meanNormalize
    dataIntensity = [dataIntensity;data_train(i).intensity(:)];
    
end

%meanNormalize
mnIntensity = mean(dataIntensity);
stdIntensity = std(dataIntensity);

for i = 1:677
    data_train(i).intensity = (data_train(i).intensity - mnIntensity)/stdIntensity;
end
