germanDataPath = 'data/german.txt';
mnistDataPath = 'data/mnist.txt';

germanMatrix = load(germanDataPath);
mnistMatrix = load(mnistDataPath);
[gerM,gerN] = size(germanMatrix);
[mniM,mniN] = size(mnistMatrix);
germanK = 2;
mnistK = 10;

germanLabel = germanMatrix(:,gerN);
mnistLabel = mnistMatrix(:,mniN);

germanMatrix(:,gerN) = [];
mnistMatrix(:,mniN) = [];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
disp('compute for k-mediods~~');
tic;
maxGerP = 0;
mingerGini = 1;
disp('compute for k-mediods:german~~');
for i = 1:10
    labelAlgDeter = k_medoids(germanMatrix, germanK, germanLabel);
    [gerP, gerGini] = qualityCom(germanLabel,labelAlgDeter,germanK);
    if maxGerP < gerP
        maxGerP  = gerP;
    end
    if mingerGini > gerGini
        mingerGini = gerGini;
    end
end
toc;
disp(['german, purity: ',num2str(maxGerP),', gini index: ',num2str(mingerGini)]);

%%%%%%%

tic;
maxMnistP = 0;
minMnisGini = 1;
disp('compute for k-mediods:mnist~~');
for i = 1:10
    labelAlgDeter = k_medoids(mnistMatrix, mnistK, mnistLabel);
    [minstP, mnistGini] = qualityCom(mnistLabel,labelAlgDeter,mnistK);
    if maxMnistP < minstP
        maxMnistP  = minstP;
    end
    if minMnisGini>mnistGini
        minMnisGini = mnistGini;
    end
end
toc;
disp(['mnist, purity: ',num2str(maxMnistP),', gini index: ',num2str(minMnisGini)]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp(' ');
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
disp('compute alg2:The spectral clustering algorithm');
%compute sda for german
disp('compute alg2:german');
for j = 1:3
    tic;
    reduceGerman = sdaAlg(germanMatrix,germanK,3*j);
    maxGerP = 0;
    mingerGini = 1;
    for i = 1:10
        labelAlgDeter = k_medoids(reduceGerman, germanK, germanLabel);
        [gerP, gerGini] = qualityCom(germanLabel,labelAlgDeter,germanK);
        if maxGerP < gerP
            maxGerP  = gerP;
        end
        if mingerGini > gerGini
            mingerGini = gerGini;
        end
    end
    toc;
    disp(['german, purity: ',num2str(maxGerP),', gini index: ',num2str(mingerGini)]);
    disp(['conn value:',num2str(3*j)]);
end


disp('compute alg2:mnist');
%compute sda for mnist
for j = 1:3
    tic;
    reduceMnist = sdaAlg(mnistMatrix,mnistK,3*j);
    maxMnistP = 0;
    minMnisGini = 1;
    for i = 1:10
        labelAlgDeter = k_medoids(reduceMnist, mnistK, mnistLabel);
        [minstP, mnistGini] = qualityCom(mnistLabel,labelAlgDeter,mnistK);
        if maxMnistP < minstP
            maxMnistP  = minstP;
        end
        if minMnisGini>mnistGini
            minMnisGini = mnistGini;
        end
    end
    toc;
    disp(['mnist, purity: ',num2str(maxMnistP),', gini index: ',num2str(minMnisGini)]);
    disp(['conn value:',num2str(3*j)]);
end




