dataIntensity = [];
dataLable = [];
for i=1:TRAIN_SAMPLE
    dataIntensity = [dataIntensity;data_train(i).intensity(:)];
    dataLable = [dataLable;data_train(i).region(:)];
end

dataIntensity = [ones(size(dataIntensity)) repmat(dataIntensity,1,2)];

maxIter = 20;
tol = 0.01;
w = [0.1 0 0]';
e_all = [];
for iter = 1:maxIter
    y = sigmoid(dataIntensity*w);
    e = -sum(dataLable.*log(y) + (1-dataLable).*log(1-y));
    e_all(end+1) = e;
    
    Rnn = y.*(1-y);
    R = diag(Rnn);
    w_old = w;
    z = dataIntensity*w_old - (R^-1)*(y-dataLable);
    w = ((dataIntensity'*R*dataIntensity)^-1)*dataIntensity'*R*z;
    
    fprintf('iter %d, negative log-likelihood %.4f, w= \n', iter, e);
    
    if iter>1
        if abs(e-e_all(iter-1))<tol
          break;
        end
    end
  
end

