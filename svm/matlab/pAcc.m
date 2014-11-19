%polynomial 
load('train.mat')
load('test.mat')


pAccuracy = zeros(10,10,100);

for gamma = 1:3:20
    for coef0 = 1:1:5
        for degree = 1:4:50
            s = sprintf('-s 0 -t 1 -g -v 5 %d -r %d -d %d',gamma,coef0,degree);
            pAccuracy(gamma,coef0,degree) = svmtrain(Ltrain,Ftrain,s);
            fprintf('gamma %d   coef0 %d  degree %d accuracy %1.3f',gamma,coef0,degree,pAccuracy(gamma,coef0,degree));
        end
    end
end