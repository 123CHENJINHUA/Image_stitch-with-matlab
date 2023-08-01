function stitchedImage = Stitch(im1, im2, bestHomography)
stitchedImage = im1;
stitchedImage = padarray(stitchedImage, [0 size(im2, 2)], 0, 'post');
stitchedImage = padarray(stitchedImage, [size(im2, 1) 0], 0, 'both');
for i=1:size(stitchedImage, 2)
    for j=1:size(stitchedImage, 1)
        p2 = bestHomography * [i; j-size(im2, 1); 1];
        p2 = p2 ./ p2(3);
        x2 = round(p2(1));
        y2 = round(p2(2));
        if x2 > 0 && x2 <= size(im2, 2) && y2 > 0 && y2 <= size(im2, 1)
            if (im2(y2, x2)>stitchedImage(j, i))         
                stitchedImage(j, i) = im2(y2, x2);
            end
        end
    end
end
end