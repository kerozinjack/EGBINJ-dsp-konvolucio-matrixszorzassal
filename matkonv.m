% MATKONV Ket vektor konvolucioja matrixszorzassal.
% Bemenet: x, h - valos vagy komplex vektorok.
% Kimenet: y - a konvolucio eredmenye (sorvektor).
% Pelda: y = matkonv([1 2 3], [1 1]);

function y = matkonv(x, h)
    % x ellenorzese
    if isempty(x)
        error('Az x vektor nem lehet ures!');
    end
    if ~isvector(x)
        error('Az x bemenetnek vektornak kell lennie!');
    end
    if ~isnumeric(x)
        error('Az x bemenetnek szamvektornak kell lennie!');
    end
    
    % h ellenorzese
    if isempty(h)
        error('A h vektor nem lehet ures!');
    end
    if ~isvector(h)
        error('A h bemenetnek vektornak kell lennie!');
    end
    if ~isnumeric(h)
        error('A h bemenetnek szamvektornak kell lennie!');
    end

    % hosszabb jelbol konvmatrix
    if length(x) >= length(h)
        H = konvmatrix(x, length(h));
        rovidebb = h(:).';
    else
        H = konvmatrix(h, length(x));
        rovidebb = x(:).';
    end

    % konvolucio
    y = rovidebb * H;
end
