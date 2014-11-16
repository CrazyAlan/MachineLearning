dataIntensity = [];
dataLable = [];
for i=1:TRAIN_SAMPLE
    dataIntensity = [dataIntensity;data_train(i).intensity(:)];
    dataLable = [dataLable;data_train(i).region(:)];
end

featureIntensity = [ones(size(dataIntensity)) repmat(dataIntensity,1,2)];
featureIntensity(:,3) = featureIntensity(:,3).^2;

B = mnrfit(featureIntensity,dataLable+1);

