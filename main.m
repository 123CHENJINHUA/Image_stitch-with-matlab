clear, clc, close all
% Preparation
run('vl_setup'); % run once

im1 = imread('cu1.JPG');
im2 = imread('cu2.JPG');

im1 = imresize(im1, 0.5); im1 = rgb2gray(im1); im1 = single(im1);
im2 = imresize(im2, 0.5); im2 = rgb2gray(im2); im2 = single(im2);

[k1,d1] = vl_sift(im1); % k is a 4 (x,y,sigma, theta) x num_features
[k2,d2] = vl_sift(im2); % d is a 128 x num_features

[matches,scores] = match_descriptor(k1,k2,d1,d2);
[bestH, num_of_inliners] = RANSAC ( k1, k2, matches);
stitchedImage = Stitch(im1, im2, bestH);
[x,y]=find(stitchedImage);
x1=min(y);x2=max(y);y1=min(x);y2=max(x);
stitchedImage_crop=imcrop(stitchedImage,[x1,y1,x2-x1,y2-y1]);
imshow(stitchedImage_crop,[]);
