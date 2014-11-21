TRAIN_SAMPLE = 100;
%Xt = [dataLoc dataRGB dataTxt dataInt];
load Xt.mat;
load t.mat
%Xt = Xt(1:1000000,:);

K = 1;  % Number of classes.
ETA = 0.1; % Step size for stochastic gradient descent.
MAX_ITER = 20; % Maximum number of iterations through the training data.

t = t; % Lable

% Set up training and testing sets.
TRAIN_INDS=1:0.5*size(Xt,1);
TEST_INDS=(0.5*size(Xt,1)+1):size(Xt,1);
% Use below instead if you wish to use the remainder as test data.
% TEST_INDS=setdiff(1:size(Xt,1),TRAIN_INDS);

Xtest=Xt(TEST_INDS,:);
ttest=t(TEST_INDS);

Xtrain=Xt(TRAIN_INDS,:);
ttrain=t(TRAIN_INDS);
[N D] = size(Xtrain);

% Create neural network data structure.
% Simple version, have weight vector per node, all nodes in a layer are same type.
% NN(i).weights is a matrix of weights, each row corresponds to the weights for a node at the next layer.
%  I.e. a_k = NN(i).weights(:,k)' * z, where z is the vector of node outputs at the preceding layer.
H = 4;  % Number of hidden nodes.
clear NN;

%Parameter
% LocParameter = [6.82 -16.32 -7.01 14.60 7.50 -1.36]
% RGBParameter = [1.8723   -0.2686    1.3210   -0.7205   -0.3293   -2.6354    1.0265    1.9550   -0.9254 0.9133]
% TxtParameter = [2.36 -0.36 0.42	-1.59	-1.37 -0.65 -0.79 0.92 1.42 0.28]
% IntParameter = [1.9961    0.4894   -0.2475]
%Need To Initialize With Pre-trained Value
NN = struct('weights',rand(D+1,H),'type','sigmoid');
tmp = zeros(D+1,H);
tmp(1:5,1) = [-16.32 -7.01 14.60 7.50 -1.36];tmp(end,1) = 6.82;
tmp(6:14,2) = [-0.2686    1.3210   -0.7205   -0.3293   -2.6354    1.0265    1.9550   -0.9254 0.9133];
tmp(end,2) = 1.8723;
tmp(15:23,3) = [-0.36 0.42	-1.59	-1.37 -0.65 -0.79 0.92 1.42 0.28];tmp(end,3) = 2.36;
tmp(24:25,4) = [0.4894   -0.2475]; tmp(end,4) = 1.9961;

NN(1).weights =  tmp;
NN(2).type = 'sigmoid';

NN(2).weights = 0.25*ones(H+1,K);
NN(2).type = 'sigmoid';



% Stochastic gradient descent with back-propagation.
% Training/testing set accuracy
tra_all=[];
tea_all=[];
for iter=1:MAX_ITER
  fprintf('Training neural network iter %d/%d: ', iter, MAX_ITER);
  tt = clock;
  for x_i=1:N
    [A,Z] = feedForward(Xtrain(x_i,:),NN);

    % Output layer derivative.
    % Assume classification with softmax.
    % Note: code for multiple hidden layers should use a for loop, but the first/last layers are special cases, hence no loop used here.
    % TO DO:: fill this in.
    dW2 = zeros(H+1,K);
    
    tk = ttrain(x_i,1);
    delta_k = Z{2} - tk;
    dW2 = (delta_k'*[Z{1} 1])';
    
    % Hidden layer derivative.
    % Backpropagate error from output layer to hidden layer.
    % TO DO:: fill this in.
    dW1 = zeros(D+1,H);
    g_prime_aj = Z{1}.*(1-Z{1}); %1*500
    w_kjDelta_k = NN(2).weights(1:H,:)*(delta_k');%500*1
    delta_j = g_prime_aj'.*w_kjDelta_k; %500*1
    dW1 = delta_j*[Xtrain(x_i,:) 1];
    dW1 = dW1';
    

    % Apply the computed gradients in a stochastic gradient descent update.
    NN(2).weights = NN(2).weights - ETA*dW2;
    NN(1).weights = NN(1).weights - ETA*dW1;
  end

  tra_all(iter) = comptAcc(Xtrain,NN,ttrain);
  tea_all(iter) = comptAcc(Xtest,NN,ttest);
  fprintf('training accuracy = %.4f, took %.2f seconds\n',tra_all(iter),etime(clock,tt));

end
fprintf('Final test accuracy = %.4f.\n',tea_all(end));
    

% Set up a figure for plotting training error.
figure(1);
clf;
plot(tra_all,'bo-');
hold on;
plot(tea_all,'ro-');
hold off;
set(gca,'FontSize',15);
xlabel('Iteration');
ylabel('Classification accuracy')
title('Training neural network with backpropagation');
legend('Training set','Test set');
axis([1 MAX_ITER 0 1])


% Produce webpage showing predictions.
fprintf('Producing webpage of results... ');
% Get predictions
[A,Z] = feedforward(Xtest,NN);
% Take max over output layer to get predictions.
[mvals,preds] = max(Z{end},[],2);

% -1 to convert back to actual digits.
webpageDisplay(X,TEST_INDS,preds-1,ttest-1);
fprintf('done.\n  TRY OPENING output.html\n');
