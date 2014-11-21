load dataNorm.mat;
clear dataRGB;
clear t;

TRAIN_SAMPLE = 100;

dataRGB = [];
t = [];

%Convert Struct data to Matrix

for i = 1:TRAIN_SAMPLE
    dataRGB = [dataRGB; reshape(data_train(i).rgbimage,numel(data_train(i).rgbimage(:,:,1)),3)];
    t = [t;data_train(i).region(:)];
end

%Feature Vector (1,r,g,b,r2,g2,b2,r*g,r*b,g*b)

%dataRGB = repmat(dataRGB,1,3); % don't need bias 1

dataRGB = [dataRGB dataRGB(:,1).^2 dataRGB(:,2).^2 dataRGB(:,3).^2 dataRGB(:,1).*dataRGB(:,2) dataRGB(:,1).*dataRGB(:,3) dataRGB(:,2).*dataRGB(:,3)];

%Logistic Regression Training 
%B is the coefficient 

B = mnrfit(dataRGB,t+1); %t+1, positive lable

result = mnrval(B,dataRGB);

lable = result(:,2)>0.5;    % 1 is foreground

%Caculate Accuracy
LF = sum(t(find(lable == 1)) == 1);
TF = sum(t == 1);
TB = numel(t) - TF;
LB = numel(t) - LF;
accuracy = 0.5*(LF/TF + LB/TB)

 
%draw comparing image
%{
figure;
subplot(2,1,1);
imshow(reshape(lable,240,320));
subplot(2,1,2);
imshow(reshape(t,240,320));
%}
