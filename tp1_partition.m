%exo1
[x,Fs] = audioread('furElise_TP.wav');
soundsc(x,Fs); %listen to the mucis echantille

N = size(x);
temps = 0:1/Fs:(N-1)/Fs;
figure; plot(temps, x)

%exo2
Nf= 2^18;
X = fft(x,Nf);
freq = 0:Fs/Nf:(Nf-1)*Fs/Nf;
figure; plot(freq,abs(X))

t0 = 0.1;
L100 = round(t0*Fs);
y = x(1:L100); %cut the first 100ms
Y = fft(y,Nf);
figure; plot(freq, abs(Y))

%exo3
Nf2 = 2^12;
freq = 0:Fs/Nf2:(Nf2-1)*Fs/Nf2;
S = zeros(Nf2, N(1)-L100);
for k = 1:N(1)-L100
    z = x(k:k+L100);
    Z = fft(z,Nf2);
    S(:, k)=abs(Z).^2;
end
figure; imagesc(temps,freq,log10(S)); 
axis xy; 
colorbar
hold on

%exo4
load('notes.mat');
find = zeros(N(1)-L100, 1);
for k = 1:N(1)-L100
    z = x(k:k+L100); %cut chain of 100ms
    Z = fft(z,Nf2);
    [max1, index1] = max(abs(Z)); %find max freq and index
    fmax = freq(index1);
    [min2, index2] = min(abs(notes - fmax)); %find matched
    find(k) = notes(index2);
end

plot( temps(1:N-L100) , find)


