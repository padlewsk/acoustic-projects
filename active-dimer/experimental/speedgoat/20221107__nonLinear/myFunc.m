function [y1,y2] = myFunc(x1, x2)

    if ~exist('x1', 'var') || isempty(x1)
        x1 = 0;
    end

    if ~exist('x2', 'var') || isempty(x2)
        x2 = 3;
    end

    y1 = x1+x2;
    y2 = x1-x2;

end