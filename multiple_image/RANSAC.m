function [bestH, num_of_inliners] = RANSAC ( k1, k2, matches)
num_Iteration=100;
max_inliner=0;
for interation=1:num_Iteration
Pixel_Error=3;
inliner=0;
numMatches = size(matches, 2); numPts = 4;
randSample = randperm(numMatches, numPts);
d1Ind_pt1 = matches(1, randSample(1));
d2Ind_pt1 = matches(2, randSample(1));
d1Ind_pt2 = matches(1, randSample(2));
d2Ind_pt2 = matches(2, randSample(2));
d1Ind_pt3 = matches(1, randSample(3));
d2Ind_pt3 = matches(2, randSample(3));
d1Ind_pt4 = matches(1, randSample(4));
d2Ind_pt4 = matches(2, randSample(4));
H = FindHomography(k1(1, d1Ind_pt1), k1(2, d1Ind_pt1), k1(1, d1Ind_pt2), k1(2, d1Ind_pt2), k1(1, d1Ind_pt3), k1(2, d1Ind_pt3), k1(1, d1Ind_pt4), k1(2, d1Ind_pt4), ...
    k2(1, d2Ind_pt1), k2(2, d2Ind_pt1), k2(1, d2Ind_pt2), k2(2, d2Ind_pt2), k2(1, d2Ind_pt3), k2(2, d2Ind_pt3), k2(1, d2Ind_pt4), k2(2, d2Ind_pt4));
% warp pts
for matchIndex = 1:size(matches, 2)
    d1Ind = matches(1, matchIndex);
    d2Ind  = matches(2, matchIndex);
    X1 = k1(1, d1Ind); Y1 = k1(2, d1Ind);
    X2  = k2(1, d2Ind); Y2  = k2(2, d2Ind);

    P1 = [X1; Y1; 1];
    P2  = [X2; Y2; 1];

    P11 = H*P1;
    P11 = P11 ./ P11(3);
    err = norm((P11 - P2),2);
    if err<Pixel_Error
        inliner=inliner+1;
    end
    if inliner>max_inliner
        max_inliner=inliner;
        bestH=H;
        num_of_inliners=max_inliner;
    end
end
end
end