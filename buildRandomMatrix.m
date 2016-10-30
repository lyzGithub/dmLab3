function [ randomOMatrix ] = buildRandomMatrix( data, index )
[~,n1] = size(index);
[~,n2]  =size(data);
randomOMatrix = zeros(n1,n2);
for i = 1:n1
    randomOMatrix(i,:) = data(index(1,i),:);
end
end
% product by ???

