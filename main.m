%Logistic Regression
clear all;
clc;

TRAIN_SAMPLE = [1 300];
TEST_SAMPLE = [301 500];

[dataLoc,dataRGB,dataTxt,dataInt,t,dataLocT,dataRGBT,dataTxtT,dataIntT,tT] = loadFeature(TRAIN_SAMPLE,TEST_SAMPLE);

%Location Logistic Regression
[locTrainAccu,B] = logRegTrain(dataLoc,t);
[locTestAccu] = logRegTest(dataLocT,B,tT);



