dataIntensity = [];
dataLable = [];
for i=1:TRAIN_SAMPLE
    dataIntensity = [dataIntensity;data_train(i).intensity(:)];
    dataLable = [dataLable;data_train(i).region(:)];
end

featureIntensity = repmat(dataIntensity,1,2);
featureIntensity(:,2) = featureIntensity(:,2).^2;

B = mnrfit(featureIntensity(1:100000,:),dataLable(1:100000)+1);

