big = imread('big.png');
small = imread('small.png');
bigSize = size(big);
brow = bigSize(1);
bcol = bigSize(2);

smallSize = size(small);
srow = smallSize(1);
scol = smallSize(2);

tic;
for row = (1:brow-srow)
    for column = (1:bcol-scol)
        croppedImage = big(row:row+srow-1,column:column+scol-1,:);
        if ((croppedImage - small) == 0)
            disp('Verified');
            x=row;
            y=column;
            toc;
            return;
        end
        
    end
end

imshow(croppedImage);
