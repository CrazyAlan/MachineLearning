load dataNorm.mat;
clear dataLoc;
clear t;

TRAIN_SAMPLE = 100;

dataLoc = [];
t = [];

%Convert Struct data to Matrix

for i = 1:TRAIN_SAMPLE
    %row col
    dataLoc = [dataLoc; data_train(i).loc];
    t = [t;data_train(i).region(:)];
end

%Feature Vector (1,r,g,b,r2,g2,b2,r*g,r*b,g*b)

%dataLoc = repmat(dataLoc,1,3); % don't need bias 1

dataLoc = [dataLoc dataLoc(:,1).^2 dataLoc(:,2).^2 dataLoc(:,1).*dataLoc(:,2)];

%Logistic Regression Training 
%B is the coefficient 

eB = mnrfit(dataLoc,t+1); %t+1, positive lable

result = mnrval(B,dataLoc);

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
