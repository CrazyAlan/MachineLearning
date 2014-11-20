% 
% Train a neural network.
%
% Question 5

% Load data.
% Loads X (28x28x10000): images, t (10000x1): labels
% Note that original labels are integers in 0-9.
load digits10000

K = 10;  % Number of classes.
ETA = 0.1; % Step size for stochastic gradient descent.
MAX_ITER = 20; % Maximum number of iterations through the training data.

% Transform digits to 10000x784, remove spatial structure.
Xt = transformDigits(X);
t = t+1; % Encode as 1-10, digit+1.

% Set up training and testing sets.
TRAIN_INDS=1:500;
TEST_INDS=501:1000;
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
H = 500;  % Number of hidden nodes.
clear NN;
NN = struct('weights',rand(D+1,H),'type','sigmoid');
%NN(1).weights =  eye(D+1,H);
%NN(1).weights = 1*rand(D+1,H) - 0.5;
NN(2).weights = 0.1*rand(H+1,K);
NN(2).type = 'softmax';



% Stochastic gradient descent with back-propagation.
% Training/testing set accuracy
tra_all=[];
tea_all=[];
for iter=1:MAX_ITER
  fprintf('Training neural network iter %d/%d: ', iter, MAX_ITER);
  tt = clock;
  for x_i=1:N
    [A,Z] = feedforward(Xtrain(x_i,:),NN);

    % Output layer derivative.
    % Assume classification with softmax.
    % Note: code for multiple hidden layers should use a for loop, but the first/last layers are special cases, hence no loop used here.
    % TO DO:: fill this in.
    dW2 = zeros(H+1,K);
    
    tk = zeros(1,10);
    tk(1,ttrain(x_i,1)) = 1;
    delta_k = Z{2} - tk;
    dW2 = (delta_k'*[1 Z{1}])';
    
    % Hidden layer derivative.
    % Backpropagate error from output layer to hidden layer.
    % TO DO:: fill this in.
    dW1 = zeros(D+1,H);
    g_prime_aj = Z{1}.*(1-Z{1}); %1*500
   % g_prime_aj = [0 g_prime_aj];%1*501
    w_kjDelta_k = NN(2).weights(2:501,:)*(delta_k');%500*1
    delta_j = g_prime_aj'.*w_kjDelta_k; %500*1
    dW1 = delta_j*[1 Xtrain(x_i,:)];
    dW1 = dW1';
    

    % Apply the computed gradients in a stochastic gradient descent update.
    NN(2).weights = NN(2).weights - ETA*dW2;
    NN(1).weights = NN(1).weights - ETA*dW1;
  end

  tra_all(iter) = computeAcc(Xtrain,NN,ttrain);
  tea_all(iter) = computeAcc(Xtest,NN,ttest);
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
