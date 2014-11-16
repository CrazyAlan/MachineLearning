clc;
clear all;
load data_sample.mat;
dataIntensity = [];
dataRGB = [];
for i = 1:677
    data_train(i).intensity = im2double(data_train(i).intensity);
    data_train(i).rgbimage = im2double(data_train(i).rgbimage);
    %meanNormalize
    dataIntensity = [dataIntensity;data_train(i).intensity(:)];
    dataRGB = [dataRGB; reshape(data_train(i).rgbimage,numel(data_train(i).rgbimage(:,:,1)),3)];
end

%meanNormalize
mnIntensity = mean(dataIntensity);
stdIntensity = std(dataIntensity);
mnRGB = mean(dataRGB);
stdRGB = std(dataRGB);

for i = 1:677
    data_train(i).intensity = (data_train(i).intensity - mnIntensity)/stdIntensity;
   % data_train(i).rgbimage(:,:,1) = (data_train(i).rgbimage(:,:,1) - mnRGB(1,1))/stdRGB(1,1);
   % data_train(i).rgbimage(:,:,2) = (data_train(i).rgbimage(:,:,2) - mnRGB(1,2))/stdRGB(1,2);
   % data_train(i).rgbimage(:,:,3) = (data_train(i).rgbimage(:,:,3) - mnRGB(1,3))/stdRGB(1,3);
end
