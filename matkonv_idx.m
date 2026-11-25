% MATKONV_IDX Konvolucio idoindexekkel.
% Bemenet: x, h - jelek; nx, nh - egyesevel novekvo egesz indexek.
% Kimenet: y - konvolucio eredmenye; ny - kimeneti idoindexek.
% Pelda: [y, ny] = matkonv_idx([1 2 3], 0:2, [1 1], -1:0);

function [y, ny] = matkonv_idx(x, nx, h, nh)
    % nx ellenorzese
    if isempty(nx)
        error('Az nx vektor nem lehet ures!');
    end
    if ~isvector(nx)
        error('Az nx bemenetnek vektornak kell lennie!');
    end
    if ~isnumeric(nx)
        error('Az nx bemenetnek szamvektornak kell lennie!');
    end
    % nh ellenorzese
    if isempty(nh)
        error('Az nh vektor nem lehet ures!');
    end
    if ~isvector(nh)
        error('Az nh bemenetnek vektornak kell lennie!');
    end
    if ~isnumeric(nh)
        error('Az nh bemenetnek szamvektornak kell lennie!');
    end

    % indexvektorok sorvektorokka alakitasa
    nx = nx(:).';
    nh = nh(:).';

    % minden mintahoz pontosan egy idoindex
    if length(nx) ~= length(x)
        error('Az nx es x hosszanak egyeznie kell!');
    end
    
    if length(nh) ~= length(h)
        error('Az nh es h hosszanak egyeznie kell!');
    end
    
    if ~isreal(nx) || ~isreal(nh)
        error('Az indexeknek valos szamoknak kell lenniuk!');
    end
    

    % nx indexeinek ellenorzese
    for i = 1:length(nx)
        if ~isfinite(nx(i))
            error('Az nx indexei csak veges szamok lehetnek!');
        end

        if nx(i) ~= floor(nx(i))
            error('Az nx indexei csak egesz szamok lehetnek!');
        end

        if i > 1
            if nx(i) - nx(i-1) ~= 1
                error('Az nx indexei egyesevel novekedjenek!');
            end
        end
    end

    % nh indexeinek ellenorzese
    for i = 1:length(nh)
        if ~isfinite(nh(i))
            error('Az nh indexei csak veges szamok lehetnek!');
        end

        if nh(i) ~= floor(nh(i))
            error('Az nh indexei csak egesz szamok lehetnek!');
        end

        if i > 1
            if nh(i) - nh(i-1) ~= 1
                error('Az nh indexei egyesevel novekedjenek!');
            end
        end
    end
    
    % konvolucio
    y = matkonv(x, h);

    % idoindexvektor
    kezdet = nx(1) + nh(1);
    veg = kezdet + length(y) - 1;
    ny = kezdet:veg;

end
