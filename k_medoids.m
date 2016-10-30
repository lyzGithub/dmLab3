function [ labelAlgDeter ] = k_medoids( dataSet, k )
[m,n] = size(dataSet);
temp = zeros(m,1);
dataCluster = [dataSet temp];


E1 = 0;
E2 = 0;
%???????
randomIndex = randi(m,[1,k]);
randomOMatrix = buildRandomMatrix( dataSet, randomIndex);
for i= 1:m
    tmpRow = dataSet(i,:);
    D = pdist2(tmpRow,randomOMatrix,'cityblock');
    [minDis,I] = min(D.');%????
    dataCluster(i,n+1) = I;%1-k
    E1 = E1+minDis;
end


isChanged = 1;
while isChanged == 1
    
    randomOi = randi(m);
    belongTag = dataCluster(randomOi,n+1);
    newIndex = randomIndex;
    newIndex(1,belongTag) = randomOi;
    newOMatrix = buildRandomMatrix(dataSet,newIndex);
    dataClusterNew = dataCluster;
    for i= 1:m
        tmpRow = dataSet(i,:);
        D = pdist2(tmpRow,newOMatrix,'cityblock');
        [minDis,I] = min(D.');%????
        dataClusterNew(i,n+1) = I;%1-k
        E2 = E2+minDis;
    end
    % disp(['is in E2 E1: ',num2str(E2),' ',num2str(E1)]);
    if E2 < E1
        dataCluster = dataClusterNew;
        randomIndex = newIndex;
        %disp('in exchange');
    end
    if E1 <= E2
        isChanged = 0;
    end
    
end

labelAlgDeter = dataCluster(:,n+1);



end
% product by ???
