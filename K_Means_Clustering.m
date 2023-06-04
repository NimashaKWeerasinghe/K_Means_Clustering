X=gen_kmeansdata(10749974); % Genarate Personal Data Matrix 

% Data Analysis

noOfRows = height(X) % Returns Total number of Rows/ Objects 
noOfFeatures = width(X) % Returns Total number of Features/ Columns
meanOfColumns = mean(X) % Returns Mean value for each column 
stdOfColumns = std(X) % std(X,0,1); % Returns Standard Deviation for each column
histogram(X); % Histogram using histogram()
figure("Name","Histogram using hist()");
hist(X); % Histogram for each column using hist()

covarianceMatrix = cov(X) % Returns Covariance Matrix
correlationMatrix = corrcoef(X) % Returns Correlation Matrix

mean_silhArray = []; % Initilize array for mean Silhouette Values  
kArray = []; % Initilize array for k values


for k=3 : +1 : 5
    figure;
    [idx,C,sumd]=kmeans(X,k); % Create Clusters and Examine Separation
    disp(C); 
   
     % Evaluate the Cluster Quality using Silhouette
    [silh,h]= silhouette(X,idx,'sqEuclidean');
    title(['Number of clusters =' int2str(k)]);
    xlabel 'Silhouette Value';
    ylabel 'Cluster';
    
    mean_silh = mean(silh); % Calculate Mean value for Sihouette
    mean_silhArray(end+1) = mean_silh; %Append the Mean Sihouette values of each iteration into array
    kArray(end+1) = k; %Append the k values of each iteration into array
  
    % Plot the clusters and the cluster centroids
    figure ;
    gscatter(X(:,1),X(:,2),idx,'bgmyr')
    hold on
    plot(C(:,1),C(:,2),'kx','MarkerSize',8,'LineWidth',2)
    if k == 3
      legend('Cluster 1','Cluster 2','Cluster 3','Cluster Centroid')
    elseif k == 4
      legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Cluster Centroid')
    else
      legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Cluster 5','Cluster Centroid')
    end
end

maxMeanSih = max(mean_silhArray); % Find best Mean Sihouette value
clusterDic = dictionary(mean_silhArray,kArray); % Insert Mean Sihouette values and k values into dictionary
bestNumberOfClusters = clusterDic(maxMeanSih) % Find k value of best Mean Sihouette value

