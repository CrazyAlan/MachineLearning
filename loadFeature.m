function [dataLoc,dataRGB,dataTxt,dataInt,t,dataLocT,dataRGBT,dataTxtT,dataIntT,tT] = loadFeature(train,test)

load dataNorm.mat;

dataRGB =[];
dataTxt =[];
dataLoc =[];
dataInt =[];
t =[];

dataRGBT =[];
dataTxtT =[];
dataLocT =[];
dataIntT =[];
tT =[];

trainStart = train(1);
trainEnd = train(2);
testStart = test(1);
testEnd = test(2);
%Convert Struct data to Matrix

for i = trainStart:trainEnd
    dataRGB = [dataRGB; reshape(data_train(i).rgbimage,numel(data_train(i).rgbimage(:,:,1)),3)];
    dataTxt = [dataTxt; reshape(data_train(i).segament,numel(data_train(i).segament(:,:,1)),3)];
    dataLoc = [dataLoc; data_train(i).loc];
    dataInt = [dataInt; data_train(i).intensity(:)];
    t = [t;data_train(i).region(:)];
end

for i = testStart:testEnd
    dataRGBT = [dataRGBT; reshape(data_train(i).rgbimage,numel(data_train(i).rgbimage(:,:,1)),3)];
    dataTxtT = [dataTxtT; reshape(data_train(i).segament,numel(data_train(i).segament(:,:,1)),3)];
    dataLocT = [dataLocT; data_train(i).loc];
    dataIntT = [dataIntT; data_train(i).intensity(:)];
    tT = [tT;data_train(i).region(:)];
end

dataInt = [dataInt dataInt(:,1).^2];
dataRGB = [dataRGB dataRGB(:,1).^2 dataRGB(:,2).^2 dataRGB(:,3).^2 dataRGB(:,1).*dataRGB(:,2) dataRGB(:,1).*dataRGB(:,3) dataRGB(:,2).*dataRGB(:,3)];
dataTxt = [dataTxt dataTxt(:,1).^2 dataTxt(:,2).^2 dataTxt(:,3).^2 dataTxt(:,1).*dataTxt(:,2) dataTxt(:,1).*dataTxt(:,3) dataTxt(:,2).*dataTxt(:,3)];
dataLoc = [dataLoc dataLoc(:,1).^2 dataLoc(:,2).^2 dataLoc(:,1).*dataLoc(:,2)];

dataIntT = [dataIntT dataIntT(:,1).^2];
dataRGBT = [dataRGBT dataRGBT(:,1).^2 dataRGBT(:,2).^2 dataRGBT(:,3).^2 dataRGBT(:,1).*dataRGBT(:,2) dataRGBT(:,1).*dataRGBT(:,3) dataRGBT(:,2).*dataRGBT(:,3)];
dataTxtT = [dataTxtT dataTxtT(:,1).^2 dataTxtT(:,2).^2 dataTxtT(:,3).^2 dataTxtT(:,1).*dataTxtT(:,2) dataTxtT(:,1).*dataTxtT(:,3) dataTxtT(:,2).*dataTxtT(:,3)];
dataLocT = [dataLocT dataLocT(:,1).^2 dataLocT(:,2).^2 dataLocT(:,1).*dataLocT(:,2)];
