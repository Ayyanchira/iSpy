function [row,column] = i_spy (smallImage,bigImage,x)
big = rgb2gray(bigImage);
small = rgb2gray(smallImage);

imshow(big);
figure;
imshow(small);
close all;
intensity = small(1,1)+1;
xlocations = [];
ylocations = [];
xlocations = [xlocations,x(intensity).rowVal];
ylocations = [ylocations,x(intensity).colVal];

bigSize = size(big);
brow = bigSize(1);
bcol = bigSize(2);
smallSize = size(small);
srow = smallSize(1);
scol = smallSize(2);

%deciding factor...
smallImagearea = srow*scol;
squareroot = int8(sqrt(smallImagearea));
factor = double(floor(squareroot/4));

sreduced = small(1:factor:srow,1:factor:scol);
for i = 1:numel(xlocations)
    if(xlocations(i)<(brow-srow)&&ylocations(i)<(bcol-scol))
        newReducedImage = big(xlocations(i):factor:xlocations(i)+srow-1,ylocations(i):factor:ylocations(i)+scol-1);
        if(newReducedImage == sreduced)
            row = xlocations(i);
            column = ylocations(i);
            return ;
        end
    end
end

end
