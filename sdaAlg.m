function [ reduceMatrix ] = sdaAlg( dataMatrix, k, conn )
%dataMatrix ????????????k?????????
% product by ???
[m,~] = size(dataMatrix);
disMatrix = pdist2(dataMatrix,dataMatrix);
[~,orderMatrix] = sort(disMatrix.');
wMatrix = zeros(m,m);
reduceMatrix = zeros(m,k);
for i = 1:m
    for j = 1:conn
        wMatrix(i, orderMatrix(j,i)) = 1;
        wMatrix(orderMatrix(j,i), i) = 1;
    end
end

G = graph(wMatrix);
cons = conncomp(G);
if cons == 0
    disp('g is not connected in conn = ',num2str(conn));
    return ;
end

%Ly=eDy
%D^-1Ly = Ey
D = zeros(m,m);
L = zeros(m,m);
for i = 1:m
    D(i,i) = sum(wMatrix(:,i));
end
L = D - wMatrix;
TEM = (D^-1) * L;
[eigenVector, eigenValues] = eig(TEM);
listValues = abs(real(diag(eigenValues)));
[~,order] = sort(listValues);
for i = 1:k
    reduceMatrix(:,i) = real(eigenVector(:,order(i)));
end
end
% product by ???

