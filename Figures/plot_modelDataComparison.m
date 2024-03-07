figure
plot(tsc.airTenVecs.mag.Time(startI:endI), squeeze(tsc.airTenVecs.mag.Data(startI:endI)))
hold on
plot(tscMod.tension.Time-tscMod.tension.Time(1)+0, tscMod.tension.Data/2)
title('Fowler flap - 130% chord, 4 deg. camber - 7 deg. elev.')
grid on
xlabel('Time (s)')
ylabel('Tether tension magnitude (N)')
legend('Simulation', 'Experimental Data')