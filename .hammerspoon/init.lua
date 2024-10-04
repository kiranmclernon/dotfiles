hs.loadSpoon("EmmyLua")
hs.application.enableSpotlightForNameSearches(true)

DOUBLE_PRESS_TIMEOUT = 0.3
local lastShiftPressTime = hs.timer.secondsSinceEpoch()
local function getApps(callback)
    local appDirs = {
        "/Applications",
        "/System/Applications",
        "/System/Applications/Utilities"
    }
    local apps = {}

    local spotlight = hs.spotlight.new():queryString('kMDItemKind == "Application"')
        :callbackMessages({"didUpdate", "didFinish"})
        :searchScopes(appDirs)
        :setCallback(function(obj, message, _, _)
            if message == "didFinish" then
                for i = 1, obj:count() do
                    hs.printf("inserting")
                    local item = obj:resultAtIndex(i)
                    local filePath = item:valueForAttribute("kMDItemPath")
                    local displayName = item:valueForAttribute("kMDItemDisplayName")
                    hs.printf(filePath)
                    table.insert(apps, {text=displayName, subText=filePath, image=hs.image.iconForFile(filePath)})
                end
                callback(apps)
            end
        end)
        :start()



    return apps
end

local function getPdfs()
    local pdfIcon = hs.image.iconForFileType("pdf")
    local spotlight = hs.spotlight.new():queryString('kMDItemContentType == "com.adobe.pdf"')
        :callbackMessages({"didUpdate", "didFinish"})
        :searchScopes({os.getenv("HOME").."/Desktop", os.getenv("HOME").."/Documents"})
        :setCallback(function(obj, message, _, _)
            hs.printf("Message: " .. message)
            if message == "didFinish" then
                local choices = {}
                for i = 1, obj:count() do
                    local item = obj:resultAtIndex(i)
                    local filePath = item:valueForAttribute("kMDItemPath")
                    local displayName = item:valueForAttribute("kMDItemDisplayName")
                    table.insert(choices, {text=displayName, subText=filePath, image=pdfIcon})
                end
                local pdfChooser = hs.chooser.new(function (selectedItem)
                    if selectedItem then
                        hs.execute(string.format('open "%s"', selectedItem.subText))
                    end
                end)
                pdfChooser:choices(choices)
                pdfChooser:show()
            end
        end)
        :start()
end



local function getVisibleAppsNames()
    local appleScript = [[
        tell application "System Events"
            set appList to name of every application process whose visible is true
        end tell
        return appList
    ]]

    local _, result, _ = hs.osascript.applescript(appleScript)
    local visibleApps = {}
    for _, value in ipairs(result) do
        if value ~= "Finder" then
            if string.find(value, "wezterm") then
                value = "wezterm"
            end
            local application = hs.application.find(value)
            visibleApps[application:name()] = application
        end
    end
    return visibleApps
end
local commandMap = {}

commandMap["PDF"] = getPdfs
commandMap["spotify"] = function()
    local applescript = [[
        tell application "Safari"
            set spotifyTabOpen to false
            set windowList to windows
            repeat with currentWindow in windowList
                set tabList to tabs of currentWindow
                repeat with currentTab in tabList
                    if (URL of currentTab contains "open.spotify.com") then
                        set spotifyTabOpen to true
                        tell currentWindow to set current tab to currentTab
                        activate
                        exit repeat
                    end if
                end repeat
                if spotifyTabOpen is true then
                    exit repeat
                end if
            end repeat
        end tell
    ]]
    hs.osascript.applescript(applescript)
end
commandMap["quit"] = function()
    local runningApps = getVisibleAppsNames()
    local choices = {}
    for _, application in pairs(runningApps) do
        table.insert(choices, {text = application:name(),  subText = application:name(), image=hs.image.imageFromAppBundle(application:bundleID())})
    end
    local quitChooser = hs.chooser.new(function (selectedItem)
        if not selectedItem then
            return
        else
            runningApps[selectedItem.subText]:kill()
        end
    end)
    quitChooser:choices(choices)
    quitChooser:show()
end
commandMap["force quit"] = function()
    local runningApps = getVisibleAppsNames()
    local choices = {}
    for _, application in pairs(runningApps) do
        table.insert(choices, {text = application:name(),  subText = application:name(), image=hs.image.imageFromAppBundle(application:bundleID())})
    end
    local quitChooser = hs.chooser.new(function (selectedItem)
        if not selectedItem then
            return
        else
            runningApps[selectedItem.subText]:kill9()
        end
    end)
    quitChooser:choices(choices)
    quitChooser:show()
end
commandMap["lock"] = hs.caffeinate.lockScreen
commandMap["sleep"] = hs.caffeinate.systemSleep
commandMap["restart"] = hs.caffeinate.restartSystem



local function showChooser(apps)
    local choices = {}

    for command, _ in pairs(commandMap) do
        table.insert(choices, {text = command, subText = "" .. command})
    end

    for _, app in ipairs(apps) do
        table.insert(choices, {text = app.text, subText = app.subText, image=app.image})
    end


    local chooser = hs.chooser.new(function(selectedItem)
        hs.printf("caller func called")
        if not selectedItem then
            hs.printf("nothing chosen")
            return
        end

        hs.printf("looking")

        local commandFunc = commandMap[selectedItem.subText]
        hs.printf("found")
        if commandFunc then
            commandFunc()
        else
        hs.execute(string.format('open "%s"', selectedItem.subText))
        end
    end)

    chooser:choices(choices)
    chooser:show()
end

local function handleShiftPress()
    local currentTime = hs.timer.secondsSinceEpoch()
    hs.printf("called handleShiftPress")
    if currentTime - lastShiftPressTime <= DOUBLE_PRESS_TIMEOUT then
        getApps(showChooser)
    else
        lastShiftPressTime = currentTime
    end
    hs.printf("handle shift press complete")
end

shiftTap = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, function(event)
    local flags = event:getFlags()
    if flags.shift then
        handleShiftPress()
    end
end)

shiftTap:start()
