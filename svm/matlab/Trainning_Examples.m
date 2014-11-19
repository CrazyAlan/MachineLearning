accuracy = zeros(4,20);
%Ltest = zeros(500,1);
%linear_accuracy = svmtrain(Ltrain,Ftrain,'-s 0 -t 0'); 26.6
%fprintf('linear_accuracy %d \n',linear_accuracy);

%rst = svmpredict(Ltest,Ftest,model)

%polynomial 
pAccuracy = zeros(10,10,100);

for gamma = 1:3:20
    for coef0 = 1:1:5
        for degree = 1:4:50
            s = sprintf('-s 0 -t 1 -g %d -r %d -d %d',gamma,coef0,degree);
            pAccuracy(gamma,coef0,degree) = svmtrain(Ltrain,Ftrain,s);
            fprintf('gamma %d   coef0 %d  degree %d accuracy %1.3f',gamma,coef0,degree,pAccuracy(gamma,coef0,degree));
        end
    end
end

%radial basis
rAccuracy = zeros(20,1);
for gamma = 1:3:30
    s = sprintf('-s 0 -t 2 -g %d ',gamma);
    rAccuracy(gamma,1) = svmtrain(Ltrain,Ftrain,s);
    fprintf('gamma %d accuracy %1.3f \n',gamma,rAccuracy(gamma,1));
end

%sigmoid basis
sAccuracy = zeros(20,20);
for gamma = 1:3:30
    for coef0 = 1:2:30
    s = sprintf('-s 0 -t 3 -g %d -r %d',gamma,coef0);
    sAccuracy(gamma,1) = svmtrain(Ltrain,Ftrain,s);
    fprintf('gamma %d %coef0 %d accuracy %1.3f \n',gamma,coef0,sAccuracy(gamma,coef0));
    end
end