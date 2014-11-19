load dataNorm.mat;
clear dataTxt;
clear t;

TRAIN_SAMPLE = 10;

dataTxt = [];
t = [];

%Convert Struct data to Matrix

for i = 1:TRAIN_SAMPLE
    dataTxt = [dataTxt; reshape(data_train(i).segament,numel(data_train(i).segament(:,:,1)),3)];
    t = [t;data_train(i).region(:)];
end

%Feature Vector (1,r,g,b,r2,g2,b2,r*g,r*b,g*b)

%dataTxt = repmat(dataTxt,1,3); % don't need bias 1

dataTxt = [dataTxt dataTxt(:,1).^2 dataTxt(:,2).^2 dataTxt(:,3).^2 dataTxt(:,1).*dataTxt(:,2) dataTxt(:,1).*dataTxt(:,3) dataTxt(:,2).*dataTxt(:,3)];

%Logistic Regression Training 
%B is the coefficient 

B = mnrfit(dataTxt,t+1); %t+1, positive lable

result = mnrval(B,dataTxt);

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
