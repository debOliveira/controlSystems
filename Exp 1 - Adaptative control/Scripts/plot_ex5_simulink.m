figure()
plot(out.constant.Time,out.constant.Data(:,1),...
    "Color",lineStyles(1,:),"LineWidth",1.5); hold on;
plot(out.constant.Time,out.constant.Data(:,2),...
    "Color",lineStyles(2,:),"LineWidth",1.5); 
plot(out.constant.Time,out.constant.Data(:,3),...
    "Color",lineStyles(3,:),"LineWidth",1.5);grid;
legend("$q=0.5$","$q=1.0$","$q=2.0$",...
    "Interpreter","Latex","Location", "southeast")
title("Time step response with constant flow")
xlabel("Time (s)"); ylabel("y")