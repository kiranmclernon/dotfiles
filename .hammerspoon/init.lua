hs.loadSpoon("EmmyLua")
hs.application.enableSpotlightForNameSearches(true)

local appDirs = {
    "/Applications",
    "/System/Applications",
    "/System/Applications/Utilities",
}
local apps = {}
local spotlight = hs.spotlight
    .new()
    :queryString('kMDItemKind == "Application"')
    :callbackMessages({ "didUpdate", "didFinish" })
    :searchScopes(appDirs)
    :setCallback(function(obj, message, _, _)
        if message == "didFinish" then
            for i = 1, obj:count() do
                hs.printf("inserting")
                local item = obj:resultAtIndex(i)
                local filePath = item:valueForAttribute("kMDItemPath")
                local displayName = item:valueForAttribute("kMDItemDisplayName")
                local lastUsedDate = item:valueForAttribute("kMDItemLastUsedDate") or 0
                hs.printf(lastUsedDate)
                hs.printf(filePath)
                table.insert(apps, {
                    text = displayName,
                    subText = filePath,
                    image = hs.image.iconForFile(filePath),
                    lastUsed = lastUsedDate,
                })
            end
        end
        table.sort(apps, function(a, b)
            return a.lastUsed > b.lastUsed
        end)
        hs.printf("apps loaded")
    end)
    :start()

DOUBLE_PRESS_TIMEOUT = 0.2
local lastShiftPressTime = hs.timer.secondsSinceEpoch()

local function getPdfs()
    local pdfIcon = hs.image.iconForFileType("pdf")
    local spotlight = hs.spotlight
        .new()
        :queryString('kMDItemContentType == "com.adobe.pdf"')
        :callbackMessages({ "didUpdate", "didFinish" })
        :searchScopes({ os.getenv("HOME") .. "/Desktop", os.getenv("HOME") .. "/Documents" })
        :setCallback(function(obj, message, _, _)
            hs.printf("Message: " .. message)
            if message == "didFinish" then
                local choices = {}
                for i = 1, obj:count() do
                    local item = obj:resultAtIndex(i)
                    local filePath = item:valueForAttribute("kMDItemPath")
                    local displayName = item:valueForAttribute("kMDItemDisplayName")
                    table.insert(choices, { text = displayName, subText = filePath, image = pdfIcon })
                end
                local pdfChooser = hs.chooser.new(function(selectedItem)
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
    local visibleApps = {}
    local runningApps = hs.application.runningApplications()
    for _, app in ipairs(runningApps) do
        if app:kind() == 1 then
            visibleApps[app:name()] = app
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
        table.insert(choices, {
            text = application:name(),
            subText = application:name(),
            image = hs.image.imageFromAppBundle(application:bundleID()),
        })
    end
    local quitChooser = hs.chooser.new(function(selectedItem)
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
        table.insert(choices, {
            text = application:name(),
            subText = application:name(),
            image = hs.image.imageFromAppBundle(application:bundleID()),
        })
    end
    local quitChooser = hs.chooser.new(function(selectedItem)
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

local function dynamicMathEval(expression)
    local trimmed = expression:match("^%s*(.-)%s*$")
    local env = {}
    local func, _ = load("return " .. trimmed, "expression", "t", env)

    if not func then
        return
    end

    local ok, result = pcall(func)

    if not ok then
        return
    end

    return result
end

local function showChooser()
    local choices = {}

    for command, _ in pairs(commandMap) do
        table.insert(choices, { text = command, subText = "" .. command })
    end

    for _, app in ipairs(apps) do
        table.insert(choices, { text = app.text, subText = app.subText, image = app.image })
    end

    local chooser = hs.chooser.new(function(selectedItem)
        if not selectedItem then
            return
        end

        local commandFunc = commandMap[selectedItem.subText]
        hs.printf("found")
        if commandFunc then
            commandFunc()
        else
            hs.execute(string.format('open "%s"', selectedItem.subText))
        end
    end)

    chooser:choices(choices)
    chooser:queryChangedCallback(function(query)
        chooser:choices(choices)
        local numericalResult = dynamicMathEval(query)

        if numericalResult then
            local updatedChoices = {}
            for i, v in ipairs(choices) do
                updatedChoices[i] = v
            end

            table.insert(updatedChoices, 1, { text = tostring(numericalResult), subText = "Numerical result" })

            chooser:choices(updatedChoices)
        else
            local filteredChoices = {}
            for _, choice in ipairs(choices) do
                if
                    string.match(choice.text:lower(), query:lower())
                    or (choice.subText and string.match(choice.subText:lower(), query:lower()))
                then
                    table.insert(filteredChoices, choice)
                end
            end

            chooser:choices(filteredChoices)
        end
    end)
    chooser:show()
end

local function handleShiftPress()
    local currentTime = hs.timer.secondsSinceEpoch()
    hs.printf("called handleShiftPress")
    if currentTime - lastShiftPressTime <= DOUBLE_PRESS_TIMEOUT then
        showChooser()
    else
        lastShiftPressTime = currentTime
    end
    hs.printf("handle shift press complete")
end

shiftTap = hs.eventtap.new({ hs.eventtap.event.types.flagsChanged }, function(event)
    local flags = event:getFlags()
    hs.printf("hello")
    if flags.shift then
        handleShiftPress()
    end
end)

shiftTap:start()

hs.hotkey.bind({ "cmd", "shift" }, "F", function()
    local win = hs.window.focusedWindow()
    if win then
        win:maximize()
    end
end)
