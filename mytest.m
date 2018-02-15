function [row,column] = mytest ( bigImage,smallImage)
big = rgb2gray(bigImage);
small = rgb2gray(smallImage);
bigSize = size(big);
brow = bigSize(1);
bcol = bigSize(2);
smallSize = size(small);
srow = smallSize(1);
scol = smallSize(2);
factor = 0;
if(bigSize(1)*bigSize(2)<300000)
    factor = 8;
elseif(bigSize(1)*bigSize(2)<500000)
    factor = 12;
elseif(bigSize(1)*bigSize(2)<1000000)
    factor = 18;
elseif(bigSize(1)*bigSize(2)<3000000)
    factor = 25;
elseif(bigSize(1)*bigSize(2)<5000000)
    factor = 30;
end

sreduced = small(1:factor:srow,1:factor:scol);
for row = (1:brow-srow)
    for column = (1:bcol-scol)
        croppedImage = big(row:factor:row+srow-1,column:factor:column+scol-1);
        if (croppedImage == sreduced)
            %code to verify
%             if(smallImage~=bigImage(row:row+srow-1,column:column+scol-1,:))
%                 disp('case not equal found');
%                 break;
%             end
            return;
        end
    end
end

end
