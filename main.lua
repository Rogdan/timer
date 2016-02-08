--[[ Gotchas. Don't forget about it.
Timers run on system time. If the app is suspended, running timers will not be automatically paused,
meaning that when the app is resumed, all timers that would have completed/triggered during the suspended
period will trigger immediately. Thus, if you have running timers that are not paused (in code) upon
suspension of the app, you should handle this task by calling timer.pause() on all applicable timers.
--]]

local currentTime = 0;
local timeText = display.newText("00:00", display.contentCenterX, display.actualContentHeight/3, native.systemFont, 50);
local myTimer;
local startButton, stopButton, pauseButton;

local function initButtons()
	local height = display.actualContentHeight*2/3;
	local font = native.systemFont;
	local fontSize = 30;

	startButton = display.newText("Start", display.actualContentWidth/4, height, font, fontSize);
	stopButton = display.newText("Stop", display.contentCenterX, height, font, fontSize);
	pauseButton = display.newText("Pause", display.actualContentWidth*65/100, height, font, fontSize);
end;

function stopTimer(event)
	if(event.phase == "ended") then
		pauseTimer(event);	
		currentTime = 0;
		printTime();
	end;
end;

function pauseTimer(event)
	if(event.phase == "ended") then
		timer.pause(myTimer);
	end;
end;

function startTimer(event)
	if (event.phase == "ended") then
		timer.resume(myTimer);
	end;	
end;

function refreshTime(event)
	incTime(); 
	printTime();
end;

function incTime()
	currentTime = currentTime + 1;
end;

function printTime()
	local minutes = "";
	local seconds = "";
	
	minutes = tostring(math.floor(currentTime/60));
	minutes = appenndTheroToBegin(minutes);
	
	local seconds = tostring(currentTime % 60);
	seconds = appenndTheroToBegin(seconds);
		
	timeText.text = minutes .. ":"..seconds;	
end;

function appenndTheroToBegin(line)
	if (#line < 2) then
		line = "0"..line;
	end;
	
	return line;
end;

function initButtonsEventListener()
	startButton:addEventListener("touch", startTimer);
	stopButton:addEventListener("touch", stopTimer);
	pauseButton:addEventListener("touch", pauseTimer);
end;

function main()
	initButtons();
	initButtonsEventListener()
	myTimer = timer.performWithDelay(1000, refreshTime, -1);
	timer.pause(myTimer);
end;

--Run main
main();