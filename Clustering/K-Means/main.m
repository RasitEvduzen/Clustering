clc,clear all,close all;
% K-Means Clustering
% Rasit EVDUZEN
% 22-Feb-2020

%% Create Random Data
DimensionOfData = 2;
clu = ceil(rand*10);
centers = 100*rand(DimensionOfData,clu);
T = [];
for k=1:clu
    temp = 15+ceil(15*rand);
    T = [T,centers(:,k)*ones(1,temp)+10*[rand(DimensionOfData,temp)-0.5]];
end
T = T';
T = [T-min(T)]./[max(T)-min(T)];        % Data Normalization


%% Create Algorithm
set(gcf,'Position',[100 100 1000 800])
loop2 = 1; K = 0;
while loop2
    K = K +1;
    NumberOfData = size(T,1);
    
    INDEX = randperm(NumberOfData,K);
    CENTROIDS = T(INDEX,:);  % initial center point
    loop = 1; iteration = 0; c = rand(K,3);
    while loop
        clf
        iteration = iteration + 1;
        for i=1:NumberOfData
            VeriNoktasi = T(i,:);
            d = pdist2(VeriNoktasi,CENTROIDS);
            [V,I] = min(d);
            ClusterIndex(i,1) = I;
        end
        
        PrevCENTROIDS = CENTROIDS;
        
        for k=1:K
            I = find(ClusterIndex==k);
            if length(I) > 1
                CENTROIDS(k,:) = mean(T(I,:));
            elseif length(I) ==1
                CENTROIDS(k,:) = T(I,:);
            end
        end
        % Stop Condition
        if norm(PrevCENTROIDS-CENTROIDS) < 1e-6
            loop = 0;
        end
        scatter(T(:,1),T(:,2),'r','filled'), hold on, grid minor,axis([-0.2 1.2 -0.2 1.2])
        scatter(CENTROIDS(:,1),CENTROIDS(:,2),'k','filled')
        title({['Number Of Cluster :',num2str(K)];['Number Of Ýteration :',num2str(iteration)]})
        for j = 1:size(CENTROIDS,1)
            xc = CENTROIDS(j,1);
            yc = CENTROIDS(j,2);
            r = 0.15;
            x = r*sin(-pi:0.01*pi:pi) + xc;
            y = r*cos(-pi:0.01*pi:pi) + yc;
            fill(x, y, c(j,:), 'FaceAlpha', 0.2)
        end
        pause(0.5)
    end
    if K == 1
    else
      temp = pdist2(CENTROIDS,CENTROIDS);
       if min(temp(temp>0)) < 0.2
           loop2 = 0;
           fprintf(['Best Number Of Cluster : ',num2str(K-1)])
       end
    end
end





