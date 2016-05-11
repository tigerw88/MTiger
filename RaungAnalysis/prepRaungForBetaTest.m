%% prepRaungForBetaTest

    % Load example vinfo, params, and inputFiles files for example
% I did this for Augustine

    % Copy those files for Raung
RaungInfo = vinfo;
RaungParams = params;
RaungInputFiles = inputFiles;
    % Change files to match Raung
RaungInfo.name = 'Raung';
RaungParams.volcanoes = 'Raung';

%% 

eruption_windows = [];
makeRaungCatalog % beta_catalog => is created in makeRaungCatalog
baddata = [];
good_window = [datenum('2010/01/01') datenum('2015/12/31')];

%% Do the beta test

Raung.beta_output = run_betas(beta_catalog.DateTime, good_window, RaungParams.ndays_all, 'all', RaungParams.it, RaungParams.be_thresPer);

%% Figures

dates = datenum('2010/01/01'):100:datenum('2015/01/01');
DateTime = datetime(datestr(dates));


figure(1)
plot(Tanggal, VulkanikB, 'k-');
hold on;
plot(Tanggal, VulkanikA, 'b-');
plot(Tanggal, TektonikLokal, 'b:');
plot(Tanggal, Hembusan, 'g-');
plot(Tanggal, Tremor, 'r-');
hold on; plot(DateTime, nan(size(DateTime)))

figure(2); betaPlot5('Raung', Raung.beta_output, eruption_windows, baddata)
hold on; plot(DateTime, nan(size(DateTime)))
