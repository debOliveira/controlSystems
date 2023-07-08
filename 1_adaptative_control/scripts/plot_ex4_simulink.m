figure()
plot(out.simout.Time,out.simout.Data(:,1),...
    "Color",lineStyles(1,:),"LineWidth",1.5); hold on;
plot(out.simout.Time,out.simout.Data(:,2),...
    "Color",lineStyles(2,:),"LineWidth",1.5); grid;
legend("With inversion", "Without inversion", "Location", "southeast")
title("Time step response with and without non-linear inversion")
xlabel("Time (s)"); ylabel("y")