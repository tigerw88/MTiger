function magnitude = duration2magnitude( duration )

magnitude = 2.65 * log10(duration) - 2.45; % Pacific Northwest
% magnitude = 1.91 * log10(duration) - 1.45; % PVMBG

end