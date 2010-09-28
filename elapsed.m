function str_elapsed = elapsed(t)
%takes a time t and converts it into hours, minutes, seconds.
% param t is in seconds
% return str_elapsed says "Time Elapsed is 6 seconds, 4 minutes, ..."
if t > 1
str_elapsed = ['Time Elapsed is ', seconds2human(t)];
else
str_elapsed = ['Time Elapsed is ', num2str(t), ' seconds'];
end;