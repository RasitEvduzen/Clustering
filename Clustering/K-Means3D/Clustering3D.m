clc,close all,clear all
% Written By: Rasit Evduzen
% 17-Jul-2024
% K-Means Clustering
%% Create Data
rng(1); % fixed seed
data = [randn(100, 3)+1;randn(100, 3)-1;randn(100, 3)+[5, 5, 0]];


numClusters = 3;  % Number of Cluster
maxIter = 100;    % MaxIter
initialCenters = data(randperm(size(data, 1), numClusters), :);
centers = initialCenters;

figure('units', 'normalized', 'outerposition', [0 0 1 1], 'color', 'w')
for iter = 1:maxIter
    distances = pdist2(data, centers);
    [~, idx] = min(distances, [], 2);

    newCenters = zeros(numClusters, size(data, 2));
    for k = 1:numClusters
        newCenters(k, :) = mean(data(idx == k, :), 1);
    end

    clusterCenters = centers(:, 1:2);
    clusterWidths = zeros(numClusters, 1);

    for i = 1:numClusters
        clusterData = data(idx == i, :);
        clusterWidths(i) = std(clusterData(:, 3));
    end
    
    clf
    subplot(121)
    hold on;view(45,20)
    scatter3(data(:, 1), data(:, 2), data(:, 3), 10, idx, 'filled', 'LineWidth', 5);
    scatter3(centers(:, 1), centers(:, 2), centers(:, 3), 100, 'kx', 'LineWidth', 3);
    title('KMeans in 3D'),xlabel('X'),ylabel('Y'),zlabel('Z'),grid on,axis equal;

    subplot(122);
    hold on;
    scatter(data(:, 1), data(:, 2), 10, idx, 'filled', 'LineWidth', 5);
    scatter(centers(:, 1), centers(:, 2), 100, 'kx', 'LineWidth', 3);
    theta = linspace(0, 2*pi, 100);
    for i = 1:numClusters
        xCenter = clusterCenters(i, 1);
        yCenter = clusterCenters(i, 2);
        radius = clusterWidths(i);
        xCircle = xCenter + radius * cos(theta);
        yCircle = yCenter + radius * sin(theta);
        plot(xCircle, yCircle, 'k--', 'LineWidth', 1.5);
    end
    title('K Means Clustering in X-Y Plane Projection'),xlabel('X'),ylabel('Y'),grid on,axis equal;
    drawnow

    if max(max(abs(newCenters - centers))) < 1e-6
        break;
    end
    centers = newCenters;
end
