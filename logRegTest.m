%Logistic Regression for Testing
function [accuracy] = logRegTest(data,B,t) %B is the coefficient

%Logistic Regression
result = mnrval(B,data);
lable = result(:,2)>0.5;    % 1 is foreground
%Caculate Accuracy
LF = sum(t(find(lable == 1)) == 1);
TF = sum(t == 1);
TB = numel(t) - TF;
LB = numel(t) - LF;
accuracy = 0.5*(LF/TF + LB/TB);