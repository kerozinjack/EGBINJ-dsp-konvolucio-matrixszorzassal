% KONVMATRIX Teljes konvolucios matrix letrehozasa.
% Bemenet: h - valos vagy komplex vektor, L - pozitiv egesz szam.
% Kimenet: H - L x (L+length(h)-1) meretu teljes matrix.
% Pelda: H = konvmatrix([1 2 3], 4);

function H = konvmatrix(h, L)
    % h szamvektor ellenorzes
    if isempty(h)
        error('A h vektor nem lehet ures!');
    end
    if ~isvector(h)
        error('A h bemenetnek vektornak kell lennie!');
    end
    if ~isnumeric(h)
        error('A h bemenetnek szamvektornak kell lennie!');
    end

    % L valos egesz szam ellenorzes
    if ~isnumeric(L) || ~isscalar(L) || ~isreal(L) || ~isfinite(L) 
        error('L valos veges szam kell legyen!');
    end
    if L<1 || L~=floor(L) 
        error('L pozitív egesz szam kell legyen!');
    end

    % sorvektorra alakitas
    h = h(:).';
    % matrix meretek
    Lh = length(h);
    Ly = L + Lh - 1;
    % nullamatrix
    H = zeros(L, Ly);

    % H<=h i sorba i oszloptol kezdve
    for i = 1:L               
        kezdet = i;
        veg = i + Lh - 1;
        H(i, kezdet:veg) = h;   
    end                         
end
