A = data_train(197).intensity;
A = im2double(A);
D = [ones(numel(A),1) A(:) A(:).^2];

t = data_train(197).region;
t = t(:);



B = mnrfit(D,t+1);
 %197 bul
 
 