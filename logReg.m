%{
dataIntensity = [];
dataLable = [];
for i=1:TRAIN_SAMPLE
    dataIntensity = [dataIntensity;data_train(i).intensity(:)];
    dataLable = [dataLable;data_train(i).region(:)];
end

dataIntensity = [ones(size(dataIntensity)) repmat(dataIntensity,1,2)];
%}
    
load dataIntensity.mat;
load dataLable.mat;
dataIntensity(:,3) = dataIntensity(:,3).^2;
maxIter = 100;
tol = 0.01;
eta = 0.0000005;
w = [1.3 .1 .1]';
e_all = [];
for iter = 1:maxIter
   % for i=1:size(dataIntensity,1)
    y = sigmoid(dataIntensity*w);
    e = -sum(dataLable.*log(y) + (1-dataLable).*log(1-y));
    e_all(end+1) = e;
    
    % Gradient of the error, using Eqn 4.91
    Rnn = y.*(1-y);
    %R = diag(Rnn);
    w_old = w;
    z = dataIntensity*w_old - (Rnn.^-1).*(y-dataLable);
    R = repmat(Rnn,1,3);
    w = (((dataIntensity.*R)'*dataIntensity)^-1)*(dataIntensity.*R)'*z;
    % Update w, *subtracting* a step in the error derivative since we're minimizing
    
    
    fprintf('iter %d, negative log-likelihood %.4f, w= \n', iter, e);
    
    
   % end
    if iter>1
        if abs(e-e_all(iter-1))<tol
          break;
        end
    end
  
end

