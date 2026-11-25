% KONVMATRIX_SPARSE Ritka konvolucios matrix letrehozasa.
% Bemenet: h - valos vagy komplex vektor, L - pozitiv egesz szam.
% Kimenet: H - L x (L+length(h)-1) meretu sparse matrix.
% Pelda: H = konvmatrix_sparse([1 2 3], 4);

function H = konvmatrix_sparse(h, L)
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
    
    % L ellenorzese
    if ~isnumeric(L) || ~isscalar(L) || ~isreal(L) || ~isfinite(L)
        error('L valos veges szam kell legyen!');
    end
    if L < 1 || L ~= floor(L)
        error('L pozitiv egesz szam kell legyen!');
    end
    
    % h sorvektorra alakitasa
    h = h(:).';
    
    % A matrix mereteinek meghatarozasa
    Lh = length(h);
    Ly = L + Lh - 1;
    
    % Az elemek sorindexeinek letrehozasa
    sorok = repelem(1:L, Lh);
    
    % Az elemek oszlopindexeinek letrehozasa
    eltolasok = repmat(0:Lh-1, 1, L);
    oszlopok = sorok + eltolasok;
    
    % Az elemek ertekeinek letrehozasa
    ertekek = repmat(h, 1, L);
    
    %pl.: {h=[1 2 3] , L=3} --> Lh=3 

    %eltolasok =    [0 1 2 0 1 2 0 1 2]
    %sorok =        [1 1 1 2 2 2 3 3 3]
    %oszlopok =     [1 2 3 2 3 4 3 4 5]
    %ertekek =      [1 2 3 1 2 3 1 2 3] 

    % sparse konvolucios matrix
    H = sparse(sorok, oszlopok, ertekek, L, Ly);
    
end
