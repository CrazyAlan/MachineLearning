%Our
function e = comptAcc(X,NN,t)
% Compute classification accuracy for network NN on data X with targets t.
[A,Z] = feedForward(X,NN);

% Take max over output layer, compare to t.
lable = Z{end} < 0.5;

LF = sum(t(find(lable == 1)) == 1);
TF = sum(t == 1);
TB = numel(t) - TF;
LB = numel(t) - LF;
e = 0.5*(LF/TF + LB/TB)