%% Make Raung RaungCatalog from Earthquake Counts

    % Load Excel data for daily earthquake counts at Raung
load('RaungGempaJumlah2010-2015.mat')

    % Initialize RaungCatalog
RaungCatalog.VulkanikA = [];
RaungCatalog.VulkanikB = [];
RaungCatalog.TektonikJauh = [];
RaungCatalog.TektonikLokal = [];
RaungCatalog.Tremor = [];
RaungCatalog.Hembusan = [];

    % convert daily counts to a RaungCatalog
for n = 1:length(Tanggal)
    
    RaungCatalog2.VulkanikA = [RaungCatalog.VulkanikA; repmat(Tanggal(n), [VulkanikA(n) 1])];
    RaungCatalog2.VulkanikB = [RaungCatalog.VulkanikB; repmat(Tanggal(n), [VulkanikB(n) 1])];
    RaungCatalog2.TektonikLokal = [RaungCatalog.TektonikLokal; repmat(Tanggal(n), [TektonikLokal(n) 1])];
    RaungCatalog.TektonikJauh = [RaungCatalog.TektonikJauh; repmat(Tanggal(n), [TektonikJauh(n) 1])];
    RaungCatalog.Tremor = [RaungCatalog.Tremor; repmat(Tanggal(n), [Tremor(n) 1])];
    RaungCatalog.Hembusan = [RaungCatalog.Hembusan; repmat(Tanggal(n), [Hembusan(n) 1])];

end

    % convert RaungCatalog to the equivalent of the jiggle RaungCatalog format that is used in the beta tests
beta_catalog.DateTime = RaungCatalog2.VulkanikB;

%% Plot Raung Events Per Day

figure;
eventax1 = subplot(311);
plot(Tanggal, TektonikJauh, ':', 'Color', [0.8 0.8 0.8], 'LineWidth', 2); hold on;
plot(Tanggal, Hembusan, '-', 'Color', [0 0 0.8], 'LineWidth', 2);
plot(Tanggal, Tremor, '-', 'Color', [0 0.8 0], 'LineWidth', 2);
plot(Tanggal, VulkanikB, '-', 'Color', [0.8 0.8 0], 'LineWidth', 2);
plot(Tanggal, TektonikLokal, '-', 'Color', [0.8 0.5 0], 'LineWidth', 2);
plot(Tanggal, VulkanikA, '-', 'Color', [1 0 0], 'LineWidth', 2);
plot(datetime(datestr(Tanggal(1))),NaN)
datetick('x','yyyy/mm/dd')
legend('Tektonik Jauh','Hembusan','Tremor','Vulkanik B','Tektonik Local','Vulkanik A','Location','northwest')
title('Raung - Daily Event Counts','FontSize',12)
ylabel('Daily Counts','FontSize',12,'FontWeight','bold')

eventax2 = subplot(312);
plot(Tanggal, TektonikJauh, ':', 'Color', [0.8 0.8 0.8], 'LineWidth', 2); hold on;
plot(Tanggal, Hembusan + Tremor + VulkanikB, '-', 'Color', [0 0 0.8], 'LineWidth', 2);
plot(Tanggal, TektonikLokal + VulkanikA, '-', 'Color', [0.8 0 0], 'LineWidth', 2);
% plot(datetime(datestr(Tanggal(1))),NaN)
datetick('x','yyyy/mm/dd')
legend('Tektonik Jauh','Lower Frequencies (Volcanic)','Higher Frequencies (Volcanic)','Location','northwest')
ylabel('Daily Counts','FontSize',12,'FontWeight','bold')

KBUR_rsam_plots
