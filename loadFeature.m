clear all;
load dataNorm.mat;

TRAIN_SAMPLE = 100;

dataRGB = [];
dataTxt = [];
dataLoc = [];
dataInt = []; %Intensity
t = [];

%Convert Struct data to Matrix

for i = 1:TRAIN_SAMPLE
    dataRGB = [dataRGB; reshape(data_train(i).rgbimage,numel(data_train(i).rgbimage(:,:,1)),3)];
    dataTxt = [dataTxt; reshape(data_train(i).segament,numel(data_train(i).segament(:,:,1)),3)];
    dataLoc = [dataLoc; data_train(i).loc];
    dataInt = [dataInt; data_train(i).intensity(:)];
    t = [t;data_train(i).region(:)];
end

dataInt = [dataInt dataInt(:,1).^2];
dataRGB = [dataRGB dataRGB(:,1).^2 dataRGB(:,2).^2 dataRGB(:,3).^2 dataRGB(:,1).*dataRGB(:,2) dataRGB(:,1).*dataRGB(:,3) dataRGB(:,2).*dataRGB(:,3)];
dataTxt = [dataTxt dataTxt(:,1).^2 dataTxt(:,2).^2 dataTxt(:,3).^2 dataTxt(:,1).*dataTxt(:,2) dataTxt(:,1).*dataTxt(:,3) dataTxt(:,2).*dataTxt(:,3)];
dataLoc = [dataLoc dataLoc(:,1).^2 dataLoc(:,2).^2 dataLoc(:,1).*dataLoc(:,2)];