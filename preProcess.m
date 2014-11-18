clc;
clear all;
TRAIN_SAMPLE = 100;
load data_sample.mat;
dataIntensity = [];
dataRGB = [];
dataLoc = [];
dataTxt = [];

for i = 1:TRAIN_SAMPLE
    data_train(i).intensity = im2double(data_train(i).intensity);
    data_train(i).rgbimage = im2double(data_train(i).rgbimage);
    %meanNormalize
    dataIntensity = [dataIntensity;data_train(i).intensity(:)];
    dataRGB = [dataRGB; reshape(data_train(i).rgbimage,numel(data_train(i).rgbimage(:,:,1)),3)];
    dataTxt = [dataTxt; reshape(data_train(i).segament,numel(data_train(i).segament(:,:,1)),3)];
end

%meanNormalize
mnIntensity = mean(dataIntensity);
stdIntensity = std(dataIntensity);
mnRGB = mean(dataRGB);
stdRGB = std(dataRGB);
mnTxt = mean(dataTxt);
stdTxt = std(dataTxt);

for i = 1:TRAIN_SAMPLE
    data_train(i).intensity = (data_train(i).intensity - mnIntensity)/stdIntensity;
    data_train(i).rgbimage(:,:,1) = (data_train(i).rgbimage(:,:,1) - mnRGB(1,1))/stdRGB(1,1);
    data_train(i).rgbimage(:,:,2) = (data_train(i).rgbimage(:,:,2) - mnRGB(1,2))/stdRGB(1,2);
    data_train(i).rgbimage(:,:,3) = (data_train(i).rgbimage(:,:,3) - mnRGB(1,3))/stdRGB(1,3);
    data_train(i).segament(:,:,1) = (data_train(i).segament(:,:,1) - mnTxt(1,1))/stdTxt(1,1);
    data_train(i).segament(:,:,2) = (data_train(i).segament(:,:,2) - mnTxt(1,2))/stdTxt(1,2);
    data_train(i).segament(:,:,3) = (data_train(i).segament(:,:,3) - mnTxt(1,3))/stdTxt(1,3);
end


save dataNorm.mat data_train;




