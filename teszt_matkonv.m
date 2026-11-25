% TESZT_MATKONV A negy sajat fuggveny helyessegenek ellenorzese.
% A szkript ismert peldakat, peremeseteket es veletlen jeleket tesztel.
% A beepitett conv fuggvenyt csak referenciakent hasznaljuk.

clear;
close all;
rng(2026);

% 1. pelda teszt
x = [1 2 -1];
h = [1 1 1 1];
elvart = [1 3 2 2 1 -1];

y = matkonv(x, h);

elso_ok = isequal(y, elvart);

% 2. peremeset vizsgalatok
perem_ok = true;

% kommutativitas vizsgalat
if ~isequal(matkonv(x, h), matkonv(h, x))
    perem_ok = false;
end

% Oszlopvektor bemenetek
if ~isequal(matkonv(x.', h), elvart)
    perem_ok = false;
end

if ~isequal(matkonv(x, h.'), elvart)
    perem_ok = false;
end

if ~isequal(matkonv(x.', h.'), elvart)
    perem_ok = false;
end

% Egymintas jelek
if ~isequal(matkonv(2, 2), 4)
    perem_ok = false;
end

% Egysegimpulzus
if ~isequal(matkonv(1, [1 2 3]), [1 2 3])
    perem_ok = false;
end

% 3. veletlen 1000 proba
legnagyobb_hiba = 0;
veletlen_ok = true;

for k = 1:1000

    % jelhosszok
    Lx = randi([1 200]);
    Lh = randi([1 200]);

    % szamvektorok
    xv = randn(1, Lx);
    hv = randn(1, Lh);

    % komplex jelek
    if mod(k, 2) == 0
        xv = xv + 1i * randn(1, Lx);
        hv = hv + 1i * randn(1, Lh);
    end

    % sajat+beepitett konvolucio
    y = matkonv(xv, hv);
    yref = conv(xv, hv);

    relativ_hiba = max(abs(y - yref)) / max(abs(yref));

    if relativ_hiba > legnagyobb_hiba
        legnagyobb_hiba = relativ_hiba;
    end

    if ~(relativ_hiba < 1e-12)
        veletlen_ok = false;
    end
end


% 4. matkonv_idx ellenorzes
x = [1 2 3];
nx = [0 1 2];

h = [1 1 1] / 3;
nh = -1:1;

[y, ny] = matkonv_idx(x, nx, h, nh);

index_ok = isequal(ny, -1:3);

% abrazolas
figure;
stem(ny, y);
title('Harompontos nem kauzalis mozgoatlag');
xlabel('Idoindex (n)');
ylabel('Kimeneti jel erteke');
grid on;


% 5. sparse ellenorzes
otos_ok = true;

for k = 1:20
    % jelhosszok
    L = randi([1 200]);
    Lh = randi([1 200]);
    
    % szamvektor
    h = randn(1, Lh);

    H1 = konvmatrix(h, L);
    H2 = konvmatrix_sparse(h, L);

    if ~issparse(H2)
        otos_ok = false;
    end

    if ~isequal(H1, full(H2))
        otos_ok = false;
    end

end


% 6. Teszteredmenyek osszesitese

tesztnevek = {'Pelda', 'Peremesetek','1000 veletlen teszt','Idoindexek','Sparse matrixok'};

teszteredmenyek = [elso_ok, perem_ok, veletlen_ok, index_ok, otos_ok];

fprintf('Teszteredmenyek\n');

for i = 1:length(teszteredmenyek)
    if teszteredmenyek(i)
        fprintf('%s: SIKERES\n', tesztnevek{i});
    else
        fprintf('%s: SIKERTELEN\n', tesztnevek{i});
    end
end

fprintf('Legnagyobb relativ hiba: %.3e\n', legnagyobb_hiba);
