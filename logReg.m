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
maxIter = 100;
tol = 0.01;
eta = 0.000001;
w = [-0.588126826925528 -0.0944626478713500 -0.0944626478713500]';
e_all = [];
for iter = 1:maxIter
   % for i=1:size(dataIntensity,1)
    y = logsig(dataIntensity*w);
    e = -sum(dataLable.*log(y) + (1-dataLable).*log(1-y));
    e_all(end+1) = e;
    
    % Gradient of the error, using Eqn 4.91
    grad_e = sum(repmat(y - dataLable,[1 size(dataIntensity,2)]) .* dataIntensity, 1);
    %grad_e = (y(i,1) - dataLable(i,1)).*dataIntensity(i,:);
    % Update w, *subtracting* a step in the error derivative since we're minimizing
    w_old = w;
    w = w - eta*grad_e';
    
    fprintf('iter %d, negative log-likelihood %.4f, w= \n', iter, e);
    
    
   % end
    if iter>1
        if abs(e-e_all(iter-1))<tol
          break;
        end
    end
  
end

