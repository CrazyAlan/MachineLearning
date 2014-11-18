A = data_train(1).intensity;
A = im2double(A);
D = [A(:) A(:).^2];

t = data_train(1).region;
t = t(:);

%w = [-3.08309457699786;-1.16685472887340;0.499204155734427];

B = mnrfit(D,t+1);
C = mnrval(B,D);
E = C>0.5;
F = reshape(E(:,1),240,320);
imshow(F);
 %197 bul
 
 n = [3000];
 A = (exp(0.12)/(1.12^1.12)).^(0.45*n);