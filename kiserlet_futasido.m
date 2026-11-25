% KISERLET_FUTASIDO 
% A negy konvolucios modszer osszehasonlitasa.
% Futasidok es memoriahasznalat merese.

clear;
close all;
rng(2026);

Lh = 31;
h = randn(1, Lh);
Lx_ertekek = [256 512 1024 2048 4096 8192 16384 32768 65536]; %1. 2. 4.-hez
Lx_teljes = [256 512 1024 2048 4096]; %3.hoz

% futasidok nullavektorok
ido_conv = zeros(1, length(Lx_ertekek));
ido_matkonv = zeros(1, length(Lx_ertekek));
ido_ritka = zeros(1, length(Lx_ertekek));

ido_teljes = zeros(1, length(Lx_teljes));

% Futasidok
for k = 1:length(Lx_ertekek)

    Lx = Lx_ertekek(k);
    x = randn(1, Lx);

    % 1. conv
    f = @() conv(x, h);
    ido_conv(k) = timeit(f);

    % 2. matkonv
    f = @() matkonv(x, h);
    ido_matkonv(k) = timeit(f);

    % 3. teljes matrix h-bol
    if k <= length(Lx_teljes)
        f = @() x * konvmatrix(h, Lx);
        ido_teljes(k) = timeit(f);
    end

    % 4. ritka matrix h-bol
    f = @() x * konvmatrix_sparse(h, Lx);
    ido_ritka(k) = timeit(f);

end


% Futasidok abrazolasa
figure;

loglog(Lx_ertekek, ido_conv, '-');
hold on;

loglog(Lx_ertekek, ido_matkonv, '-');
loglog(Lx_teljes, ido_teljes, '-');
loglog(Lx_ertekek, ido_ritka, '-');

legend('conv', 'matkonv', 'teljes matrix h-bol', 'ritka matrix h-bol');

xlabel('Bemeneti jel hossza [minta]');
ylabel('Futasido [s]');
title('Konvolucios modszerek futasideje');

grid on;
hold off;

% Memoriahasznalat  Lx = 2^12 eseten
Lx_mem = 2^12;
x_mem = randn(1, Lx_mem);

% A harom matrix letrehozasa
H_opt = konvmatrix(x_mem, Lh);
H_teljes = konvmatrix(h, Lx_mem);
H_ritka = konvmatrix_sparse(h, Lx_mem);

% Memoriaigenyek lekerdezese
adat_opt = whos('H_opt');
adat_teljes = whos('H_teljes');
adat_ritka = whos('H_ritka');

% Eredmenyek kiirasa
fprintf('Memoriahasznalat Lx=2^12 eseten\n');

fprintf('Optimalizalt: %d byte (%.2f MiB)\n', adat_opt.bytes, adat_opt.bytes / 2^20);

fprintf('Teljes matrix: %d byte (%.2f MiB)\n', adat_teljes.bytes, adat_teljes.bytes / 2^20);

fprintf('Sparse matrix: %d byte (%.2f MiB)\n', adat_ritka.bytes, adat_ritka.bytes / 2^20);


% Lx = 2^16 teljes matrix memoriaigenye csak becsles

Lx_nagy = 2^16;
Ly_nagy = Lx_nagy + Lh - 1;

byte_becsles = Lx_nagy * Ly_nagy * 8;

fprintf('Lx = 2^16 becsult memoriaigeny: %.2f GiB\n', byte_becsles / 2^30);



% Futasidok kiirasa
fprintf('Futasidok\n');

% 1. 2. 4.
fprintf('%-10s %-15s %-15s %-15s\n','Lx', 'conv', 'matkonv', 'ritka');

for k = 1:length(Lx_ertekek)
    fprintf('%-10d %-15.3e %-15.3e %-15.3e\n', Lx_ertekek(k), ido_conv(k),ido_matkonv(k), ido_ritka(k));
end

% 3.
fprintf('\nTeljes matrix h-bol:\n');
fprintf('%-10s %-15s\n', 'Lx', 'futasido');

for k = 1:length(Lx_teljes)
    fprintf('%-10d %-15.3e\n', Lx_teljes(k), ido_teljes(k));
end