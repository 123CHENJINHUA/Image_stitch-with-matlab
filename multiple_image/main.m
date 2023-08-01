clear, clc, close all
% Preparation
run('vl_setup'); % run once

im3 = imread('n1.JPG');
im1 = imread('n2.JPG');
im2 = imread('n3.JPG');

im1 = imresize(im1, 0.5); im1 = rgb2gray(im1); im1 = single(im1);
im2 = imresize(im2, 0.5); im2 = rgb2gray(im2); im2 = single(im2);
im3 = imresize(im3, 0.5); im3 = rgb2gray(im3); im3 = single(im3);

[k1,d1] = vl_sift(im1); % k is a 4 (x,y,sigma, theta) x num_features
[k2,d2] = vl_sift(im2); % d is a 128 x num_features
[k3,d3] = vl_sift(im3);

[matches1,scores1] = match_descriptor(k1,k2,d1,d2);
[matches2,scores2] = match_descriptor(k1,k3,d1,d3);
[bestH1, num_of_inliners1] = RANSAC ( k1, k2, matches1);
[bestH2, num_of_inliners2] = RANSAC ( k1, k3, matches2);
stitchedImage = main_multiple_images(im1, im2,im3, bestH1,bestH2);
[x,y]=find(stitchedImage);
x1=min(y);x2=max(y);y1=min(x);y2=max(x);
stitchedImage_crop=imcrop(stitchedImage,[x1,y1,x2-x1,y2-y1]);
imshow(stitchedImage_crop,[]);
