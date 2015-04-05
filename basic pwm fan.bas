Dirs = %00000100
symbol hours = b6
symbol minutes = b7

low 2
disablebod

' sit for 10 seconds so if in brownout state we crash here instead of leaving the fan running
pause 10000

start:
' run at full throttle to make sure the fan spins up
high 2
pause 5000

' run at full for 20 minutes
let minutes = 20
gosub delayminutes

main:
' run at 80% duty cycle after that
pwmout 2, 62, 200			' 0.8 * 250 = 200 ~= 80% duty cycle

' for ~2 hours (2 hours total)
let hours = 2
gosub delayhours

' then off for an hour (3 hours total)
low 2
let hours = 1
gosub delayhours

' and on for 2 hours at 80% (5 hours total)
pwmout 2, 62, 200			' 0.8 * 250 = 200 ~= 80% duty cycle
let hours = 2
gosub delayhours

' then off for an hour (6 hours total)
low 2
let hours = 1
gosub delayhours

' and on for 2 hours at 80% (8 hours total)
pwmout 2, 62, 200			' 0.8 * 250 = 200 ~= 80% duty cycle
let hours = 2
gosub delayhours

' and off
low 2
end

delayhours:
for b0 = 1 to hours		' b6 hours
  for b1 = 1 to 60		' 60 = 1 hour
    pause 60000
  next b1
next b0
return

delayminutes:
for b1 = 1 to minutes		' b7 minutes
  pause 60000
next b1
return