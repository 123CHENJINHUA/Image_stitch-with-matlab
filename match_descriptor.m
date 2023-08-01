function [matches,scores] = match_descriptor(k1,k2,d1,d2)
% Find SIFT Features and Descriptors
thresh = 1.5;
Num_of_matches =1;
temp = zeros(2,size(k2,2)); scores = zeros(1,size(k1,2)); matches = zeros(2,size(k1,2));
for i=1 : size(k1,2)
    for j = 1 : size(k2,2)
        temp(1 , j) = j;
        temp(2 , j) = norm(double(d1(:,i)-d2(:,j)),2);
    end
    sorted = transpose(sortrows(transpose(temp),2));
    min1 = sorted(:,1);
    min2 = sorted(:,2);
    NNDR=min2(2,:) / min1(2,:);
    if NNDR>thresh
        matches(1,Num_of_matches)=i;
        matches(2,Num_of_matches)=min1(1,1);
        scores(1,Num_of_matches)=min1(2,1);
        Num_of_matches=Num_of_matches+1;
    end
end
matches(:,Num_of_matches:end)=[];
scores(:,Num_of_matches:end)=[];
end