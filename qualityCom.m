function [ purity, gini ] = qualityCom( trueLabel, deterLabel, k )
[m,~] = size(trueLabel);
tlabel = trueLabel;
if k == 2
    
    for i = 1:m
        if tlabel(i,1) == -1
            tlabel(i,1) = 2;
        end
    end
    
    M = zeros(k,k);
    for i = 1:m
        M(tlabel(i,1),deterLabel(i,1)) = M(tlabel(i,1),deterLabel(i,1)) +1;
    end
    [maxS,~] = max(M);
    d=sum(sum(maxS));
    purity = d/m;
    
    GjMj = 0;
    b = sum(M);
    for j = 1:k
        sumTmp = 0;
        for i = 1:k
            sumTmp = sumTmp +(M(i,j)/b(1,j))^2;
        end
        
        Gj = 1-sumTmp;
        GjMj = GjMj + Gj*b(1,j);
    end
    gini = GjMj/m;
    
    
    
    
end



if k == 10
    for i = 1:m
        tlabel(i,1) = tlabel(i,1) + 1;
    end
    M = zeros(k,k);
    for i = 1:m
        M(tlabel(i,1),deterLabel(i,1)) = M(tlabel(i,1),deterLabel(i,1)) +1;
    end
    
    [maxS,~] = max(M);
    d=sum(sum(maxS));
    purity = d/m;
    
    GjMj = 0;
    b = sum(M);
    for j = 1:k
        sumTmp = 0;
        for i = 1:k
            sumTmp = sumTmp +(M(i,j)/b(1,j))^2;
        end
        
        Gj = 1-sumTmp;
        GjMj = GjMj + Gj*b(1,j);
    end
    gini = GjMj/m;
    
    
    
end
if k ~= 10 && k~=2
    disp('k is not right!!!');
    
end
end
% product by ???
