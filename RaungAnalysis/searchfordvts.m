%% search for dvts

% wday -> a waveform of 1 day of data
% E -> a structure of four events; the sceond waveform for each event is
% the KBUR station

template1 = E(1).w(2); template1d = get(extract(template1,'Index', 890, 1175),'data');
template2 = E(2).w(2); template2d = get(extract(template2,'Index', 800, 1300),'data');
template3 = E(3).w(2); template3d = get(extract(template3,'Index', 900, 1300),'data');
template4 = E(4).w(2); template4d = get(extract(template4,'Index', 890, 1250),'data');

figure;
subplot(411), plot(template1d)
subplot(412), plot(template2d)
subplot(413), plot(template3d)
subplot(414), plot(template4d)

dayd = get(wday,'data');

d1 = template1d; d2 = dayd; [r, lags] = xcorr(d1/max(d1),d2/max(d2)); figure; subplot(211), plot(lags, r), subplot(212), plot(d1), hold on, plot(d2,'k'); r1 = r; lags1 = lags;
d1 = template2d; d2 = dayd; [r, lags] = xcorr(d1/max(d1),d2/max(d2)); figure; subplot(211), plot(lags, r), subplot(212), plot(d1), hold on, plot(d2,'k'); r2 = r; lags2 = lags;
d1 = template3d; d2 = dayd; [r, lags] = xcorr(d1/max(d1),d2/max(d2)); figure; subplot(211), plot(lags, r), subplot(212), plot(d1), hold on, plot(d2,'k'); r3 = r; lags3 = lags;
d1 = template4d; d2 = dayd; [r, lags] = xcorr(d1/max(d1),d2/max(d2)); figure; subplot(211), plot(lags, r), subplot(212), plot(d1), hold on, plot(d2,'k'); r4 = r; lags4 = lags;

rmat = [r1 r2 r3 r4];
% rmax = max(rmat');
rmax = max(r3);

match_id = find(rmax>15);



figure;
subplot(211)
plot(lags1, rmax, 'b'), hold on
plot(lags1(match_id),rmax(match_id), 'or')

subplot(212)
plot(dayd,'k')



