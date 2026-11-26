print("Antler Loaded")

-- globals
getgenv().checkout = false
getgenv().partSpawner = false

connections = {
    axefling = nil,
}

-- locals
local Players = game:GetService("Players")
local plr = game.Players.LocalPlayer
local Player = game.Players.LocalPlayer
local speaker = game:GetService("Players").LocalPlayer
local LocalPlayer = game:GetService("Players").LocalPlayer
local Humanoid = game:GetService("Players").LocalPlayer.Character.Humanoid
local player = game.Players.LocalPlayer
local playerGui = player.PlayerGui
local Mouse = game.Players.LocalPlayer:GetMouse()
repeat
    wait()
until Mouse
local propClient = plr.PlayerGui:WaitForChild("PropertyPurchasingGUI"):WaitForChild("PropertyPurchasingClient")
local propEnvironment = select(2, pcall(getsenv, propClient))
local oldPurchase = type(propEnvironment) == "table" and propEnvironment.enterPurchaseMode or nil
local Night = false
local Day = false
local Betterselection
local Speed = nil
local maxspeed = 100
Players = game.Players
IYMouse = Players.LocalPlayer:GetMouse()
speaker = Players.LocalPlayer
QEfly = true
local CustomDragger = false
local FLYING = false
local ItemList = {}
local slot = 1
local GetChar = function()
    if Player.Character == nil then
        repeat
            task.wait()
        until Player.Character ~= nil
        return Player.Character
    else
        return Player.Character
    end
end

-- theme
local theme = {
    bg = Color3.fromRGB(40, 40, 40),
    accent = Color3.fromRGB(30, 30, 30),
    gray = Color3.fromRGB(35, 35, 35),
    dark = Color3.fromRGB(25, 25, 25),
    text = Color3.fromRGB(255, 255, 255),
}

pcall(function()
    LocalPlayer.PlayerGui.Chat.Frame.ChatBarParentFrame.Frame.BoxFrame.Frame.ChatBar.TextColor3 =
        Color3.fromRGB(220, 220, 220)
end)

iyflyspeed = 5
vehicleflyspeed = 5

-- notify
local ui
function Notify(titletxt, text, time)
    if ui then
        ui.notify("notify", tostring(text), time or 3)
    end
end

-- functions

function round(x)
    if x:FindFirstChild("uicorner") then
        return
    end
    if x.Name == "TargetGui" or x:FindFirstAncestor("TargetGui") then
        return
    end
    local e = Instance.new("UICorner")
    e.Parent = x
    e.Name = "uicorner"
    e.CornerRadius = UDim.new(0, 5)
end

-- skip targetgui, the game recolors it
function isProtectedGui(obj)
    return obj.Name == "TargetGui" or obj:FindFirstAncestor("TargetGui") ~= nil
end

local recoloring, recolorPending = false, false
function RecolorGui()
    if recoloring then
        recolorPending = true
        return
    end
    recoloring = true
    repeat
        recolorPending = false
        pcall(function()
            -- remove corners from targetgui
            local targetGui = playerGui:FindFirstChild("TargetGui")
            if targetGui then
                for _, d in ipairs(targetGui:GetDescendants()) do
                    if d:IsA("UICorner") and d.Name == "uicorner" then
                        d:Destroy()
                    end
                end
            end

            local count = 0
            for _, frame in ipairs(playerGui:GetDescendants()) do
                count = count + 1
                if count % 150 == 0 then
                    task.wait()
                end
                if not isProtectedGui(frame) then
                    if frame:IsA("Frame") then
                        frame.BackgroundColor3 = theme.bg
                    end

                    if frame:IsA("TextLabel") then
                        frame.TextColor3 = theme.text
                        frame.BackgroundColor3 = theme.accent
                    end

                    if frame:IsA("TextButton") then
                        frame.BackgroundColor3 = theme.accent
                    end

                    if frame:IsA("ScrollingFrame") then
                        frame.BackgroundColor3 = theme.gray
                    end
                end
            end

            count = 0
            for i, v in next, game.Players.LocalPlayer.PlayerGui:GetDescendants() do
                count = count + 1
                if count % 150 == 0 then
                    task.wait()
                end
                if v ~= nil and not isProtectedGui(v) then
                    if v:IsA("TextLabel") then
                        if v.Name == "DropShadow" then
                            v.TextColor3 = theme.dark
                            v.BackgroundColor3 = theme.dark
                        else
                            v.TextColor3 = theme.text
                            v.BackgroundColor3 = theme.accent
                        end

                        round(v)
                    end
                    if v:IsA("TextBox") then
                        if v.Name == "DropShadow" then
                            v.TextColor3 = theme.dark
                            v.BackgroundColor3 = theme.dark
                        else
                            if v.TextColor3 ~= Color3.fromRGB(49, 137, 28) then
                                v.TextColor3 = theme.text
                                v.BackgroundColor3 = theme.gray
                            end
                        end

                        round(v)
                    end
                    if v:IsA("TextButton") then
                        if v.Name == "DropShadow" then
                            v.TextColor3 = theme.dark
                        else
                            v.TextColor3 = theme.text
                        end
                        v.BackgroundColor3 = theme.accent
                        round(v)
                    end
                    if v:IsA("ImageLabel") then
                        v.BackgroundTransparency = 1
                        round(v)
                    end
                    if v:IsA("ImageButton") then
                        v.BackgroundTransparency = 1
                        round(v)
                    end
                    if v:IsA("Frame") then
                        round(v)
                        if v.Name == "DropShadow" then
                            v.BackgroundColor3 = theme.dark
                        elseif v.BackgroundColor3 ~= Color3.fromRGB(112, 220, 108) then
                            v.BackgroundColor3 = theme.bg
                        end
                    end
                    if v:IsA("ScrollingFrame") then
                        round(v)
                        if v.Name == "Drop Shadow" then
                            v.BackgroundColor3 = theme.dark
                        elseif v.BackgroundColor3 ~= Color3.fromRGB(112, 220, 108) then
                            v.BackgroundColor3 = theme.gray
                        end
                    end
                end
            end
        end)
    until not recolorPending
    recoloring = false
end

function LoadTeleportOff()
    local LP = game:GetService("Players").LocalPlayer
    local HRP = LP.Character.HumanoidRootPart
    local Clone = HRP:Clone()
    HRP:Destroy()
    Clone.Parent = LP.Character
end

function SafeSuicide()
    local LPR = game.Players.LocalPlayer.Character
    LPR.HumanoidRootPart.CFrame = CFrame.new(-24, -248, -1773)
end

local Mouse = game.Players.LocalPlayer:GetMouse()
local AxeClassesFolder = game:GetService("ReplicatedStorage").AxeClasses

function GetBestAxe(Tree)
    if game.Players.LocalPlayer.Character:FindFirstChild("Tool") then
        game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
    end
    local SelectedTool = nil
    local HighestAxeDamage = 0
    for i, v in next, game.Players.LocalPlayer.Backpack:GetChildren() do
        if v.Name == "Tool" then
            if
                require(AxeClassesFolder:FindFirstChild("AxeClass_" .. v.ToolName.Value)).new().Damage
                > HighestAxeDamage
            then
                SelectedTool = v
                if require(AxeClassesFolder:FindFirstChild("AxeClass_" .. v.ToolName.Value)).new().SpecialTrees then
                    if
                        require(AxeClassesFolder:FindFirstChild("AxeClass_" .. v.ToolName.Value)).new().SpecialTrees[Tree]
                    then
                        return v
                    end
                end
            end
        end
    end
    return SelectedTool
end

local logcount = 0
local mil

local logcount = 0
local mil

spawn(function()
    function PartSpawner()
        while getgenv().partSpawner == true do
            wait()
            local part = Instance.new("Part", workspace)
            part.Name = "AntlerPart"
            part.Anchored = true
            part.Size = Vector3.new(2, 2, 2)
            part.Color = Color3.fromRGB(0, 0, 0)
            part:PivotTo(game.Players.LocalPlayer.Character:GetPivot() - Vector3.new(0, part.Size.Y, 0))
        end
    end
end)

function Brightness(value)
    game.Lighting.Brightness = value
end

function BTools()
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local mouse = LocalPlayer:GetMouse()
    local deletetool = Instance.new("Tool", LocalPlayer.Backpack)
    local undotool = Instance.new("Tool", LocalPlayer.Backpack)

    if editedparts == nil then
        editedparts = {}
        parentfix = {}
        positionfix = {}
    end

    deletetool.Name = "Delete"
    undotool.Name = "Undo"
    undotool.CanBeDropped = false
    deletetool.CanBeDropped = false
    undotool.RequiresHandle = false
    deletetool.RequiresHandle = false

    deletetool.Activated:Connect(function()
        table.insert(editedparts, mouse.Target)
        table.insert(parentfix, mouse.Target.Parent)
        table.insert(positionfix, mouse.Target.CFrame)
        spawn(function()
            local deletedpart = mouse.Target
            repeat
                deletedpart.Anchored = true
                deletedpart.CFrame = CFrame.new(1000000000, 1000000000, 1000000000)
                wait()
            until deletedpart.CFrame ~= CFrame.new(1000000000, 1000000000, 1000000000)
        end)
    end)

    undotool.Activated:Connect(function()
        editedparts[#editedparts].Parent = parentfix[#parentfix]
        editedparts[#editedparts].CFrame = positionfix[#positionfix]
        table.remove(positionfix, #positionfix)
        table.remove(editedparts, #editedparts)
        table.remove(parentfix, #parentfix)
    end)
end

function btoolsdisable()
    LocalPlayer.Backpack.Undo:Destroy()
    LocalPlayer.Backpack.Delete:Destroy()
end

function speed()
    game.Players.LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().Speed
    end)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().Speed
end

function BridgeDown()
    for i, v in next, game:GetService("Workspace").Bridge.VerticalLiftBridge.Lift:GetChildren() do
        v.CFrame = Value and v.CFrame - Vector3.new(0, 26, 0) or v.CFrame + Vector3.new(0, 26, 0)
    end
end

function anyvehicle()
    game:GetService("Players").MrMaclintosh.PlayerScripts.SitPermissions:Destroy()
end

function Purchase(ID)
    spawn(function()
        game:GetService("ReplicatedStorage").NPCDialog.PlayerChatted:InvokeServer(
            { ["ID"] = ID, ["Character"] = "name", ["Name"] = "name", ["Dialog"] = "Dialog" },
            "ConfirmPurchase"
        )
    end)
end

function GetChar()
    local Player = game.Players.LocalPlayer
    if Player.Character == nil then
        repeat
            task.wait()
        until Player.Character ~= nil
        return Player.Character
    else
        return Player.Character
    end
end

function sFLY(vfly)
    repeat
        wait()
    until Players.LocalPlayer
        and Players.LocalPlayer.Character
        and getRoot(Players.LocalPlayer.Character)
        and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    repeat
        wait()
    until IYMouse
    if flyKeyDown or flyKeyUp then
        flyKeyDown:Disconnect()
        flyKeyUp:Disconnect()
    end

    local T = getRoot(Players.LocalPlayer.Character)
    local CONTROL = { F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0 }
    local lCONTROL = { F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0 }
    local SPEED = 0

    local function FLY()
        FLYING = true
        local BG = Instance.new("BodyGyro")
        local BV = Instance.new("BodyVelocity")
        BG.P = 9e4
        BG.Parent = T
        BV.Parent = T
        BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        BG.cframe = T.CFrame
        BV.velocity = Vector3.new(0, 0, 0)
        BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
        task.spawn(function()
            repeat
                wait()
                if not vfly and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                    Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand = true
                end
                if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
                    SPEED = 50
                elseif
                    not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0)
                    and SPEED ~= 0
                then
                    SPEED = 0
                end
                if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
                    BV.velocity = (
                        (workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B))
                        + (
                            (
                                workspace.CurrentCamera.CoordinateFrame
                                * CFrame.new(
                                    CONTROL.L + CONTROL.R,
                                    (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2,
                                    0
                                ).p
                            ) - workspace.CurrentCamera.CoordinateFrame.p
                        )
                    ) * SPEED
                    lCONTROL = { F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R }
                elseif
                    (CONTROL.L + CONTROL.R) == 0
                    and (CONTROL.F + CONTROL.B) == 0
                    and (CONTROL.Q + CONTROL.E) == 0
                    and SPEED ~= 0
                then
                    BV.velocity = (
                        (workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B))
                        + (
                            (
                                workspace.CurrentCamera.CoordinateFrame
                                * CFrame.new(
                                    lCONTROL.L + lCONTROL.R,
                                    (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2,
                                    0
                                ).p
                            ) - workspace.CurrentCamera.CoordinateFrame.p
                        )
                    ) * SPEED
                else
                    BV.velocity = Vector3.new(0, 0, 0)
                end
                BG.cframe = workspace.CurrentCamera.CoordinateFrame
            until not FLYING
            CONTROL = { F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0 }
            lCONTROL = { F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0 }
            SPEED = 0
            BG:Destroy()
            BV:Destroy()
            if Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand = false
            end
        end)
    end
    flyKeyDown = IYMouse.KeyDown:Connect(function(KEY)
        if KEY:lower() == "w" then
            CONTROL.F = (vfly and vehicleflyspeed or iyflyspeed)
        elseif KEY:lower() == "s" then
            CONTROL.B = -(vfly and vehicleflyspeed or iyflyspeed)
        elseif KEY:lower() == "a" then
            CONTROL.L = -(vfly and vehicleflyspeed or iyflyspeed)
        elseif KEY:lower() == "d" then
            CONTROL.R = (vfly and vehicleflyspeed or iyflyspeed)
        elseif QEfly and KEY:lower() == "e" then
            CONTROL.Q = (vfly and vehicleflyspeed or iyflyspeed) * 2
        elseif QEfly and KEY:lower() == "q" then
            CONTROL.E = -(vfly and vehicleflyspeed or iyflyspeed) * 2
        end
        pcall(function()
            workspace.CurrentCamera.CameraType = Enum.CameraType.Track
        end)
    end)
    flyKeyUp = IYMouse.KeyUp:Connect(function(KEY)
        if KEY:lower() == "w" then
            CONTROL.F = 0
        elseif KEY:lower() == "s" then
            CONTROL.B = 0
        elseif KEY:lower() == "a" then
            CONTROL.L = 0
        elseif KEY:lower() == "d" then
            CONTROL.R = 0
        elseif KEY:lower() == "e" then
            CONTROL.Q = 0
        elseif KEY:lower() == "q" then
            CONTROL.E = 0
        end
    end)
    FLY()
end

function nf()
    FLYING = false
    if flyKeyDown or flyKeyUp then
        flyKeyDown:Disconnect()
        flyKeyUp:Disconnect()
    end
    if Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand = false
    end
    pcall(function()
        workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
    end)
end

local function getPlots()
    local Properties = {}
    for _, v in next, workspace.Properties:GetChildren() do
        local Owner = v:FindFirstChild("Owner")
        if Owner and Owner.Value == nil then
            table.insert(Properties, v)
        end
    end
    return Properties[#Properties]
end

pcall(function()
    getsenv(propClient).enterPurchaseMode = function(...)
        if not skipLoading then
            return oldPurchase(...)
        end
        setupvalue(propEnvironment.rotate, 3, 0)
        setupvalue(oldPurchase, 10, getPlots())
        return
    end
end)

function BridgeUp()
    for i, v in pairs(game:GetService("Workspace").Bridge.VerticalLiftBridge.Weight:GetChildren()) do
        v.CFrame = Value and v.CFrame + Vector3.new(0, 26, 0) or v.CFrame - Vector3.new(0, 26, 0)
    end
end

function flip()
    local player = game.Players.LocalPlayer
    local humanoid = player.Character.Humanoid
    if humanoid.Seated then
        local CurrentSeat = player.Character.Humanoid.SeatPart
        if CurrentSeat and CurrentSeat.Parent.Type.Value == "Vehicle" then
            CurrentSeat.CFrame =
                CurrentSeat.CFrame * CFrame.Angles(math.rad(-180), 0, 0) + Vector3.new(0, 5, 0),
                1000,
                CurrentSeat.CFrame
        end
    end
end

function BetterFly()
    repeat
        wait()
    until game.Players.LocalPlayer
        and game.Players.LocalPlayer.Character
        and game.Players.LocalPlayer.Character:findFirstChild("Head")
        and game.Players.LocalPlayer.Character:findFirstChild("Humanoid")
    local mouse = game.Players.LocalPlayer:GetMouse()
    repeat
        wait()
    until mouse
    local plr = game.Players.LocalPlayer
    local torso = plr.Character.Head
    local flying = false
    local ctrl = { f = 0, b = 0, l = 0, r = 0 }
    local lastctrl = { f = 0, b = 0, l = 0, r = 0 }
    local speed = 5000

    function Fly()
        local bg = Instance.new("BodyGyro", torso)
        bg.P = 9e4
        bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.cframe = torso.CFrame
        local bv = Instance.new("BodyVelocity", torso)
        bv.velocity = Vector3.new(0, 0.1, 0)
        bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
        repeat
            wait()
            plr.Character.Humanoid.PlatformStand = true
            if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
                speed = maxspeed
            elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
                speed = 0
            end
            if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
                bv.velocity = (
                    (game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f + ctrl.b))
                    + (
                        (
                            game.Workspace.CurrentCamera.CoordinateFrame
                            * CFrame.new(ctrl.l + ctrl.r, (ctrl.f + ctrl.b) * 0.2, 0).p
                        ) - game.Workspace.CurrentCamera.CoordinateFrame.p
                    )
                ) * speed
                lastctrl = { f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r }
            elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
                bv.velocity = (
                    (game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f + lastctrl.b))
                    + (
                        (
                            game.Workspace.CurrentCamera.CoordinateFrame
                            * CFrame.new(lastctrl.l + lastctrl.r, (lastctrl.f + lastctrl.b) * 0.2, 0).p
                        ) - game.Workspace.CurrentCamera.CoordinateFrame.p
                    )
                ) * speed
            else
                bv.velocity = Vector3.new(0, 0, 0)
            end
            bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame
                * CFrame.Angles(-math.rad((ctrl.f + ctrl.b) * speed / maxspeed), 0, 0)
        until not flying
        ctrl = { f = 0, b = 0, l = 0, r = 0 }
        lastctrl = { f = 0, b = 0, l = 0, r = 0 }
        speed = 0
        bg:Destroy()
        bv:Destroy()
        plr.Character.Humanoid.PlatformStand = false
    end
    -- called by the Flight keybind in the Player tab (Q by default, can be changed there)
    function ToggleFlight()
        if flying then
            flying = false
        else
            flying = true
            Fly()
        end
    end
    mouse.KeyDown:connect(function(key)
        if key:lower() == "w" then
            ctrl.f = 1
        elseif key:lower() == "s" then
            ctrl.b = -1
        elseif key:lower() == "a" then
            ctrl.l = -1
        elseif key:lower() == "d" then
            ctrl.r = 1
        end
    end)
    mouse.KeyUp:connect(function(key)
        if key:lower() == "w" then
            ctrl.f = 0
        elseif key:lower() == "s" then
            ctrl.b = 0
        elseif key:lower() == "a" then
            ctrl.l = 0
        elseif key:lower() == "d" then
            ctrl.r = 0
        end
    end)
    Fly()
end
game.Players.LocalPlayer.CharacterAdded:Connect(BetterFly)
BetterFly()

-- always day and night
local savedClockTime = nil
local savedLighting = nil
local dayAmbient = Color3.new(25 / 255, 25 / 255, 25 / 255)

local function EnforceTime()
    local L = game.Lighting
    if Day then
        if L.ClockTime ~= 12 then
            L.ClockTime = 12
        end
    elseif Night then
        if L.ClockTime ~= 0 then
            L.ClockTime = 0
        end
    end
end

local function RestoreLighting()
    if savedLighting then
        local L = game.Lighting
        L.Brightness = savedLighting.Brightness
        L.Ambient = savedLighting.Ambient
        L.OutdoorAmbient = savedLighting.OutdoorAmbient
        savedLighting = nil
    end
end

local function RefreshTimeMode()
    local L = game.Lighting
    if Day or Night then
        if savedClockTime == nil then
            savedClockTime = L.ClockTime
        end
        if Day then
            if not savedLighting then
                savedLighting = {
                    Brightness = L.Brightness,
                    Ambient = L.Ambient,
                    OutdoorAmbient = L.OutdoorAmbient,
                }
            end
            L.Brightness = 0.8
            L.Ambient = dayAmbient
            L.OutdoorAmbient = Color3.new(1, 1, 1)
        else
            RestoreLighting()
        end
        EnforceTime()
    else
        RestoreLighting()
        if savedClockTime ~= nil then
            L.ClockTime = savedClockTime
            savedClockTime = nil
        end
    end
end

-- hold day ambient
game:GetService("RunService").Heartbeat:Connect(function()
    if Day then
        local L = game.Lighting
        if L.Ambient ~= dayAmbient then
            L.Ambient = dayAmbient
        end
        if L.OutdoorAmbient ~= Color3.new(1, 1, 1) then
            L.OutdoorAmbient = Color3.new(1, 1, 1)
        end
    end
end)
game.Lighting:GetPropertyChangedSignal("ClockTime"):Connect(EnforceTime)

function noclip()
    Clip = false
    local function Nocl()
        if Clip == false and game.Players.LocalPlayer.Character ~= nil then
            for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") and v.CanCollide and v.Name ~= floatName then
                    v.CanCollide = false
                end
            end
        end
        wait(0.21)
    end
    Noclip = game:GetService("RunService").Stepped:Connect(Nocl)
end

function clip()
    if Noclip then
        Noclip:Disconnect()
    end
    Clip = true
end

function VehicleSpeed(Val)
    for i, v in next, game:GetService("Workspace").PlayerModels:GetChildren() do
        if v:FindFirstChild("Owner") and v.Owner.Value == game.Players.LocalPlayer then
            if v:FindFirstChild("Type") and v.Type.Value == "Vehicle" then
                if v:FindFirstChild("Configuration") then
                    v.Configuration.MaxSpeed.Value = Val
                end
            end
        end
    end
end

function AntiAFK(Val)
    if not Val then
        AFKVal:Disconnect()
        return
    end
    AFKVal = game:GetService("Players").LocalPlayer.Idled:connect(function()
        game:GetService("VirtualInputManager"):SendKeyEvent(true, "W", false, game)
        wait()
        game:GetService("VirtualInputManager"):SendKeyEvent(false, "W", false, game)
    end)
end

function getRoot(char)
    local rootPart = char:FindFirstChild("HumanoidRootPart")
        or char:FindFirstChild("Torso")
        or char:FindFirstChild("UpperTorso")
    return rootPart
end

function is_in_frame(screenpos, frame)
    local xPos = frame.AbsolutePosition.X
    local yPos = frame.AbsolutePosition.Yisinframe

    local xSize = frame.AbsoluteSize.X
    local ySize = frame.AbsoluteSize.Y

    local check1 = screenpos.X >= xPos and screenpos.X <= xPos + xSize
    local check2 = screenpos.X <= xPos and screenpos.X >= xPos + xSize

    local check3 = screenpos.Y >= yPos and screenpos.Y <= yPos + ySize
    local check4 = screenpos.Y <= yPos and screenpos.Y >= yPos + ySize

    local finale = (check1 and check3) or (check2 and check3) or (check1 and check4) or (check2 and check4)

    return finale
end

function Light(Val)
    if Val == false then
        game.Players.LocalPlayer.Character.Head.PointLight:Destroy()
        return
    end
    local PL = Instance.new("PointLight", game.Players.LocalPlayer.Character:FindFirstChild("Head"))
    PL.Range = 100
    PL.Brightness = 1
    PL.Shadows = false
end

local hardDraggerConn = nil

function HardDragger(state)
    local workspace = game:GetService("Workspace")
    local RunService = game:GetService("RunService")

    -- clear old connection
    if hardDraggerConn then
        hardDraggerConn:Disconnect()
        hardDraggerConn = nil
    end

    if not state then
        return
    end

    hardDraggerConn = workspace.ChildAdded:Connect(function(child)
        if tostring(child) ~= "Dragger" then
            return
        end

        local BodyGyro = child:WaitForChild("BodyGyro")
        local BodyPosition = child:WaitForChild("BodyPosition")

        -- wait for dragger
        repeat
            RunService.Stepped:Wait()
        until workspace:FindFirstChild("Dragger")

        -- hard drag while dragging
        repeat
            RunService.Stepped:Wait()
            BodyPosition.P = 120000
            BodyPosition.D = 1000
            BodyPosition.maxForce = Vector3.new(1, 1, 1) * 1000000
            BodyGyro.maxTorque = Vector3.new(1, 1, 1) * 200
            BodyGyro.P = 1200
            BodyGyro.D = 140
        until not workspace:FindFirstChild("Dragger")

        -- reset after drag
        BodyPosition.P = 10000
        BodyPosition.D = 800
        BodyPosition.maxForce = Vector3.new(17000, 17000, 17000)
        BodyGyro.maxTorque = Vector3.new(200, 200, 200)
        BodyGyro.P = 1200
        BodyGyro.D = 140
    end)
end

local AllPlayers = { game.Players.LocalPlayer.Name }
for i, v in next, game.Players:GetPlayers() do
    if not table.find(AllPlayers, v.Name) then
        table.insert(AllPlayers, v.Name)
    end
end

function TeleportToPlayer(Plr)
    for i, v in next, game.Players:GetPlayers() do
        if tostring(v.Name) == Plr then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                CFrame.new(v.Character.HumanoidRootPart.CFrame.p)
            print("")
            break
        end
    end
end

function TeleportToBase(Plr)
    for i, v in next, game:GetService("Workspace").Properties:GetChildren() do
        if v:FindFirstChild("Owner") and tostring(v.Owner.Value) == Plr then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.OriginSquare.CFrame + Vector3.new(0, 2, 0)
            break
        end
    end
end

function LoadSlot(slot)
    if
        not game:GetService("ReplicatedStorage").LoadSaveRequests.ClientMayLoad
            :InvokeServer(game:GetService("Players").LocalPlayer)
    then
        repeat
            task.wait()
        until game:GetService("ReplicatedStorage").LoadSaveRequests.ClientMayLoad
                :InvokeServer(game:GetService("Players").LocalPlayer)
    end
    local skipLoading = skil.skipLoading
    game:GetService("ReplicatedStorage").LoadSaveRequests.RequestLoad:InvokeServer(slot, game.Players.LocalPlayer)
    if game:GetService("Players").LocalPlayer.CurrentSaveSlot.Value == slot then
        Notify("Fast Load | LW", "Slot Succesfully Loaded!" .. slot, 2)
    end
end

function SellSoldSign()
    for i, v in next, game:GetService("Workspace").PlayerModels:GetChildren() do
        if v:FindFirstChild("Owner") and v.Owner.Value == game.Players.LocalPlayer then
            if v:FindFirstChild("ItemName") and v.ItemName.Value == "PropertySoldSign" then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Main.CFrame.p)
                    + Vector3.new(0, 0, 2)
                game:GetService("ReplicatedStorage").Interaction.ClientInteracted:FireServer(v, "Take down sold sign")
                for i = 1, 30 do
                    game:GetService("ReplicatedStorage").Interaction.ClientIsDragging:FireServer(v)
                    v.Main.CFrame = CFrame.new(314.54, -0.5, 86.823)
                    task.wait()
                end
            end
        end
    end
end

local ReplicatedStorage = game:GetService("ReplicatedStorage")

function PurchaseItem(ID)
    ReplicatedStorage.NPCDialog.PlayerChatted:InvokeServer({
        ["Character"] = "",
        ["Name"] = "",
        ["ID"] = ID,
        ["Dialog"] = "",
    }, "ConfirmPurchase")
end

pcall(function()
    for _, v in pairs(game:GetService("ReplicatedStorage").ClientItemInfo:GetChildren()) do
        if v:IsA("Folder") then
            for _, x in pairs(workspace.Stores:GetDescendants()) do
                if x.Name == "BoxItemName" then
                    if x.Value == v.Name and not table.find(ItemList, v.Name) then
                        table.insert(ItemList, v.Name)
                    end
                end
            end
        end
    end
end)

local CheckIfWPPlaced = function()
    if TPToWPorPLR == false then
        local WayPointPart = Instance.new("Part")
        if not WayPointPart then
            return false
        end
    else
        return true
    end

    return true
end

local AxeIndex = {
    Basic_Hatchet = {
        Damage = 0.2,
        Cooldown = 0.304,
    },
    Plain_Axe = {
        Damage = 0.55,
        Cooldown = 0.383,
    },
    Steel_Axe = {
        Damage = 0.93,
        Cooldown = 0.369,
    },
    Hardened_Axe = {
        Damage = 1.45,
        Cooldown = 0.328,
    },
    Silver_Axe = {
        Damage = 1.6,
        Cooldown = 0.222,
    },
    The_Many_Axe = {
        Damage = 10.2,
        Cooldown = 0.328,
    },
    Alpha_Axe_of_Testing = {
        Damage = 1.5,
        Cooldown = 0.234,
    },
    Bird_Axe = {
        Damage = 1.65,
        DamageToLava = 2.5,
        DamageToCavecrawler = 3.9,
        Cooldown = 0.171,
    },
    Rukiryaxe = {
        Damage = 1.68,
        Cooldown = 0.172,
    },
    beesaxe = {
        Damage = 1.4,
        Cooldown = 0.218,
    },
    Beta_Axe_of_Bosses = {
        Damage = 1.45,
        Cooldown = 0.256,
    },
    Cave_Axe = {
        Damage = 0.4,
        DamageToCavecrawler = 7.2,
        CooldownCavecrawler = 0.051,
        Cooldown = 0.175,
    },
    Fire_Axe = {
        Damage = 0.6,
        DamageToLava = 6.35,
        CooldownLava = 0.105,
        Cooldown = 0.258,
    },
    Candy_Corn_Axe = {
        Damage = 1.75,
        Cooldown = 0.259,
    },
    CHICKEN_AXE = {
        Damage = 0.9,
        Cooldown = 0.060,
    },
    Gingerbread_Axe = {
        Damage = 1.2,
        DamageToKoa = 11,
        DamageToWalnut = 8.5,
        CooldownKoa = 0.134,
        CooldownWalnut = 0.170,
        Cooldown = 0.218,
    },
    Rusty_Axe = {
        Damage = 0.55,
        Cooldown = 0.4,
    },
    Overgrown_Axe = {
        Damage = 0.8,
        DamageToZombie = 7,
        DamageToGold = 5.35,
        CooldownGold = 0.185,
        CooldownZombie = 0.248,
        Cooldown = 0.290,
    },
    End_Times_Axe = {
        Damage = 1.58,
        Cooldown = 0.4,
    },
    Frost_Axe = {
        Damage = 0.36,
        Cooldown = 0.4,
    },
}

local ClientIsDragging = game:GetService("ReplicatedStorage").Interaction.ClientIsDragging

local finished = false
local cooper = game.Players.LocalPlayer
local treeregins = {}
local treclases = {}
local replicatedfarts = game.ReplicatedStorage
local axeclasses = replicatedfarts:WaitForChild("AxeClasses")

local plraxe = nil

local ready = true

pcall(function()
    for _, cooper in next, workspace:GetChildren() do
        if cooper.Name == "TreeRegion" then
            table.insert(treeregins, cooper)
        end
    end
end)

pcall(function()
    for _, cooper in next, treeregins do
        for _, cooper in next, cooper:GetChildren() do
            if cooper:FindFirstChild("TreeClass") and not table.find(treclases, cooper.TreeClass.Value) then
                table.insert(treclases, cooper.TreeClass.Value)
            end
        end
    end
end)

workspace.PlayerModels.ChildAdded:Connect(function(a)
    if finished then
        return
    end
    task.wait(0.25)
    if a:FindFirstChild("Owner") and a:FindFirstChild("Owner").Value == game.Players.LocalPlayer then
        if a:FindFirstChild("ToolName") and a.ToolName.Value == "EndTimesAxe" then
            plraxe = a
        end
    end
end)

local catschar = cooper.Character or cooper.CharacterAdded:Wait()

task.wait()

local Part = Instance.new("Part", game:GetService("Workspace"))
Part.Name = "WaypointLocation"
Part.Anchored = true
Part.Transparency = 1
Part.Size = Vector3.new(2, 1, 1)
Part.CanCollide = false
Part.Position = Vector3.new(-46.3202, -197.261, -1345.9)

function blueprints()
    local open = game.Workspace.PlayerModels.ChildAdded:connect(function(v)
        spawn(function()
            if v.Type.Value == "Blueprint" then
                game:GetService("ReplicatedStorage").Interaction.ClientInteracted:FireServer(v, "Open box")
            end
        end)
    end)
end

function is_in_frame(screenpos, frame)
    local xPos = frame.AbsolutePosition.X
    local yPos = frame.AbsolutePosition.Yisinframe

    local xSize = frame.AbsoluteSize.X
    local ySize = frame.AbsoluteSize.Y

    local check1 = screenpos.X >= xPos and screenpos.X <= xPos + xSize
    local check2 = screenpos.X <= xPos and screenpos.X >= xPos + xSize

    local check3 = screenpos.Y >= yPos and screenpos.Y <= yPos + ySize
    local check4 = screenpos.Y <= yPos and screenpos.Y >= yPos + ySize

    local finale = (check1 and check3) or (check2 and check3) or (check1 and check4) or (check2 and check4)

    return finale
end

function GetChar()
    local Player = game.Players.LocalPlayer
    if Player.Character == nil then
        repeat
            task.wait()
        until Player.Character ~= nil
        return Player.Character
    else
        return Player.Character
    end
end

local Betterselection
local Mouse = game.Players.LocalPlayer:GetMouse()

function selectionv2(PLY)
    if _G.selectionv2 == false then
        Betterselection:Disconnect()
        return print("Func Off")
    end
    Betterselection = Mouse.Button1Up:Connect(function()
        for i, v in pairs(game.Workspace.PlayerModels:GetChildren()) do
            if v:FindFirstChild("Main") then
                if v.Main.Parent.Name == Mouse.Target.Parent.Name then
                    if Mouse.Target.Parent:FindFirstChild("Owner") and tostring(v.Owner.Value) == PLY then
                        if v.Main:FindFirstChild("Selection") then
                        else
                            local bobv2 = Instance.new("SelectionBox", v.Main)
                            bobv2.Name = "Selection"
                            bobv2.Adornee = bobv2.Parent
                            bobv2.SurfaceTransparency = 0.75
                            bobv2.LineThickness = 0.02
                            bobv2.SurfaceColor3 = Color3.fromRGB(0, 0, 0)
                            bobv2.Color3 = Color3.fromRGB(115, 185, 255)
                        end
                    end
                end
            end
        end
    end)
end

locations = {
    "The Den",
    "Lighthouse",
    "Safari",
    "Bridge",
    "Bob's Shack",
    "EndTimes Cave",
    "The Swamp",
    "The Cabin",
    "Volcano",
    "Boxed Cars",
    "Tiaga Peak",
    "Land Store",
    "Link's Logic",
    "Palm Island",
    "Palm Island 2",
    "Palm Island 3",
    "Fine Art Shop",
    "SnowGlow Biome",
    "Cave",
    "Shrine Of Sight",
    "Fancy Furnishings",
    "Docks",
    "Strange Man",
    "Wood Dropoff",
    "Snow Biome",
    "Wood RUs",
    "Green Box",
    "Spawn",
    "Cherry Meadow",
    "Bird Cave",
}

repeat
    task.wait()
until game:IsLoaded()
-- library
local library
do
    library = {}
    local Objects =
        { BackgroundColor = {}, AccentColor = {}, TextColor = {}, GrayContrastColor = {}, DarkContrastColor = {} }
    local ObjectsSearch = {}
    local showsearch = true
    local toggleRegistry, categoryRegistry = {}, {}
    local selectedCategoryName = nil

    local Themes = {
        BackgroundColor = Color3.fromRGB(40, 40, 40),
        TextColor = Color3.fromRGB(255, 255, 255),
        AccentColor = Color3.fromRGB(30, 30, 30),
        GrayContrastColor = Color3.fromRGB(35, 35, 35),
        DarkContrastColor = Color3.fromRGB(25, 25, 25),
    }

    local ts = game:GetService("TweenService")
    local uis = game:GetService("UserInputService")
    local mouse = game:GetService("Players").LocalPlayer:GetMouse()
    local rs = game:GetService("RunService")
    local categoryopacity, categorytopacity = 0, 0
    local textcolorsave = Color3.fromRGB(255, 255, 255)

    local function stroke(parent, pos, size, rot)
        local f = Instance.new("Frame")
        f.AnchorPoint = Vector2.new(0.5, 0.5)
        f.BackgroundColor3 = Themes.TextColor
        f.BorderSizePixel = 0
        f.Position = pos
        f.Size = size
        f.Rotation = rot
        Instance.new("UICorner", f).CornerRadius = UDim.new(1, 0)
        f.Parent = parent
        table.insert(Objects.TextColor, f)
        return f
    end

    local function drawcross(parent)
        stroke(parent, UDim2.new(0.5, 0, 0.5, 0), UDim2.new(0.85, 0, 0, 2), 45)
        stroke(parent, UDim2.new(0.5, 0, 0.5, 0), UDim2.new(0.85, 0, 0, 2), -45)
    end

    local function drawsearch(parent)
        parent.ClipsDescendants = true
        local holder = Instance.new("Frame")
        holder.AnchorPoint = Vector2.new(0.5, 0.5)
        holder.BackgroundTransparency = 1
        holder.Position = UDim2.new(0.5, 0, 0.5, 0)
        holder.Size = UDim2.new(0, 26, 0, 28)
        holder.Parent = parent

        local ring = Instance.new("Frame")
        ring.BackgroundTransparency = 1
        ring.Position = UDim2.new(0, 5, 0, 6)
        ring.Size = UDim2.new(0, 11, 0, 11)
        Instance.new("UICorner", ring).CornerRadius = UDim.new(1, 0)
        local st = Instance.new("UIStroke")
        st.Thickness = 2
        st.Color = Themes.TextColor
        st.Parent = ring
        ring.Parent = holder
        table.insert(Objects.TextColor, st)

        stroke(holder, UDim2.new(0, 18, 0, 19), UDim2.new(0, 9, 0, 2), 45)
    end

    function library.create(what, propri)
        local instance = Instance.new(what)

        for i, v in next, propri do
            if instance[i] and propri ~= "Parent" then
                instance[i] = v
            end
        end

        return instance
    end

    function library.initiate(setting)
        if game:GetService("CoreGui"):FindFirstChild("Antler") then
            game:GetService("CoreGui").Antler:Destroy()
        end

        local firstcategory = true

        local categoryopendname

        local main = {}

        main.screengui = library.create("ScreenGui", {
            Name = "Antler",
            ZIndexBehavior = Enum.ZIndexBehavior.Global,
            ResetOnSpawn = false,
        })

        main.notifyframe = library.create("Frame", {
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1.000,
            BorderSizePixel = 0,
            Position = UDim2.new(1, -360, 0, 0),
            Size = UDim2.new(0, 360, 1, -10),
        })

        main.notifyframe.ClipsDescendants = true

        main.notifylayout = library.create("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 10),
            VerticalAlignment = Enum.VerticalAlignment.Bottom,
        })

        main.notifyframe.ClipsDescendants = true
        function main.notify(NotificationType, NotificationText, Duration, CallBack)
            local Notifications = main.notifyframe:GetChildren()
            if #Notifications >= 5 then
                ts:Create(
                    Notifications[2],
                    TweenInfo.new(0.14, Enum.EasingStyle.Quint),
                    { Size = UDim2.new(0, 350, 0, 0) }
                ):Play()
                wait(0.15)
                Notifications[2]:Destroy()
            end
            local returnwhat = false
            local NotificationTemplate

            local Text = Instance.new("TextLabel")
            local Icon = Instance.new("ImageLabel")
            local Title = Instance.new("TextLabel")

            if not CallBack then
                NotificationTemplate = Instance.new("ImageLabel")

                NotificationTemplate.Name = "NotificationTemplate"
                NotificationTemplate.Parent = main.notifyframe
                NotificationTemplate.AnchorPoint = Vector2.new(0, 1)
                NotificationTemplate.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                NotificationTemplate.BackgroundTransparency = 1.000
                NotificationTemplate.ClipsDescendants = true
                NotificationTemplate.Position = UDim2.new(1, -360, 1, -10)
                NotificationTemplate.Size = UDim2.new(0, 350, 0, 0)
                NotificationTemplate.Image = "rbxassetid://3570695787"
                NotificationTemplate.ImageColor3 = Themes.BackgroundColor
                NotificationTemplate.ScaleType = Enum.ScaleType.Slice
                NotificationTemplate.SliceCenter = Rect.new(100, 100, 100, 100)
                NotificationTemplate.SliceScale = 0.060
            else
                NotificationTemplate = Instance.new("ImageButton")

                NotificationTemplate.Name = "NotificationTemplate"
                NotificationTemplate.Parent = main.notifyframe
                NotificationTemplate.AnchorPoint = Vector2.new(0, 1)
                NotificationTemplate.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                NotificationTemplate.BackgroundTransparency = 1.000
                NotificationTemplate.ClipsDescendants = true
                NotificationTemplate.Position = UDim2.new(1, -360, 1, -10)
                NotificationTemplate.Size = UDim2.new(0, 350, 0, 0)
                NotificationTemplate.Image = "rbxassetid://3570695787"
                NotificationTemplate.ImageColor3 = Themes.BackgroundColor
                NotificationTemplate.ScaleType = Enum.ScaleType.Slice
                NotificationTemplate.SliceCenter = Rect.new(100, 100, 100, 100)
                NotificationTemplate.SliceScale = 0.060

                NotificationTemplate.MouseEnter:Connect(function()
                    ts:Create(
                        NotificationTemplate,
                        TweenInfo.new(0.18, Enum.EasingStyle.Quint),
                        { ImageColor3 = Themes.BackgroundColor:Lerp(Color3.new(1, 1, 1), 0.18) }
                    ):Play()
                end)
                NotificationTemplate.MouseLeave:Connect(function()
                    ts:Create(
                        NotificationTemplate,
                        TweenInfo.new(0.18, Enum.EasingStyle.Quint),
                        { ImageColor3 = Themes.BackgroundColor }
                    ):Play()
                end)
                NotificationTemplate.MouseButton1Click:Connect(function()
                    ts:Create(
                        NotificationTemplate,
                        TweenInfo.new(0.14, Enum.EasingStyle.Quint),
                        { Size = UDim2.new(0, 350, 0, 0) }
                    ):Play()
                    wait(0.15)
                    NotificationTemplate:Destroy()
                    if CallBack then
                        CallBack(true)
                    end
                    returnwhat = true
                end)
            end

            Text.Name = "Text"
            Text.Parent = NotificationTemplate
            Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Text.BackgroundTransparency = 1.000
            Text.Position = UDim2.new(0, 8, 0, 25)
            Text.Size = UDim2.new(0, 334, 0, 40)
            Text.Font = Enum.Font.Gotham
            Text.Text = NotificationText
            Text.TextColor3 = Themes.TextColor
            Text.TextSize = 14.000
            Text.TextWrapped = true
            Text.TextXAlignment = Enum.TextXAlignment.Left

            Icon.Name = "Icon"
            Icon.Parent = NotificationTemplate
            Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Icon.BackgroundTransparency = 1.000
            Icon.Position = UDim2.new(0, 8, 0, 5)
            Icon.Size = UDim2.new(0, 23, 0, 23)
            Icon.ImageColor3 = Themes.TextColor

            Title.Name = "Title"
            Title.Parent = NotificationTemplate
            Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Title.BackgroundTransparency = 1.000
            Title.Position = UDim2.new(0, 40, 0, 5)
            Title.Size = UDim2.new(0, 310, 0, 23)
            Title.Font = Enum.Font.GothamBold
            Title.Text = "Notification"
            Title.TextColor3 = Themes.TextColor
            Title.TextSize = 15.000
            Title.TextWrapped = true
            Title.TextXAlignment = Enum.TextXAlignment.Left

            if NotificationType:lower() == "click here" or NotificationType:lower() == "click" then
                Title.Text = "Click here"
                Icon.Image = "http://www.roblox.com/asset/?id=6070014671"
            elseif NotificationType:lower() == "notify" or NotificationType:lower() == "notification" then
                Icon.Image = "http://www.roblox.com/asset/?id=6069122440"
                Title.Text = "Notification"
            elseif NotificationType:lower() == "error" then
                Icon.Image = "http://www.roblox.com/asset/?id=6069146108"
                Title.Text = "Error"
            end
            NotificationTemplate.Name = #Notifications + 1
            ts:Create(
                NotificationTemplate,
                TweenInfo.new(0.14, Enum.EasingStyle.Quint),
                { Size = UDim2.new(0, 350, 0, 65) }
            ):Play()
            spawn(function()
                delay((Duration or 4), function()
                    if not returnwhat then
                        if CallBack then
                            CallBack(false)
                        end
                    end
                    ts:Create(
                        NotificationTemplate,
                        TweenInfo.new(0.14, Enum.EasingStyle.Quint),
                        { Size = UDim2.new(0, 350, 0, 0) }
                    ):Play()
                    wait(0.15)
                    NotificationTemplate:Destroy()
                end)
            end)
        end

        main.mainframe = library.create("ImageLabel", {
            Name = "MainFrame",
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1.000,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Image = "rbxassetid://3570695787",
            ImageColor3 = Themes.BackgroundColor,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(100, 100, 100, 100),
            SliceScale = 0.060,
        })
        table.insert(Objects.BackgroundColor, main.mainframe)

        if setting.default then
            main.mainframe.Size = setting.default
        else
            main.mainframe.Size = UDim2.new(0, 510, 0, 425)
        end

        main.backshadow = library.create("ImageLabel", {
            Name = "RoundShadow",
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1.000,
            Position = UDim2.new(0, -35, 0, -35),
            Size = UDim2.new(1, 70, 1, 70),
            ZIndex = 0,
            Image = "http://www.roblox.com/asset/?id=5865572413",
            ImageTransparency = 0.500,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(50, 50, 50, 50),
        })

        main.navbar = library.create("ImageLabel", {
            Name = "TopNavBar",
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1.000,
            Size = UDim2.new(1, 0, 0, 38),
            Image = "http://www.roblox.com/asset/?id=5865316406",
            ImageColor3 = Themes.AccentColor,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(100, 100, 100, 100),
            SliceScale = 0.060,
        })
        main.navbar.ClipsDescendants = true
        table.insert(Objects.AccentColor, main.navbar)

        local function hasi(v, p)
            local x = v[p]
        end
        local function has(v, p)
            return pcall(function()
                hasi(v, p)
            end)
        end

        local dragging
        local dragInput
        local dragStart
        local startPos

        local function update(input)
            local delta = input.Position - dragStart
            main.mainframe:TweenPosition(
                UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y),
                "Out",
                "Quad",
                0.06,
                true
            )
        end

        main.navbar.InputBegan:Connect(function(input)
            if
                input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.Touch
            then
                dragging = true
                dragStart = input.Position
                startPos = main.mainframe.Position
                repeat
                    wait()
                until input.UserInputState == Enum.UserInputState.End
                dragging = false
            end
        end)

        main.navbar.InputChanged:Connect(function(input)
            if
                input.UserInputType == Enum.UserInputType.MouseMovement
                or input.UserInputType == Enum.UserInputType.Touch
            then
                dragInput = input
            end
        end)

        uis.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                update(input)
            end
        end)

        main.logo = library.create("TextLabel", {
            Name = "Logo",
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1.000,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Position = UDim2.new(0, 8, 0, 0),
            Size = UDim2.new(0, 200, 0, 38),
            Font = Enum.Font.GothamBold,
            Text = "Antler",
            TextColor3 = Themes.TextColor,
            TextSize = 20.000,
            TextXAlignment = Enum.TextXAlignment.Left,
        })
        table.insert(Objects.TextColor, main.logo)

        main.categorybutton = library.create("ImageButton", {
            Name = "Button",
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1.000,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            Position = UDim2.new(1, -35, 0, 4),
            Size = UDim2.new(0, 30, 0, 28),
            ZIndex = 2,
        })

        main.categorybuttonframe = library.create("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1.000,
            Position = UDim2.new(0, 15, 0, 14),
            Size = UDim2.new(0, 30, 0, 28),
        })
        main.categorybuttonframe.ClipsDescendants = true

        main.categorybuttonimagefirst = library.create("ImageLabel", {
            Name = "first",
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1.000,
            Position = UDim2.new(0, 15, 0, 7),
            Size = UDim2.new(0, 20, 0, 2),
            Image = "rbxassetid://3570695787",
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(100, 100, 100, 100),
            SliceScale = 0.050,
            ImageColor3 = Themes.TextColor,
        })
        table.insert(Objects.TextColor, main.categorybuttonimagefirst)

        main.categorybuttonimagesecond = library.create("ImageLabel", {
            Name = "second",
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1.000,
            Position = UDim2.new(0, 15, 0, 13),
            Size = UDim2.new(0, 20, 0, 2),
            Image = "rbxassetid://3570695787",
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(100, 100, 100, 100),
            SliceScale = 0.050,
            ImageColor3 = Themes.TextColor,
        })
        table.insert(Objects.TextColor, main.categorybuttonimagesecond)

        main.categorybuttonimagethird = library.create("ImageLabel", {
            Name = "third",
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1.000,
            Position = UDim2.new(0, 15, 0, 19),
            Size = UDim2.new(0, 20, 0, 2),
            Image = "rbxassetid://3570695787",
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(100, 100, 100, 100),
            SliceScale = 0.050,
            ImageColor3 = Themes.TextColor,
        })
        table.insert(Objects.TextColor, main.categorybuttonimagethird)

        main.closebuttonmark = library.create("ImageLabel", {
            Name = "CloseMark",
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1.000,
            Position = UDim2.new(0.366666704, 0, 0.464285702, 0),
            Size = UDim2.new(0, 0, 0, 0),
            ImageTransparency = 1,
            ImageColor3 = Themes.TextColor,
        })
        table.insert(Objects.TextColor, main.closebuttonmark)
        drawcross(main.closebuttonmark)

        main.searchbutton = library.create("ImageButton", {
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1.000,
            Position = UDim2.new(1, -72, 0, 4),
            Size = UDim2.new(0, 26, 0, 28),
            AutoButtonColor = false,
            ImageTransparency = 1,
        })

        if setting.resize then
            main.resizablebutton = library.create("TextButton", {
                Name = "Resizable",
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1.000,
                Position = UDim2.new(1, -20, 1, -20),
                Size = UDim2.new(0, 20, 0, 20),
                Font = Enum.Font.SourceSans,
                Text = "",
                TextColor3 = Color3.fromRGB(0, 0, 0),
                TextSize = 14.000,
            })

            main.resizablebutton.Parent = main.mainframe

            local min = setting.min
            local max = setting.max
            local connection
            local sP
            local MSS
            local size

            main.resizablebutton.MouseButton1Down:Connect(function()
                sP = Vector2.new(mouse.X, mouse.Y)
                MSS = main.mainframe.Size
                connection = rs.Heartbeat:Connect(function()
                    if sP then
                        local distance = Vector2.new(mouse.X, mouse.Y) - sP
                        size = (MSS + UDim2.new(0, distance.X, 0, distance.Y))
                        if (MSS + UDim2.new(0, distance.X, 0, distance.Y)).X.Offset <= min.X.Offset then
                            size = UDim2.new(0, min.X.Offset, 0, size.Y.Offset)
                        elseif (MSS + UDim2.new(0, distance.X, 0, distance.Y)).X.Offset >= max.X.Offset then
                            size = UDim2.new(0, max.X.Offset, 0, size.Y.Offset)
                        end

                        if (MSS + UDim2.new(0, distance.X, 0, distance.Y)).Y.Offset <= min.Y.Offset then
                            size = UDim2.new(0, size.X.Offset, 0, min.Y.Offset)
                        elseif (MSS + UDim2.new(0, distance.X, 0, distance.Y)).Y.Offset >= max.Y.Offset then
                            size = UDim2.new(0, size.X.Offset, 0, max.Y.Offset)
                        end
                        main.mainframe.Size = size
                    end
                end)
                uis.InputEnded:Connect(function(Check)
                    if
                        Check.UserInputType == Enum.UserInputType.MouseButton1
                        or Check.UserInputType == Enum.UserInputType.Touch
                    then
                        if connection then
                            connection:Disconnect()
                            connection = nil
                        end
                    end
                end)
            end)
        end

        main.categoryhandler = library.create("ImageLabel", {
            Name = "CategoryHandler",
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1.000,
            Position = UDim2.new(0, 0, 0, 38),
            Size = UDim2.new(1, 0, 1, -38),
            ImageTransparency = 1.000,
        })

        main.categoryhandlerscrolling = library.create("ScrollingFrame", {
            Name = "CategoryHandlerScrolling",
            Active = true,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1.000,
            Size = UDim2.new(1, 0, 1, 0),
            CanvasSize = UDim2.new(0, 0, 0, 0),
            ScrollBarThickness = 0,
        })

        main.categoryhandlerlayout = library.create("UIListLayout", {
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 8),
        })

        main.categoryhandlerpadding = library.create("UIPadding", {
            PaddingTop = UDim.new(0, 8),
            PaddingBottom = UDim.new(0, 8),
        })

        main.categories = library.create("ImageLabel", {
            Name = "Categories",
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1.000,
            Position = UDim2.new(0, 0, 0, 38),
            Size = UDim2.new(1, 0, 1, 0),
            ImageTransparency = 1.000,
        })

        main.closebuttonmarksearch = library.create("ImageLabel", {
            Name = "CloseMark",
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1.000,
            Position = UDim2.new(0.366666704, 0, 0.464285702, 0),
            Size = UDim2.new(0, 0, 0, 0),
            ImageTransparency = 1,
            ImageColor3 = Themes.TextColor,
        })
        table.insert(Objects.TextColor, main.closebuttonmarksearch)
        drawcross(main.closebuttonmarksearch)

        main.searchicon = library.create("ImageLabel", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1.000,
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Size = UDim2.new(0, 26, 0, 28),
            ImageTransparency = 1,
            ImageColor3 = Themes.TextColor,
        })
        table.insert(Objects.TextColor, main.searchicon)
        drawsearch(main.searchicon)

        main.searchbox = library.create("TextBox", {
            Name = "SearchBox",
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 8, 0, -38),
            Size = UDim2.new(0.8, 0, 1, 0),
            PlaceholderText = "Search...",
            PlaceholderColor3 = Color3.fromRGB(150, 150, 150),
            ClearTextOnFocus = false,
            Text = "",
            TextColor3 = Themes.TextColor,
            TextSize = 14.000,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Left,
        })
        table.insert(Objects.TextColor, main.searchbox)

        main.searchscrollingback = library.create("ImageLabel", {
            Name = "SearchScrollingBack",
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1.000,
            Position = UDim2.new(0, 0, 0, 38),
            Size = UDim2.new(1, 0, 1, -38),
            ImageTransparency = 1.000,
        })

        main.searchscrolling = library.create("ScrollingFrame", {
            Name = "CategoryHandlerScrolling",
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 1.000,
            Size = UDim2.new(1, 0, 1, 0),
            Visible = false,
            CanvasSize = UDim2.new(0, 0, 0, 344),
            ScrollBarThickness = 0,
        })

        main.searchscrollinglayout = library.create("UIListLayout", {
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 8),
        })

        local showcategories = false

        local searchid = 0

        local function norm(t)
            return (t:gsub("%s", "")):lower()
        end

        main.searchbox:GetPropertyChangedSignal("Text"):Connect(function()
            if showsearch then
                return
            end
            searchid = searchid + 1
            local id = searchid

            local query = norm(main.searchbox.Text)

            for i, v in pairs(main.categories:GetChildren()) do
                v.ScrollingFrame.Visible = false
            end

            local firstcontainer
            local firstobject

            if query ~= "" then
                for i, v in pairs(ObjectsSearch) do
                    if v.Parent then
                        local text = v:FindFirstChildOfClass("TextLabel") or v:FindFirstChildOfClass("TextBox")
                        if text and string.find(norm(text.Text), query, 1, true) then
                            local container = v
                            while container.Parent and container.Parent ~= main.categories do
                                container = container.Parent
                            end
                            if container.Parent == main.categories then
                                firstcontainer = container
                                firstobject = v
                                break
                            end
                        end
                    end
                end
            end

            if not firstcontainer then
                main.mainframe["Categories"][categoryopendname].ScrollingFrame.Visible = true
                return
            end

            local scroll = firstcontainer.ScrollingFrame
            scroll.Visible = true
            rs.Heartbeat:Wait()
            if id ~= searchid then
                return
            end
            local y = firstobject.AbsolutePosition.Y - scroll.AbsolutePosition.Y + scroll.CanvasPosition.Y - 8
            ts:Create(
                scroll,
                TweenInfo.new(0.25, Enum.EasingStyle.Quint),
                { CanvasPosition = Vector2.new(0, math.max(0, y)) }
            ):Play()
        end)

        main.categorybutton.MouseButton1Click:Connect(function()
            showcategories = not showcategories
            if showcategories then
                main.categoryhandlerscrolling.Visible = true
                ts:Create(
                    main.categorybuttonframe,
                    TweenInfo.new(0.18, Enum.EasingStyle.Quint),
                    { Size = UDim2.new(0, 0, 0, 28) }
                ):Play()
                wait(0.15)
                ts:Create(
                    main.closebuttonmark,
                    TweenInfo.new(0.18, Enum.EasingStyle.Quint),
                    { Size = UDim2.new(0, 25, 0, 25) }
                ):Play()
                for i, v in pairs(main.mainframe["Categories"]:GetChildren()) do
                    v.ScrollingFrame.Visible = false
                end

                for i, v in pairs(main.categoryhandlerscrolling:GetChildren()) do
                    if v:IsA("Frame") then
                        for a, b in pairs(v:GetChildren()) do
                            ts:Create(
                                b,
                                TweenInfo.new(0.22, Enum.EasingStyle.Quint),
                                { ImageTransparency = categoryopacity }
                            ):Play()
                            ts:Create(
                                b.Text,
                                TweenInfo.new(0.22, Enum.EasingStyle.Quint),
                                { TextTransparency = categorytopacity }
                            ):Play()
                            wait(0.02)
                        end
                    end
                end
            else
                ts:Create(
                    main.closebuttonmark,
                    TweenInfo.new(0.18, Enum.EasingStyle.Quint),
                    { Size = UDim2.new(0, 0, 0, 0) }
                ):Play()
                wait(0.15)
                ts:Create(
                    main.categorybuttonframe,
                    TweenInfo.new(0.18, Enum.EasingStyle.Quint),
                    { Size = UDim2.new(0, 30, 0, 28) }
                ):Play()
                for i, v in pairs(main.categoryhandlerscrolling:GetChildren()) do
                    if v:IsA("Frame") then
                        for a, b in pairs(v:GetChildren()) do
                            ts:Create(b, TweenInfo.new(0.22, Enum.EasingStyle.Quint), { ImageTransparency = 1 }):Play()
                            ts:Create(b.Text, TweenInfo.new(0.22, Enum.EasingStyle.Quint), { TextTransparency = 1 })
                                :Play()
                            wait()
                        end
                    end
                end
                main.categoryhandlerscrolling.Visible = false
                main.mainframe["Categories"][categoryopendname].ScrollingFrame.Visible = true
            end
        end)

        function main.category(name)
            local category = {}

            category.categorybuttonback = library.create("Frame", {
                Name = name,
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1.000,
                Position = UDim2.new(0, 0, 0, 0),
                Size = UDim2.new(0.951, 0, 0, 35),
            })

            category.categorybutton = library.create("ImageButton", {
                Name = name,
                ImageTransparency = 1,
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1.000,
                Position = UDim2.new(0, 0, 0, 0),
                Size = UDim2.new(1, 0, 0, 35),
                Image = "rbxassetid://3570695787",
                ImageColor3 = Themes.AccentColor,
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(100, 100, 100, 100),
                SliceScale = 0.060,
            })
            table.insert(Objects.AccentColor, category.categorybutton)

            category.text = library.create("TextLabel", {
                Name = "Text",
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1.000,
                TextTransparency = 1,
                BorderColor3 = Color3.fromRGB(0, 0, 0),
                Position = UDim2.new(0, 8, 0, 0),
                Size = UDim2.new(0, 200, 0, 35),
                Font = Enum.Font.GothamBold,
                Text = name,
                TextColor3 = Themes.TextColor,
                TextSize = 16,
                TextXAlignment = Enum.TextXAlignment.Left,
            })
            table.insert(Objects.TextColor, category.text)
            table.insert(categoryRegistry, { name = name, button = category.categorybutton, text = category.text })

            category.categorycontainer = library.create("ImageLabel", {
                Name = name .. "Container",
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1.000,
                Position = UDim2.new(0, 0, 0, 0),
                Size = UDim2.new(1, 0, 1, -38),
                ImageTransparency = 1.000,
            })
            category.categorycontainer.ClipsDescendants = true

            category.categoryscrolling = library.create("ScrollingFrame", {
                Visible = false,
                Active = true,
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1.000,
                Size = UDim2.new(1, 0, 1, 0),
                CanvasSize = UDim2.new(0, 0, 0, 8),
                ScrollBarThickness = 0,
            })

            category.categoryscrollinglayout = library.create("UIListLayout", {
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 8),
            })

            category.categoryscrollingpadding = library.create("UIPadding", {
                PaddingTop = UDim.new(0, 8),
                PaddingBottom = UDim.new(0, 8),
            })

            category.categorybutton.MouseButton1Click:Connect(function()
                ts:Create(
                    category.categorybutton,
                    TweenInfo.new(0.14, Enum.EasingStyle.Quint),
                    { Position = UDim2.new(0, 2, 0, 3) }
                ):Play()
                wait(0.15)
                ts:Create(
                    category.categorybutton,
                    TweenInfo.new(0.14, Enum.EasingStyle.Quint),
                    { Position = UDim2.new(0, 0, 0, 0) }
                ):Play()
                showcategories = false
                ts:Create(
                    main.closebuttonmark,
                    TweenInfo.new(0.18, Enum.EasingStyle.Quint),
                    { Size = UDim2.new(0, 0, 0, 0) }
                ):Play()
                wait(0.15)
                ts:Create(
                    main.categorybuttonframe,
                    TweenInfo.new(0.18, Enum.EasingStyle.Quint),
                    { Size = UDim2.new(0, 30, 0, 28) }
                ):Play()
                for i, v in pairs(main.categoryhandlerscrolling:GetChildren()) do
                    if v:IsA("Frame") then
                        for a, b in pairs(v:GetChildren()) do
                            ts:Create(b, TweenInfo.new(0.22, Enum.EasingStyle.Quint), { ImageTransparency = 1 }):Play()
                            ts:Create(b.Text, TweenInfo.new(0.22, Enum.EasingStyle.Quint), { TextTransparency = 1 })
                                :Play()
                            wait()
                        end
                    end
                end
                category.categoryscrolling.Visible = true
                main.categoryhandlerscrolling.Visible = false
                categoryopendname = name .. "Container"
                library:UpdateCategoryHighlight(name)
            end)

            function category.section(name)
                local sections = {}

                sections.section = library.create("ImageLabel", {
                    Name = name .. "Section",
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = 1.000,
                    Position = UDim2.new(0.12330097, -56, 0.0204081628, 0),
                    Size = UDim2.new(0.972, 0, 0, 36),
                    Image = "rbxassetid://3570695787",
                    ImageColor3 = Themes.GrayContrastColor,
                    ScaleType = Enum.ScaleType.Slice,
                    SliceCenter = Rect.new(100, 100, 100, 100),
                    SliceScale = 0.060,
                })
                table.insert(ObjectsSearch, sections.section)
                table.insert(Objects.GrayContrastColor, sections.section)

                sections.text = library.create("TextLabel", {
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = 1.000,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0.140211612, 0, 0.0627451017, 0),
                    Size = UDim2.new(0.97299999, 0, 0, 28),
                    Font = Enum.Font.GothamBold,
                    Text = name,
                    TextColor3 = Themes.TextColor,
                    TextSize = 16,
                    TextXAlignment = Enum.TextXAlignment.Left,
                })
                table.insert(Objects.TextColor, sections.text)

                sections.sectionlayout = library.create("UIListLayout", {
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Padding = UDim.new(0, 8),
                })

                function sections.button(name, callback, animated)
                    local buttons = {}

                    buttons.buttonback = library.create("Frame", {
                        Name = name .. "Button",
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1.000,
                        Position = UDim2.new(0.0155339809, 0, 0.0204081628, 0),
                        Size = UDim2.new(0.964, 0, 0, 35),
                    })

                    buttons.button = library.create("ImageButton", {
                        Name = name .. "Button",
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1.000,
                        Size = UDim2.new(1, 0, 0, 35),
                        Position = UDim2.new(0.5, 0, 0.5, 0),
                        Image = "rbxassetid://3570695787",
                        ImageColor3 = Themes.AccentColor,
                        ScaleType = Enum.ScaleType.Slice,
                        SliceCenter = Rect.new(100, 100, 100, 100),
                        SliceScale = 0.060,
                    })
                    table.insert(ObjectsSearch, buttons.button)
                    table.insert(Objects.AccentColor, buttons.button)

                    buttons.text = library.create("TextLabel", {
                        Name = "Text",
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1.000,
                        BorderColor3 = Color3.fromRGB(0, 0, 0),
                        Position = UDim2.new(0, 0, 0, 0),
                        Size = UDim2.new(1, 0, 0, 35),
                        Font = Enum.Font.GothamBold,
                        Text = name,
                        TextColor3 = Themes.TextColor,
                        TextSize = 16,
                        TextXAlignment = Enum.TextXAlignment.Center,
                    })
                    table.insert(Objects.TextColor, buttons.text)

                    buttons.button.MouseButton1Click:Connect(function()
                        if animated then
                            ts:Create(
                                buttons.button,
                                TweenInfo.new(0.14, Enum.EasingStyle.Quint),
                                { Size = UDim2.new(0.96, 0, 0, 30) }
                            ):Play()
                            wait(0.15)
                            ts:Create(
                                buttons.button,
                                TweenInfo.new(0.14, Enum.EasingStyle.Quint),
                                { Size = UDim2.new(1, 0, 0, 35) }
                            ):Play()
                        end

                        if callback then
                            callback()
                        end
                    end)

                    sections.section.Size = sections.section.Size + UDim2.new(0, 0, 0, 43)
                    category.categoryscrolling.CanvasSize = category.categoryscrolling.CanvasSize
                        + UDim2.new(0, 0, 0, 43)

                    buttons.buttonback.Parent = sections.section
                    buttons.button.Parent = buttons.buttonback
                    buttons.text.Parent = buttons.button

                    return buttons
                end

                function sections.toggle(name, callback, default)
                    local toggles = {}

                    local toggled = false

                    toggles.toggle = library.create("ImageButton", {
                        Name = name .. "Toggle",
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1.000,
                        BorderSizePixel = 0,
                        Position = UDim2.new(0.00576804997, 0, 0.055555556, 0),
                        Size = UDim2.new(0.964, 0, 0, 35),
                        Image = "rbxassetid://3570695787",
                        ImageColor3 = Themes.AccentColor,
                        ScaleType = Enum.ScaleType.Slice,
                        SliceCenter = Rect.new(100, 100, 100, 100),
                        SliceScale = 0.040,
                    })
                    table.insert(ObjectsSearch, toggles.toggle)
                    table.insert(Objects.AccentColor, toggles.toggle)

                    toggles.text = library.create("TextLabel", {
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1.000,
                        BorderSizePixel = 0,
                        Position = UDim2.new(0.00800000038, 0, 0.057, 0),
                        Size = UDim2.new(0.399576753, 0, 0.857142866, 0),
                        Font = Enum.Font.GothamBold,
                        Text = name,
                        TextColor3 = Themes.TextColor,
                        TextSize = 16,
                        TextXAlignment = Enum.TextXAlignment.Left,
                    })
                    table.insert(Objects.TextColor, toggles.text)

                    toggles.showback = library.create("ImageLabel", {
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1.000,
                        Position = UDim2.new(1, -56, 0.114, 0),
                        Size = UDim2.new(0, 50, 0, 26),
                        Image = "rbxassetid://3570695787",
                        ImageColor3 = Themes.DarkContrastColor,
                        ScaleType = Enum.ScaleType.Slice,
                        SliceCenter = Rect.new(100, 100, 100, 100),
                        SliceScale = 0.550,
                    })
                    table.insert(Objects.DarkContrastColor, toggles.showback)

                    local function refreshTrack()
                        local onColor = toggled and Themes.ToggleColor or nil
                        toggles.showback.ImageColor3 = onColor or Themes.DarkContrastColor
                        -- dark knob on light track
                        local light = onColor and (onColor.R * 0.299 + onColor.G * 0.587 + onColor.B * 0.114) > 0.7
                        toggles.show.ImageColor3 = light and Themes.DarkContrastColor or Themes.TextColor
                    end
                    table.insert(toggleRegistry, refreshTrack)

                    toggles.show = library.create("ImageLabel", {
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1.000,
                        Position = UDim2.new(0.099999994, 0, 0.115000002, 0),
                        Size = UDim2.new(0, 20, 0, 20),
                        Image = "rbxassetid://3570695787",
                        ScaleType = Enum.ScaleType.Slice,
                        SliceCenter = Rect.new(100, 100, 100, 100),
                        ImageColor3 = Themes.TextColor,
                    })
                    table.insert(Objects.TextColor, toggles.show)

                    if default then
                        toggled = default
                        refreshTrack()
                        callback(default)
                        if toggled then
                            ts
                                :Create(toggles.show, TweenInfo.new(0.18, Enum.EasingStyle.Quint), {
                                    Position = UDim2.new(0.5, 0, 0.115, 0),
                                })
                                :Play()
                        else
                            ts
                                :Create(toggles.show, TweenInfo.new(0.18, Enum.EasingStyle.Quint), {
                                    Position = UDim2.new(0.1, 0, 0.115, 0),
                                })
                                :Play()
                        end
                    end

                    toggles.toggle.MouseButton1Click:Connect(function()
                        toggled = not toggled
                        refreshTrack()

                        if toggled then
                            ts
                                :Create(toggles.show, TweenInfo.new(0.18, Enum.EasingStyle.Quint), {
                                    Position = UDim2.new(0.5, 0, 0.115, 0),
                                })
                                :Play()
                        else
                            ts
                                :Create(toggles.show, TweenInfo.new(0.18, Enum.EasingStyle.Quint), {
                                    Position = UDim2.new(0.1, 0, 0.115, 0),
                                })
                                :Play()
                        end

                        callback(toggled)
                    end)

                    function toggles:ChangeState(NewState)
                        toggled = NewState
                        refreshTrack()

                        if toggled then
                            ts
                                :Create(toggles.show, TweenInfo.new(0.18, Enum.EasingStyle.Quint), {
                                    Position = UDim2.new(0.5, 0, 0.115, 0),
                                })
                                :Play()
                        else
                            ts
                                :Create(toggles.show, TweenInfo.new(0.18, Enum.EasingStyle.Quint), {
                                    Position = UDim2.new(0.1, 0, 0.115, 0),
                                })
                                :Play()
                        end

                        callback(toggled)
                    end

                    sections.section.Size = sections.section.Size + UDim2.new(0, 0, 0, 43)
                    category.categoryscrolling.CanvasSize = category.categoryscrolling.CanvasSize
                        + UDim2.new(0, 0, 0, 43)

                    toggles.toggle.Parent = sections.section
                    toggles.text.Parent = toggles.toggle
                    toggles.showback.Parent = toggles.toggle
                    toggles.show.Parent = toggles.showback

                    return toggles
                end

                function sections.slider(name, callback, min, max, default, changablevalue, overmax)
                    local sliders = {}

                    local Value = 0

                    local connection

                    sliders.background = library.create("ImageLabel", {
                        Name = name .. "Slider",
                        BackgroundColor3 = Color3.fromRGB(248, 248, 248),
                        BackgroundTransparency = 1.000,
                        BorderColor3 = Color3.fromRGB(27, 42, 53),
                        Position = UDim2.new(0, 8, 0, 91),
                        Size = UDim2.new(0.964, 0, 0, 50),
                        Image = "rbxassetid://3570695787",
                        ImageColor3 = Themes.AccentColor,
                        ScaleType = Enum.ScaleType.Slice,
                        SliceCenter = Rect.new(100, 100, 100, 100),
                        SliceScale = 0.060,
                    })
                    table.insert(ObjectsSearch, sliders.background)
                    table.insert(Objects.AccentColor, sliders.background)

                    sliders.text = library.create("TextLabel", {
                        Name = "Text",
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1.000,
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 4, 0, 2),
                        Size = UDim2.new(0, 150, 0, 30),
                        Font = Enum.Font.GothamBold,
                        Text = name,
                        TextColor3 = Themes.TextColor,
                        TextSize = 16,
                        TextXAlignment = Enum.TextXAlignment.Left,
                    })
                    table.insert(Objects.TextColor, sliders.text)

                    if not changablevalue then
                        sliders.value = library.create("TextLabel", {
                            Name = "Value",
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1.000,
                            BorderSizePixel = 0,
                            Position = UDim2.new(0.888000011, 0, 0, 6),
                            Size = UDim2.new(0.0879999995, 0, 0, 22),
                            Font = Enum.Font.GothamBold,
                            Text = "0",
                            TextColor3 = Themes.TextColor,
                            TextSize = 16,
                            TextXAlignment = Enum.TextXAlignment.Right,
                        })
                        table.insert(Objects.TextColor, sliders.value)
                    else
                        sliders.value = library.create("TextBox", {
                            Name = "Value",
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1.000,
                            BorderSizePixel = 0,
                            Position = UDim2.new(0.78, 0, 0, 4),
                            Size = UDim2.new(0.2, 0, 0, 28),
                            ClearTextOnFocus = true,
                            Font = Enum.Font.GothamBold,
                            Text = "0",
                            TextColor3 = Themes.TextColor,
                            TextSize = 16,
                            TextXAlignment = Enum.TextXAlignment.Right,
                        })
                        table.insert(Objects.TextColor, sliders.value)
                        sliders.value.FocusLost:Connect(function()
                            if sliders.value.Text == "" then
                                sliders.value.Text = Value
                            end
                        end)
                        local function apply()
                            if not connection then
                                local number = tonumber(sliders.value.Text)
                                if not tonumber(number) then
                                    sliders.value.Text = sliders.value.Text:gsub("%D", "")
                                elseif number < min then
                                    Value = min
                                    sliders.value.Text = tostring(min)
                                elseif number > max and not overmax then
                                    Value = max
                                    sliders.value.Text = tostring(max)
                                elseif number >= max and overmax then
                                    Value = number
                                    if Value > 10000 then
                                        Value = 10000
                                        sliders.value.Text = tonumber(10000)
                                    end
                                    if callback then
                                        callback(number)
                                    end
                                    ts
                                        :Create(
                                            sliders.inner,
                                            TweenInfo.new(0.08, Enum.EasingStyle.Quad),
                                            { Size = UDim2.new(1, 0, 0, 6) }
                                        )
                                        :Play()
                                    ts
                                        :create(
                                            sliders.circle,
                                            TweenInfo.new(0.08, Enum.EasingStyle.Quad),
                                            { Position = UDim2.new(1, -7, 0, -3) }
                                        )
                                        :Play()
                                elseif number >= min and number <= max then
                                    Value = number
                                    if callback then
                                        callback(number)
                                    end
                                    local scale = (number - min) / (max - min)
                                    ts
                                        :Create(
                                            sliders.inner,
                                            TweenInfo.new(0.08, Enum.EasingStyle.Quad),
                                            { Size = UDim2.new(scale, 0, 0, 6) }
                                        )
                                        :Play()
                                    ts
                                        :create(
                                            sliders.circle,
                                            TweenInfo.new(0.08, Enum.EasingStyle.Quad),
                                            { Position = UDim2.new(scale, -7, 0, -3) }
                                        )
                                        :Play()
                                end
                            end
                        end
                        sliders.value:GetPropertyChangedSignal("Text"):Connect(function()
                            if not sliders.value:IsFocused() then
                                apply()
                            end
                        end)
                        sliders.value.FocusLost:Connect(apply)
                    end

                    sliders.slider = library.create("ImageButton", {
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1.000,
                        BorderSizePixel = 0,
                        Position = UDim2.new(0.011, 0, 0, 35),
                        Size = UDim2.new(0.968, 0, 0, 7),
                        AutoButtonColor = false,
                        Image = "rbxassetid://3570695787",
                        ImageColor3 = Themes.DarkContrastColor,
                        ScaleType = Enum.ScaleType.Slice,
                        SliceCenter = Rect.new(100, 100, 100, 100),
                        SliceScale = 0.020,
                    })
                    table.insert(Objects.DarkContrastColor, sliders.slider)

                    sliders.inner = library.create("ImageLabel", {
                        Name = "Inner",
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1.000,
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 0, 0, 0),
                        Size = UDim2.new(0, 0, 0, 8),
                        Image = "rbxassetid://3570695787",
                        ScaleType = Enum.ScaleType.Slice,
                        SliceCenter = Rect.new(100, 100, 100, 100),
                        SliceScale = 0.03,
                        ImageColor3 = Themes.TextColor,
                    })
                    table.insert(Objects.TextColor, sliders.inner)

                    sliders.circle = library.create("ImageLabel", {
                        Name = "Circle",
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1.000,
                        Position = UDim2.new(-0.000949703157, 0, 0, -3),
                        Size = UDim2.new(0, 13, 0, 13),
                        Image = "rbxassetid://3570695787",
                        ScaleType = Enum.ScaleType.Slice,
                        ImageColor3 = Themes.TextColor,
                        SliceCenter = Rect.new(100, 100, 100, 100),
                    })
                    table.insert(Objects.TextColor, sliders.circle)

                    sliders.circletransparency = library.create("ImageLabel", {
                        Name = "CircleTrasparency",
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1.000,
                        Position = UDim2.new(0.5, 0, 0.5, 0),
                        Size = UDim2.new(0, 24, 0, 24),
                        Image = "rbxassetid://3570695787",
                        ImageTransparency = 1,
                        ZIndex = 2,
                        ImageColor3 = Themes.TextColor,
                        ScaleType = Enum.ScaleType.Slice,
                        SliceCenter = Rect.new(100, 100, 100, 100),
                    })
                    table.insert(Objects.TextColor, sliders.circletransparency)

                    sliders.circle.MouseEnter:Connect(function()
                        if not connection then
                            ts:create(
                                sliders.circletransparency,
                                TweenInfo.new(0.18, Enum.EasingStyle.Quint),
                                { ImageTransparency = 0.9 }
                            ):Play()
                        end
                    end)

                    sliders.circle.MouseLeave:Connect(function()
                        if not connection then
                            ts:create(
                                sliders.circletransparency,
                                TweenInfo.new(0.18, Enum.EasingStyle.Quint),
                                { ImageTransparency = 1 }
                            ):Play()
                        end
                    end)

                    if tonumber(default) and not overmax then
                        sliders.value.Text = tostring(default)
                        if callback then
                            callback(default)
                        end
                        local scale = (default - min) / (max - min)
                        ts:Create(
                            sliders.inner,
                            TweenInfo.new(0.08, Enum.EasingStyle.Quad),
                            { Size = UDim2.new(scale, 0, 0, 6) }
                        ):Play()
                        ts:create(
                            sliders.circle,
                            TweenInfo.new(0.08, Enum.EasingStyle.Quad),
                            { Position = UDim2.new(scale, -7, 0, -3) }
                        ):Play()
                    elseif tonumber(default) and overmax then
                        sliders.value.Text = tostring(default)
                        if callback then
                            callback(default)
                        end
                        local scale
                        if tonumber(default) >= max then
                            scale = 1
                        elseif tonumber(default) < max then
                            scale = (default - min) / (max - min)
                        end
                        ts:Create(
                            sliders.inner,
                            TweenInfo.new(0.08, Enum.EasingStyle.Quad),
                            { Size = UDim2.new(scale, 0, 0, 6) }
                        ):Play()
                        ts:create(
                            sliders.circle,
                            TweenInfo.new(0.08, Enum.EasingStyle.Quad),
                            { Position = UDim2.new(scale, -7, 0, -3) }
                        ):Play()
                    end

                    local precise = (min % 1 > 0)
                    sliders.slider.MouseButton1Down:Connect(function()
                        ts:create(
                            sliders.circletransparency,
                            TweenInfo.new(0.18, Enum.EasingStyle.Quint),
                            { ImageTransparency = 0.7 }
                        ):Play()

                        connection = rs.Heartbeat:Connect(function()
                            local scale = math.clamp(
                                mouse.X - sliders.slider.AbsolutePosition.X,
                                0,
                                sliders.slider.AbsoluteSize.X
                            ) / sliders.slider.AbsoluteSize.X
                            if precise then
                                Value = string.format("%.1f", min + ((max - min) * scale))
                            else
                                Value = math.floor(min + ((max - min) * scale))
                            end
                            sliders.value.Text = tostring(Value)

                            if callback then
                                callback(Value)
                            end

                            ts:Create(
                                sliders.inner,
                                TweenInfo.new(0.08, Enum.EasingStyle.Quad),
                                { Size = UDim2.new(scale, 0, 0, 6) }
                            ):Play()
                            ts:create(
                                sliders.circle,
                                TweenInfo.new(0.08, Enum.EasingStyle.Quad),
                                { Position = UDim2.new(scale, -8, 0, -3) }
                            ):Play()
                        end)

                        uis.InputEnded:Connect(function(Check)
                            if
                                Check.UserInputType == Enum.UserInputType.MouseButton1
                                or Check.UserInputType == Enum.UserInputType.Touch
                            then
                                if connection then
                                    ts
                                        :create(
                                            sliders.circletransparency,
                                            TweenInfo.new(0.18, Enum.EasingStyle.Quint),
                                            { ImageTransparency = 1 }
                                        )
                                        :Play()
                                    connection:Disconnect()
                                    connection = nil
                                end
                            end
                        end)
                    end)

                    sections.section.Size = sections.section.Size + UDim2.new(0, 0, 0, 58)
                    category.categoryscrolling.CanvasSize = category.categoryscrolling.CanvasSize
                        + UDim2.new(0, 0, 0, 58)

                    sliders.background.Parent = sections.section
                    sliders.text.Parent = sliders.background
                    sliders.value.Parent = sliders.background
                    sliders.slider.Parent = sliders.background
                    sliders.inner.Parent = sliders.slider
                    sliders.circle.Parent = sliders.slider
                    sliders.circletransparency.Parent = sliders.circle

                    return sliders
                end

                function sections.textbox(name, callback, placeholder)
                    local textboxes = {}

                    textboxes.background = library.create("ImageLabel", {
                        Name = name .. "Textbox",
                        BackgroundColor3 = Color3.fromRGB(248, 248, 248),
                        BackgroundTransparency = 1.000,
                        BorderSizePixel = 0,
                        Position = UDim2.new(0.0192307699, 0, 0.467741936, 0),
                        Size = UDim2.new(0.964, 0, 0, 35),
                        Image = "rbxassetid://3570695787",
                        ImageColor3 = Themes.AccentColor,
                        ScaleType = Enum.ScaleType.Slice,
                        SliceCenter = Rect.new(100, 100, 100, 100),
                        SliceScale = 0.040,
                    })
                    table.insert(ObjectsSearch, textboxes.background)
                    table.insert(Objects.AccentColor, textboxes.background)

                    textboxes.text = library.create("TextLabel", {
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1.000,
                        Position = UDim2.new(0, 4, 0, 2),
                        Size = UDim2.new(0.400000006, 0, 0, 30),
                        Font = Enum.Font.GothamBold,
                        Text = name,
                        TextColor3 = Themes.TextColor,
                        TextSize = 16,
                        TextXAlignment = Enum.TextXAlignment.Left,
                    })
                    table.insert(Objects.TextColor, textboxes.text)

                    textboxes.textboxbox = library.create("ImageLabel", {
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1.000,
                        BorderSizePixel = 0,
                        Position = UDim2.new(0.587970376, 0, 0.114, 0),
                        Size = UDim2.new(0.400000006, 0, 0, 26),
                        Image = "rbxassetid://3570695787",
                        ImageColor3 = Themes.DarkContrastColor,
                        ScaleType = Enum.ScaleType.Slice,
                        SliceCenter = Rect.new(100, 100, 100, 100),
                        SliceScale = 0.040,
                    })
                    table.insert(Objects.DarkContrastColor, textboxes.textboxbox)

                    textboxes.textbox = library.create("TextBox", {
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1.000,
                        Position = UDim2.new(0, 0, 0.0384615399, 0),
                        Size = UDim2.new(0.966, 0, 0, 23),
                        Font = Enum.Font.GothamBold,
                        PlaceholderText = "",
                        Text = "",
                        TextColor3 = Themes.TextColor,
                        TextSize = 14.000,
                        TextXAlignment = Enum.TextXAlignment.Right,
                    })
                    table.insert(Objects.TextColor, textboxes.textbox)
                    textboxes.textbox.TextWrapped = true

                    if placeholder then
                        textboxes.textbox.PlaceholderText = placeholder
                    end

                    textboxes.textbox.FocusLost:Connect(function()
                        local text = textboxes.textbox.Text

                        if callback then
                            callback(text)
                        end
                    end)

                    sections.section.Size = sections.section.Size + UDim2.new(0, 0, 0, 43)
                    category.categoryscrolling.CanvasSize = category.categoryscrolling.CanvasSize
                        + UDim2.new(0, 0, 0, 43)

                    textboxes.background.Parent = sections.section
                    textboxes.text.Parent = textboxes.background
                    textboxes.textboxbox.Parent = textboxes.background
                    textboxes.textbox.Parent = textboxes.textboxbox

                    return textboxes
                end

                function sections.label(name)
                    local labels = {}

                    labels.background = library.create("ImageLabel", {
                        Name = name .. "Label",
                        BackgroundColor3 = Color3.fromRGB(248, 248, 248),
                        BackgroundTransparency = 1.000,
                        BorderSizePixel = 0,
                        Position = UDim2.new(0.0192307699, 0, 0.467741936, 0),
                        Size = UDim2.new(0.964, 0, 0, 35),
                        Image = "rbxassetid://3570695787",
                        ImageColor3 = Themes.AccentColor,
                        ScaleType = Enum.ScaleType.Slice,
                        SliceCenter = Rect.new(100, 100, 100, 100),
                        SliceScale = 0.040,
                    })
                    table.insert(ObjectsSearch, labels.background)
                    table.insert(Objects.AccentColor, labels.background)

                    labels.text = library.create("TextLabel", {
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1.000,
                        Position = UDim2.new(0, 4, 0, 0),
                        Size = UDim2.new(0.991999984, 0, 0, 35),
                        Font = Enum.Font.GothamBold,
                        TextColor3 = Themes.TextColor,
                        TextSize = 16,
                        Text = name,
                        TextXAlignment = Enum.TextXAlignment.Left,
                    })
                    table.insert(Objects.TextColor, labels.text)

                    sections.section.Size = sections.section.Size + UDim2.new(0, 0, 0, 43)
                    category.categoryscrolling.CanvasSize = category.categoryscrolling.CanvasSize
                        + UDim2.new(0, 0, 0, 43)

                    labels.background.Parent = sections.section
                    labels.text.Parent = labels.background

                    return labels
                end

                function sections.keybind(name, callback, default)
                    local keybinds = {}

                    local bind = nil

                    local changing

                    local inputconnection

                    local checkconnection
                    keybinds.background = library.create("ImageLabel", {
                        Name = name .. "KeyBind",
                        BackgroundColor3 = Color3.fromRGB(248, 248, 248),
                        BackgroundTransparency = 1.000,
                        BorderColor3 = Color3.fromRGB(27, 42, 53),
                        Position = UDim2.new(0, 10, 0, 235),
                        Size = UDim2.new(0.963999987, 0, 0, 35),
                        Image = "rbxassetid://3570695787",
                        ImageColor3 = Themes.AccentColor,
                        ScaleType = Enum.ScaleType.Slice,
                        SliceCenter = Rect.new(100, 100, 100, 100),
                        SliceScale = 0.040,
                    })
                    table.insert(ObjectsSearch, keybinds.background)
                    table.insert(Objects.AccentColor, keybinds.background)

                    keybinds.text = library.create("TextLabel", {
                        Name = "Text",
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1.000,
                        BorderSizePixel = 0,
                        Position = UDim2.new(0.00800000038, 0, 0, 2),
                        Size = UDim2.new(0.400000006, 0, 0, 30),
                        Font = Enum.Font.GothamBold,
                        Text = name,
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        TextSize = 16,
                        TextXAlignment = Enum.TextXAlignment.Left,
                    })
                    table.insert(Objects.TextColor, keybinds.text)

                    keybinds.keybind = library.create("ImageButton", {
                        Name = "Button",
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1.000,
                        BorderSizePixel = 0,
                        Position = UDim2.new(1, -126, 0, 4),
                        Size = UDim2.new(0, 120, 0, 26),
                        AutoButtonColor = false,
                        Image = "rbxassetid://3570695787",
                        ImageColor3 = Themes.DarkContrastColor,
                        ScaleType = Enum.ScaleType.Slice,
                        SliceCenter = Rect.new(100, 100, 100, 100),
                        SliceScale = 0.040,
                    })
                    table.insert(Objects.DarkContrastColor, keybinds.keybind)

                    keybinds.key = library.create("TextLabel", {
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1.000,
                        BorderSizePixel = 0,
                        Position = UDim2.new(0.639999986, -30, 0, 0),
                        Size = UDim2.new(0, 30, 1, 0),
                        Font = Enum.Font.GothamBold,
                        Text = "None",
                        TextColor3 = Themes.TextColor,
                        TextSize = 16,
                    })
                    table.insert(Objects.TextColor, keybinds.key)

                    keybinds.background.Parent = sections.section
                    keybinds.keybind.Parent = keybinds.background
                    keybinds.text.Parent = keybinds.background
                    keybinds.key.Parent = keybinds.keybind

                    if default then
                        bind = default
                        keybinds.key.Text = bind.Name
                    end

                    -- make the key box only as wide as the key name
                    local function fitKeyBox()
                        local ok, size = pcall(function()
                            return game:GetService("TextService"):GetTextSize(
                                keybinds.key.Text,
                                keybinds.key.TextSize,
                                keybinds.key.Font,
                                Vector2.new(1000, 1000)
                            )
                        end)
                        local w = math.max(28, (ok and size.X or 20) + 16)
                        keybinds.keybind.Size = UDim2.new(0, w, 0, 26)
                        keybinds.keybind.Position = UDim2.new(1, -(w + 6), 0, 4)
                        keybinds.key.Position = UDim2.new(0, 0, 0, 0)
                        keybinds.key.Size = UDim2.new(1, 0, 1, 0)
                    end
                    keybinds.key:GetPropertyChangedSignal("Text"):Connect(fitKeyBox)
                    fitKeyBox()

                    keybinds.keybind.MouseButton1Click:Connect(function()
                        changing = true
                        keybinds.key.Text = "..."
                        connection = uis.InputBegan:Connect(function(i)
                            if i.UserInputType.Name == "Keyboard" and i.KeyCode ~= Enum.KeyCode.Backspace then
                                keybinds.key.Text = i.KeyCode.Name
                                bind = i.KeyCode
                                if connection then
                                    connection:Disconnect()
                                    connection = nil
                                    wait(0.15)
                                    changing = false
                                end
                            elseif i.KeyCode == Enum.KeyCode.Backspace then
                                keybinds.key.Text = "None"
                                bind = nil
                                if connection then
                                    connection:Disconnect()
                                    connection = nil
                                    wait(0.15)
                                    changing = false
                                end
                            end
                        end)
                    end)

                    inputconnection = uis.InputBegan:Connect(function(i, GPE)
                        if bind and i.KeyCode == bind and not GPE and not connection then
                            if callback and not changing then
                                callback(i.KeyCode)
                            end
                        end
                    end)

                    checkconnection = game:GetService("CoreGui").ChildRemoved:Connect(function(child)
                        if child.Name == "Antler" then
                            if inputconnection then
                                inputconnection:Disconnect()
                                inputconnection = nil
                            end
                            if checkconnection then
                                checkconnection:Disconnect()
                                checkconnection = nil
                            end
                        end
                    end)

                    sections.section.Size = sections.section.Size + UDim2.new(0, 0, 0, 43)
                    category.categoryscrolling.CanvasSize = category.categoryscrolling.CanvasSize
                        + UDim2.new(0, 0, 0, 43)

                    return keybinds
                end

                function sections.dropdown(name, callback, options, playerlist, search, beforeopen)
                    local dropdowns
                    local function revealList()
                        local scroll = category.categoryscrolling
                        local view = scroll.AbsoluteWindowSize.Y
                        local top = dropdowns.background.AbsolutePosition.Y
                            - scroll.AbsolutePosition.Y
                            + scroll.CanvasPosition.Y
                        local limit = scroll.CanvasSize.Y.Offset + 125 - view
                        local target = math.clamp(top + 154 + 8 - view, 0, math.max(0, limit))
                        if target > scroll.CanvasPosition.Y then
                            ts:Create(
                                scroll,
                                TweenInfo.new(0.18, Enum.EasingStyle.Quint),
                                { CanvasPosition = Vector2.new(0, target) }
                            ):Play()
                        end
                    end

                    if search then
                        local tableA = {}

                        dropdowns = {}

                        local listopend = false

                        local SearchLock = true

                        local lastText = name

                        local selectedvalue

                        if options and not playerlist then
                            tableA = {}
                            tableA = options
                        elseif options and playerlist then
                            tableA = {}
                            for i, v in pairs(options) do
                                table.insert(tableA, v)
                            end
                            local list = game:GetService("Players")
                            for a, b in pairs(list:GetChildren()) do
                                if b:IsA("Player") then
                                    table.insert(tableA, b.Name)
                                end
                            end
                        elseif not options and playerlist then
                            tableA = {}
                            local list = game:GetService("Players")
                            for a, b in pairs(list:GetChildren()) do
                                if b:IsA("Player") then
                                    table.insert(tableA, b.Name)
                                end
                            end
                        end

                        dropdowns.background = library.create("ImageLabel", {
                            Name = name .. "DropDown",
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1.000,
                            BorderColor3 = Color3.fromRGB(27, 42, 53),
                            ClipsDescendants = true,
                            Position = UDim2.new(0, 11, 0, 40),
                            Size = UDim2.new(0.963999987, 0, 0, 30),
                            Image = "rbxassetid://3570695787",
                            ImageColor3 = Color3.fromRGB(29, 29, 35),
                            ImageTransparency = 1.000,
                            ScaleType = Enum.ScaleType.Slice,
                            SliceCenter = Rect.new(100, 100, 100, 100),
                            SliceScale = 0.040,
                        })
                        dropdowns.background.ClipsDescendants = true

                        dropdowns.background2 = library.create("ImageLabel", {
                            Name = "Background",
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1.000,
                            BorderColor3 = Color3.fromRGB(27, 42, 53),
                            Size = UDim2.new(1, 0, 0, 30),
                            Image = "rbxassetid://3570695787",
                            ImageColor3 = Themes.AccentColor,
                            ScaleType = Enum.ScaleType.Slice,
                            SliceCenter = Rect.new(100, 100, 100, 100),
                            SliceScale = 0.040,
                        })
                        table.insert(ObjectsSearch, dropdowns.background2)
                        table.insert(Objects.AccentColor, dropdowns.background2)

                        dropdowns.textbox = library.create("TextBox", {
                            ClearTextOnFocus = false,
                            Active = true,
                            BackgroundColor3 = Color3.fromRGB(248, 248, 248),
                            BackgroundTransparency = 1.000,
                            BorderSizePixel = 0,
                            Position = UDim2.new(0.00800000038, 0, 0, 0),
                            Selectable = true,
                            Size = UDim2.new(0.75, 0, 1, 0),
                            Font = Enum.Font.GothamBold,
                            TextColor3 = Color3.fromRGB(255, 255, 255),
                            TextSize = 16,
                            Text = name,
                            TextXAlignment = Enum.TextXAlignment.Left,
                        })
                        table.insert(Objects.TextColor, dropdowns.textbox)

                        dropdowns.arrow = library.create("ImageButton", {
                            Name = "Arrow",
                            BackgroundColor3 = Color3.fromRGB(248, 248, 248),
                            BackgroundTransparency = 1.000,
                            BorderColor3 = Color3.fromRGB(27, 42, 53),
                            BorderSizePixel = 0,
                            Position = UDim2.new(1, -32, 0.0333333351, 0),
                            Rotation = 90.000,
                            AutoButtonColor = false,
                            ImageColor3 = Themes.TextColor,
                            Size = UDim2.new(0, 28, 0, 28),
                            Image = "http://www.roblox.com/asset/?id=5054982349",
                        })
                        table.insert(Objects.TextColor, dropdowns.arrow)

                        dropdowns.backgroundlist = library.create("ImageLabel", {
                            Name = "Backgroundlist",
                            BackgroundColor3 = Color3.fromRGB(248, 248, 248),
                            BackgroundTransparency = 1.000,
                            BorderColor3 = Color3.fromRGB(27, 42, 53),
                            Position = UDim2.new(0, 0, 0, 40),
                            Size = UDim2.new(1, 0, 0, 120),
                            ZIndex = 2,
                            Image = "rbxassetid://3570695787",
                            ImageColor3 = Color3.fromRGB(
                                math.floor(Themes.GrayContrastColor.r * 255) - 3,
                                math.floor(Themes.GrayContrastColor.g * 255) - 3,
                                math.floor(Themes.GrayContrastColor.b * 255) - 3
                            ),
                            ScaleType = Enum.ScaleType.Slice,
                            SliceCenter = Rect.new(100, 100, 100, 100),
                            SliceScale = 0.040,
                        })
                        table.insert(Objects.GrayContrastColor, dropdowns.backgroundlist)

                        dropdowns.list = library.create("ScrollingFrame", {
                            BackgroundColor3 = Color3.fromRGB(29, 29, 35),
                            BackgroundTransparency = 1.000,
                            BorderSizePixel = 0,
                            Size = UDim2.new(1, 0, 1, 0),
                            ZIndex = 2,
                            CanvasSize = UDim2.new(0, 0, 0, 0),
                            ScrollBarImageColor3 = Color3.fromRGB(35 - 5, 35 - 5, 35 - 5),
                            ScrollBarThickness = 3,
                        })

                        dropdowns.listlayout = library.create("UIListLayout", {
                            SortOrder = Enum.SortOrder.LayoutOrder,
                            Padding = UDim.new(0, 10),
                        })

                        dropdowns.listpadding = library.create("UIPadding", {
                            PaddingBottom = UDim.new(0, 10),
                            PaddingLeft = UDim.new(0, 10),
                            PaddingTop = UDim.new(0, 10),
                        })

                        local function HideShowList()
                            if not listopend then
                                ts
                                    :Create(
                                        dropdowns.arrow,
                                        TweenInfo.new(0.18, Enum.EasingStyle.Quint),
                                        { Rotation = 90 }
                                    )
                                    :Play()
                                ts
                                    :Create(
                                        sections.section,
                                        TweenInfo.new(0.18, Enum.EasingStyle.Quint),
                                        { Size = sections.section.Size - UDim2.new(0, 0, 0, 125) }
                                    )
                                    :Play()
                                ts
                                    :Create(
                                        category.categoryscrolling,
                                        TweenInfo.new(0.18, Enum.EasingStyle.Quint),
                                        { CanvasSize = category.categoryscrolling.CanvasSize - UDim2.new(0, 0, 0, 125) }
                                    )
                                    :Play()
                                ts
                                    :Create(
                                        dropdowns.background,
                                        TweenInfo.new(0.18, Enum.EasingStyle.Quint),
                                        { Size = UDim2.new(0.964, 0, 0, 30) }
                                    )
                                    :Play()
                            else
                                ts
                                    :Create(
                                        dropdowns.arrow,
                                        TweenInfo.new(0.18, Enum.EasingStyle.Quint),
                                        { Rotation = 0 }
                                    )
                                    :Play()
                                ts
                                    :Create(
                                        sections.section,
                                        TweenInfo.new(0.18, Enum.EasingStyle.Quint),
                                        { Size = sections.section.Size + UDim2.new(0, 0, 0, 125) }
                                    )
                                    :Play()
                                ts
                                    :Create(dropdowns.list, TweenInfo.new(0.18, Enum.EasingStyle.Quint), {
                                        CanvasSize = UDim2.new(
                                            0,
                                            0,
                                            0,
                                            dropdowns.list["UIListLayout"].AbsoluteContentSize.Y
                                        ) + UDim2.new(0, 0, 0, 26),
                                    })
                                    :Play()
                                ts
                                    :Create(
                                        category.categoryscrolling,
                                        TweenInfo.new(0.18, Enum.EasingStyle.Quint),
                                        { CanvasSize = category.categoryscrolling.CanvasSize + UDim2.new(0, 0, 0, 125) }
                                    )
                                    :Play()
                                revealList()
                                ts
                                    :Create(
                                        dropdowns.background,
                                        TweenInfo.new(0.18, Enum.EasingStyle.Quint),
                                        { Size = UDim2.new(0.964, 0, 0, 154) }
                                    )
                                    :Play()
                            end
                        end

                        local function RefreshList()
                            for a, b in pairs(dropdowns.list:GetChildren()) do
                                if b:IsA("ImageButton") then
                                    b:Destroy()
                                end
                            end

                            for i, v in pairs(tableA) do
                                local button = library.create("ImageButton", {
                                    Name = string.lower(v),
                                    AnchorPoint = Vector2.new(0.5, 0.5),
                                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                    BackgroundTransparency = 1.000,
                                    BorderColor3 = Color3.fromRGB(27, 42, 53),
                                    Position = UDim2.new(0, 252, 0, 0),
                                    Size = UDim2.new(0.98, 0, 0, 30),
                                    ZIndex = 2,
                                    AutoButtonColor = false,
                                    Image = "rbxassetid://3570695787",
                                    ImageColor3 = Themes.AccentColor,
                                    ScaleType = Enum.ScaleType.Slice,
                                    SliceCenter = Rect.new(100, 100, 100, 100),
                                    SliceScale = 0.040,
                                })
                                table.insert(Objects.AccentColor, button)

                                local buttontext = library.create("TextLabel", {
                                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                    BackgroundTransparency = 1.000,
                                    BorderSizePixel = 0,
                                    Position = UDim2.new(0.078, 0, 0, 0),
                                    Size = UDim2.new(0.833, 0, 1, 0),
                                    ZIndex = 2,
                                    Font = Enum.Font.GothamBold,
                                    Text = v,
                                    TextColor3 = Themes.TextColor,
                                    TextSize = 16,
                                })
                                table.insert(Objects.TextColor, buttontext)

                                button.Parent = dropdowns.list
                                buttontext.Parent = button

                                button.MouseButton1Click:Connect(function()
                                    if listopend then
                                        listopend = not listopend
                                        dropdowns.textbox.Text = v
                                        lastText = v

                                        HideShowList()

                                        if callback then
                                            callback(v)
                                        end
                                    end
                                end)
                            end
                        end

                        local Found = {}
                        local searchtable = {}

                        for f, h in pairs(tableA) do
                            table.insert(searchtable, string.lower(h))
                        end

                        RefreshList()

                        dropdowns.textbox.Focused:Connect(function()
                            if dropdowns.textbox.Text ~= "" then
                                lastText = dropdowns.textbox.Text
                            end
                            dropdowns.textbox.Text = ""
                            SearchLock = false
                            if not listopend then
                                if beforeopen then
                                    local newtable = beforeopen()
                                    tableA = newtable
                                    for f, h in pairs(tableA) do
                                        table.insert(searchtable, string.lower(h))
                                    end
                                end
                                if options and playerlist then
                                    tableA = {}
                                    for i, v in pairs(options) do
                                        table.insert(tableA, v)
                                    end
                                    local list = game:GetService("Players")
                                    for a, b in pairs(list:GetChildren()) do
                                        if b:IsA("Player") then
                                            table.insert(tableA, b.Name)
                                        end
                                    end
                                elseif not options and playerlist then
                                    tableA = {}
                                    local list = game:GetService("Players")
                                    for i, v in pairs(list:GetChildren()) do
                                        if v:IsA("Player") then
                                            table.insert(tableA, v.Name)
                                        end
                                    end
                                end
                                listopend = not listopend
                                HideShowList()
                                RefreshList()
                            end
                        end)

                        -- tap opens keyboard on mobile
                        dropdowns.textbox.InputBegan:Connect(function(input)
                            if
                                input.UserInputType == Enum.UserInputType.Touch
                                or input.UserInputType == Enum.UserInputType.MouseButton1
                            then
                                if not dropdowns.textbox:IsFocused() then
                                    dropdowns.textbox:CaptureFocus()
                                end
                            end
                        end)

                        dropdowns.arrow.MouseButton1Click:Connect(function()
                            listopend = not listopend
                            if beforeopen then
                                local newtable = beforeopen()
                                tableA = newtable
                                for f, h in pairs(tableA) do
                                    table.insert(searchtable, string.lower(h))
                                end
                            end
                            if options and playerlist then
                                tableA = {}
                                for i, v in pairs(options) do
                                    table.insert(tableA, v)
                                end
                                local list = game:GetService("Players")
                                for a, b in pairs(list:GetChildren()) do
                                    if b:IsA("Player") then
                                        table.insert(tableA, b.Name)
                                    end
                                end
                            elseif not options and playerlist then
                                tableA = {}
                                local list = game:GetService("Players")
                                for i, v in pairs(list:GetChildren()) do
                                    if v:IsA("Player") then
                                        table.insert(tableA, v.Name)
                                    end
                                end
                            end
                            HideShowList()
                            RefreshList()
                        end)

                        local function Search()
                            local q = string.lower(dropdowns.textbox.Text)
                            local count = 0
                            for _, b in ipairs(dropdowns.list:GetChildren()) do
                                if b:IsA("ImageButton") then
                                    local show = q == "" or string.find(b.Name, q, 1, true) ~= nil
                                    b.Visible = show
                                    if show then
                                        count = count + 1
                                    end
                                end
                            end
                            dropdowns.list.CanvasSize = UDim2.new(0, 0, 0, count * 40 + 20)
                        end

                        local function Nil()
                            for i, v in pairs(dropdowns.list:GetChildren()) do
                                if not v:IsA("UIListLayout") and not v:IsA("UIPadding") and v.Visible == false then
                                    ts
                                        :Create(dropdowns.list, TweenInfo.new(0.18, Enum.EasingStyle.Quint), {
                                            CanvasSize = UDim2.new(
                                                0,
                                                0,
                                                0,
                                                dropdowns.list["UIListLayout"].AbsoluteContentSize.Y
                                            ) + UDim2.new(0, 0, 0, 26),
                                        })
                                        :Play()
                                    v.Visible = true
                                end
                            end
                        end

                        dropdowns.textbox:GetPropertyChangedSignal("Text"):Connect(function()
                            if not SearchLock then
                                Search()
                            end
                            if dropdowns.textbox.Text == "" then
                                Nil()
                                ts
                                    :Create(dropdowns.list, TweenInfo.new(0.18, Enum.EasingStyle.Quint), {
                                        CanvasSize = UDim2.new(
                                            0,
                                            0,
                                            0,
                                            dropdowns.list["UIListLayout"].AbsoluteContentSize.Y
                                        ) + UDim2.new(0, 0, 0, 26),
                                    })
                                    :Play()
                            end
                        end)

                        dropdowns.textbox.FocusLost:connect(function()
                            SearchLock = true
                            dropdowns.textbox.Text = lastText
                        end)

                        sections.section.Size = sections.section.Size + UDim2.new(0, 0, 0, 38)
                        category.categoryscrolling.CanvasSize = category.categoryscrolling.CanvasSize
                            + UDim2.new(0, 0, 0, 38)

                        dropdowns.background.Parent = sections.section
                        dropdowns.background2.Parent = dropdowns.background
                        dropdowns.arrow.Parent = dropdowns.background2
                        dropdowns.textbox.Parent = dropdowns.background2
                        dropdowns.backgroundlist.Parent = dropdowns.background
                        dropdowns.list.Parent = dropdowns.backgroundlist
                        dropdowns.listlayout.Parent = dropdowns.list
                        dropdowns.listpadding.Parent = dropdowns.list
                    else
                        dropdowns = {}

                        local tableA = {}
                        local lastsig

                        local listopend = false

                        local SearchLock = true

                        local selectedvalue

                        if options and not playerlist then
                            tableA = {}
                            tableA = options
                        elseif options and playerlist then
                            tableA = {}
                            for i, v in pairs(options) do
                                table.insert(tableA, v)
                            end
                            local list = game:GetService("Players")
                            for a, b in pairs(list:GetChildren()) do
                                if b:IsA("Player") then
                                    table.insert(tableA, b.Name)
                                end
                            end
                        elseif not options and playerlist then
                            tableA = {}
                            local list = game:GetService("Players")
                            for a, b in pairs(list:GetChildren()) do
                                if b:IsA("Player") then
                                    table.insert(tableA, b.Name)
                                end
                            end
                        end

                        dropdowns.background = library.create("ImageLabel", {
                            Name = name .. "DropDown",
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1.000,
                            BorderColor3 = Color3.fromRGB(27, 42, 53),
                            ClipsDescendants = true,
                            Position = UDim2.new(0, 11, 0, 40),
                            Size = UDim2.new(0.963999987, 0, 0, 30),
                            Image = "rbxassetid://3570695787",
                            ImageColor3 = Color3.fromRGB(29, 29, 35),
                            ImageTransparency = 1.000,
                            ScaleType = Enum.ScaleType.Slice,
                            SliceCenter = Rect.new(100, 100, 100, 100),
                            SliceScale = 0.040,
                        })
                        dropdowns.background.ClipsDescendants = true

                        dropdowns.background2 = library.create("ImageButton", {
                            Name = "Background",
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1.000,
                            BorderColor3 = Color3.fromRGB(27, 42, 53),
                            Size = UDim2.new(1, 0, 0, 30),
                            Image = "rbxassetid://3570695787",
                            ImageColor3 = Themes.AccentColor,
                            AutoButtonColor = false,
                            ScaleType = Enum.ScaleType.Slice,
                            SliceCenter = Rect.new(100, 100, 100, 100),
                            SliceScale = 0.040,
                        })
                        table.insert(ObjectsSearch, dropdowns.background2)
                        table.insert(Objects.AccentColor, dropdowns.background2)

                        dropdowns.textbox = library.create("TextLabel", {
                            Active = false,
                            BackgroundColor3 = Color3.fromRGB(248, 248, 248),
                            BackgroundTransparency = 1.000,
                            BorderSizePixel = 0,
                            Position = UDim2.new(0.00800000038, 0, 0, 0),
                            Selectable = false,
                            Size = UDim2.new(0.2, 0, 1, 0),
                            Font = Enum.Font.GothamBold,
                            TextColor3 = Themes.TextColor,
                            TextSize = 16,
                            Text = name,
                            TextXAlignment = Enum.TextXAlignment.Left,
                        })
                        table.insert(Objects.TextColor, dropdowns.textbox)

                        dropdowns.arrow = library.create("ImageButton", {
                            Name = "Arrow",
                            BackgroundColor3 = Color3.fromRGB(248, 248, 248),
                            BackgroundTransparency = 1.000,
                            BorderColor3 = Color3.fromRGB(27, 42, 53),
                            BorderSizePixel = 0,
                            Position = UDim2.new(1, -32, 0.0333333351, 0),
                            Rotation = 90.000,
                            AutoButtonColor = false,
                            ImageColor3 = Themes.TextColor,
                            Size = UDim2.new(0, 28, 0, 28),
                            Image = "http://www.roblox.com/asset/?id=5054982349",
                        })
                        table.insert(Objects.TextColor, dropdowns.arrow)

                        dropdowns.backgroundlist = library.create("ImageLabel", {
                            Name = "Backgroundlist",
                            BackgroundColor3 = Color3.fromRGB(248, 248, 248),
                            BackgroundTransparency = 1.000,
                            BorderColor3 = Color3.fromRGB(27, 42, 53),
                            Position = UDim2.new(0, 0, 0, 40),
                            Size = UDim2.new(1, 0, 0, 120),
                            ZIndex = 2,
                            Image = "rbxassetid://3570695787",
                            ImageColor3 = Color3.fromRGB(
                                math.floor(Themes.GrayContrastColor.r * 255) - 3,
                                math.floor(Themes.GrayContrastColor.g * 255) - 3,
                                math.floor(Themes.GrayContrastColor.b * 255) - 3
                            ),
                            ScaleType = Enum.ScaleType.Slice,
                            SliceCenter = Rect.new(100, 100, 100, 100),
                            SliceScale = 0.040,
                        })
                        table.insert(Objects.GrayContrastColor, dropdowns.backgroundlist)

                        dropdowns.list = library.create("ScrollingFrame", {
                            BackgroundColor3 = Color3.fromRGB(29, 29, 35),
                            BackgroundTransparency = 1.000,
                            BorderSizePixel = 0,
                            Size = UDim2.new(1, 0, 1, 0),
                            ZIndex = 2,
                            CanvasSize = UDim2.new(0, 0, 0, 0),
                            ScrollBarImageColor3 = Color3.fromRGB(35 - 5, 35 - 5, 35 - 5),
                            ScrollBarThickness = 3,
                        })

                        dropdowns.listlayout = library.create("UIListLayout", {
                            SortOrder = Enum.SortOrder.LayoutOrder,
                            Padding = UDim.new(0, 10),
                        })

                        dropdowns.listpadding = library.create("UIPadding", {
                            PaddingBottom = UDim.new(0, 10),
                            PaddingLeft = UDim.new(0, 10),
                            PaddingTop = UDim.new(0, 10),
                        })

                        local function HideShowList()
                            if not listopend then
                                ts
                                    :Create(
                                        dropdowns.arrow,
                                        TweenInfo.new(0.18, Enum.EasingStyle.Quint),
                                        { Rotation = 90 }
                                    )
                                    :Play()
                                ts
                                    :Create(
                                        sections.section,
                                        TweenInfo.new(0.18, Enum.EasingStyle.Quint),
                                        { Size = sections.section.Size - UDim2.new(0, 0, 0, 125) }
                                    )
                                    :Play()
                                ts
                                    :Create(
                                        category.categoryscrolling,
                                        TweenInfo.new(0.18, Enum.EasingStyle.Quint),
                                        { CanvasSize = category.categoryscrolling.CanvasSize - UDim2.new(0, 0, 0, 125) }
                                    )
                                    :Play()
                                ts
                                    :Create(
                                        dropdowns.background,
                                        TweenInfo.new(0.18, Enum.EasingStyle.Quint),
                                        { Size = UDim2.new(0.964, 0, 0, 30) }
                                    )
                                    :Play()
                            else
                                ts
                                    :Create(
                                        dropdowns.arrow,
                                        TweenInfo.new(0.18, Enum.EasingStyle.Quint),
                                        { Rotation = 0 }
                                    )
                                    :Play()
                                ts
                                    :Create(
                                        sections.section,
                                        TweenInfo.new(0.18, Enum.EasingStyle.Quint),
                                        { Size = sections.section.Size + UDim2.new(0, 0, 0, 125) }
                                    )
                                    :Play()
                                ts
                                    :Create(dropdowns.list, TweenInfo.new(0.18, Enum.EasingStyle.Quint), {
                                        CanvasSize = UDim2.new(
                                            0,
                                            0,
                                            0,
                                            dropdowns.list["UIListLayout"].AbsoluteContentSize.Y
                                        ) + UDim2.new(0, 0, 0, 26),
                                    })
                                    :Play()
                                ts
                                    :Create(
                                        category.categoryscrolling,
                                        TweenInfo.new(0.18, Enum.EasingStyle.Quint),
                                        { CanvasSize = category.categoryscrolling.CanvasSize + UDim2.new(0, 0, 0, 125) }
                                    )
                                    :Play()
                                revealList()
                                ts
                                    :Create(
                                        dropdowns.background,
                                        TweenInfo.new(0.18, Enum.EasingStyle.Quint),
                                        { Size = UDim2.new(0.964, 0, 0, 154) }
                                    )
                                    :Play()
                            end
                        end

                        local function RefreshList()
                            for a, b in pairs(dropdowns.list:GetChildren()) do
                                if b:IsA("ImageButton") then
                                    b:Destroy()
                                end
                            end

                            for i, v in pairs(tableA) do
                                local button = library.create("ImageButton", {
                                    Name = string.lower(v),
                                    AnchorPoint = Vector2.new(0.5, 0.5),
                                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                    BackgroundTransparency = 1.000,
                                    BorderColor3 = Color3.fromRGB(27, 42, 53),
                                    Position = UDim2.new(0, 252, 0, 0),
                                    Size = UDim2.new(0.98, 0, 0, 30),
                                    ZIndex = 2,
                                    AutoButtonColor = false,
                                    Image = "rbxassetid://3570695787",
                                    ImageColor3 = Themes.AccentColor,
                                    ScaleType = Enum.ScaleType.Slice,
                                    SliceCenter = Rect.new(100, 100, 100, 100),
                                    SliceScale = 0.040,
                                })
                                table.insert(Objects.AccentColor, button)

                                local buttontext = library.create("TextLabel", {
                                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                                    BackgroundTransparency = 1.000,
                                    BorderSizePixel = 0,
                                    Position = UDim2.new(0.078, 0, 0, 0),
                                    Size = UDim2.new(0.833, 0, 1, 0),
                                    ZIndex = 2,
                                    Font = Enum.Font.GothamBold,
                                    Text = v,
                                    TextColor3 = Themes.TextColor,
                                    TextSize = 16,
                                })
                                table.insert(Objects.TextColor, buttontext)

                                button.Parent = dropdowns.list
                                buttontext.Parent = button

                                button.MouseButton1Click:Connect(function()
                                    if listopend then
                                        listopend = not listopend
                                        dropdowns.textbox.Text = v

                                        HideShowList()

                                        if callback then
                                            callback(v)
                                        end
                                    end
                                end)
                            end
                        end

                        RefreshList()

                        dropdowns.arrow.MouseButton1Click:Connect(function()
                            listopend = not listopend
                            if beforeopen then
                                local newtable = beforeopen()
                                local okc, sig = pcall(table.concat, newtable, "\0")
                                tableA = newtable
                                if not okc or sig ~= lastsig then
                                    lastsig = sig
                                    RefreshList()
                                end
                            end
                            if options and playerlist then
                                tableA = {}
                                for i, v in pairs(options) do
                                    table.insert(tableA, v)
                                end
                                local list = game:GetService("Players")
                                for a, b in pairs(list:GetChildren()) do
                                    if b:IsA("Player") then
                                        table.insert(tableA, b.Name)
                                    end
                                end
                            elseif not options and playerlist then
                                tableA = {}
                                local list = game:GetService("Players")
                                for a, b in pairs(list:GetChildren()) do
                                    if b:IsA("Player") then
                                        table.insert(tableA, b.Name)
                                    end
                                end
                            end
                            HideShowList()
                        end)

                        dropdowns.background2.MouseButton1Click:Connect(function()
                            listopend = not listopend
                            if beforeopen then
                                local newtable = beforeopen()
                                local okc, sig = pcall(table.concat, newtable, "\0")
                                tableA = newtable
                                if not okc or sig ~= lastsig then
                                    lastsig = sig
                                    RefreshList()
                                end
                            end
                            if options and playerlist then
                                tableA = {}
                                for i, v in pairs(options) do
                                    table.insert(tableA, v)
                                end
                                local list = game:GetService("Players")
                                for a, b in pairs(list:GetChildren()) do
                                    if b:IsA("Player") then
                                        table.insert(tableA, b.Name)
                                    end
                                end
                            elseif not options and playerlist then
                                tableA = {}
                                local list = game:GetService("Players")
                                for a, b in pairs(list:GetChildren()) do
                                    if b:IsA("Player") then
                                        table.insert(tableA, b.Name)
                                    end
                                end
                            end
                            HideShowList()
                        end)

                        sections.section.Size = sections.section.Size + UDim2.new(0, 0, 0, 38)
                        category.categoryscrolling.CanvasSize = category.categoryscrolling.CanvasSize
                            + UDim2.new(0, 0, 0, 38)

                        dropdowns.background.Parent = sections.section
                        dropdowns.background2.Parent = dropdowns.background
                        dropdowns.arrow.Parent = dropdowns.background2
                        dropdowns.textbox.Parent = dropdowns.background2
                        dropdowns.backgroundlist.Parent = dropdowns.background
                        dropdowns.list.Parent = dropdowns.backgroundlist
                        dropdowns.listlayout.Parent = dropdowns.list
                        dropdowns.listpadding.Parent = dropdowns.list
                    end

                    return dropdowns
                end

                function sections.colorpicker(name, callback, default, opacitydefault)
                    local colorpickers = {}

                    local pickeropen = false

                    colorpickers.background = library.create("ImageLabel", {
                        Name = name .. "ColorPicker",
                        BackgroundColor3 = Color3.fromRGB(248, 248, 248),
                        BackgroundTransparency = 1.000,
                        BorderColor3 = Color3.fromRGB(27, 42, 53),
                        Position = UDim2.new(0, 10, 0, 235),
                        Size = UDim2.new(0.963999987, 0, 0, 35),
                        Image = "rbxassetid://3570695787",
                        ImageColor3 = Themes.AccentColor,
                        ScaleType = Enum.ScaleType.Slice,
                        SliceCenter = Rect.new(100, 100, 100, 100),
                        SliceScale = 0.040,
                    })
                    table.insert(Objects.AccentColor, colorpickers.background)
                    table.insert(ObjectsSearch, colorpickers.background)

                    colorpickers.text = library.create("TextLabel", {
                        Name = "Text",
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1.000,
                        BorderSizePixel = 0,
                        Position = UDim2.new(0.00800000038, 0, 0, 2),
                        Size = UDim2.new(0.400000006, 0, 0, 30),
                        Font = Enum.Font.GothamBold,
                        Text = name,
                        TextColor3 = Themes.TextColor,
                        TextSize = 16,
                        TextXAlignment = Enum.TextXAlignment.Left,
                    })
                    table.insert(Objects.TextColor, colorpickers.text)

                    colorpickers.button = library.create("ImageButton", {
                        Name = "Button",
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1.000,
                        BorderSizePixel = 0,
                        Position = UDim2.new(1, -106, 0, 4),
                        Size = UDim2.new(0, 100, 0, 26),
                        AutoButtonColor = false,
                        Image = "rbxassetid://3570695787",
                        ImageColor3 = Color3.fromRGB(255, 255, 255),
                        ScaleType = Enum.ScaleType.Slice,
                        SliceCenter = Rect.new(100, 100, 100, 100),
                        SliceScale = 0.040,
                    })

                    colorpickers.framebackground = library.create("Frame", {
                        Name = "colorframe",
                        BackgroundColor3 = Color3.fromRGB(46, 46, 54),
                        BackgroundTransparency = 1.000,
                        BorderSizePixel = 0,
                        ClipsDescendants = true,
                        Position = UDim2.new(1, 8, 0, 0),
                        Size = UDim2.new(0, 0, 0, 265),
                    })
                    colorpickers.framebackground.ClipsDescendants = true

                    colorpickers.frame = library.create("ImageLabel", {
                        Name = "MainFrame",
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1.000,
                        Size = UDim2.new(0, 220, 0, 265),
                        Image = "rbxassetid://3570695787",
                        ImageColor3 = Themes.BackgroundColor,
                        ScaleType = Enum.ScaleType.Slice,
                        SliceCenter = Rect.new(100, 100, 100, 100),
                        SliceScale = 0.060,
                    })
                    table.insert(Objects.BackgroundColor, colorpickers.frame)

                    colorpickers.huepicker = library.create("ImageButton", {
                        Name = "HuePicker",
                        BackgroundColor3 = Color3.fromRGB(46, 46, 54),
                        BackgroundTransparency = 1.000,
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 183, 0, 20),
                        Size = UDim2.new(0, 17, 0, 150),
                        ZIndex = 2,
                        AutoButtonColor = false,
                        Image = "http://www.roblox.com/asset/?id=5118428654",
                    })

                    colorpickers.huerounder = library.create("ImageLabel", {
                        Name = "HueRounder",
                        BackgroundColor3 = Color3.fromRGB(46, 46, 54),
                        BackgroundTransparency = 1.000,
                        BorderColor3 = Color3.fromRGB(27, 42, 53),
                        BorderSizePixel = 0,
                        Size = UDim2.new(1, 0, 1, 0),
                        ZIndex = 2,
                        Image = "rbxassetid://4695575676",
                        ImageColor3 = Color3.fromRGB(40, 40, 40),
                        ScaleType = Enum.ScaleType.Slice,
                        SliceCenter = Rect.new(128, 128, 128, 128),
                        SliceScale = 0.080,
                    })
                    table.insert(Objects.BackgroundColor, colorpickers.huerounder)

                    colorpickers.huering = library.create("ImageLabel", {
                        Name = "HueRing",
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1.000,
                        Position = UDim2.new(0.147, 0, 0, -6),
                        Size = UDim2.new(0, 12, 0, 12),
                        SizeConstraint = Enum.SizeConstraint.RelativeYY,
                        ZIndex = 5,
                        Image = "http://www.roblox.com/asset/?id=5674514673",
                    })

                    colorpickers.darknesspicker = library.create("ImageButton", {
                        Name = "DarknessPicker",
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BorderColor3 = Color3.fromRGB(221, 221, 221),
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 20, 0, 20),
                        Size = UDim2.new(0, 150, 0, 150),
                        AutoButtonColor = false,
                        Image = "rbxassetid://5113592272",
                        ImageColor3 = Color3.fromRGB(255, 0, 0),
                    })

                    colorpickers.darknesslight = library.create("ImageLabel", {
                        Name = "Light",
                        BackgroundTransparency = 1.000,
                        BorderSizePixel = 0,
                        Size = UDim2.new(1, 0, 1, 0),
                        Image = "rbxassetid://5113600420",
                    })

                    colorpickers.darknessrounder = library.create("ImageLabel", {
                        Name = "DarknessRounder",
                        BackgroundColor3 = Color3.fromRGB(46, 46, 54),
                        BackgroundTransparency = 1.000,
                        BorderColor3 = Color3.fromRGB(27, 42, 53),
                        BorderSizePixel = 0,
                        Size = UDim2.new(1, 0, 1, 0),
                        ZIndex = 2,
                        Image = "rbxassetid://4695575676",
                        ImageColor3 = Color3.fromRGB(40, 40, 40),
                        ScaleType = Enum.ScaleType.Slice,
                        SliceCenter = Rect.new(128, 128, 128, 128),
                        SliceScale = 0.050,
                    })
                    table.insert(Objects.BackgroundColor, colorpickers.darknessrounder)

                    colorpickers.darknessring = library.create("ImageLabel", {
                        Name = "DarknessRing",
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1.000,
                        Position = UDim2.new(0, -6, 0, -6),
                        Size = UDim2.new(0, 12, 0, 12),
                        SizeConstraint = Enum.SizeConstraint.RelativeYY,
                        ZIndex = 5,
                        Image = "http://www.roblox.com/asset/?id=5674514673",
                    })

                    colorpickers.alphapicker = library.create("ImageButton", {
                        Name = "Alpha",
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 20, 0, 180),
                        Size = UDim2.new(0, 180, 0, 17),
                        AutoButtonColor = false,
                    })

                    colorpickers.alpharounder = library.create("ImageLabel", {
                        Name = "AlphaRounder",
                        BackgroundColor3 = Color3.fromRGB(46, 46, 54),
                        BackgroundTransparency = 1.000,
                        BorderColor3 = Color3.fromRGB(27, 42, 53),
                        BorderSizePixel = 0,
                        Size = UDim2.new(1, 0, 1, 0),
                        ZIndex = 2,
                        Image = "rbxassetid://4695575676",
                        ImageColor3 = Color3.fromRGB(40, 40, 40),
                        ScaleType = Enum.ScaleType.Slice,
                        SliceCenter = Rect.new(128, 128, 128, 128),
                        SliceScale = 0.080,
                    })
                    table.insert(Objects.BackgroundColor, colorpickers.alpharounder)

                    colorpickers.alpharing = library.create("ImageLabel", {
                        Name = "AlphaRing",
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1.000,
                        Position = UDim2.new(1, -6, 0.125, 0),
                        Size = UDim2.new(0, 12, 0, 12),
                        SizeConstraint = Enum.SizeConstraint.RelativeYY,
                        ZIndex = 5,
                        Image = "http://www.roblox.com/asset/?id=5674514673",
                    })

                    colorpickers.alphagradient = library.create("UIGradient", {
                        Color = ColorSequence.new({
                            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)),
                            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 0, 0)),
                        }),
                    })

                    colorpickers.R = library.create("Frame", {
                        Name = "R",
                        BackgroundColor3 = Color3.fromRGB(72, 72, 85),
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 20, 0, 244),
                        Size = UDim2.new(0, 30, 0, 2),
                    })

                    colorpickers.RLabel = library.create("TextLabel", {
                        Name = "RLabel",
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1.000,
                        Position = UDim2.new(0, 0, 0, -34),
                        Size = UDim2.new(0, 30, 0, 15),
                        Font = Enum.Font.GothamBold,
                        Text = "R:",
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        TextSize = 14.000,
                        TextXAlignment = Enum.TextXAlignment.Left,
                    })

                    colorpickers.RBox = library.create("TextBox", {
                        Name = "RBox",
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1.000,
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 0, 0, -15),
                        Size = UDim2.new(0, 30, 0, 15),
                        Font = Enum.Font.GothamBold,
                        Text = "255",
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        TextSize = 14.000,
                        TextXAlignment = Enum.TextXAlignment.Left,
                    })

                    colorpickers.G = library.create("Frame", {
                        Name = "G",
                        BackgroundColor3 = Color3.fromRGB(72, 72, 85),
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 95, 0, 244),
                        Size = UDim2.new(0, 30, 0, 2),
                    })

                    colorpickers.GLabel = library.create("TextLabel", {
                        Name = "GLabel",
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1.000,
                        Position = UDim2.new(0, 0, 0, -34),
                        Size = UDim2.new(0, 30, 0, 15),
                        Font = Enum.Font.GothamBold,
                        Text = "G:",
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        TextSize = 14.000,
                        TextXAlignment = Enum.TextXAlignment.Left,
                    })

                    colorpickers.GBox = library.create("TextBox", {
                        Name = "GBox",
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1.000,
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 0, 0, -15),
                        Size = UDim2.new(0, 30, 0, 15),
                        Font = Enum.Font.GothamBold,
                        Text = "255",
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        TextSize = 14.000,
                        TextXAlignment = Enum.TextXAlignment.Left,
                    })

                    colorpickers.B = library.create("Frame", {
                        Name = "B",
                        BackgroundColor3 = Color3.fromRGB(72, 72, 85),
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 171, 0, 244),
                        Size = UDim2.new(0, 30, 0, 2),
                    })

                    colorpickers.BLabel = library.create("TextLabel", {
                        Name = "BLabel",
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1.000,
                        Position = UDim2.new(0, 0, 0, -34),
                        Size = UDim2.new(0, 30, 0, 15),
                        Font = Enum.Font.GothamBold,
                        Text = "B:",
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        TextSize = 14.000,
                        TextXAlignment = Enum.TextXAlignment.Left,
                    })

                    colorpickers.BBox = library.create("TextBox", {
                        Name = "BBox",
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 1.000,
                        BorderSizePixel = 0,
                        Position = UDim2.new(0, 0, 0, -15),
                        Size = UDim2.new(0, 30, 0, 15),
                        Font = Enum.Font.GothamBold,
                        Text = "255",
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        TextSize = 14.000,
                        TextXAlignment = Enum.TextXAlignment.Left,
                    })

                    colorpickers.background.Parent = sections.section
                    colorpickers.text.Parent = colorpickers.background
                    colorpickers.button.Parent = colorpickers.background
                    colorpickers.framebackground.Parent = main.mainframe
                    colorpickers.frame.Parent = colorpickers.framebackground
                    colorpickers.huepicker.Parent = colorpickers.frame
                    colorpickers.huerounder.Parent = colorpickers.huepicker
                    colorpickers.huering.Parent = colorpickers.huepicker
                    colorpickers.darknesspicker.Parent = colorpickers.frame
                    colorpickers.darknessrounder.Parent = colorpickers.darknesspicker
                    colorpickers.darknessring.Parent = colorpickers.darknesspicker
                    colorpickers.darknesslight.Parent = colorpickers.darknesspicker
                    colorpickers.alphapicker.Parent = colorpickers.frame
                    colorpickers.alpharounder.Parent = colorpickers.alphapicker
                    colorpickers.alpharing.Parent = colorpickers.alphapicker
                    colorpickers.alphagradient.Parent = colorpickers.alphapicker
                    colorpickers.R.Parent = colorpickers.frame
                    colorpickers.RLabel.Parent = colorpickers.R
                    colorpickers.RBox.Parent = colorpickers.R
                    colorpickers.G.Parent = colorpickers.frame
                    colorpickers.GLabel.Parent = colorpickers.G
                    colorpickers.GBox.Parent = colorpickers.G
                    colorpickers.B.Parent = colorpickers.frame
                    colorpickers.BLabel.Parent = colorpickers.B
                    colorpickers.BBox.Parent = colorpickers.B

                    colorpickers.button.MouseButton1Click:Connect(function()
                        pickeropen = not pickeropen

                        for i, v in pairs(main.mainframe:GetChildren()) do
                            if v.Name == "colorframe" then
                                ts:Create(
                                    v,
                                    TweenInfo.new(0.35, Enum.EasingStyle.Quint),
                                    { Size = UDim2.new(0, 0, 0, 265) }
                                ):Play()
                            end
                        end

                        if pickeropen then
                            ts:Create(
                                colorpickers.framebackground,
                                TweenInfo.new(0.35, Enum.EasingStyle.Quint),
                                { Size = UDim2.new(0, 220, 0, 265) }
                            ):Play()
                        end
                    end)

                    local h, s, v = 0, 0, 1
                    local color = Color3.fromRGB(255, 255, 255)
                    local r, g, b = 255, 255, 255
                    local opacity = 1

                    local hueconnection
                    local darknessconnection
                    local alphaconnection

                    local function Update()
                        colorpickers.RBox.Text = math.floor(r)
                        colorpickers.GBox.Text = math.floor(g)
                        colorpickers.BBox.Text = math.floor(b)

                        ts:Create(colorpickers.huering, TweenInfo.new(0.12), { Position = UDim2.new(0.147, 0, h, -6) })
                            :Play()
                        ts:Create(
                            colorpickers.darknessring,
                            TweenInfo.new(0.12),
                            { Position = UDim2.new(s, -6, 1 - v, -6) }
                        ):Play()
                        ts:Create(
                            colorpickers.alpharing,
                            TweenInfo.new(0.12),
                            { Position = UDim2.new(opacity, -6, 0.125, 0) }
                        ):Play()

                        colorpickers.darknesspicker.ImageColor3 = Color3.fromHSV(h, 1, 1)

                        colorpickers.button.ImageColor3 = Color3.fromRGB(r, g, b)
                        colorpickers.button.ImageTransparency = 1 - opacity

                        local colorvalue = Color3.fromHSV(h, s, v)
                        local opacityvalue = 1 - opacity

                        if callback then
                            callback(colorvalue, opacityvalue)
                        end
                    end

                    colorpickers.huepicker.MouseButton1Down:Connect(function()
                        hueconnection = rs.Heartbeat:Connect(function()
                            h = 1
                                - math.clamp(
                                    1
                                        - (
                                            (mouse.Y - colorpickers.huepicker.AbsolutePosition.Y)
                                            / colorpickers.huepicker.AbsoluteSize.Y
                                        ),
                                    0,
                                    1
                                )
                            color = Color3.fromHSV(h, s, v)

                            r, g, b = math.floor(color.r * 255), math.floor(color.g * 255), math.floor(color.b * 255)

                            Update()
                        end)
                    end)

                    colorpickers.darknesspicker.MouseButton1Down:Connect(function()
                        darknessconnection = rs.Heartbeat:Connect(function()
                            s = math.clamp(
                                (mouse.X - colorpickers.darknesspicker.AbsolutePosition.X)
                                    / colorpickers.darknesspicker.AbsoluteSize.X,
                                0,
                                1
                            )
                            v = 1
                                - math.clamp(
                                    (mouse.Y - colorpickers.darknesspicker.AbsolutePosition.Y)
                                        / colorpickers.darknesspicker.AbsoluteSize.Y,
                                    0,
                                    1
                                )
                            color = Color3.fromHSV(h, s, v)

                            r, g, b = math.floor(color.r * 255), math.floor(color.g * 255), math.floor(color.b * 255)

                            Update()
                        end)
                    end)

                    colorpickers.alphapicker.MouseButton1Down:Connect(function()
                        alphaconnection = rs.Heartbeat:Connect(function()
                            opacity = math.clamp(
                                mouse.X - colorpickers.alphapicker.AbsolutePosition.X,
                                0,
                                colorpickers.alphapicker.AbsoluteSize.X
                            ) / colorpickers.alphapicker.AbsoluteSize.X

                            Update()
                        end)
                    end)

                    colorpickers.RBox:GetPropertyChangedSignal("Text"):Connect(function()
                        if not hueconnection and not darknessconnection then
                            local Text = colorpickers.RBox.Text

                            if not tonumber(Text) then
                                colorpickers.RBox.Text = colorpickers.RBox.Text:gsub("%D", "")
                            elseif tonumber(Text) > 255 then
                                colorpickers.RBox.Text = "255"
                            elseif tonumber(Text) and tonumber(Text) <= 255 then
                                r = Text
                                local color = Color3.fromRGB(r, g, b)
                                h, s, v = Color3.toHSV(color)
                                Update()
                            end
                        end
                    end)

                    colorpickers.GBox:GetPropertyChangedSignal("Text"):Connect(function()
                        if not hueconnection and not darknessconnection then
                            local Text = colorpickers.GBox.Text

                            if not tonumber(Text) then
                                colorpickers.GBox.Text = colorpickers.GBox.Text:gsub("%D", "")
                            elseif tonumber(Text) > 255 then
                                colorpickers.GBox.Text = "255"
                            elseif tonumber(Text) and tonumber(Text) <= 255 then
                                g = Text
                                local color = Color3.fromRGB(r, g, b)
                                h, s, v = Color3.toHSV(color)
                                Update()
                            end
                        end
                    end)

                    colorpickers.BBox:GetPropertyChangedSignal("Text"):Connect(function()
                        if not hueconnection and not darknessconnection then
                            local Text = colorpickers.BBox.Text

                            if not tonumber(Text) then
                                colorpickers.BBox.Text = colorpickers.BBox.Text:gsub("%D", "")
                            elseif tonumber(Text) > 255 then
                                colorpickers.BBox.Text = "255"
                            elseif tonumber(Text) and tonumber(Text) <= 255 then
                                b = Text
                                local color = Color3.fromRGB(r, g, b)
                                h, s, v = Color3.toHSV(color)
                                Update()
                            end
                        end
                    end)

                    if default then
                        r, g, b = default.r * 255, default.g * 255, default.b * 255
                        h, s, v = Color3.toHSV(default)
                        Update()
                    end

                    if opacitydefault then
                        opacity = opacitydefault
                        Update()
                    end

                    function colorpickers:SetColor(Color)
                        r, g, b = Color.r * 255, Color.g * 255, Color.b * 255
                        h, s, v = Color3.toHSV(Color)
                        Update()
                    end

                    uis.InputEnded:Connect(function(Mouse)
                        if
                            Mouse.UserInputType == Enum.UserInputType.MouseButton1
                            or Mouse.UserInputType == Enum.UserInputType.Touch
                        then
                            if hueconnection then
                                hueconnection:Disconnect()
                                hueconnection = nil
                            end
                            if darknessconnection then
                                darknessconnection:Disconnect()
                                darknessconnection = nil
                            end
                            if alphaconnection then
                                alphaconnection:Disconnect()
                                alphaconnection = nil
                            end
                        end
                    end)

                    sections.section.Size = sections.section.Size + UDim2.new(0, 0, 0, 43)
                    category.categoryscrolling.CanvasSize = category.categoryscrolling.CanvasSize
                        + UDim2.new(0, 0, 0, 43)
                    return colorpickers
                end

                category.categoryscrolling.CanvasSize = category.categoryscrolling.CanvasSize + UDim2.new(0, 0, 0, 44)

                sections.section.Parent = category.categoryscrolling
                sections.text.Parent = sections.section
                sections.sectionlayout.Parent = sections.section

                return sections
            end

            main.categoryhandlerscrolling.CanvasSize = main.categoryhandlerscrolling.CanvasSize + UDim2.new(0, 0, 0, 43)

            if firstcategory then
                for i, v in pairs(main.categoryhandlerscrolling:GetChildren()) do
                    if v:IsA("Frame") then
                        for a, b in pairs(v:GetChildren()) do
                            ts:Create(b, TweenInfo.new(0.22, Enum.EasingStyle.Quint), { ImageTransparency = 1 }):Play()
                            ts:Create(b.Text, TweenInfo.new(0.22, Enum.EasingStyle.Quint), { TextTransparency = 1 })
                                :Play()
                            wait()
                        end
                    end
                end
                category.categoryscrolling.Visible = true
                main.categoryhandlerscrolling.Visible = false
                categoryopendname = name .. "Container"
                library:UpdateCategoryHighlight(name)
            end

            category.categorybuttonback.Parent = main.categoryhandlerscrolling
            category.categorybutton.Parent = category.categorybuttonback
            category.text.Parent = category.categorybutton
            category.categorycontainer.Parent = main.categories
            category.categoryscrolling.Parent = category.categorycontainer
            category.categoryscrollinglayout.Parent = category.categoryscrolling
            category.categoryscrollingpadding.Parent = category.categoryscrolling

            firstcategory = false

            return category
        end

        main.searchbutton.MouseButton1Click:Connect(function()
            showsearch = not showsearch

            if not showsearch then
                ts:Create(main.categorybutton, TweenInfo.new(0), { Position = UDim2.new(1, -35, 0, -28) }):Play()
                ts:Create(main.logo, TweenInfo.new(0), { Position = UDim2.new(0, 8, 0, -28) }):Play()
                ts:Create(
                    main.searchbutton,
                    TweenInfo.new(0.18, Enum.EasingStyle.Quint),
                    { Position = UDim2.new(1, -35, 0, 4) }
                ):Play()
                ts
                    :Create(
                        main.searchicon,
                        TweenInfo.new(0.18, Enum.EasingStyle.Quint),
                        { Size = UDim2.new(0, 0, 0, 28) }
                    )
                    :Play()
                ts:Create(main.searchbox, TweenInfo.new(0), { Position = UDim2.new(0, 8, 0, 0) }):Play()
                if showcategories then
                    showcategories = false
                    main.categoryhandlerscrolling.Visible = false
                    main.categorybuttonframe.Size = UDim2.new(0, 30, 0, 28)
                    main.closebuttonmark.Size = UDim2.new(0, 0, 0, 0)
                    main.mainframe["Categories"][categoryopendname].ScrollingFrame.Visible = true
                end
                main.searchbox.Text = ""
                wait(0.15)
                ts:Create(
                    main.closebuttonmarksearch,
                    TweenInfo.new(0.18, Enum.EasingStyle.Quint),
                    { Size = UDim2.new(0, 25, 0, 25) }
                ):Play()
                main.searchbox:CaptureFocus()
            else
                ts:Create(main.categorybutton, TweenInfo.new(0), { Position = UDim2.new(1, -35, 0, 4) }):Play()
                ts:Create(main.logo, TweenInfo.new(0), { Position = UDim2.new(0, 8, 0, 0) }):Play()
                ts:Create(
                    main.searchbutton,
                    TweenInfo.new(0.18, Enum.EasingStyle.Quint),
                    { Position = UDim2.new(1, -72, 0, 4) }
                ):Play()
                ts:Create(
                    main.closebuttonmarksearch,
                    TweenInfo.new(0.18, Enum.EasingStyle.Quint),
                    { Size = UDim2.new(0, 0, 0, 0) }
                ):Play()
                ts:Create(
                    main.closebuttonmarksearch,
                    TweenInfo.new(0.18, Enum.EasingStyle.Quint),
                    { Size = UDim2.new(0, 0, 0, 0) }
                ):Play()
                ts:Create(main.searchbox, TweenInfo.new(0), { Position = UDim2.new(0, 8, 0, -38) }):Play()
                wait(0.15)
                for i, v in pairs(main.categories:GetChildren()) do
                    v.ScrollingFrame.Visible = false
                end
                main.searchbox.Text = ""
                main.mainframe["Categories"][categoryopendname].ScrollingFrame.Visible = true
                ts:Create(
                    main.searchicon,
                    TweenInfo.new(0.18, Enum.EasingStyle.Quint),
                    { Size = UDim2.new(0, 26, 0, 28) }
                ):Play()
            end
        end)

        main.screengui.Parent = game:GetService("CoreGui")
        main.mainframe.Parent = main.screengui
        main.notifyframe.Parent = main.screengui
        main.notifylayout.Parent = main.notifyframe
        main.backshadow.Parent = main.mainframe
        main.navbar.Parent = main.mainframe
        main.logo.Parent = main.navbar
        main.categorybutton.Parent = main.navbar
        main.categorybuttonframe.Parent = main.categorybutton
        main.closebuttonmark.Parent = main.categorybutton
        main.searchbutton.Parent = main.navbar
        main.searchicon.Parent = main.searchbutton
        main.searchbox.Parent = main.navbar
        main.searchscrollingback.Parent = main.mainframe
        main.searchscrolling.Parent = main.searchscrollingback
        main.searchscrollinglayout.Parent = main.searchscrolling
        main.closebuttonmarksearch.Parent = main.searchbutton
        main.categorybuttonimagefirst.Parent = main.categorybuttonframe
        main.categorybuttonimagesecond.Parent = main.categorybuttonframe
        main.categorybuttonimagethird.Parent = main.categorybuttonframe
        main.categoryhandler.Parent = main.mainframe
        main.categoryhandlerscrolling.Parent = main.categoryhandler
        main.categoryhandlerlayout.Parent = main.categoryhandlerscrolling
        main.categoryhandlerpadding.Parent = main.categoryhandler
        main.categories.Parent = main.mainframe

        return main
    end

    function library:SetThemeColor(Theme, Color, TransparencyValue)
        Themes[Theme] = Color

        if Theme == "TextColor" then
            for i, v in pairs(Objects.TextColor) do
                if v:IsA("TextLabel") or v:IsA("TextButton") or v:IsA("TextBox") then
                    textcolorsave = Color
                    if
                        v.Parent
                        and v.Parent.Parent
                        and v.Parent.Parent.Parent
                        and v.Parent.Parent.Parent.Name == "CategoryHandlerScrolling"
                    then
                        v.TextColor3 = Color
                        v.TextTransparency = TransparencyValue
                        categorytopacity = TransparencyValue
                    else
                        v.TextColor3 = Color
                        v.TextTransparency = TransparencyValue
                    end
                elseif v:IsA("ImageLabel") or v:IsA("ImageButton") then
                    v.ImageColor3 = Color
                    if not v.Name == "CircleTrasparency" then
                        v.ImageTransparency = TransparencyValue
                    end
                elseif v:IsA("Frame") then
                    v.BackgroundColor3 = Color
                elseif v:IsA("UIStroke") then
                    v.Color = Color
                end
            end
        elseif Theme == "BackgroundColor" then
            for i, v in pairs(Objects.BackgroundColor) do
                if v:IsA("Frame") or v:IsA("TextButton") or v:IsA("ScrollingFrame") then
                    v.BackgroundColor3 = Color
                    v.BackgroundTransparency = TransparencyValue
                elseif v:IsA("ImageLabel") then
                    v.ImageColor3 = Color
                    v.ImageTransparency = TransparencyValue
                end
            end
        elseif Theme == "GrayContrastColor" then
            for i, v in pairs(Objects.GrayContrastColor) do
                if v:IsA("ImageLabel") then
                    if v.Name ~= "Backgroundlist" then
                        v.ImageColor3 = Color
                        v.ImageTransparency = TransparencyValue
                    else
                        v.ImageColor3 = Color3.fromRGB(
                            math.floor(Color.r * 255) - 3,
                            math.floor(Color.g * 255) - 3,
                            math.floor(Color.b * 255) - 3
                        )
                        v.ImageTransparency = TransparencyValue
                    end
                end
            end
        elseif Theme == "DarkContrastColor" then
            for i, v in pairs(Objects.DarkContrastColor) do
                if v:IsA("ImageLabel") or v:IsA("ImageButton") then
                    v.ImageColor3 = Color
                    v.ImageTransparency = TransparencyValue
                end
            end
        elseif Theme == "AccentColor" then
            for i, v in pairs(Objects.AccentColor) do
                if v:IsA("ImageLabel") or v:IsA("ImageButton") then
                    if v.Parent and v.Parent.Parent and v.Parent.Parent.Name == "CategoryHandlerScrolling" then
                        v.ImageColor3 = Color
                        v.ImageTransparency = TransparencyValue
                        categoryopacity = TransparencyValue
                    else
                        v.ImageColor3 = Color
                        v.ImageTransparency = TransparencyValue
                    end
                end
            end
        end
    end

    -- toggle on color
    function library:RefreshToggles()
        for _, f in ipairs(toggleRegistry) do
            pcall(f)
        end
    end

    function library:SetToggleColor(color)
        Themes.ToggleColor = color
        library:RefreshToggles()
    end

    -- selected tab style
    function library:UpdateCategoryHighlight(name)
        if name then
            selectedCategoryName = name
        end
        for _, c in ipairs(categoryRegistry) do
            local on = Themes.SelectedGradient and c.name == selectedCategoryName
            local grad = c.button:FindFirstChild("SelectedGradient")
            if on then
                c.button.ImageColor3 = Color3.new(1, 1, 1)
                c.text.TextColor3 = Color3.fromRGB(28, 28, 38)
                if not grad then
                    grad = Instance.new("UIGradient")
                    grad.Name = "SelectedGradient"
                    grad.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(150, 150, 168))
                    grad.Parent = c.button
                end
                grad.Enabled = true
            else
                c.button.ImageColor3 = Themes.AccentColor
                c.text.TextColor3 = Themes.TextColor
                if grad then
                    grad.Enabled = false
                end
            end
        end
    end

    function library:SetSelectedStyle(on)
        Themes.SelectedGradient = on and true or false
        library:UpdateCategoryHighlight()
    end
end

-- ui
ui = library.initiate({ default = UDim2.new(0, 572, 0, 353) })
library.flags = {}

-- compat
local window = {}
function window:Tab(name)
    local category = ui.category(name)
    local tab = {}

    function tab:section(title)
        local sec = category.section(title)
        local s = {}

        function s:Button(text, callback)
            local b = sec.button(text, function()
                if callback then
                    task.spawn(callback)
                end
            end, true)
            return { Btn = b.text, Module = b.buttonback }
        end

        function s:Label(text)
            return sec.label(text).text
        end

        function s:Toggle(text, flag, enabled, callback)
            callback = callback or function() end
            library.flags[flag] = enabled == true
            local t = sec.toggle(text, function(v)
                library.flags[flag] = v
                callback(v)
            end, enabled == true or nil)
            return {
                Module = t.toggle,
                SetState = function(self, state)
                    if state == nil then
                        state = not library.flags[flag]
                    end
                    if library.flags[flag] == state then
                        return
                    end
                    t:ChangeState(state)
                end,
            }
        end

        function s:Slider(text, flag, default, min, max, precise, callback)
            callback = callback or function() end
            library.flags[flag] = default or min
            local sl = sec.slider(text, function(v)
                library.flags[flag] = v
                callback(v)
            end, min, max, default or min, true)
            return { Module = sl.background, SetDisabled = function() end }
        end

        function s:Dropdown(text, flag, options, callback, search)
            callback = callback or function() end
            local list = {}
            for _, v in ipairs(options or {}) do
                list[#list + 1] = tostring(v)
            end
            library.flags[flag] = nil
            local d = sec.dropdown(
                text,
                function(v)
                    library.flags[flag] = v
                    callback(v)
                end,
                list,
                false,
                search == true,
                function()
                    return list
                end
            )
            local funcs = {}
            function funcs:AddOption(option)
                list[#list + 1] = tostring(option)
            end
            function funcs:RemoveOption(option)
                for i, v in ipairs(list) do
                    if v == option then
                        table.remove(list, i)
                        break
                    end
                end
            end
            function funcs:SetOptions(new)
                for i = #list, 1, -1 do
                    list[i] = nil
                end
                for _, v in ipairs(new) do
                    list[#list + 1] = tostring(v)
                end
            end
            function funcs:SetSelected(name)
                d.textbox.Text = tostring(name)
                library.flags[flag] = name
            end
            return funcs
        end

        function s:Textbox(text, flag, default, callback)
            local tb = sec.textbox(text, function(v)
                library.flags[flag] = v
                if callback then
                    callback(v)
                end
            end, "")
            if default then
                tb.textbox.Text = tostring(default)
            end
            library.flags[flag] = default
            return tb.textbox
        end

        function s:Keybind(text, default, callback)
            return sec.keybind(text, function(key)
                if callback then
                    callback(key)
                end
            end, default)
        end

        function s:ColorPicker(text, default, callback)
            return sec.colorpicker(text, function(color)
                if callback then
                    callback(color)
                end
            end, default)
        end

        return s
    end

    return tab
end

local function ToggleUILib()
    ui.mainframe.Visible = not ui.mainframe.Visible
end

-- themes
local themes = {
    Default = {
        BackgroundColor = Color3.fromRGB(40, 40, 40),
        AccentColor = Color3.fromRGB(30, 30, 30),
        GrayContrastColor = Color3.fromRGB(35, 35, 35),
        DarkContrastColor = Color3.fromRGB(25, 25, 25),
        TextColor = Color3.fromRGB(255, 255, 255),
    },
    Mocha = {
        BackgroundColor = Color3.fromRGB(132, 93, 67),
        AccentColor = Color3.fromRGB(93, 64, 39),
        GrayContrastColor = Color3.fromRGB(80, 54, 36),
        DarkContrastColor = Color3.fromRGB(58, 40, 28),
        TextColor = Color3.fromRGB(255, 255, 255),
    },
    Vice = {
        BackgroundColor = Color3.fromRGB(31, 35, 56),
        AccentColor = Color3.fromRGB(22, 25, 42),
        GrayContrastColor = Color3.fromRGB(39, 45, 72),
        DarkContrastColor = Color3.fromRGB(16, 18, 30),
        TextColor = Color3.fromRGB(255, 255, 255),
        ToggleColor = Color3.fromRGB(89, 109, 192),
        SelectedGradient = true,
    },
    Palm = {
        BackgroundColor = Color3.fromRGB(86, 50, 99),
        AccentColor = Color3.fromRGB(62, 36, 75),
        GrayContrastColor = Color3.fromRGB(108, 64, 120),
        DarkContrastColor = Color3.fromRGB(44, 26, 56),
        TextColor = Color3.fromRGB(255, 255, 255),
        ToggleColor = Color3.fromRGB(255, 92, 155),
        SelectedGradient = true,
    },
    Custom = {
        BackgroundColor = Color3.fromRGB(40, 40, 40),
        AccentColor = Color3.fromRGB(30, 30, 30),
        GrayContrastColor = Color3.fromRGB(35, 35, 35),
        DarkContrastColor = Color3.fromRGB(25, 25, 25),
        TextColor = Color3.fromRGB(255, 255, 255),
    },
}
local themeNames = { "Default", "Mocha", "Vice", "Palm", "Custom" }
local themeKeys = { "BackgroundColor", "AccentColor", "GrayContrastColor", "DarkContrastColor", "TextColor" }
local currentTheme = "Default"
local themeDropdown
local pickers = {}
local syncing = false
local uiReady = false
local recolorToken = 0

local function SyncPickers(t)
    syncing = true
    for key, picker in pairs(pickers) do
        pcall(function()
            picker:SetColor(t[key])
        end)
    end
    syncing = false
end

local themeHooks = {} -- theme extras
local function RunThemeHooks()
    for _, h in ipairs(themeHooks) do
        pcall(h)
    end
end

local function ApplyTheme(name)
    local t = themes[name]
    if not t then
        return
    end
    currentTheme = name
    for _, key in ipairs(themeKeys) do
        library:SetThemeColor(key, t[key], 0)
    end
    library:SetToggleColor(t.ToggleColor)
    library:SetSelectedStyle(t.SelectedGradient)
    RunThemeHooks()
    theme.bg = t.BackgroundColor
    theme.accent = t.AccentColor
    theme.gray = t.GrayContrastColor
    theme.dark = t.DarkContrastColor
    theme.text = t.TextColor
    task.spawn(RecolorGui)
    SyncPickers(t)
end

-- reload
local autoReload = false
local scriptFile = "Antler.lua"
local autoToggle, scriptBox
local queueTeleport = queue_on_teleport or (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport)

local function FileExists(path)
    local ok = pcall(readfile, path)
    return ok
end

game:GetService("Players").LocalPlayer.OnTeleport:Connect(function()
    if autoReload and queueTeleport and FileExists(scriptFile) then
        queueTeleport('loadstring(readfile("' .. scriptFile .. '"))()')
    end
end)

-- configs
local configFolder = "Antler"
local function ConfigPath(name)
    return configFolder .. "/" .. name .. ".json"
end
local function ColorToTable(c)
    return { math.floor(c.R * 255 + 0.5), math.floor(c.G * 255 + 0.5), math.floor(c.B * 255 + 0.5) }
end
local function TableToColor(t)
    return Color3.fromRGB(t[1], t[2], t[3])
end

local function SaveConfig(name)
    return pcall(function()
        if makefolder and isfolder and not isfolder(configFolder) then
            makefolder(configFolder)
        end
        local custom = {}
        for _, key in ipairs(themeKeys) do
            custom[key] = ColorToTable(themes.Custom[key])
        end
        writefile(
            ConfigPath(name),
            game:GetService("HttpService"):JSONEncode({
                theme = currentTheme,
                custom = custom,
                autoreload = autoReload,
                scriptfile = scriptFile,
            })
        )
    end)
end

local function LoadConfig(name)
    local ok, data = pcall(function()
        return game:GetService("HttpService"):JSONDecode(readfile(ConfigPath(name)))
    end)
    if not ok or type(data) ~= "table" then
        return false
    end
    if type(data.custom) == "table" then
        for _, key in ipairs(themeKeys) do
            local c = data.custom[key]
            if type(c) == "table" and #c == 3 then
                themes.Custom[key] = TableToColor(c)
            end
        end
    end
    if type(data.scriptfile) == "string" and data.scriptfile ~= "" then
        scriptFile = data.scriptfile
        if scriptBox then
            scriptBox.Text = scriptFile
        end
    end
    if type(data.autoreload) == "boolean" then
        autoReload = data.autoreload
        if autoToggle then
            autoToggle:SetState(autoReload)
        end
    end
    if themes[data.theme] then
        ApplyTheme(data.theme)
    end
    return true
end

local function SetCustomColor(key, color)
    if syncing or not uiReady then
        return
    end
    if currentTheme ~= "Custom" then
        for _, k in ipairs(themeKeys) do
            themes.Custom[k] = themes[currentTheme][k]
        end
        themes.Custom.ToggleColor = themes[currentTheme].ToggleColor
        themes.Custom.SelectedGradient = themes[currentTheme].SelectedGradient
        currentTheme = "Custom"
        if themeDropdown then
            themeDropdown:SetSelected("Custom")
        end
    end
    themes.Custom[key] = color
    library:SetThemeColor(key, color, 0)
    library:RefreshToggles()
    library:UpdateCategoryHighlight()
    RunThemeHooks()
    recolorToken = recolorToken + 1
    local token = recolorToken
    task.delay(0.6, function()
        if token ~= recolorToken then
            return
        end
        local t = themes.Custom
        theme.bg = t.BackgroundColor
        theme.accent = t.AccentColor
        theme.gray = t.GrayContrastColor
        theme.dark = t.DarkContrastColor
        theme.text = t.TextColor
        task.spawn(RecolorGui)
        SaveConfig("default")
    end)
end

if not LoadConfig("default") then
    task.spawn(RecolorGui)
end

-- button
local btn = Instance.new("TextButton")
btn.Name = "ToggleUI"
btn.Parent = ui.screengui
btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
btn.Position = UDim2.new(0.00496894401, 0, 0.406779647, 0)
btn.Size = UDim2.new(0, 76, 0, 32)
btn.Font = Enum.Font.GothamBold
btn.Text = "Open/Close"
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.TextSize = 11
btn.TextScaled = true -- shrink the text to fit instead of spilling out of the box
btn.TextWrapped = false
do
    local limit = Instance.new("UITextSizeConstraint", btn)
    limit.MaxTextSize = 11
    limit.MinTextSize = 6
    local pad = Instance.new("UIPadding", btn)
    pad.PaddingLeft = UDim.new(0, 5)
    pad.PaddingRight = UDim.new(0, 5)
end
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(ToggleUILib)

table.insert(themeHooks, function()
    local t = themes[currentTheme] or themes.Default
    btn.BackgroundColor3 = t.BackgroundColor
    btn.TextColor3 = t.TextColor
end)
RunThemeHooks()

-- wood
local dx = {}
do
    local __modules = {}
    __modules["LT2Axes"] = function()
        return assert(loadstring(
            [[local LT2Axes = {}

LT2Axes.Damage = {

    ["Inverse Axe"]          = function(_)  return -1   end,
    ["Refined Axe"]          = function(_)  return  0   end,
    ["Candy Cane Axe"]       = function(_)  return  0   end,

    ["Basic Hatchet"]        = function(_)  return  0.20 end,
    ["Plain Axe"]            = function(_)  return  0.55 end,
    ["Rusty Axe"]            = function(_)  return  0.55 end,
    ["Spearmint Axe"]        = function(_)  return  0.80 end,
    ["CHICKEN AXE"]          = function(_)  return  0.90 end,
    ["Steel Axe"]            = function(_)  return  0.93 end,
    ["Hardened Axe"]         = function(_)  return  1.45 end,
    ["Beta Axe of Bosses"]   = function(_)  return  1.45 end,
    ["Beesaxe"]              = function(_)  return  1.40 end,
    ["Alpha Axe of Testing"] = function(_)  return  1.50 end,
    ["Pig Axe"]              = function(_)  return  1.50 end,
    ["End Times Axe"]        = function(_)  return  1.58 end,
    ["Silver Axe"]           = function(_)  return  1.60 end,
    ["Rukiryaxe"]            = function(_)  return  1.68 end,
    ["Candy Corn Axe"]       = function(_)  return  1.75 end,
    ["Amber Axe"]            = function(_)  return  3.39 end,
    ["The Many Axe"]         = function(_)  return 10.2  end,

    ["Pie Axe"] = function(tc)
        if tc == "Cherry"      then return 1.90 end
        return 0.95
    end,
    ["Fire Axe"] = function(tc)
        if tc == "Volcano"     then return 6.35 end
        return 0.60
    end,
    ["Cave Axe"] = function(tc)
        if tc == "CaveCrawler" then return 7.20 end
        return 0.40
    end,
    ["Frost Axe"] = function(tc)
        if tc == "Frost"       then return 6.00 end
        return 0.36
    end,
    ["Bird Axe"] = function(tc)
        if tc == "CaveCrawler" then return 3.90
        elseif tc == "Volcano" then return 2.50 end
        return 1.65
    end,
    ["Bluesteel Axe"] = function(tc)
        if tc == "BlueSpruce"  then return 12.10 end
        return 2.80
    end,
    ["OverGrown Axe"] = function(tc)
        if tc == "GreenSwampy" then return 7.00
        elseif tc == "GoldSwampy" then return 5.30 end
        return 0.80
    end,
    ["Gingerbread Axe"] = function(tc)
        if tc == "Koa"         then return 11.00
        elseif tc == "Walnut"  then return  8.50 end
        return 1.20
    end,
    ["End Times Axe"] = function(tc)
        if tc == "LoneCave"    then return 1e7  end
        return 1.58
    end,
}

LT2Axes.Priority = {
    "The Many Axe",
    "Amber Axe",
    "Bluesteel Axe",
    "Johiro",
    "Candy Corn Axe",
    "Rukiryaxe",
    "Bird Axe",
    "Silver Axe",
    "End Times Axe",
    "Alpha Axe of Testing",
    "Pig Axe",
    "Hardened Axe",
    "Beta Axe of Bosses",
    "Beesaxe",
    "Gingerbread Axe",
    "Pie Axe",
    "Steel Axe",
    "CHICKEN AXE",
    "OverGrown Axe",
    "Spearmint Axe",
    "Fire Axe",
    "Plain Axe",
    "Rusty Axe",
    "Cave Axe",
    "Frost Axe",
    "Basic Hatchet",
    "Candy Cane Axe",
    "Refined Axe",
    "Inverse Axe",
}

LT2Axes.Rank = {}
for rank, name in ipairs(LT2Axes.Priority) do
    LT2Axes.Rank[name] = rank
end

function LT2Axes.GetDamage(axeName, treeClass)
    local fn = LT2Axes.Damage[axeName]
    return fn and fn(treeClass) or 1.0
end

return LT2Axes
]],
            "LT2Axes"
        ))()
    end
    __modules["LooseObjectTeleport"] = function()
        return assert(loadstring(
            [=[local LooseObjectTeleport = {}

local UIS          = game:GetService("UserInputService")
local RunService   = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local GuiService   = game:GetService("GuiService")
local Players      = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Player    = Players.LocalPlayer
local Camera    = workspace.CurrentCamera
local Mouse     = Player:GetMouse()

local ClientIsDragging = ReplicatedStorage:WaitForChild("Interaction"):WaitForChild("ClientIsDragging")

local function NewSignal()
    local sig = { _listeners = {} }
    function sig:Connect(fn)
        local id = {}
        self._listeners[id] = fn
        return { Disconnect = function() self._listeners[id] = nil end }
    end
    function sig:Wait()
        local co = coroutine.running()
        local conn
        conn = self:Connect(function(...)
            conn:Disconnect()
            task.spawn(co, ...)
        end)
        return coroutine.yield()
    end
    function sig:_Fire(...)
        for _, fn in pairs(self._listeners) do
            task.spawn(fn, ...)
        end
    end
    return sig
end

local Settings = {
    OwnershipTimeout = 1,
    FallbackWait     = 0.5,
    PreFireWait      = 0.05,
    PostObjectDelay  = 0.1,
    ProximityRadius  = 10,

    SelectionColor   = Color3.fromRGB(74, 120, 255),
    OutlineThickness = 0.05,

    StackX       = 5,
    StackY       = 1,
    StackZ       = 2,
    StackPadding = 0.1,

    PyramidMode  = false,
    KeepSelected   = false,
    ReturnToOrigin = true,
    MatchPlankSize = true,
}

local State = {
    SelectedObjects = {},
    SelectionBoxes  = {},
    Connections     = {},
    IsBusy          = false,
    BatchCancelled  = false,

    ClickSelectMode = false,
    GroupSelectMode = false,
    LassoMode       = false,
    LassoDragging   = false,
    LassoStartPos   = nil,
    LassoGui        = nil,
    LassoFrame      = nil,
    TpBtn           = nil,

    StackMode         = false,
    StackPreviewParts = {},
    StackPreviewBoxes = {},
    StackPreviewConn  = nil,
    StackStartBtn     = nil,
    StackRotation     = CFrame.new(),
    ItemRotation      = CFrame.new(),

    Library        = nil,
    BatchCompleted = NewSignal(),

    SyncButtons    = nil,
}

local function GetItemName(model)
    if not model then return nil end
    local iv = model:FindFirstChild("ItemName")
    return (iv and iv.Value ~= "") and iv.Value or model.Name
end

local function GetOwnerIdentity(model)
    if not model then return nil end
    local ownerValue = model:FindFirstChild("Owner")
    if ownerValue then
        local val = ownerValue.Value
        if typeof(val) == "Instance" and val:IsA("Player") then return val.Name end
        return tostring(val)
    end
    return nil
end

local function GetModelSignature(model)
    local mainPart  = model:FindFirstChild("Main") or model:FindFirstChildWhichIsA("BasePart")
    local mainClass = mainPart and mainPart.ClassName or "nil"
    local childKeys = {}
    for _, child in ipairs(model:GetChildren()) do
        if child.Name == "Type" then continue end
        table.insert(childKeys, child.ClassName .. ":" .. child.Name)
    end
    table.sort(childKeys)
    return mainClass .. "|" .. table.concat(childKeys, ",")
end

local function GetTreeClass(model)
    local tc = model:FindFirstChild("TreeClass")
    return tc and tostring(tc.Value) or nil
end

local function getObjectData(target)
    if not target or not target:IsA("BasePart") or target.Anchored then return nil end
    if target:IsDescendantOf(Player.Character) then return nil end

    local current = target.Parent
    while current and current ~= workspace do
        if current:IsA("Model") then
            local typeVal = current:FindFirstChild("Type")
            if typeVal and (typeVal.Value == "Vehicle" or typeVal.Value == "Structure")
            and not current:FindFirstChild("PurchasedBoxItemName") then
                return nil
            end
        end
        current = current.Parent
    end

    local model = target:FindFirstAncestorOfClass("Model")
    local main  = (model and model:FindFirstChild("Main")) or target
    if main:IsA("BasePart") and not main.Anchored then
        return main, (model and model.Name or target.Name), model
    end
    return nil
end

local function UpdateVisuals()
    for _, v in pairs(State.SelectionBoxes) do v:Destroy() end
    State.SelectionBoxes = {}
    for _, obj in ipairs(State.SelectedObjects) do
        if obj and obj.Parent then
            local box         = Instance.new("SelectionBox")
            box.Color3        = Settings.SelectionColor
            box.LineThickness = Settings.OutlineThickness
            box.Adornee       = obj
            box.Parent        = game:GetService("CoreGui")
            table.insert(State.SelectionBoxes, box)
        end
    end

    if State.SyncButtons then State.SyncButtons() end
end

local function GetDynamicDelay()
    local samples = {}
    local last = workspace.DistributedGameTime
    for _ = 1, 5 do
        RunService.Heartbeat:Wait()
        local now = workspace.DistributedGameTime
        if now ~= last then
            table.insert(samples, now - last)
            last = now
        end
    end
    local avg = if #samples > 0
        then (function() local s = 0 for _, v in ipairs(samples) do s += v end return s / #samples end)()
        else 1/20

    return math.clamp(avg * 20, 0.5, 1)
end

local function PlayerAlignedCFrame(position, root)
    local look     = root.CFrame.LookVector
    local flatLook = Vector3.new(look.X, 0, look.Z)
    if flatLook.Magnitude < 0.001 then
        flatLook = Vector3.new(0, 0, -1)
    end
    flatLook = flatLook.Unit
    local yaw = math.atan2(-flatLook.X, -flatLook.Z)
    return CFrame.new(position) * CFrame.Angles(0, yaw, 0) * CFrame.Angles(math.rad(90), 0, 0)
end

local function FindLastInteraction(model)
    local ownerFolder = model:FindFirstChild("Owner")
    if ownerFolder then
        local li = ownerFolder:FindFirstChild("LastInteraction")
        if li then return li end
    end
    return model:FindFirstChild("LastInteraction")
end

local function TeleportSingle(target, goalCF, root)
    if not target or not target.Parent then return end

    local model          = target:FindFirstAncestorOfClass("Model") or target.Parent
    local lastInteracted = FindLastInteraction(model)

    local flat = (root.Position - target.Position) * Vector3.new(1, 0, 1)
    if flat.Magnitude > Settings.ProximityRadius then
        root.CFrame = CFrame.new(target.Position + Vector3.new(0, 3, 0))
    end

    local ownerFolder = model:FindFirstChild("Owner")
    local ownerString = ownerFolder and ownerFolder:FindFirstChild("OwnerString")
    if ownerString and ownerString.Value ~= Player.Name then
        local MAX_ATTEMPTS = 5
        local BASE_DELAY   = GetDynamicDelay()

        for attempt = 1, MAX_ATTEMPTS do
            local deadline = tick() + (BASE_DELAY * attempt)
            while tick() < deadline do
                pcall(ClientIsDragging.FireServer, ClientIsDragging, model)
                task.wait()
            end

            if target and target.Parent then
                target.CFrame = goalCF
            end
            task.wait(0.2)

            local dist = (target.Position - goalCF.Position).Magnitude
            if dist < 2 then break end
        end

        task.wait(Settings.PostObjectDelay)
        return
    end

    task.wait(Settings.PreFireWait)

    if lastInteracted then
        local co    = coroutine.running()
        local fired = false

        local conn = lastInteracted:GetPropertyChangedSignal("Value"):Connect(function()
            if not fired then
                fired = true
                task.spawn(co)
            end
        end)

        local fireLoop = task.spawn(function()
            local deadline = tick() + Settings.OwnershipTimeout

            local ok, err = pcall(function()
                while not fired and tick() < deadline do
                    ClientIsDragging:FireServer(model)
                    task.wait()
                end
            end)

            if not fired then
                fired = true
                task.spawn(co)
                if not ok then
                    warn(("[LOT] FireServer errored on '%s': %s")
                        :format(model.Name, tostring(err)))
                else
                    warn(("[LOT] LastInteraction on '%s' never changed within %.1fs — proceeding anyway.")
                        :format(model.Name, Settings.OwnershipTimeout))
                end
            end
        end)

        coroutine.yield()
        conn:Disconnect()
        pcall(task.cancel, fireLoop)
    else
        warn(("[LOT] No Owner.LastInteraction found on '%s' — using fallback wait."):format(model.Name))
        local deadline = tick() + Settings.FallbackWait
        while tick() < deadline do
            local ok, err = pcall(ClientIsDragging.FireServer, ClientIsDragging, model)
            if not ok then
                warn(("[LOT] Fallback FireServer errored on '%s': %s"):format(model.Name, tostring(err)))
                break
            end
            task.wait()
        end
    end

    if target and target.Parent then
        target.CFrame = goalCF
    end

    task.wait(Settings.PostObjectDelay)
end

local function RunBatch(jobs, returnToOrigin)
    if returnToOrigin == nil then
        returnToOrigin = Settings.ReturnToOrigin
    end

    if #jobs == 0 then
        State.BatchCompleted:_Fire(true, 0)
        return true
    end

    local char = Player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not char or not root then
        State.BatchCompleted:_Fire(false, 0)
        return false
    end

    State.IsBusy         = true
    State.BatchCancelled = false

    local savedCFrame = root.CFrame

    for _, job in ipairs(jobs) do
        if State.BatchCancelled then break end
        if job.target and job.target.Parent then
            local ok, err = pcall(TeleportSingle, job.target, job.goalCF, root)
            if not ok then
                warn(("[LOT] TeleportSingle failed, skipping object: %s"):format(tostring(err)))
            end
        end
    end

    if returnToOrigin and root and root.Parent then
        root.CFrame = savedCFrame
    end

    State.IsBusy = false

    local success = not State.BatchCancelled
    State.BatchCompleted:_Fire(success, #jobs)
    return success
end

local function InitLassoGui()
    if State.LassoGui then State.LassoGui:Destroy() end
    local sg = Instance.new("ScreenGui")
    sg.Name           = "LassoDragGui"
    sg.ResetOnSpawn   = false
    sg.IgnoreGuiInset = true
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    sg.Parent         = game:GetService("CoreGui")

    local frame = Instance.new("Frame")
    frame.BackgroundColor3       = Color3.fromRGB(60, 130, 255)
    frame.BackgroundTransparency = 0.75
    frame.BorderSizePixel        = 0
    frame.Visible                = false
    frame.ZIndex                 = 10
    frame.Parent                 = sg

    local stroke           = Instance.new("UIStroke")
    stroke.Color           = Color3.fromRGB(120, 180, 255)
    stroke.Thickness       = 1.5
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent          = frame

    State.LassoGui   = sg
    State.LassoFrame = frame
end

local function UpdateLassoFrame(currentPos)
    if not State.LassoFrame or not State.LassoStartPos then return end
    local minX = math.min(State.LassoStartPos.X, currentPos.X)
    local minY = math.min(State.LassoStartPos.Y, currentPos.Y)
    local maxX = math.max(State.LassoStartPos.X, currentPos.X)
    local maxY = math.max(State.LassoStartPos.Y, currentPos.Y)
    State.LassoFrame.Position = UDim2.fromOffset(minX, minY)
    State.LassoFrame.Size     = UDim2.fromOffset(maxX - minX, maxY - minY)
    State.LassoFrame.Visible  = true
end

local function SelectObjectsInLassoRect(startPos, endPos)
    local minX = math.min(startPos.X, endPos.X)
    local minY = math.min(startPos.Y, endPos.Y)
    local maxX = math.max(startPos.X, endPos.X)
    local maxY = math.max(startPos.Y, endPos.Y)
    if (maxX - minX) < 6 or (maxY - minY) < 6 then return end

    local playerModels = workspace:FindFirstChild("PlayerModels")
    if not playerModels then return end

    local inset = GuiService:GetGuiInset()
    local seen  = {}

    for _, obj in ipairs(playerModels:GetDescendants()) do
        if obj:IsA("BasePart") then
            local main = getObjectData(obj)
            if main and not seen[main] then
                seen[main] = true
                local screenPos, onScreen = Camera:WorldToScreenPoint(main.Position)
                local sx = screenPos.X + inset.X
                local sy = screenPos.Y + inset.Y
                if onScreen and screenPos.Z > 0
                    and sx >= minX and sx <= maxX
                    and sy >= minY and sy <= maxY then
                    local idx = table.find(State.SelectedObjects, main)
                    if idx then
                        table.remove(State.SelectedObjects, idx)
                    else
                        table.insert(State.SelectedObjects, main)
                    end
                end
            end
        end
    end

    UpdateVisuals()
end

local function GetMainPartSizeY(model)
    local main = model:FindFirstChild("Main") or model:FindFirstChildWhichIsA("BasePart")
    if not main then return nil end
    return math.round(main.Size.Y * 100) / 100
end

local function AllSelectedSameType()
    if #State.SelectedObjects == 0 then return false, "Queue is empty." end
    local refName, refSig, refTreeClass, refSizeY
    for _, obj in ipairs(State.SelectedObjects) do
        if not (obj and obj.Parent) then continue end
        local model     = obj:FindFirstAncestorOfClass("Model")
        local name      = model and GetItemName(model) or obj.Name
        local sig       = model and GetModelSignature(model) or (obj.ClassName .. ":" .. obj.Name)
        local treeClass = model and GetTreeClass(model) or nil
        local sizeY     = model and GetMainPartSizeY(model) or nil

        if not refName then
            refName = name; refSig = sig
            refTreeClass = treeClass; refSizeY = sizeY
        else
            if name ~= refName or sig ~= refSig then
                return false, "Mixed item types — all items must be identical."
            end
            if treeClass ~= refTreeClass then
                return false, "Mixed wood types — all items must be the same tree class."
            end
            if sizeY ~= nil and refSizeY ~= nil then
                if Settings.MatchPlankSize and math.abs(sizeY - refSizeY) > 1 then
                    return false, "Mixed sizes — all items must be the same size."
                end
            end
        end
    end
    return true, "OK"
end

local function GetStackPositions(origin, itemSize, countX, countY, countZ, totalItems, stackRotation)
    stackRotation = stackRotation or CFrame.new()
    local stepX = itemSize.X + Settings.StackPadding
    local stepY = itemSize.Y
    local stepZ = itemSize.Z + Settings.StackPadding

    local raw = {}
    for y = 0, countY - 1 do
        for z = 0, countZ - 1 do
            for x = 0, countX - 1 do
                table.insert(raw, Vector3.new(x * stepX, y * stepY, z * stepZ))
                if #raw >= totalItems then break end
            end
            if #raw >= totalItems then break end
        end
        if #raw >= totalItems then break end
    end

    local sumX, sumZ = 0, 0
    for _, p in ipairs(raw) do sumX += p.X; sumZ += p.Z end
    local cx = sumX / #raw
    local cz = sumZ / #raw

    local positions = {}
    for _, p in ipairs(raw) do
        local centered = Vector3.new(p.X - cx, p.Y, p.Z - cz)
        table.insert(positions, origin + stackRotation:VectorToWorldSpace(centered))
    end
    return positions
end

local function GetPyramidCapacity(countX, countZ)
    local total, layer = 0, 0
    while true do
        local lx = countX - layer
        local lz = countZ - layer
        if lx <= 0 or lz <= 0 then break end
        total += lx * lz
        layer += 1
    end
    return math.max(total, 1)
end

local function GetPyramidPositions(origin, itemSize, countX, countZ, totalItems, stackRotation)
    stackRotation = stackRotation or CFrame.new()
    local stepX = itemSize.X + Settings.StackPadding
    local stepY = itemSize.Y
    local stepZ = itemSize.Z + Settings.StackPadding

    local raw   = {}
    local layer = 0

    while #raw < totalItems do
        local lx = countX - layer
        local lz = countZ - layer
        if lx <= 0 or lz <= 0 then break end

        local offsetX = layer * stepX * 0.5
        local offsetZ = layer * stepZ * 0.5

        for z = 0, lz - 1 do
            for x = 0, lx - 1 do
                table.insert(raw, Vector3.new(
                    x * stepX + offsetX,
                    layer * stepY,
                    z * stepZ + offsetZ
                ))
                if #raw >= totalItems then break end
            end
            if #raw >= totalItems then break end
        end
        layer += 1
    end

    local sumX, sumZ = 0, 0
    for _, p in ipairs(raw) do sumX += p.X; sumZ += p.Z end
    local cx = sumX / #raw
    local cz = sumZ / #raw

    local positions = {}
    for _, p in ipairs(raw) do
        local centered = Vector3.new(p.X - cx, p.Y, p.Z - cz)
        table.insert(positions, origin + stackRotation:VectorToWorldSpace(centered))
    end
    return positions
end

local function ClearStackPreview()
    if State.StackPreviewConn then State.StackPreviewConn:Disconnect() State.StackPreviewConn = nil end
    for _, box in ipairs(State.StackPreviewBoxes) do if box and box.Parent then box:Destroy() end end
    State.StackPreviewBoxes = {}
    for _, p in ipairs(State.StackPreviewParts) do if p and p.Parent then p:Destroy() end end
    State.StackPreviewParts = {}
end

local function SetTpBtnLabel(label)
    if State.TpBtn and State.TpBtn.SetText then
        State.TpBtn:SetText(label)
    end
end

local function SetStackBtnLabel(label)
    if State.StackStartBtn and State.StackStartBtn.SetText then
        State.StackStartBtn:SetText(label)
    end
end

local function StopStackMode(silent)
    State.StackMode     = false
    State.StackRotation = CFrame.new()
    State.ItemRotation  = CFrame.new()
    ClearStackPreview()
    if not silent then
        SetStackBtnLabel("Start")
        if State.SyncButtons then State.SyncButtons() end
    end
end

local function RotatedBoundingSize(size, rotation)
    local c1 = rotation.RightVector
    local c2 = rotation.UpVector
    local c3 = -rotation.LookVector
    return Vector3.new(
        math.abs(c1.X)*size.X + math.abs(c2.X)*size.Y + math.abs(c3.X)*size.Z,
        math.abs(c1.Y)*size.X + math.abs(c2.Y)*size.Y + math.abs(c3.Y)*size.Z,
        math.abs(c1.Z)*size.X + math.abs(c2.Z)*size.Y + math.abs(c3.Z)*size.Z
    )
end

local function StartStackMode()
    if State.StackMode then StopStackMode() return end

    local ok = AllSelectedSameType()
    if not ok then return end

    local capacity = Settings.PyramidMode
        and GetPyramidCapacity(Settings.StackX, Settings.StackZ)
        or  (Settings.StackX * Settings.StackY * Settings.StackZ)
    local stackCount = math.min(capacity, #State.SelectedObjects)

    local refModel  = nil
    local refSize   = Vector3.new(4, 4, 4)
    local refBBSize = Vector3.new(4, 4, 4)
    for _, obj in ipairs(State.SelectedObjects) do
        if obj and obj.Parent then
            refModel = obj:FindFirstAncestorOfClass("Model") or obj.Parent
            refSize  = obj.Size
            local _, bbSize = refModel:GetBoundingBox()
            refBBSize = bbSize
            break
        end
    end
    if not refModel then return end

    ClearStackPreview()
    for i = 1, stackCount do
        local clone = refModel:Clone()
        for _, desc in ipairs(clone:GetDescendants()) do
            if desc:IsA("BasePart") then
                desc.Transparency = 0.55
                desc.Anchored     = true
                desc.CanCollide   = false
                desc.CanTouch     = false
                desc.CastShadow   = false
            end
        end
        local main = clone:FindFirstChild("Main") or clone:FindFirstChildWhichIsA("BasePart")
        if main then clone.PrimaryPart = main end
        clone.Parent = workspace
        table.insert(State.StackPreviewParts, clone)

        local box         = Instance.new("SelectionBox")
        box.Color3        = Color3.fromRGB(140, 180, 255)
        box.LineThickness = 0.03
        box.Adornee       = clone
        box.Parent        = game:GetService("CoreGui")
        table.insert(State.StackPreviewBoxes, box)
    end

    State.StackMode = true
    SetStackBtnLabel("Stop")
    if State.SyncButtons then State.SyncButtons() end

    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Exclude

    State.StackPreviewConn = RunService.RenderStepped:Connect(function()
        if not State.StackMode then return end

        local excludeList = {}
        if Player.Character then table.insert(excludeList, Player.Character) end
        for _, preview in ipairs(State.StackPreviewParts) do
            for _, part in ipairs(preview:GetDescendants()) do
                if part:IsA("BasePart") then table.insert(excludeList, part) end
            end
        end
        rayParams.FilterDescendantsInstances = excludeList

        local unitRay = Camera:ScreenPointToRay(Mouse.X, Mouse.Y)
        local result  = workspace:Raycast(unitRay.Origin, unitRay.Direction * 500, rayParams)

        local effectiveSize = RotatedBoundingSize(refSize, State.ItemRotation)
        local groundOrigin  = result
            and (result.Position + Vector3.new(0, RotatedBoundingSize(refBBSize, State.ItemRotation).Y * 0.5, 0))
            or  (unitRay.Origin + unitRay.Direction * 40)

        local positions = Settings.PyramidMode
            and GetPyramidPositions(
                    groundOrigin, effectiveSize,
                    Settings.StackX, Settings.StackZ,
                    #State.StackPreviewParts, State.StackRotation)
            or  GetStackPositions(
                    groundOrigin, effectiveSize,
                    Settings.StackX, Settings.StackY, Settings.StackZ,
                    #State.StackPreviewParts, State.StackRotation)

        for i, preview in ipairs(State.StackPreviewParts) do
            if positions[i] then
                preview:PivotTo(CFrame.new(positions[i]) * State.StackRotation * State.ItemRotation)
            end
        end
    end)
end

local function PerformStackExecute(hitPos)
    if not State.StackMode then return end
    local ok = AllSelectedSameType()
    if not ok then StopStackMode() return end

    local refModel  = nil
    local refSize   = Vector3.new(4, 4, 4)
    local refBBSize = Vector3.new(4, 4, 4)
    for _, obj in ipairs(State.SelectedObjects) do
        if obj and obj.Parent then
            refModel = obj:FindFirstAncestorOfClass("Model") or obj.Parent
            refSize  = obj.Size
            local _, bbSize = refModel:GetBoundingBox()
            refBBSize = bbSize
            break
        end
    end

    local capacity = Settings.PyramidMode
        and GetPyramidCapacity(Settings.StackX, Settings.StackZ)
        or  (Settings.StackX * Settings.StackY * Settings.StackZ)
    local stackCount = math.min(capacity, #State.SelectedObjects)

    local capturedRotation     = State.StackRotation
        local capturedItemRotation = State.ItemRotation

        local effectiveSize = RotatedBoundingSize(refSize, capturedItemRotation)
        local groundOrigin  = hitPos + Vector3.new(0, RotatedBoundingSize(refBBSize, capturedItemRotation).Y * 0.5, 0)
        local goalPositions = Settings.PyramidMode
            and GetPyramidPositions(
                    groundOrigin, effectiveSize,
                    Settings.StackX, Settings.StackZ,
                    stackCount, capturedRotation)
            or  GetStackPositions(
                    groundOrigin, effectiveSize,
                    Settings.StackX, Settings.StackY, Settings.StackZ,
                    stackCount, capturedRotation)

    StopStackMode(true)

    local jobs = {}
    for i = 1, stackCount do
        local obj = State.SelectedObjects[i]
        if obj and obj.Parent then
            table.insert(jobs, {
                target = obj,
                goalCF = CFrame.new(goalPositions[i] or groundOrigin) * capturedRotation * capturedItemRotation
            })
        end
    end

    task.spawn(function()
        SetStackBtnLabel("Stop")

        if State.SyncButtons then State.SyncButtons() end

        RunBatch(jobs)

        SetStackBtnLabel("Start")
        if not Settings.KeepSelected then State.SelectedObjects = {} end
        UpdateVisuals()
    end)
end

local function PerformSingleSelect()
    local main = getObjectData(Mouse.Target)
    if main then
        local idx = table.find(State.SelectedObjects, main)
        if not idx then
            table.insert(State.SelectedObjects, main)
        else
            table.remove(State.SelectedObjects, idx)
        end
        UpdateVisuals()
    end
end

local function PerformGroupSelect()
    local _, _, targetModel = getObjectData(Mouse.Target)
    if not targetModel then return end

    local targetItemName  = GetItemName(targetModel)
    local targetOwnerIden = GetOwnerIdentity(targetModel)
    local targetSig       = GetModelSignature(targetModel)
    local targetTreeClass = GetTreeClass(targetModel)
    local targetSizeY = targetModel and GetMainPartSizeY(targetModel) or nil

    if not targetItemName then return end

    local playerModels = workspace:FindFirstChild("PlayerModels")
    if not playerModels then return end

    local seen = {}
    local i    = 0
    for _, obj in ipairs(playerModels:GetDescendants()) do
        i += 1
        if i % 1000 == 0 then task.wait() end

        if obj:IsA("Model")
            and GetItemName(obj) == targetItemName
            and GetOwnerIdentity(obj) == targetOwnerIden
            and GetModelSignature(obj) == targetSig
            and GetTreeClass(obj) == targetTreeClass
            and (not Settings.MatchPlankSize
                or targetSizeY == nil
                or (GetMainPartSizeY(obj) ~= nil and math.abs(GetMainPartSizeY(obj) - targetSizeY) <= 1))
        then
            local rawPart = obj:FindFirstChild("Main") or obj:FindFirstChildWhichIsA("BasePart")
            if rawPart then
                local main = getObjectData(rawPart)
                if main and not seen[main] then
                    seen[main] = true
                    local idx = table.find(State.SelectedObjects, main)
                    if idx then
                        table.remove(State.SelectedObjects, idx)
                    else
                        table.insert(State.SelectedObjects, main)
                    end
                end
            end
        end
    end
    UpdateVisuals()
end

local function PerformClear()
    if State.StackMode then StopStackMode() end
    State.SelectedObjects = {}
    State.BatchCancelled  = true
    UpdateVisuals()
end

local function PerformExecute()
    if State.IsBusy then
        State.BatchCancelled = true
        return
    end

    if #State.SelectedObjects == 0 or not Player.Character then return end
    local char = Player.Character
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local finalPos = root.Position

    local jobs = {}
    for _, obj in ipairs(State.SelectedObjects) do
        if obj and obj.Parent then
            table.insert(jobs, {
                target = obj,
                goalCF = PlayerAlignedCFrame(finalPos, root)
            })
        end
    end

    task.spawn(function()
        SetTpBtnLabel("Stop")

        if State.SyncButtons then State.SyncButtons() end

        RunBatch(jobs)

        SetTpBtnLabel("Start")
        if not Settings.KeepSelected then State.SelectedObjects = {} end
        UpdateVisuals()
    end)
end

function LooseObjectTeleport.Select(part)
    assert(typeof(part) == "Instance" and part:IsA("BasePart"), "LOT.Select: expected BasePart")
    if State.IsBusy then warn("LOT.Select: ignored — batch running.") return end
    if not table.find(State.SelectedObjects, part) then
        table.insert(State.SelectedObjects, part)
        UpdateVisuals()
    end
end

function LooseObjectTeleport.Deselect(part)
    local idx = table.find(State.SelectedObjects, part)
    if idx then table.remove(State.SelectedObjects, idx) UpdateVisuals() end
end

function LooseObjectTeleport.Clear()
    PerformClear()
end

function LooseObjectTeleport.TeleportTo(goalCF, returnToOrigin)
    assert(typeof(goalCF) == "CFrame", "LOT.TeleportTo: expected CFrame")
    if #State.SelectedObjects == 0 then return false end
    if State.IsBusy then warn("LOT.TeleportTo: ignored — batch running.") return false end
    local jobs = {}
    for _, obj in ipairs(State.SelectedObjects) do
        if obj and obj.Parent then table.insert(jobs, { target = obj, goalCF = goalCF }) end
    end
    local success = RunBatch(jobs, returnToOrigin)
    State.SelectedObjects = {}
    UpdateVisuals()
    return success
end

function LooseObjectTeleport.TeleportObjectTo(part, goalCF, returnToOrigin)
    assert(typeof(part) == "Instance" and part:IsA("BasePart"), "LOT.TeleportObjectTo: expected BasePart")
    assert(typeof(goalCF) == "CFrame", "LOT.TeleportObjectTo: expected CFrame")
    if State.IsBusy then warn("LOT.TeleportObjectTo: ignored — batch running.") return false end
    return RunBatch({ { target = part, goalCF = goalCF } }, returnToOrigin)
end

function LooseObjectTeleport.TeleportMany(jobs, returnToOrigin, opts)
    assert(type(jobs) == "table", "LOT.TeleportMany: expected table of jobs")
    if State.IsBusy then warn("LOT.TeleportMany: ignored — batch running.") return false end
    if type(opts) == "table" then
        -- optional per-call timing override (PreFireWait / PostObjectDelay), restored afterwards
        local oldPre, oldPost = Settings.PreFireWait, Settings.PostObjectDelay
        Settings.PreFireWait     = opts.PreFireWait or oldPre
        Settings.PostObjectDelay = opts.PostObjectDelay or oldPost
        local ok, res = pcall(RunBatch, jobs, returnToOrigin)
        Settings.PreFireWait, Settings.PostObjectDelay = oldPre, oldPost
        if not ok then error(res, 0) end
        return res
    end
    return RunBatch(jobs, returnToOrigin)
end

function LooseObjectTeleport.WaitForBatch()
    if not State.IsBusy then return true, 0 end
    return State.BatchCompleted:Wait()
end

function LooseObjectTeleport.IsBusy()
    return State.IsBusy
end

function LooseObjectTeleport.GetQueueSize()
    return #State.SelectedObjects
end

LooseObjectTeleport.BatchCompleted = nil

function LooseObjectTeleport.Init(Tab, LibraryInstance)
    State.Library = LibraryInstance
    LooseObjectTeleport.BatchCompleted = State.BatchCompleted

    for _, conn in ipairs(State.Connections) do conn:Disconnect() end
    State.Connections = {}

    InitLassoGui()

    local ClickToggle, GroupToggle, LassoToggle

    local function DisableOtherSelectionModes(except)
        if except ~= "click" and State.ClickSelectMode then
            State.ClickSelectMode = false
            if ClickToggle then ClickToggle:SetState(false) end
        end
        if except ~= "group" and State.GroupSelectMode then
            State.GroupSelectMode = false
            if GroupToggle then GroupToggle:SetState(false) end
        end
        if except ~= "lasso" and State.LassoMode then
            State.LassoMode     = false
            State.LassoDragging = false
            if State.LassoFrame then State.LassoFrame.Visible = false end
            if LassoToggle then LassoToggle:SetState(false) end
        end
    end

    local Notice = Tab:CreateInfoBox()
    Notice:AddText("⚠  Server Performance Notice", {
        Bold = true,
        Size = 14,
    })
    Notice:AddDivider()
    Notice:AddText(
        "You may experience delays or failures in heavily populated servers " ..
        "or on low tick-rate servers. If objects fail to move, try increasing " ..
        "the Ownership Timeout slider below.",
        {
            Size    = 13,
            Opacity = 0.80,
            Italic  = true,
            Wrap    = true,
        }
    )

    Tab:CreateSection("Selection Tools")
    ClickToggle = Tab:CreateToggle("Click Selection", false, function(val)
        State.ClickSelectMode = val
        if val then DisableOtherSelectionModes("click") end
    end)
    GroupToggle = Tab:CreateToggle("Group Selection", false, function(val)
        State.GroupSelectMode = val
        if val then DisableOtherSelectionModes("group") end
    end)
    LassoToggle = Tab:CreateToggle("Lasso Tool", false, function(val)
        State.LassoMode = val
        if val then
            DisableOtherSelectionModes("lasso")
        else
            State.LassoDragging = false
            if State.LassoFrame then State.LassoFrame.Visible = false end
        end
    end)

    local MainRow = Tab:CreateRow()
    MainRow:CreateAction("Clear Selection", "", PerformClear)
    State.TpBtn = MainRow:CreateAction("Teleport Selection", "Start", function()
        task.spawn(PerformExecute)
    end)

    Tab:CreateSection("Sorting")
    local xSlider       = Tab:CreateSlider("X", 1, 40, Settings.StackX, function(val) Settings.StackX = val end)
    local ySlider       = Tab:CreateSlider("Y", 1, 20, Settings.StackY, function(val) Settings.StackY = val end)
    local zSlider       = Tab:CreateSlider("Z", 1, 40, Settings.StackZ, function(val) Settings.StackZ = val end)
    local paddingSlider = Tab:CreateSlider("Padding", 0, 1, Settings.StackPadding, function(val)
        Settings.StackPadding = val
    end, 2)

    local StackRow = Tab:CreateRow()
    State.StackStartBtn = StackRow:CreateAction("Sort Selected Objects", "Start", function()
        if State.StackMode then
            StopStackMode()
        elseif State.IsBusy then
            State.BatchCancelled = true
        else
            StartStackMode()
        end
    end)

    local function syncButtons()
        local stackLocked = State.IsBusy or State.StackMode

        if State.TpBtn then
            State.TpBtn:SetDisabled(not State.IsBusy and #State.SelectedObjects == 0)
        end

        if State.StackStartBtn then
            local disable
            if State.IsBusy or State.StackMode then
                disable = false
            else
                local ok = AllSelectedSameType()
                disable  = not ok
            end
            State.StackStartBtn:SetDisabled(disable)
        end

        xSlider:SetDisabled(stackLocked)

        if not stackLocked then
            ySlider:SetDisabled(Settings.PyramidMode)
        else
            ySlider:SetDisabled(true)
        end
        zSlider:SetDisabled(stackLocked)
        paddingSlider:SetDisabled(stackLocked)
    end

    State.SyncButtons = syncButtons
    syncButtons()

    Tab:CreateSection("Settings")
    local RotRow = Tab:CreateRow()
    RotRow:CreateKeybind("Rotate (X)", Enum.KeyCode.R, function()
        if State.StackMode then
            State.ItemRotation = State.ItemRotation * CFrame.Angles(0, math.rad(90), 0)
        end
    end)
    RotRow:CreateKeybind("Rotate (Y)", Enum.KeyCode.T, function()
        if State.StackMode then
            State.ItemRotation = State.ItemRotation * CFrame.Angles(math.rad(90), 0, 0)
        end
    end)
    Tab:CreateToggle("Pyramid Sorter", false, function(val)
        Settings.PyramidMode = val
        ySlider:SetDisabled(val)
    end):AddTooltip("Stacks objects into a pyramid shape. Y layer is unused in pyramid mode.")
    Tab:CreateToggle("Keep Selection After TP", false, function(val)
        Settings.KeepSelected = val
    end)
    Tab:CreateToggle("Return To Origin After TP", true, function(val)
        Settings.ReturnToOrigin = val
    end)
    Tab:CreateToggle("Match Plank Y Size (Group Select)", true, function(val)
    Settings.MatchPlankSize = val
    end):AddTooltip("When on, group selection only picks planks within 1 stud of the target's Y size. When off, Y size is ignored.")
    Tab:CreateSlider("Ownership Timeout (s)", 1, 6, Settings.OwnershipTimeout, function(val)
        Settings.OwnershipTimeout = val
    end):AddTooltip("Max amount of seconds to attempt obtaining ownership of the object.")

    table.insert(State.Connections, UIS.InputBegan:Connect(function(input, processed)
        if processed then return end

        if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
        if State.IsBusy then return end

        if State.StackMode then
            local excludeList = {}
            if Player.Character then table.insert(excludeList, Player.Character) end
            for _, preview in ipairs(State.StackPreviewParts) do
                for _, part in ipairs(preview:GetDescendants()) do
                    if part:IsA("BasePart") then table.insert(excludeList, part) end
                end
            end
            local rayParams = RaycastParams.new()
            rayParams.FilterType                 = Enum.RaycastFilterType.Exclude
            rayParams.FilterDescendantsInstances = excludeList
            local unitRay = Camera:ScreenPointToRay(Mouse.X, Mouse.Y)
            local result  = workspace:Raycast(unitRay.Origin, unitRay.Direction * 500, rayParams)
            local hitPos  = result and result.Position or (unitRay.Origin + unitRay.Direction * 40)
            task.spawn(PerformStackExecute, hitPos)

        elseif State.LassoMode then
            State.LassoDragging = true
            State.LassoStartPos = UIS:GetMouseLocation()
            if State.LassoFrame then State.LassoFrame.Size = UDim2.fromOffset(0, 0) State.LassoFrame.Visible = false end

        elseif State.GroupSelectMode then
            PerformGroupSelect()

        elseif State.ClickSelectMode then
            PerformSingleSelect()
        end
    end))

    table.insert(State.Connections, UIS.InputChanged:Connect(function(input)
        if State.LassoDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            UpdateLassoFrame(UIS:GetMouseLocation())
        end
    end))

    table.insert(State.Connections, UIS.InputEnded:Connect(function(input)
        if State.LassoDragging and input.UserInputType == Enum.UserInputType.MouseButton1 then
            State.LassoDragging = false
            if State.LassoFrame then State.LassoFrame.Visible = false end
            SelectObjectsInLassoRect(State.LassoStartPos, UIS:GetMouseLocation())
            State.LassoStartPos = nil
        end
    end))

    UpdateVisuals()
end

function LooseObjectTeleport.Unload()
    StopStackMode(true)
    for _, conn in ipairs(State.Connections) do conn:Disconnect() end
    for _, v in pairs(State.SelectionBoxes) do v:Destroy() end
    if State.LassoGui then State.LassoGui:Destroy() end
end

return LooseObjectTeleport
]=],
            "LooseObjectTeleport"
        ))()
    end
    __modules["Tree"] = function()
        return assert(loadstring(
            [[local TreeModule = {}

local Settings = {
    SyncDelay       = 0.1,
    ReadyDelay      = 0.1,

    FiresPerSection = 100,
    FireDelay       = 0.01,
    SweepDelay      = 0.1,

    LogDropDistance = 6,

    SellPosition    = Vector3.new(315, 0, 88),

    RespawnResumeDelay = 1,
}

local Players           = game:GetService("Players")
local Workspace         = game:GetService("Workspace")
local RunService        = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local camera = Workspace.CurrentCamera

local isChopping          = false
local preChopCFrame       = nil
local preChopCameraCFrame = nil
local preChopLogModels    = {}

local function SilenceRegionAlternates()
    local function killAlternate(parent)
        for _, child in ipairs(parent:GetChildren()) do
            if child.Name == "Alternate" and child:IsA("Sound") then
                child.Volume = 0
                pcall(function() child:Stop() end)
            end
        end
        parent.ChildAdded:Connect(function(child)
            if child.Name == "Alternate" and child:IsA("Sound") then
                child.Volume = 0
                pcall(function() child:Stop() end)
            end
        end)
    end

    local function scanClientSounds()
        local pg     = player:WaitForChild("PlayerGui", 10)
        local sounds = pg and pg:FindFirstChild("ClientSounds")
        if not sounds then return end

        local function processRegion(folder)
            killAlternate(folder)
        end

        local function scanAll()
            for _, child in ipairs(sounds:GetChildren()) do
                if child.Name == "Region_Main" or child.Name == "Region_Mountain" then
                    processRegion(child)
                end
            end
        end

        scanAll()

        sounds.ChildAdded:Connect(function(child)
            if child.Name == "Region_Main" or child.Name == "Region_Mountain" then
                processRegion(child)
            end
        end)
    end

    task.spawn(scanClientSounds)
end

SilenceRegionAlternates()

local function ReadAxeName(tool)
    if not tool then return nil end
    local tipChild = tool:FindFirstChild("ToolTip")
    return (tipChild and tipChild:IsA("StringValue")) and tipChild.Value or tool.ToolTip
end

local function GetBackpackAxe(treeClass)
    local candidates = {}

    local function TryAdd(tool)
        if not tool:IsA("Tool") then return end
        if tool.Name == "BlueprintTool" then return end

        local axeName = ReadAxeName(tool)
        if not axeName then return end

        local score = treeClass
            and _G.LT2Axes.GetDamage(axeName, treeClass)
            or (1 / (_G.LT2Axes.Rank[axeName] or 2^53))

        table.insert(candidates, { tool = tool, axeName = axeName, score = score })
    end

    local char = player.Character
    if char then
        local equipped = char:FindFirstChildOfClass("Tool")
        if equipped then TryAdd(equipped) end
    end
    for _, tool in ipairs(player.Backpack:GetChildren()) do
        TryAdd(tool)
    end

    if #candidates == 0 then return nil, nil end

    table.sort(candidates, function(a, b) return a.score > b.score end)

    local best = candidates[1]
    return best.tool, best.axeName
end

-- equip the chosen axe when chopping starts, put it away the moment chopping is done
local AutoEquip = { tool = nil }

local function EquipAxe(tool)
    local char = player.Character
    if not (tool and tool.Parent and char) or tool.Parent == char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum and hum.Health > 0 and tool.Parent == player.Backpack then
        pcall(function()
            hum:EquipTool(tool)
        end)
        AutoEquip.tool = tool -- we equipped it, so we put it away when done
    end
end

local function UnequipAxe()
    local t = AutoEquip.tool
    AutoEquip.tool = nil
    local char = player.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if t and hum and t.Parent == char then
        pcall(function()
            hum:UnequipTools()
        end)
    end
end

local function FindPriorityTree(treeClass)
    local bestModel   = nil
    local maxSections = -1
    for _, folder in ipairs(Workspace:GetChildren()) do
        if folder.Name:lower():match("treeregion") then
            for _, model in ipairs(folder:GetChildren()) do
                if model:IsA("Model")
                and model:FindFirstChild("TreeClass")
                and model.TreeClass.Value == treeClass then
                    local count = 0
                    for _, part in ipairs(model:GetChildren()) do
                        if part.Name == "WoodSection" then count += 1 end
                    end
                    if treeClass == "Generic" and count < 12 then continue end
                    if count > maxSections then
                        maxSections = count
                        bestModel   = model
                    end
                end
            end
        end
    end
    return bestModel
end

local function GetSectionsBottomFirst(treeModel)
    local sections = {}
    for _, part in ipairs(treeModel:GetChildren()) do
        if part.Name == "WoodSection" then
            table.insert(sections, part)
        end
    end
    table.sort(sections, function(a, b)
        return a.Position.Y < b.Position.Y
    end)
    return sections
end

local function SnapshotLogModels()
    preChopLogModels = {}
    local logModels = Workspace:FindFirstChild("LogModels")
    if not logModels then return end
    for _, model in ipairs(logModels:GetChildren()) do
        preChopLogModels[model] = true
    end
end

local function IsOwnedByLocalPlayer(model)
    local ownerObj = model:FindFirstChild("Owner")
    if ownerObj then
        if ownerObj:IsA("ObjectValue") and ownerObj.Value == player then return true end
        if ownerObj:IsA("StringValue") and ownerObj.Value == player.Name then return true end
    end
    local ownerStr = model:FindFirstChild("OwnerString")
    if ownerStr and ownerStr:IsA("StringValue") and ownerStr.Value == player.Name then
        return true
    end
    return false
end

local function CountWoodSections(model)
    local count = 0
    for _, desc in ipairs(model:GetDescendants()) do
        if desc:IsA("BasePart") and desc.Name == "WoodSection" then
            count += 1
        end
    end
    return count
end

local function CountTreeSections(model)
    local count = 0
    for _, part in ipairs(model:GetChildren()) do
        if part.Name == "WoodSection" then count += 1 end
    end
    return count
end

local function ScanForTreeTypes()
    local found, seen = {}, {}
    for _, folder in ipairs(Workspace:GetChildren()) do
        if folder.Name:lower():match("treeregion") then
            for _, model in ipairs(folder:GetChildren()) do
                if model:IsA("Model") then
                    local tc = model:FindFirstChild("TreeClass")
                    if tc and tc:IsA("StringValue") and not seen[tc.Value] then
                        if CountTreeSections(model) > 1 then
                            seen[tc.Value] = true
                            table.insert(found, tc.Value)
                        end
                    end
                end
            end
        end
    end
    return #found > 0 and found or {"None Found"}
end

local function CollectNewStumps(treeClass)
    local results   = {}
    local logModels = Workspace:FindFirstChild("LogModels")
    if not logModels then return results end
    for _, model in ipairs(logModels:GetChildren()) do
        if preChopLogModels[model] then continue end
        if model:IsA("Model") then
            local tc = model:FindFirstChild("TreeClass")
            if tc and tc.Value == treeClass then
                local iw = model:FindFirstChild("InnerWood")
                if iw and iw:IsA("BasePart") then
                    table.insert(results, iw)
                end
            end
        end
    end
    if #results == 0 then
        warn("[TreeModule] No InnerWood found after chop for TreeClass:", treeClass)
    end
    return results
end

local function CollectAllOwnedStumps()
    local results   = {}
    local logModels = Workspace:FindFirstChild("LogModels")
    if not logModels then return results end
    for _, model in ipairs(logModels:GetChildren()) do
        if not model:IsA("Model") then continue end
        if not IsOwnedByLocalPlayer(model) then continue end
        local iw = model:FindFirstChild("InnerWood")
        if iw and iw:IsA("BasePart") then
            table.insert(results, iw)
        end
    end
    if #results == 0 then
        warn("[TreeModule] No owned InnerWood found.")
    end
    return results
end

local function CollectSingleSectionStumps()
    local results   = {}
    local logModels = Workspace:FindFirstChild("LogModels")
    if not logModels then return results end
    for _, model in ipairs(logModels:GetChildren()) do
        if not model:IsA("Model") then continue end
        if not IsOwnedByLocalPlayer(model) then continue end
        if CountWoodSections(model) ~= 1 then continue end
        local iw = model:FindFirstChild("InnerWood")
        if iw and iw:IsA("BasePart") then
            table.insert(results, iw)
        end
    end
    if #results == 0 then
        warn("[TreeModule] No single-section logs ready to sell. Chop logs into sections first.")
    end
    return results
end

local function SellLogModelSectionBySection(model, LOT, sellPos, sectionIndex)
    sectionIndex = sectionIndex or 0

    local sections = {}
    for _, part in ipairs(model:GetDescendants()) do
        if part:IsA("BasePart") and part.Name == "WoodSection" then
            table.insert(sections, part)
        end
    end
    table.sort(sections, function(a, b) return a.Position.Y < b.Position.Y end)

    if #sections == 0 then
        warn("[TreeModule] No WoodSections found in model:", model.Name)
        return sectionIndex
    end

    for _, section in ipairs(sections) do
        if not section or not section.Parent then continue end

        for _, desc in ipairs(model:GetDescendants()) do
            if desc:IsA("Weld") or desc:IsA("WeldConstraint") or desc:IsA("ManualWeld") then
                if desc.Part0 == section or desc.Part1 == section then
                    pcall(function() desc:Destroy() end)
                end
            end
        end

        task.wait(0.1)

        sectionIndex += 1
        local cf = CFrame.new(sellPos.X + ((sectionIndex - 1) * 3), sellPos.Y, sellPos.Z)
        if LOT.IsBusy() then repeat task.wait(0.05) until not LOT.IsBusy() end
        LOT.TeleportObjectTo(section, cf)
        repeat task.wait(0.05) until not LOT.IsBusy()
    end

    return sectionIndex
end

local function SellAllOwnedTreesSectionBySection(LOT, sellPos, onComplete)
    task.spawn(function()
        local logModels = Workspace:FindFirstChild("LogModels")
        if not logModels then
            if onComplete then onComplete() end
            return
        end

        local ownedModels = {}
        for _, model in ipairs(logModels:GetChildren()) do
            if model:IsA("Model") and IsOwnedByLocalPlayer(model) then
                table.insert(ownedModels, model)
            end
        end

        if #ownedModels == 0 then
            warn("[TreeModule] No owned log models found.")
            if onComplete then onComplete() end
            return
        end

        print(("[TreeModule] Selling %d log model(s) section by section."):format(#ownedModels))

        local globalIndex = 0
        for _, model in ipairs(ownedModels) do
            if not model or not model.Parent then continue end
            globalIndex = SellLogModelSectionBySection(model, LOT, sellPos, globalIndex)
        end

        if onComplete then onComplete() end
    end)
end

local function CleanupState()
    isChopping = false

    local char = player.Character
    local hrp  = char and char:FindFirstChild("HumanoidRootPart")

    if hrp and preChopCFrame then
        hrp.CFrame = preChopCFrame
        hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    end
    UnequipAxe() -- right as we are back at the original position

    player.CameraMode = Enum.CameraMode.Classic

    if preChopCameraCFrame then
        camera.CFrame = preChopCameraCFrame
    end
end

local function WaitForLogsToSettle(treeClass)
    local VELOCITY_THRESHOLD = 0.5
    local STABLE_DURATION    = 0.3
    local TIMEOUT            = 10
    local POLL_RATE          = 0.05

    local logModels = Workspace:FindFirstChild("LogModels")
    if not logModels then task.wait(1.5) return end

    local innerWoods = {}
    for _, model in ipairs(logModels:GetChildren()) do
        if preChopLogModels[model] then continue end
        if model:IsA("Model") then
            local tc = model:FindFirstChild("TreeClass")
            if tc and tc.Value == treeClass then
                local iw = model:FindFirstChild("InnerWood")
                if iw and iw:IsA("BasePart") then
                    table.insert(innerWoods, iw)
                end
            end
        end
    end

    if #innerWoods == 0 then task.wait(1.5) return end

    local deadline   = tick() + TIMEOUT
    local stableFrom = nil

    while tick() < deadline do
        local allStill = true
        for _, iw in ipairs(innerWoods) do
            if not iw or not iw.Parent then continue end
            if iw.AssemblyLinearVelocity.Magnitude > VELOCITY_THRESHOLD then
                allStill = false
                break
            end
        end
        if allStill then
            if not stableFrom then
                stableFrom = tick()
            elseif tick() - stableFrom >= STABLE_DURATION then
                return
            end
        else
            stableFrom = nil
        end
        task.wait(POLL_RATE)
    end
    warn("[TreeModule] WaitForLogsToSettle timed out — proceeding anyway.")
end

local function RunLOTBatch(LOT, stumps, goalCFBuilder, onComplete)
    if not LOT then if onComplete then onComplete() end return end
    if #stumps == 0 then
        warn("[TreeModule] RunLOTBatch: nothing to teleport.")
        if onComplete then onComplete() end
        return
    end

    task.spawn(function()
        for i, stump in ipairs(stumps) do
            if LOT.IsBusy() then
                repeat task.wait(0.1) until not LOT.IsBusy()
            end
            local goalCF = goalCFBuilder(i, stump)
            LOT.TeleportObjectTo(stump, goalCF, true)
            task.spawn(function()
                repeat task.wait(0.1) until not LOT.IsBusy()
            end)
        end
        if onComplete then onComplete() end
    end)
end

local PLANK_SELL_CF = CFrame.new(315, 0, 88) * CFrame.Angles(math.rad(90), 0, 0)
local PLANK_LOCK_TIME = 1
local _sellPlanksOn = false
local _hoverOutline = nil
local _hoverPlank   = nil
local _plankConn    = nil
local _clickConn    = nil
local _isSelling    = false

local function FindOwnedPlank(part)
    if not part then return nil end
    local current = part
    while current and current ~= Workspace do
        if current.Name == "Plank" and current:IsA("Model") then
            local playerModels = Workspace:FindFirstChild("PlayerModels")
            if not playerModels then return nil end
            if current.Parent ~= playerModels then return nil end
            local owner = current:FindFirstChild("Owner")
            if not owner then return nil end
            local ownerStr = owner:FindFirstChild("OwnerString")
            if not ownerStr or not ownerStr:IsA("StringValue") then return nil end
            if ownerStr.Value ~= player.Name then return nil end
            return current
        end
        current = current.Parent
    end
    return nil
end

local function ClearHoverOutline()
    if _hoverOutline then _hoverOutline:Destroy(); _hoverOutline = nil end
    _hoverPlank = nil
end

local function ApplyHoverOutline(model)
    if _hoverPlank == model then return end
    ClearHoverOutline()
    _hoverPlank                       = model
    _hoverOutline                     = Instance.new("SelectionBox")
    _hoverOutline.Adornee             = model
    _hoverOutline.Color3              = Color3.fromRGB(33, 84, 185)
    _hoverOutline.LineThickness       = 0.08
    _hoverOutline.SurfaceColor3       = Color3.fromRGB(33, 84, 185)
    _hoverOutline.SurfaceTransparency = 0.65
    _hoverOutline.Parent              = Workspace
end

local function StopSellPlanks()
    _sellPlanksOn = false
    _isSelling    = false
    ClearHoverOutline()
    if _plankConn then _plankConn:Disconnect(); _plankConn = nil end
    if _clickConn then _clickConn:Disconnect(); _clickConn = nil end
end

local function StartSellPlanks(LOT)
    if not LOT then warn("[TreeModule] LOT not available for Sell Planks.") return end

    _sellPlanksOn = true
    _isSelling    = false
    local mouse   = player:GetMouse()

    _plankConn = RunService.RenderStepped:Connect(function()
        if not _sellPlanksOn then return end
        if _isSelling then ClearHoverOutline() return end
        local plank = FindOwnedPlank(mouse.Target)
        if plank then ApplyHoverOutline(plank) else ClearHoverOutline() end
    end)

    _clickConn = mouse.Button1Down:Connect(function()
        if not _sellPlanksOn or _isSelling then return end
        if not _hoverPlank or not _hoverPlank.Parent then return end

        local plank = _hoverPlank
        ClearHoverOutline()
        _isSelling = true

        task.spawn(function()
            if LOT.IsBusy() then repeat task.wait(0.05) until not LOT.IsBusy() end

            local target = plank.PrimaryPart
            if not target then
                for _, v in ipairs(plank:GetDescendants()) do
                    if v:IsA("BasePart") then target = v; break end
                end
            end

            if not target then
                warn("[TreeModule] Plank has no BasePart to teleport.")
                _isSelling = false
                return
            end

            LOT.TeleportObjectTo(target, PLANK_SELL_CF)
            repeat task.wait(0.05) until not LOT.IsBusy()

            local lockDeadline = tick() + PLANK_LOCK_TIME
            while tick() < lockDeadline and target and target.Parent do
                target.CFrame = PLANK_SELL_CF
                target.AssemblyLinearVelocity  = Vector3.new(0, 0, 0)
                target.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                RunService.Heartbeat:Wait()
            end

            _isSelling = false
        end)
    end)
end

local RemoteProxy = ReplicatedStorage:WaitForChild("Interaction"):WaitForChild("RemoteProxy")
local NPCDialogRemote = ReplicatedStorage:WaitForChild("NPCDialog"):WaitForChild("PlayerChatted")
local NPCPromptChat   = ReplicatedStorage:WaitForChild("NPCDialog"):WaitForChild("PromptChat")

local function CutHeightFrac(sizeY)
    return math.clamp(0.1 + (8 - sizeY) / 60, 0.1, 0.2)
end

local function FireCutSection(section, tool, axeName, treeClass, stopFn)
    if not section or not section.Parent then return end

    local idObj = section:FindFirstChild("ID")
    if not idObj then return end

    local cutEvent = section:FindFirstChild("CutEvent")
                  or section.Parent:FindFirstChild("CutEvent")
                  or (section.Parent.Parent and section.Parent.Parent:FindFirstChild("CutEvent"))
    if not cutEvent then return end

    local damage = _G.LT2Axes.GetDamage(axeName, treeClass)
    local height = section.Size.Y * CutHeightFrac(section.Size.Y)

    local args = {
        sectionId    = idObj.Value,
        faceVector   = Vector3.new(0, 0, -1),
        height       = height,
        hitPoints    = damage,
        cooldown     = 0,
        cuttingClass = "Axe",
        tool         = tool,
    }

    EquipAxe(tool)
    for _ = 1, Settings.FiresPerSection do
        if not section.Parent then break end
        if stopFn and stopFn() then break end
        RemoteProxy:FireServer(cutEvent, args)
        task.wait(Settings.FireDelay)
    end
end

local function FireCutAtHeight(section, tool, axeName, treeClass, height)
    if not section or not section.Parent then return end
    local idObj = section:FindFirstChild("ID")
    if not idObj then return end

    local cutEvent = section:FindFirstChild("CutEvent")
                  or section.Parent:FindFirstChild("CutEvent")
                  or (section.Parent.Parent and section.Parent.Parent:FindFirstChild("CutEvent"))

    if not cutEvent then
        warn("[TreeModule] CutEvent not found for section:", section:GetFullName())
        for _, c in ipairs(section.Parent:GetChildren()) do
            print("  parent child:", c.Name, c.ClassName)
        end
        return
    end

    local damage = _G.LT2Axes.GetDamage(axeName, treeClass)
    local args = {
        sectionId    = idObj.Value,
        faceVector   = Vector3.new(0, 0, -1),
        height       = height,
        hitPoints    = damage,
        cooldown     = 0,
        cuttingClass = "Axe",
        tool         = tool,
    }

    EquipAxe(tool)
    for _ = 1, Settings.FiresPerSection do
        if not section.Parent then break end
        RemoteProxy:FireServer(cutEvent, args)
        task.wait(Settings.FireDelay)
    end
end

local function ChopLogsIntoSections(onComplete)
    local userDone = onComplete
    onComplete = function()
        UnequipAxe()
        if userDone then userDone() end
    end
    local logModels = Workspace:FindFirstChild("LogModels")
    if not logModels then
        warn("[TreeModule] No LogModels folder.")
        if onComplete then onComplete() end
        return
    end

    local ownedModels = {}
    for _, model in ipairs(logModels:GetChildren()) do
        if model:IsA("Model") and IsOwnedByLocalPlayer(model) then
            table.insert(ownedModels, model)
        end
    end

    if #ownedModels == 0 then
        warn("[TreeModule] No owned log models to chop.")
        if onComplete then onComplete() end
        return
    end

    local function SnapshotModels()
        local snap = {}
        for _, m in ipairs(logModels:GetChildren()) do snap[m] = true end
        return snap
    end

    local function SectionCount(model)
        local count = 0
        for _, desc in ipairs(model:GetDescendants()) do
            if desc:IsA("BasePart") and desc.Name == "WoodSection" then
                count += 1
            end
        end
        return count
    end

    local function BuildConnectionMap(model)
        local map = {}
        for _, desc in ipairs(model:GetDescendants()) do
            if (desc:IsA("Weld") or desc:IsA("ManualWeld")) and desc.Name == "Tree Weld" then
                local p0, p1 = desc.Part0, desc.Part1
                if p0 and p1 and p0.Name == "WoodSection" and p1.Name == "WoodSection" then
                    map[p0] = (map[p0] or 0) + 1
                    map[p1] = (map[p1] or 0) + 1
                end
            end
        end
        return map
    end

    local function FindStump(model)
        local iw = model:FindFirstChild("InnerWood", true)
        if not iw then return nil end
        for _, desc in ipairs(model:GetDescendants()) do
            if (desc:IsA("Weld") or desc:IsA("ManualWeld")) then
                local p0, p1 = desc.Part0, desc.Part1
                if p0 == iw and p1 and p1.Name == "WoodSection" then return p1 end
                if p1 == iw and p0 and p0.Name == "WoodSection" then return p0 end
            end
        end
        return nil
    end

    local function FindTipWeld(model, tip)
        for _, desc in ipairs(model:GetDescendants()) do
            if (desc:IsA("Weld") or desc:IsA("ManualWeld")) and desc.Name == "Tree Weld" then
                local p0, p1 = desc.Part0, desc.Part1
                if p0 == tip and p1 and p1.Name == "WoodSection" then return desc, p1 end
                if p1 == tip and p0 and p0.Name == "WoodSection" then return desc, p0 end
            end
        end
        return nil
    end

    task.spawn(function()
        local queue = {}
        for _, m in ipairs(ownedModels) do
            table.insert(queue, m)
        end

        while #queue > 0 do
            local model = table.remove(queue, 1)
            if not model or not model.Parent then continue end

            local tc        = model:FindFirstChild("TreeClass")
            local treeClass = tc and tc.Value or "Generic"
            local tool, axeName = GetBackpackAxe(treeClass)
            local stump     = FindStump(model)

            if not tool then
                warn("[TreeModule] No axe found for model:", model.Name, "— skipping.")
                continue
            end

            while model and model.Parent and SectionCount(model) > 1 do
                local connMap = BuildConnectionMap(model)

                local tip = nil
                for section, count in pairs(connMap) do
                    if count == 1 and section ~= stump and section.Parent then
                        tip = section
                        break
                    end
                end

                if not tip then break end

                local weld, parent = FindTipWeld(model, tip)
                if not weld or not parent then break end

                local cutSection    = parent:FindFirstChild("ID") and parent or tip
                local jointWorldPos = (weld.Part0.CFrame * weld.C0).Position
                local localY        = (cutSection.CFrame:Inverse() * CFrame.new(jointWorldPos)).Position.Y
                local height        = math.clamp(localY + cutSection.Size.Y / 2, 0.05, cutSection.Size.Y - 0.05)

                local char = player.Character
                local hrp  = char and char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = CFrame.new(jointWorldPos + cutSection.CFrame.RightVector * 4)
                    hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    task.wait(0.1)
                end

                local before = SnapshotModels()

                FireCutAtHeight(cutSection, tool, axeName, treeClass, height)

                task.wait(0.1)

                for _, m in ipairs(logModels:GetChildren()) do
                    if not before[m] and m:IsA("Model") and IsOwnedByLocalPlayer(m) then
                        if SectionCount(m) > 1 then
                            table.insert(queue, m)
                        end
                    end
                end
            end
        end

        print("[TreeModule] Done chopping logs into sections.")
        if onComplete then onComplete() end
    end)
end

local _bridgeNPCID       = nil
local _bridgeLastPaid    = 0
local BRIDGE_PAID_WINDOW = 120

local function BridgeSafeInvoke(npcArg, action)
    local co   = coroutine.running()
    local done = false
    local thread = task.spawn(function()
        pcall(function() NPCDialogRemote:InvokeServer(npcArg, action) end)
        if not done then done = true; task.spawn(co) end
    end)
    task.delay(7, function()
        if not done then done = true; pcall(task.cancel, thread); task.spawn(co) end
    end)
    coroutine.yield()
end

local function PayBridgeToll()
    local seranok = Workspace:FindFirstChild("Bridge")
        and Workspace.Bridge:FindFirstChild("TollBooth0")
        and Workspace.Bridge.TollBooth0:FindFirstChild("Seranok")

    if not seranok then
        warn("[TreeModule] Seranok not found — cannot lower bridge.")
        return
    end

    local char = player.Character
    local hrp  = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local npcRoot = seranok:FindFirstChild("HumanoidRootPart")
    hrp.CFrame = npcRoot
        and CFrame.new(npcRoot.Position + Vector3.new(3, 0, 0))
        or seranok:GetPivot() * CFrame.new(3, 0, 0)
    hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    task.wait(0.1)

    if not seranok:FindFirstChild("Dialog") then
        Instance.new("Dialog", seranok)
    end

    if not _bridgeNPCID then
        local lastData = nil
        local conn = NPCPromptChat.OnClientEvent:Connect(function(_, data)
            if data then lastData = data end
        end)
        pcall(function() NPCPromptChat:FireServer(true, seranok, seranok.Dialog) end)
        local t = tick()
        repeat task.wait(0.05) until lastData or tick() - t > 5
        conn:Disconnect()
        pcall(function() NPCPromptChat:FireServer(false, seranok, seranok.Dialog) end)
        task.wait(0.1)

        if lastData then
            _bridgeNPCID = lastData.ID
        else
            warn("[TreeModule] Failed to get Seranok NPC ID.")
            return
        end
    end

    local npcArg = {
        ID        = _bridgeNPCID,
        Character = seranok,
        Name      = "Seranok",
        Dialog    = seranok.Dialog,
    }

    BridgeSafeInvoke(npcArg, "Initiate")
    task.wait(0.05)
    BridgeSafeInvoke(npcArg, "ConfirmPurchase")
    task.wait(0.05)
    BridgeSafeInvoke(npcArg, "EndChat")

    print("[TreeModule] Bridge toll paid — waiting for bridge to lower.")
    task.wait(1.5)
end

local function TreeHasFallen(treeClass)
    local logModels = Workspace:FindFirstChild("LogModels")
    if not logModels then return false end
    for _, model in ipairs(logModels:GetChildren()) do
        if preChopLogModels[model] then continue end
        if not model:IsA("Model") then continue end
        local tc = model:FindFirstChild("TreeClass")
        if tc and tc.Value == treeClass then return true end
    end
    return false
end

local function WaitForRespawn()
    print("[TreeModule] Player died — waiting for respawn...")

    local char = player.Character
    local hum  = char and char:FindFirstChildOfClass("Humanoid")
    if not char or not hum or hum.Health <= 0 then
        player.CharacterAdded:Wait()
    end

    local deadline = tick() + 30
    repeat
        task.wait(0.1)
        char = player.Character
        hum  = char and char:FindFirstChildOfClass("Humanoid")
    until (char and hum and hum.Health > 0 and char:FindFirstChild("HumanoidRootPart"))
       or tick() > deadline

    print(("[TreeModule] Respawned — resuming in %ds"):format(Settings.RespawnResumeDelay))
    task.wait(Settings.RespawnResumeDelay)
end

local function StartChopping(treeClass, LOT, onComplete)
    if isChopping then return end

    SnapshotLogModels()

    local treeModel = FindPriorityTree(treeClass)
    if not treeModel then
        warn("[TreeModule] No tree found for class:", treeClass)
        if onComplete then onComplete() end
        return
    end

    local sections = GetSectionsBottomFirst(treeModel)
    if #sections == 0 then
        warn("[TreeModule] Tree has no WoodSections.")
        if onComplete then onComplete() end
        return
    end

    local tool, axeName = GetBackpackAxe(treeClass)
    if not tool then
        warn("[TreeModule] No tool found in Backpack. Cannot chop.")
        if onComplete then onComplete() end
        return
    end
    print(("[TreeModule] Using '%s' from Backpack for tree class '%s'."):format(axeName, treeClass))

    local char = player.Character
    local hrp  = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then
        if onComplete then onComplete() end
        return
    end

    preChopCFrame       = hrp.CFrame
    preChopCameraCFrame = camera.CFrame
    isChopping          = true

    if treeClass == "LoneCave" then
        PayBridgeToll()
        char = player.Character
        hrp  = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then
            isChopping = false
            if onComplete then onComplete() end
            return
        end
    end

    EquipAxe(tool)

    local targetPart = sections[1]
    for _, s in ipairs(sections) do
        local idObj = s:FindFirstChild("ID")
        if idObj and idObj.Value == 1 then
            targetPart = s
            break
        end
    end
    hrp.CFrame = targetPart.CFrame
    hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)

    local lockConn = nil

    local function StartLockConn()
        if lockConn then lockConn:Disconnect() end
        lockConn = RunService.Heartbeat:Connect(function()
            local c = player.Character
            local r = c and c:FindFirstChild("HumanoidRootPart")
            if r and targetPart and targetPart.Parent then
                r.CFrame = targetPart.CFrame
                r.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            end
        end)
    end

    local function StopLockConn()
        if lockConn then lockConn:Disconnect(); lockConn = nil end
    end

    local playerDied = false
    local diedConn   = nil

    local function HookDiedEvent()
        if diedConn then diedConn:Disconnect(); diedConn = nil end
        local c    = player.Character
        local hum2 = c and c:FindFirstChildOfClass("Humanoid")
        if not hum2 then return end
        diedConn = hum2.Died:Connect(function()
            playerDied = true
            StopLockConn()
            print("[TreeModule] Death detected during chop.")
        end)
    end

    HookDiedEvent()
    StartLockConn()
    task.wait(Settings.SyncDelay)

    task.spawn(function()
        local baseSection = nil

        local function RefreshBaseSection()
            baseSection = nil
            local fresh = GetSectionsBottomFirst(treeModel)
            if #fresh == 0 then return end
            baseSection = fresh[1]
            for _, s in ipairs(fresh) do
                local idObj = s:FindFirstChild("ID")
                if idObj and idObj.Value == 1 then
                    baseSection = s
                    break
                end
            end
        end

        RefreshBaseSection()

        while not TreeHasFallen(treeClass) and isChopping do
            if playerDied then
                StopLockConn()
                WaitForRespawn()
                if not isChopping then break end
                if TreeHasFallen(treeClass) then break end

                tool, axeName = GetBackpackAxe(treeClass)
                if not tool then
                    warn("[TreeModule] No axe found after respawn — stopping.")
                    isChopping = false
                    break
                end
                print(("[TreeModule] Resumed with '%s' after respawn."):format(axeName))

                local newChar = player.Character
                local newHRP  = newChar and newChar:FindFirstChild("HumanoidRootPart")
                if newHRP and targetPart and targetPart.Parent then
                    newHRP.CFrame = targetPart.CFrame
                    newHRP.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                end

                playerDied = false
                HookDiedEvent()
                StartLockConn()
                task.wait(Settings.SyncDelay)

                RefreshBaseSection()
            end

            if not baseSection or not baseSection.Parent then
                RefreshBaseSection()
                if not baseSection then break end
            end

            FireCutSection(baseSection, tool, axeName, treeClass, function()
                return TreeHasFallen(treeClass) or playerDied
            end)

            task.wait(Settings.SweepDelay)
        end

        StopLockConn()
        if diedConn then diedConn:Disconnect(); diedConn = nil end

        if not isChopping then
            CleanupState()
            if onComplete then onComplete() end
            return
        end

        print("[TreeModule] Tree is down. Returning player.")
        task.wait(0.3)
        CleanupState()

        local stumps     = CollectNewStumps(treeClass)
        local currentHRP = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

        RunLOTBatch(LOT, stumps, function(i, _)
            return currentHRP
                and (currentHRP.CFrame * CFrame.new((i - 1) * 5, 0, -Settings.LogDropDistance))
                or CFrame.new(0, 0, 0)
        end, onComplete)
    end)
end

local function WatchForRemovedTreeTypes(onClassEmpty)
    local connections = {}

    local function CountTreeClass(className)
        local count = 0
        for _, folder in ipairs(Workspace:GetChildren()) do
            if folder.Name:lower():match("treeregion") then
                for _, model in ipairs(folder:GetChildren()) do
                    if model:IsA("Model") then
                        local tc = model:FindFirstChild("TreeClass")
                        if tc and tc.Value == className and CountTreeSections(model) > 1 then
                            count += 1
                        end
                    end
                end
            end
        end
        return count
    end

    local function WatchFolder(folder)
        local conn = folder.ChildRemoved:Connect(function(model)
            if not model:IsA("Model") then return end
            local tc = model:FindFirstChild("TreeClass")
            if not tc or not tc:IsA("StringValue") then return end
            local className = tc.Value

            task.delay(0.5, function()
                local remaining = CountTreeClass(className)
                onClassEmpty(className, remaining == 0)
            end)
        end)
        table.insert(connections, conn)
    end

    for _, folder in ipairs(Workspace:GetChildren()) do
        if folder.Name:lower():match("treeregion") then
            WatchFolder(folder)
        end
    end

    local workspaceConn = Workspace.ChildAdded:Connect(function(child)
        if child.Name:lower():match("treeregion") then
            WatchFolder(child)
        end
    end)
    table.insert(connections, workspaceConn)

    return function()
        for _, conn in ipairs(connections) do conn:Disconnect() end
    end
end

local function WatchForNewTreeTypes(knownSet, onNewClass)
    local connections = {}

    local function WatchFolder(folder)
        local conn = folder.ChildAdded:Connect(function(model)
            if not model:IsA("Model") then return end

            task.delay(0.5, function()
                if not model or not model.Parent then return end
                local tc = model:FindFirstChild("TreeClass")
                if not tc or not tc:IsA("StringValue") then return end
                if CountTreeSections(model) <= 1 then return end
                local className = tc.Value
                if knownSet[className] then return end
                knownSet[className] = true
                onNewClass(className)
            end)
        end)
        table.insert(connections, conn)
    end

    for _, folder in ipairs(Workspace:GetChildren()) do
        if folder.Name:lower():match("treeregion") then
            WatchFolder(folder)
        end
    end

    local workspaceConn = Workspace.ChildAdded:Connect(function(child)
        if child.Name:lower():match("treeregion") then
            WatchFolder(child)
        end
    end)
    table.insert(connections, workspaceConn)

    return function()
        for _, conn in ipairs(connections) do
            conn:Disconnect()
        end
    end
end

function TreeModule.Init(Tab, LOT)
    Tab:CreateSection("Auto-Tree Configuration")

    local PRIORITY_TREES = {
        "Generic", "Cherry", "Birch", "Oak", "Walnut", "Koa", "Pine", "Palm", "Fir",
        "Volcano", "Frost", "GreenSwampy", "GoldSwampy",
        "SnowGlow", "CaveCrawler", "LoneCave", "Spook", "Sinister",
    }

    local treeTypes = ScanForTreeTypes()

    local function ScanAllTreeClasses()
        local found, seen = {}, {}
        for _, folder in ipairs(Workspace:GetChildren()) do
            if folder.Name:lower():match("treeregion") then
                for _, model in ipairs(folder:GetChildren()) do
                    if model:IsA("Model") then
                        local tc = model:FindFirstChild("TreeClass")
                        if tc and tc:IsA("StringValue") and not seen[tc.Value] then
                            seen[tc.Value] = true
                            table.insert(found, tc.Value)
                        end
                    end
                end
            end
        end
        return found
    end

    local allTreeClasses = ScanAllTreeClasses()

    local foundSet    = {}
    for _, t in ipairs(treeTypes) do foundSet[t] = true end
    local prioritySet = {}
    for _, t in ipairs(PRIORITY_TREES) do prioritySet[t] = true end

    local allClassSet = {}
    for _, t in ipairs(allTreeClasses) do allClassSet[t] = true end

    local orderedOptions = {}
    local disabledInDrop = {}

    for _, t in ipairs(PRIORITY_TREES) do
        if foundSet[t] then table.insert(orderedOptions, t) end
    end

    for _, t in ipairs(treeTypes) do
        if not prioritySet[t] then table.insert(orderedOptions, t) end
    end

    for _, t in ipairs(PRIORITY_TREES) do
        if not foundSet[t] and allClassSet[t] then
            table.insert(orderedOptions, t)
            disabledInDrop[t] = true
        end
    end

    for _, t in ipairs(PRIORITY_TREES) do
        if not allClassSet[t] then
            table.insert(orderedOptions, t)
            disabledInDrop[t] = true
        end
    end

    local selectedTree = "Error"
    for _, t in ipairs(orderedOptions) do
        if not disabledInDrop[t] then selectedTree = t; break end
    end

    local chopQuantity      = 1
    local chopButton
    local chopSessionActive = false

    local treeDropdown = Tab:CreateDropdown("Target Tree Type", orderedOptions, selectedTree, function(sel)
        selectedTree = sel
    end)

    for t in pairs(disabledInDrop) do
        treeDropdown:SetOptionDisabled(t, true)
    end

    local knownSet = {}
    for k, v in pairs(foundSet) do knownSet[k] = v end

    WatchForNewTreeTypes(knownSet, function(newClass)
        print(("[TreeModule] New tree type detected: %s — enabling in dropdown."):format(newClass))

        if disabledInDrop[newClass] then
            disabledInDrop[newClass] = nil
            treeDropdown:SetOptionDisabled(newClass, false)
        else

            local insertAt = #orderedOptions + 1
            for i, opt in ipairs(orderedOptions) do
                if disabledInDrop[opt] then
                    insertAt = i
                    break
                end
            end
            table.insert(orderedOptions, insertAt, newClass)
            treeDropdown:AddOption(newClass, insertAt)
        end

        if selectedTree == "Error" then
            selectedTree = newClass
            treeDropdown:SetSelected(newClass)
        end
    end)

    WatchForRemovedTreeTypes(function(className, isEmpty)
        if isEmpty then

            disabledInDrop[className] = true
            treeDropdown:SetOptionDisabled(className, true)
            print(("[TreeModule] No more '%s' trees — disabled in dropdown."):format(className))

            if selectedTree == className then
                selectedTree = "Error"
                for _, t in ipairs(orderedOptions) do
                    if not disabledInDrop[t] then
                        selectedTree = t
                        treeDropdown:SetSelected(t)
                        break
                    end
                end
            end
        else

            if disabledInDrop[className] then
                disabledInDrop[className] = nil
                treeDropdown:SetOptionDisabled(className, false)
                print(("[TreeModule] '%s' trees available again — enabled in dropdown."):format(className))
            end
        end
    end)

    Tab:CreateSlider("Quantity", 1, 25, 1, function(val)
        chopQuantity = val
    end)

    chopButton = Tab:CreateAction("Get Tree", "", function()
        if chopSessionActive then
            chopSessionActive = false
            isChopping = false
            if type(chopButton) == "table" and chopButton.SetFullText then
                chopButton:SetFullText("Get Tree")
            end
        else
            if selectedTree == "None Found" or selectedTree == "Error" then return end
            chopSessionActive = true
            if type(chopButton) == "table" and chopButton.SetFullText then
                chopButton:SetFullText("Abort Get Tree")
            end

            local remaining = chopQuantity
            local function chopNext()
                if not chopSessionActive or remaining <= 0 then
                    chopSessionActive = false
                    if type(chopButton) == "table" and chopButton.SetFullText then
                        chopButton:SetFullText("Get Tree")
                    end
                    return
                end
                remaining -= 1
                StartChopping(selectedTree, LOT, function()
                    chopNext()
                end)
            end

            chopNext()
        end
    end)

    Tab:CreateSection("Log Management")

    local chopSectionsButton = Tab:CreateAction("Chop All Trees", "Start", function()
        if not LOT then warn("[TreeModule] LOT not available.") return end

        if type(chopSectionsButton) == "table" and chopSectionsButton.SetText then
            chopSectionsButton:SetText("Chopping...")
        end

        ChopLogsIntoSections(function()
            if type(chopSectionsButton) == "table" and chopSectionsButton.SetText then
                chopSectionsButton:SetText("Start")
            end
        end)
    end)

    local LogRow = Tab:CreateRow()

    local tpAllButton = LogRow:CreateAction("TP All Logs", "", function()
        if not LOT then warn("[TreeModule] LOT not available.") return end
        if LOT.IsBusy() then warn("[TreeModule] LOT busy.") return end

        local stumps     = CollectAllOwnedStumps()
        local currentHRP = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if #stumps == 0 then return end

        if type(tpAllButton) == "table" and tpAllButton.SetText then
            tpAllButton:SetText("Working...")
        end

        RunLOTBatch(LOT, stumps, function(_, _)
            return currentHRP
                and (currentHRP.CFrame * CFrame.new(0, 0, -Settings.LogDropDistance))
                or CFrame.new(0, 0, 0)
        end, function()
            if type(tpAllButton) == "table" and tpAllButton.SetText then
                tpAllButton:SetText("")
            end
        end)
    end)

    local sellButton = LogRow:CreateAction("Sell All Logs", "", function()
        if not LOT then warn("[TreeModule] LOT not available.") return end
        if LOT.IsBusy() then warn("[TreeModule] LOT busy.") return end

        local stumps = CollectSingleSectionStumps()
        if #stumps == 0 then return end

        if type(sellButton) == "table" and sellButton.SetText then
            sellButton:SetText("Selling...")
        end

        local sellPos = Settings.SellPosition
        RunLOTBatch(LOT, stumps, function(_, _)
            return CFrame.new(sellPos.X, sellPos.Y, sellPos.Z)
        end, function()
            if type(sellButton) == "table" and sellButton.SetText then
                sellButton:SetText("")
            end
        end)
    end)
    Tab:CreateToggle("Click To Sell (Planks)", false, function(state)
        if state then StartSellPlanks(LOT) else StopSellPlanks() end
    end)

    local pc_enabled        = false
    local pc_isCutting      = false
    local pc_outline        = nil
    local pc_cutPlanes      = {}
    local pc_trackedSection = nil
    local pc_currentTarget  = nil
    local pc_hoverConn      = nil
    local pc_clickConn      = nil
    local pc_visualConn     = nil
    local pc_mouse          = player:GetMouse()

    local PC_FIRE_DELAY    = 0.03
    local PC_CUT_TIMEOUT   = 90
    local PC_BLUE          = Color3.fromRGB(74, 120, 255)
    local PC_MAX_CUT_UNITS = 100
    local PC_DETECT_RADIUS = 8
    local RemoteProxyPC    = ReplicatedStorage:WaitForChild("Interaction"):WaitForChild("RemoteProxy")

    local function pc_ReadAxeName(tool)
        if not tool then return nil end
        local tip = tool:FindFirstChild("ToolTip")
        return (tip and tip:IsA("StringValue")) and tip.Value or tool.ToolTip
    end

    local function pc_GetPlankTreeClass(plankModel)
        if not plankModel then return nil end
        local tc = plankModel:FindFirstChild("TreeClass")
        if tc and tc:IsA("StringValue") then return tc.Value end
        for _, v in ipairs(plankModel:GetDescendants()) do
            if v.Name == "TreeClass" and v:IsA("StringValue") then return v.Value end
        end
        return nil
    end

    local function pc_GetBestAxe(treeClass)
        local candidates = {}
        local function TryAdd(tool)
            if not tool:IsA("Tool") then return end
            if tool.Name == "BlueprintTool" then return end
            local name = pc_ReadAxeName(tool)
            if not name then return end
            if treeClass == "LoneCave" and name ~= "End Times Axe" then return end
            local dmg = _G.LT2Axes.GetDamage(name, treeClass) or 0
            table.insert(candidates, { tool = tool, name = name, dmg = dmg })
        end
        local char = player.Character
        if char then
            local eq = char:FindFirstChildOfClass("Tool")
            if eq then TryAdd(eq) end
        end
        for _, t in ipairs(player.Backpack:GetChildren()) do TryAdd(t) end
        if #candidates == 0 then return nil, nil, 0 end
        table.sort(candidates, function(a, b) return a.dmg > b.dmg end)
        local best = candidates[1]
        return best.tool, best.name, best.dmg
    end

    local function pc_FindOwnedPlank(part)
        if not part then return nil end
        local pm = Workspace:FindFirstChild("PlayerModels")
        if not pm then return nil end
        local cur = part
        while cur and cur.Parent ~= pm do cur = cur.Parent end
        if not cur or not cur:IsA("Model") or cur.Name ~= "Plank" then return nil end
        local owner    = cur:FindFirstChild("Owner")
        local ownerStr = owner and owner:FindFirstChild("OwnerString")
        if not ownerStr or ownerStr.Value ~= player.Name then return nil end
        return cur
    end

    local function pc_GetPlankSection(model)
        if not model then return nil end
        for _, d in ipairs(model:GetDescendants()) do
            if d:IsA("BasePart") and d:FindFirstChild("ID") then return d end
        end
        return nil
    end

    local function pc_GetCutStep(section)
        return math.max(0.5, 1 / math.min(section.Size.X, section.Size.Z))
    end

    local function pc_GetCutHeights(section)
        local sizeY = section.Size.Y
        local step  = pc_GetCutStep(section)
        local out   = {}
        local h     = step
        while h < sizeY - 0.01 do table.insert(out, h); h = h + step end
        return out, step
    end

    local function pc_IsPlankEligible(section, treeClass)
        if not section then return false end
        local heights = pc_GetCutHeights(section)
        if #heights > PC_MAX_CUT_UNITS then return false end
        if treeClass == "LoneCave" then
            local t = pc_GetBestAxe("LoneCave")
            if not t then return false end
        end
        return true
    end

    local function pc_EnsureOutline()
        if pc_outline and pc_outline.Parent then return end
        pc_outline = Instance.new("SelectionBox")
        pc_outline.Color3 = PC_BLUE
        pc_outline.SurfaceColor3 = PC_BLUE
        pc_outline.LineThickness = 0.04
        pc_outline.SurfaceTransparency = 0.8
        pc_outline.Parent = Workspace
    end

    local function pc_SetOutlineTarget(model)
        pc_EnsureOutline()
        if pc_outline.Adornee ~= model then pc_outline.Adornee = model end
    end

    local function pc_ClearCutPlanes()
        for _, e in ipairs(pc_cutPlanes) do pcall(function() e.part:Destroy() end) end
        pc_cutPlanes = {}
        pc_trackedSection = nil
    end

    local function pc_RebuildCutPlanes(section)
        pc_ClearCutPlanes()
        if not section or not section.Parent then return end
        local heights = pc_GetCutHeights(section)
        local sx    = section.Size.X + 0.08
        local sz    = section.Size.Z + 0.08
        local sizeY = section.Size.Y
        for _, h in ipairs(heights) do
            local localCF = CFrame.new(0, -sizeY / 2 + h, 0)
            local p = Instance.new("Part")
            p.Anchored = true; p.CanCollide = false; p.CanTouch = false
            p.CanQuery = false; p.CastShadow = false
            p.Size = Vector3.new(sx, 0.04, sz)
            p.Color = PC_BLUE; p.Material = Enum.Material.Neon
            p.Transparency = 0.2
            p.CFrame = section.CFrame * localCF
            p.Parent = Workspace
            table.insert(pc_cutPlanes, { part = p, localCF = localCF })
        end
        pc_trackedSection = section
    end

    local function pc_FindCutEvent(section)
        local cur = section
        while cur and cur ~= Workspace do
            local ce = cur:FindFirstChild("CutEvent")
            if ce then return ce end
            cur = cur.Parent
        end
        return nil
    end

    local function pc_FireUntilSplit(section, tool, damage, height)
        local idObj    = section:FindFirstChild("ID")
        local cutEvent = pc_FindCutEvent(section)
        if not idObj or not cutEvent then return nil end
        local pm = Workspace:FindFirstChild("PlayerModels")
        local snapshot = {}
        if pm then for _, m in ipairs(pm:GetChildren()) do snapshot[m] = true end end
        local args = {
            sectionId = idObj.Value, faceVector = Vector3.new(0,0,-1),
            height = height, hitPoints = damage, cooldown = 0,
            cuttingClass = "Axe", tool = tool,
        }
        EquipAxe(tool)
        local lastPos = section.Position
        local function FindNewSection()
            if not pm then return nil end
            for _, m in ipairs(pm:GetChildren()) do
                if not snapshot[m] and m:IsA("Model") and m.Name == "Plank" then
                    local owner = m:FindFirstChild("Owner")
                    local ownerStr = owner and owner:FindFirstChild("OwnerString")
                    if ownerStr and ownerStr.Value == player.Name then
                        local sec = pc_GetPlankSection(m)
                        if sec and (sec.Position - lastPos).Magnitude <= PC_DETECT_RADIUS then
                            return sec
                        end
                    end
                end
            end
            return nil
        end
        local originalSizeY = section.Size.Y
        local deadline = tick() + PC_CUT_TIMEOUT
        while tick() < deadline and pc_enabled do
            if section.Parent then lastPos = section.Position end
            if not section.Parent then task.wait(0.05); return FindNewSection() end
            RemoteProxyPC:FireServer(cutEvent, args)
            task.wait(PC_FIRE_DELAY)
            if not section.Parent or section.Size.Y ~= originalSizeY then
                task.wait(0.05); return FindNewSection()
            end
        end
        return nil
    end

    local function pc_TeleportAbovePlank(section, cutHeight)
        local char = player.Character
        local hrp  = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp or not section or not section.Parent then return end
        local bottomY   = -section.Size.Y / 2
        local localCutY = bottomY + (cutHeight or 0)
        local worldPos  = (section.CFrame * CFrame.new(0, localCutY + 3, 0)).Position
        if (hrp.Position - worldPos).Magnitude <= PC_DETECT_RADIUS then return end
        hrp.CFrame = CFrame.new(worldPos)
        hrp.AssemblyLinearVelocity  = Vector3.new(0, 0, 0)
        hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
    end

    local pc_statusBB = nil
    local pc_sessionCutCount = 0
    local pc_sessionCutTotal = 0.0

    local function pc_ShowStatus(text)
        -- status billboard removed
        return nil
    end

    local function pc_HideStatus()
        if pc_statusBB then pc_statusBB:Destroy(); pc_statusBB = nil end
    end

    local function pc_CountCuts(section)
        local heights = pc_GetCutHeights(section)
        return #heights, #heights + 1
    end

    local function pc_CutPlankIntoUnits(plankModel)
        pc_isCutting     = true
        pc_currentTarget = plankModel
        pc_SetOutlineTarget(plankModel)
        local treeClass = pc_GetPlankTreeClass(plankModel)
        local tool, axeName, damage = pc_GetBestAxe(treeClass)
        if not tool then
            pc_SetOutlineTarget(nil); pc_ClearCutPlanes()
            pc_isCutting = false; pc_currentTarget = nil; return
        end
        EquipAxe(tool)
        local section = pc_GetPlankSection(plankModel)
        if not section then
            pc_SetOutlineTarget(nil); pc_ClearCutPlanes()
            pc_isCutting = false; pc_currentTarget = nil; return
        end

        local step            = pc_GetCutStep(section)
        local cutsNeeded, planksTotal = pc_CountCuts(section)
        local statusLbl       = pc_ShowStatus(
            string.format("✂  %d planks  ·  ETA --", planksTotal)
        )

        local cutsDone    = 0
        local avgCutTime  = nil

        local function formatETA(secsLeft)
            local s = math.floor(secsLeft)
            local m = math.floor(s / 60)
            s = s % 60
            return m > 0 and string.format("%dm %ds", m, s) or string.format("%ds", s)
        end

        local function updateStatus()
            if not statusLbl or not statusLbl.Parent then return end
            local planksLeft = math.max(0, planksTotal - cutsDone - 1)
            local cutsLeft   = math.max(0, cutsNeeded - cutsDone)
            local etaStr     = "--"
            if avgCutTime and cutsLeft > 0 then
                etaStr = formatETA(avgCutTime * cutsLeft)
            elseif cutsLeft == 0 then
                etaStr = "done"
            end
            statusLbl.Text = string.format("✂  %d planks  ·  ETA %s", planksLeft, etaStr)
        end

        pc_TeleportAbovePlank(section, step)
        task.wait(0.1)

        local cur = section
        while pc_enabled and cur and cur.Parent do
            if cur.Size.Y <= step + 0.05 then break end
            pc_RebuildCutPlanes(cur)
            pc_currentTarget = cur.Parent
            pc_SetOutlineTarget(pc_currentTarget)
            pc_TeleportAbovePlank(cur, step)

            local t0     = tick()
            local newSec = pc_FireUntilSplit(cur, tool, damage, step)
            local elapsed = tick() - t0

            cutsDone += 1

            pc_sessionCutCount += 1
            pc_sessionCutTotal += elapsed
            avgCutTime = pc_sessionCutTotal / pc_sessionCutCount

            pc_ClearCutPlanes()
            updateStatus()

            if not newSec then break end
            local nextPiece = cur
            if not (cur.Parent and cur.Size.Y > newSec.Size.Y) then nextPiece = newSec end
            if nextPiece and nextPiece.Parent then
                cur = nextPiece
                pc_currentTarget = nextPiece.Parent
                pc_SetOutlineTarget(pc_currentTarget)
            end
            task.wait(0.1)
        end

        pc_sessionCutCount = 0
        pc_sessionCutTotal = 0.0
        pc_ClearCutPlanes()
        pc_HideStatus()
        UnequipAxe()
        pc_isCutting = false
    end

    Tab:CreateToggle("1x1 Cutter", false, function(state)
        if state then
            pc_enabled   = true
            pc_isCutting = false

            pc_visualConn = RunService.Heartbeat:Connect(function()
                if not pc_trackedSection or not pc_trackedSection.Parent then return end
                local cf = pc_trackedSection.CFrame
                for _, e in ipairs(pc_cutPlanes) do
                    if e.part.Parent then e.part.CFrame = cf * e.localCF end
                end
            end)

            local lastSection = nil
            pc_hoverConn = RunService.RenderStepped:Connect(function()
                if not pc_enabled or pc_isCutting then return end
                local target = pc_mouse.Target
                local plank  = pc_FindOwnedPlank(target)
                if plank then
                    local sec = pc_GetPlankSection(plank)
                    local tc  = pc_GetPlankTreeClass(plank)
                    if sec and pc_IsPlankEligible(sec, tc) then
                        if pc_currentTarget ~= plank then
                            pc_currentTarget = plank
                            pc_SetOutlineTarget(plank)
                        end
                        if sec ~= lastSection then
                            lastSection = sec
                            pc_RebuildCutPlanes(sec)
                        end
                    else
                        if pc_currentTarget then
                            pc_currentTarget = nil
                            pc_SetOutlineTarget(nil)
                            pc_ClearCutPlanes()
                            lastSection = nil
                        end
                    end
                else
                    local clearOk = true
                    if pc_currentTarget and target and target:IsDescendantOf(pc_currentTarget) then
                        clearOk = false
                    end
                    if clearOk and pc_currentTarget then
                        pc_currentTarget = nil
                        pc_SetOutlineTarget(nil)
                        pc_ClearCutPlanes()
                        lastSection = nil
                    end
                end
            end)

            pc_clickConn = pc_mouse.Button1Down:Connect(function()
                if not pc_enabled or pc_isCutting then return end
                local plank = pc_FindOwnedPlank(pc_mouse.Target)
                if not plank then return end
                local sec = pc_GetPlankSection(plank)
                local tc  = pc_GetPlankTreeClass(plank)
                if not pc_IsPlankEligible(sec, tc) then return end
                task.spawn(function() pc_CutPlankIntoUnits(plank) end)
            end)

        else
            pc_sessionCutCount = 0
            pc_sessionCutTotal = 0.0
            pc_enabled = false
            if pc_hoverConn  then pc_hoverConn:Disconnect();  pc_hoverConn  = nil end
            if pc_clickConn  then pc_clickConn:Disconnect();  pc_clickConn  = nil end
            if pc_visualConn then pc_visualConn:Disconnect(); pc_visualConn = nil end
            if pc_outline    then pc_outline.Adornee = nil end
            pc_ClearCutPlanes()
            pc_currentTarget = nil
            pc_HideStatus()
        end
    end)

end

return TreeModule
]],
            "Tree"
        ))()
    end
    __modules["ModTree"] = function()
        return assert(loadstring(
            [=[local ModTreeModule = {}

local Players           = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService        = game:GetService("RunService")

local Player      = Players.LocalPlayer
local Mouse       = Player:GetMouse()
local RemoteProxy = ReplicatedStorage:WaitForChild("Interaction"):WaitForChild("RemoteProxy")

local ClientPlacedBlueprint = ReplicatedStorage
    :WaitForChild("PlaceStructure")
    :WaitForChild("ClientPlacedBlueprint")

local _LOT = nil
local _Lib = nil

function ModTreeModule.SetLOT(lot) _LOT = lot end

local _debugMode = false

local function DebugLog(level, ...)
    if not _debugMode then return end
    if level == "warn" then warn(...) else print(...) end
end

local MOD_TP_CF            = CFrame.new(-1420, 380, 1400)
local DROP_ZONE_CF         = CFrame.new(-360, 92, -100)
local DISAPPEAR_TIMEOUT    = 60
local CHOP_FIRES           = 100
local CHOP_FIRE_DELAY      = 0.03
local CHOP_CONFIRM_TIMEOUT = 40

local BLUEPRINT_NAME  = "Wall2"
local TILE_END_OFFSET = CFrame.new(0, 5, -1.8)
local TILE_OFFSET_4L  = CFrame.new(0, 8.5, -1.8)
local MATCH_TOLERANCE = 1

local _isModding      = false
local _isModSawmill   = false
local _currentSession = nil

local _modAliveRef     = { false }
local _sawmillAliveRef = { false }

local function Notify(title, text)
    if _Lib and _Lib.Notify then
        _Lib:Notify(title, text)
    end
end

local function NotifyDebug(title, text)
    Notify(title, text)
    DebugLog("print", ("[%s] %s"):format(title, text))
end

local function GetBlueprintOffset(sawmill)
    local itemName = sawmill:FindFirstChild("ItemName")
    if itemName and itemName.Value == "Sawmill4L" then return TILE_OFFSET_4L end
    return TILE_END_OFFSET
end

local function GetSawmillParticlesCF(sawmill)
    local particles = sawmill:FindFirstChild("Particles", true)
    if particles and particles:IsA("BasePart") then return particles.CFrame end
    return select(1, sawmill:GetBoundingBox())
end

local function FindExistingBlueprint(targetCF)
    local pm = workspace:FindFirstChild("PlayerModels")
    if not pm then return nil end
    for _, model in ipairs(pm:GetChildren()) do
        local itemName = model:FindFirstChild("ItemName")
        if not itemName or itemName.Value ~= BLUEPRINT_NAME then continue end
        local owner       = model:FindFirstChild("Owner")
        local ownerString = owner and owner:FindFirstChild("OwnerString")
        local ownerVal    = owner and owner.Value
        local isOwner = (ownerString and ownerString.Value == Player.Name)
                     or (ownerVal    and ownerVal           == Player)
        if not isOwner then continue end
        local cf = (model:FindFirstChild("MainCFrame") and model.MainCFrame.Value)
                or (model.PrimaryPart and model.PrimaryPart.CFrame)
                or model:GetPivot()
        if (cf.Position - targetCF.Position).Magnitude <= MATCH_TOLERANCE then
            return model
        end
    end
    return nil
end

local function PlaceBlueprintAtSawmill(sawmill)
    local particlesCF = GetSawmillParticlesCF(sawmill)
    local offset      = GetBlueprintOffset(sawmill)
    local finalCF     = particlesCF * offset * CFrame.Angles(math.rad(90), 0, 0)
    local existing    = FindExistingBlueprint(finalCF)
    if existing then
        DebugLog("print", "[ModTree] Blueprint already at sawmill — skipping placement.")
        return false
    end
    DebugLog("print", "[ModTree] Placing blueprint at sawmill output...")
    ClientPlacedBlueprint:FireServer(BLUEPRINT_NAME, finalCF, Player)
    DebugLog("print", "[ModTree] Blueprint placed.")
    return true
end

local function ReadAxeName(tool)
    if not tool then return nil end
    local tip = tool:FindFirstChild("ToolTip")
    return (tip and tip:IsA("StringValue")) and tip.Value or tool.ToolTip
end

local function GetBestAxe(treeClass)
    local candidates = {}

    local function TryAdd(tool)
        if not tool:IsA("Tool") or tool.Name == "BlueprintTool" then return end
        local name = ReadAxeName(tool)
        if not name then return end
        local score = treeClass
            and _G.LT2Axes.GetDamage(name, treeClass)
            or (1 / (_G.LT2Axes.Rank[name] or 2^53))
        table.insert(candidates, { tool = tool, name = name, score = score })
    end

    local char = Player.Character
    if char then
        local equipped = char:FindFirstChildOfClass("Tool")
        if equipped then TryAdd(equipped) end
    end
    for _, tool in ipairs(Player.Backpack:GetChildren()) do TryAdd(tool) end

    if #candidates == 0 then return nil, nil, 0 end
    table.sort(candidates, function(a, b) return a.score > b.score end)

    local best = candidates[1]
    return best.tool, best.name, best.score
end

local function AnalyzeTree(treeModel)
    local entries = {}

    for _, part in ipairs(treeModel:GetDescendants()) do
        if part:IsA("BasePart") and part.Name ~= "Stump" then
            local idVal = part:FindFirstChild("ID")
            if idVal and (idVal:IsA("IntValue") or idVal:IsA("NumberValue")) then
                local childIDs    = {}
                local childFolder = part:FindFirstChild("ChildIDs")
                if childFolder then
                    for _, child in ipairs(childFolder:GetChildren()) do
                        if child.Name == "Child" and (child:IsA("IntValue") or child:IsA("NumberValue")) then
                            table.insert(childIDs, child.Value)
                        end
                    end
                end
                table.insert(entries, {
                    part        = part,
                    id          = idVal.Value,
                    childIDs    = childIDs,
                    hasChildren = #childIDs > 0,
                })
            end
        end
    end

    table.sort(entries, function(a, b) return a.id < b.id end)

    local stumpEntry, targetEntry = entries[1], nil
    for i = #entries, 1, -1 do
        if entries[i].hasChildren then targetEntry = entries[i]; break end
    end

    local tipID = nil
    if targetEntry then
        for _, cid in ipairs(targetEntry.childIDs) do
            if not tipID or cid > tipID then tipID = cid end
        end
    end

    return { all = entries, stump = stumpEntry, target = targetEntry, tipID = tipID }
end

local function GetAncestorModel(instance)
    local current = instance
    while current and not current:IsA("Model") do current = current.Parent end
    return current
end

local SAWMILL_NAMES = {
    Sawmill = true, Sawmill2 = true, Sawmill3 = true,
    Sawmill4 = true, Sawmill4L = true,
}

local function IsValidSawmill(model)
    if not model or not model:IsA("Model") then return false end
    local itemName = model:FindFirstChild("ItemName")
    return itemName and itemName:IsA("StringValue") and SAWMILL_NAMES[itemName.Value] == true
end

local function IsValidTree(model)
    if not model or not model:IsA("Model") then return false end
    local logModels = workspace:FindFirstChild("LogModels")
    if not logModels or model.Parent ~= logModels then return false end
    for _, desc in ipairs(model:GetDescendants()) do
        if desc:IsA("BasePart") and desc:FindFirstChild("ID") then return true end
    end
    return false
end

local function WaitForSawmillClick(aliveRef)
    local result, done, conn = nil, false, nil
    conn = Mouse.Button1Down:Connect(function()
        local target = Mouse.Target
        if not target then return end
        local playerModels = workspace:FindFirstChild("PlayerModels")
        if not playerModels then return end
        local current = target
        while current and current.Parent ~= playerModels do current = current.Parent end
        if IsValidSawmill(current) then
            result = current; done = true; conn:Disconnect()
        end
    end)
    while not done and aliveRef[1] do task.wait() end
    if conn.Connected then conn:Disconnect() end
    return result
end

local function WaitForTreeQueueThenSawmill(aliveRef)
    local queue    = {}
    local queueSet = {}
    local sawmill  = nil
    local done     = false
    local conn

    conn = Mouse.Button1Down:Connect(function()
        if not aliveRef[1] or done then return end
        local target = Mouse.Target
        if not target then return end

        do
            local playerModels = workspace:FindFirstChild("PlayerModels")
            if playerModels then
                local current = target
                while current and current.Parent ~= playerModels do
                    current = current.Parent
                end
                if IsValidSawmill(current) then
                    sawmill = current
                    done    = true
                    conn:Disconnect()
                    return
                end
            end
        end

        local model = GetAncestorModel(target)
        if not IsValidTree(model) then return end
        if queueSet[model] then
            Notify("Mod Tree", ("Already queued — %d tree(s) selected. Click your sawmill when ready."):format(#queue))
            return
        end
        queueSet[model] = true
        table.insert(queue, model)
        DebugLog("print", ("[ModTree] Tree queued: %s (total=%d)"):format(model.Name, #queue))
        Notify("Mod Tree", ("%d tree(s) queued — click your sawmill when ready."):format(#queue))
    end)

    while not done and aliveRef[1] do task.wait() end
    if conn.Connected then conn:Disconnect() end

    return queue, sawmill
end

-- equip the chosen axe when chopping starts, put it away the moment chopping is done
local AutoEquip = { tool = nil }

local function EquipAxe(tool)
    local char = Player.Character
    if not (tool and tool.Parent and char) or tool.Parent == char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum and hum.Health > 0 and tool.Parent == Player.Backpack then
        pcall(function()
            hum:EquipTool(tool)
        end)
        AutoEquip.tool = tool -- we equipped it, so we put it away when done
    end
end

local function UnequipAxe()
    local t = AutoEquip.tool
    AutoEquip.tool = nil
    local char = Player.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if t and hum and t.Parent == char then
        pcall(function()
            hum:UnequipTools()
        end)
    end
end

local function FireCutSection(section, tool, axeName, treeClass, stopFn)
    if not section or not section.Parent then return false end

    local idObj = section:FindFirstChild("ID")
    if not idObj then
        DebugLog("warn", "[ModTree] FireCutSection: no ID on", section:GetFullName()); return false
    end

    local cutEvent, current = nil, section
    while current and current ~= workspace do
        cutEvent = current:FindFirstChild("CutEvent")
        if cutEvent then break end
        current = current.Parent
    end
    if not cutEvent then
        DebugLog("warn", "[ModTree] FireCutSection: CutEvent not found for", section:GetFullName()); return false
    end

    local char = Player.Character
    local hrp  = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CFrame = CFrame.lookAt(section.Position + section.CFrame.RightVector * 4, section.Position)
        hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        task.wait(0.1)
    end

    local sizeY  = section.Size.Y
    local height = sizeY * math.clamp(0.1 + (8 - sizeY) / 60, 0.1, 0.2)
    local damage = _G.LT2Axes.GetDamage(axeName, treeClass)

    local args = {
        sectionId    = idObj.Value,
        faceVector   = Vector3.new(0, 0, -1),
        height       = height,
        hitPoints    = damage,
        cooldown     = 0,
        cuttingClass = "Axe",
        tool         = tool,
    }

    EquipAxe(tool)
    for _ = 1, CHOP_FIRES do
        if not section.Parent then break end
        if stopFn and stopFn() then break end
        RemoteProxy:FireServer(cutEvent, args)
        task.wait(CHOP_FIRE_DELAY)
    end

    return true
end

local function GetAllLavaTouchParts()
    local parts = {}
    local volcano = workspace:FindFirstChild("Region_Volcano")
    if not volcano then
        DebugLog("warn", "[ModTree] Region_Volcano not found.")
        return parts
    end
    for _, child in ipairs(volcano:GetChildren()) do
        for _, desc in ipairs(child:GetDescendants()) do
            if desc:IsA("BasePart")
            and (desc:FindFirstChildOfClass("TouchTransmitter") or desc:FindFirstChild("TouchInterest")) then
                table.insert(parts, desc)
            end
        end
    end
    return parts
end

local function SafeTeleportMany(batch)
    if _LOT.IsBusy() then _LOT.WaitForBatch() end
    _LOT.TeleportMany(batch)
    if _LOT.IsBusy() then _LOT.WaitForBatch() end
end

local function RunSingleTreeMod(aliveRef, sawmill, sawmillCF, treeModel, treeIndex, treeTotal)
    local session = {
        touchParts   = nil,
        touchSizes   = nil,
        touchCFs     = nil,
        lavaRestored = false,
    }

    local finished = false

    local function RestoreLava()
        if session.lavaRestored then return end
        session.lavaRestored = true
        if session.touchParts then
            for i, tp in ipairs(session.touchParts) do
                pcall(function()
                    if tp and tp.Parent then
                        tp.Size   = session.touchSizes[i]
                        tp.CFrame = session.touchCFs[i]
                    end
                end)
            end
        end
    end

    local function Cancelled()
        return (not aliveRef[1]) or (not _isModding)
    end

    local function Sleep(duration)
        local deadline = tick() + duration
        while tick() < deadline do
            if Cancelled() then return false end
            task.wait()
        end
        return not Cancelled()
    end

    local function Bail(title, text)
        if not finished then
            finished = true
            RestoreLava()
            if title then Notify(title, text) end
        end
        return false
    end

    local prefix = ("[%d/%d]"):format(treeIndex, treeTotal)

    DebugLog("print", ("[ModTree] %s Analysing tree: %s"):format(prefix, treeModel.Name))
    local analysis = AnalyzeTree(treeModel)

    if #analysis.all == 0 then
        return Bail("Mod Tree", prefix .. " No wood sections found.")
    end
    if not analysis.target then
        return Bail("Mod Tree", prefix .. " No weld-holding section found.")
    end

    local baseSection = nil
    for _, entry in ipairs(analysis.all) do
        if entry.id == 1 then baseSection = entry.part; break end
    end
    if not baseSection then baseSection = analysis.all[1].part end
    if not baseSection then
        return Bail("Mod Tree", prefix .. " Could not resolve base section.")
    end

    local treeClassObj = treeModel:FindFirstChild("TreeClass")
    local treeClass    = treeClassObj and treeClassObj.Value or nil

    local logModels  = workspace:FindFirstChild("LogModels")
    local beforeLogs = {}
    if logModels then
        for _, m in ipairs(logModels:GetChildren()) do beforeLogs[m] = true end
    end

    local function GetOurNewLogModels()
        local result = {}
        if logModels then
            for _, m in ipairs(logModels:GetChildren()) do
                if not beforeLogs[m] and m:IsA("Model") then
                    table.insert(result, m)
                end
            end
        end
        return result
    end

    local function FindSectionInScope(targetID)
        for _, entry in ipairs(analysis.all) do
            if entry.id == targetID and entry.part and entry.part.Parent then
                return entry.part
            end
        end
        for _, desc in ipairs(treeModel:GetDescendants()) do
            if desc:IsA("BasePart") then
                local idVal = desc:FindFirstChild("ID")
                if idVal and idVal.Value == targetID then return desc end
            end
        end
        for _, model in ipairs(GetOurNewLogModels()) do
            for _, desc in ipairs(model:GetDescendants()) do
                if desc:IsA("BasePart") then
                    local idVal = desc:FindFirstChild("ID")
                    if idVal and idVal.Value == targetID then return desc end
                end
            end
        end
        return nil
    end

    if Cancelled() then return Bail(nil, nil) end

    DebugLog("print", ("[ModTree] %s Teleporting tree to mod zone..."):format(prefix))
    local tpOk, tpErr = pcall(function()
        SafeTeleportMany({ { target = baseSection, goalCF = DROP_ZONE_CF } })
        baseSection.CFrame = MOD_TP_CF
    end)
    if not tpOk then
        return Bail("Mod Tree", prefix .. " Teleport failed: " .. tostring(tpErr))
    end
    if Cancelled() then return Bail(nil, nil) end

    local touchParts = GetAllLavaTouchParts()
    if #touchParts == 0 then
        return Bail("Mod Tree", prefix .. " No lava touch parts found.")
    end
    DebugLog("print", ("[ModTree] %s Found %d lava touch part(s)."):format(prefix, #touchParts))

    local touchSizes, touchCFs = {}, {}
    for i, tp in ipairs(touchParts) do
        touchSizes[i] = tp.Size
        touchCFs[i]   = tp.CFrame
        pcall(function() tp.Size = Vector3.new(0.1, 0.1, 0.1) end)
    end
    session.touchParts = touchParts
    session.touchSizes = touchSizes
    session.touchCFs   = touchCFs

    local targetSection = analysis.target.part
    local tipID         = analysis.tipID
    DebugLog("print", ("[ModTree] %s Target ID=%d | Tip ID=%d"):format(prefix, analysis.target.id, tipID))

    local MAX_BURN_ATTEMPTS = 5
    local burnConfirmed     = false

    for attempt = 1, MAX_BURN_ATTEMPTS do
        if Cancelled() then break end

        if attempt > 1 then
            DebugLog("print", ("[ModTree] %s Retrying burn (%d/%d)."):format(prefix, attempt, MAX_BURN_ATTEMPTS))
            pcall(function() baseSection.CFrame = MOD_TP_CF end)
            if not Sleep(0.1) then break end
        end

        local lockConn = RunService.Heartbeat:Connect(function()
            pcall(function()
                local targetCF = targetSection.CFrame
                for _, tp in ipairs(touchParts) do
                    tp.Size   = Vector3.new(0.1, 0.1, 0.1)
                    tp.CFrame = targetCF
                end
            end)
        end)
        local lockOk = Sleep(0.1)
        lockConn:Disconnect()

        for i, tp in ipairs(touchParts) do
            pcall(function() tp.Size = touchSizes[i]; tp.CFrame = touchCFs[i] end)
        end

        if not lockOk then break end
        if not Sleep(0.1) then break end

        if treeModel:FindFirstChild("Burning") then
            DebugLog("print", ("[ModTree] %s Burning confirmed (attempt %d/%d)."):format(prefix, attempt, MAX_BURN_ATTEMPTS))
            burnConfirmed = true
            break
        end

        DebugLog("warn", ("[ModTree] %s Burning not detected (attempt %d/%d)."):format(prefix, attempt, MAX_BURN_ATTEMPTS))
    end

    RestoreLava()

    if Cancelled() then return Bail(nil, nil) end
    if not burnConfirmed then
        return Bail("Mod Tree", prefix .. " Could not confirm the tree is burning.")
    end

    DebugLog("print", ("[ModTree] %s Repositioning sections."):format(prefix))
    local tipSection = FindSectionInScope(tipID)
    pcall(function() targetSection.CFrame = CFrame.new(1279, 52, 2328) end)
    pcall(function() baseSection.CFrame = DROP_ZONE_CF end)

    if tipSection and tipSection.Parent then
        local halfHeight = tipSection.Size.Y / 2
        local adjustedCF = sawmillCF * CFrame.new(0, 0, 0)
        pcall(function() tipSection.CFrame = adjustedCF end)
        DebugLog("print", ("[ModTree] %s Tip (ID=%d) placed at sawmill (height offset %.2f)."):format(prefix, tipID, halfHeight))
        if not Sleep(1) then return Bail(nil, nil) end
    else
        DebugLog("warn", ("[ModTree] %s Tip (ID=%d) not available at burn time."):format(prefix, tipID))
    end

    DebugLog("print", ("[ModTree] %s Waiting for weld-holder removal..."):format(prefix))
    local disappearDeadline = tick() + DISAPPEAR_TIMEOUT
    while tick() < disappearDeadline do
        if Cancelled() then return Bail(nil, nil) end
        if not targetSection or not targetSection.Parent then break end
        task.wait(0.1)
    end
    if targetSection and targetSection.Parent then
        DebugLog("warn", ("[ModTree] %s Weld-holder did not disappear in time — proceeding."):format(prefix))
    else
        DebugLog("print", ("[ModTree] %s Weld-holder removed."):format(prefix))
    end

    DebugLog("print", ("[ModTree] %s Chopping stump..."):format(prefix))

    local stumpID      = analysis.stump and analysis.stump.id or 1
    local stumpSection = FindSectionInScope(stumpID)

    local tool, axeName = GetBestAxe(treeClass)
    if not tool then
        DebugLog("warn", ("[ModTree] %s No axe found — skipping stump chop."):format(prefix))
        Notify("Mod Tree", prefix .. " No axe found — equip one to chop the stump.")
    else
        DebugLog("print", ("[ModTree] %s Using '%s' (treeClass=%s)."):format(prefix, axeName, tostring(treeClass)))

        local initialSize = stumpSection and stumpSection.Size
                         or Vector3.new(math.huge, math.huge, math.huge)

        local function TreeHasFallen()
            if not stumpSection or not stumpSection.Parent then return true end
            return stumpSection.Size.Y < initialSize.Y - 1
        end

        local chopDone     = false
        local chopDeadline = tick() + CHOP_CONFIRM_TIMEOUT

        while not chopDone and tick() < chopDeadline do
            if Cancelled() then return Bail(nil, nil) end
            if not stumpSection or not stumpSection.Parent then
                stumpSection = FindSectionInScope(stumpID)
                if stumpSection then initialSize = stumpSection.Size end
            end
            if not stumpSection or not stumpSection.Parent then
                DebugLog("warn", ("[ModTree] %s Stump section lost — aborting chop."):format(prefix)); break
            end
            FireCutSection(stumpSection, tool, axeName, treeClass,
                function() return Cancelled() or TreeHasFallen() end)
            chopDone = TreeHasFallen()
        end

        if Cancelled() then return Bail(nil, nil) end

        if chopDone then
            DebugLog("print", ("[ModTree] %s Chop confirmed."):format(prefix))
        else
            DebugLog("warn", ("[ModTree] %s Chop timed out — proceeding anyway."):format(prefix))
        end
    end

    if Cancelled() then return Bail(nil, nil) end
    DebugLog("print", ("[ModTree] %s Done."):format(prefix))
    finished = true
    return true
end

local function RunModLoop(onDone)
    _modAliveRef = { true }
    local aliveRef = _modAliveRef

    _isModding = true

    local char0    = Player.Character
    local root0    = char0 and char0:FindFirstChild("HumanoidRootPart")
    local preModCF = root0 and root0.CFrame

    local finished = false

    local function ReturnPlayer(cf)
        if not cf then return end
        local ch  = Player.Character
        local hrp = ch and ch:FindFirstChild("HumanoidRootPart")
        if hrp then
            pcall(function()
                hrp.CFrame = cf
                hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            end)
        end
    end

    local function Finish(notifyTitle, notifyText, returnCF)
        if finished then return end
        finished = true
        ReturnPlayer(returnCF or preModCF)
        UnequipAxe() -- right as we are back at the original position
        if notifyTitle then Notify(notifyTitle, notifyText) end
        _isModding      = false
        _currentSession = nil
        if onDone then onDone() end
    end

    local function Cancelled()
        return (not aliveRef[1]) or (not _isModding)
    end

    local function FinishCancel()
        DebugLog("print", "[ModTree] Cancelled — returning player.")
        Finish(nil, nil, preModCF)
    end

    local function FinishError(msg)
        DebugLog("warn", "[ModTree] " .. msg)
        Finish("Mod Tree", "Failed: " .. msg, preModCF)
    end

    if not _LOT    then return FinishError("LOT teleport module is not available.") end
    if not _G.LT2Axes then return FinishError("LT2Axes is not loaded.") end

    NotifyDebug("Mod Tree", "Click trees to queue them, then click your sawmill to start.")

    local treeQueue, sawmill = WaitForTreeQueueThenSawmill(aliveRef)

    if Cancelled() then return FinishCancel() end
    if not sawmill then return FinishError("No sawmill was selected.") end
    if #treeQueue == 0 then return FinishError("No trees were selected.") end

    DebugLog("print", ("[ModTree] %d tree(s) queued. Sawmill: %s"):format(#treeQueue, sawmill.Name))

    local sawmillParticles = sawmill:FindFirstChild("Particles", true)
    local sawmillCF
    if sawmillParticles and sawmillParticles:IsA("BasePart") then
        sawmillCF = sawmillParticles.CFrame
    else
        DebugLog("warn", "[ModTree] Particles part not found — using bounding box.")
        sawmillCF = select(1, sawmill:GetBoundingBox())
    end

    local function SawmillStandCF()
        return sawmillCF * CFrame.new(0, 8, 6)
    end

    NotifyDebug("Mod Tree", ("Processing %d tree(s)..."):format(#treeQueue))

    local successCount = 0
    for i, treeModel in ipairs(treeQueue) do
        if Cancelled() then return FinishCancel() end

        DebugLog("print", ("[ModTree] Starting tree %d/%d: %s"):format(i, #treeQueue, treeModel.Name))
        Notify("Mod Tree", ("Tree %d/%d — modding %s"):format(i, #treeQueue, treeModel.Name))

        local ok = RunSingleTreeMod(aliveRef, sawmill, sawmillCF, treeModel, i, #treeQueue)

        if Cancelled() then return FinishCancel() end

        if ok then
            successCount = successCount + 1
            DebugLog("print", ("[ModTree] Tree %d/%d succeeded."):format(i, #treeQueue))
        else
            DebugLog("warn", ("[ModTree] Tree %d/%d failed/skipped."):format(i, #treeQueue))
        end

        if i < #treeQueue then task.wait(1) end
    end

    local summary = ("Done! %d/%d tree(s) modded."):format(successCount, #treeQueue)
    DebugLog("print", "[ModTree] " .. summary)
    Finish("Mod Tree", summary, SawmillStandCF())
end

function ModTreeModule.Init(Tab, lot, lib)
    if lot ~= nil then _LOT = lot end
    if lib ~= nil then _Lib = lib end

    Tab:CreateSection("Mod Options")

    local ModSawmillBtn

    local function SetSawmillState(active)
        if ModSawmillBtn then
            ModSawmillBtn:SetText(active and "Cancel" or "")
        end
    end

    ModSawmillBtn = Tab:CreateAction("Mod Sawmill", "", function()
        if _isModSawmill then
            _isModSawmill       = false
            _sawmillAliveRef[1] = false
            SetSawmillState(false)
            DebugLog("print", "[ModTree] Mod Sawmill cancelled.")
            return
        end

        _isModSawmill = true
        SetSawmillState(true)

        task.spawn(function()
            _sawmillAliveRef = { true }
            local aliveRef = _sawmillAliveRef

            local function done()
                _isModSawmill = false
                SetSawmillState(false)
            end

            NotifyDebug("Mod Sawmill", "Click your sawmill.")

            local sawmill = WaitForSawmillClick(aliveRef)
            if not aliveRef[1] then return end

            if not sawmill then
                Notify("Mod Sawmill", "No sawmill selected.")
                return done()
            end

            local ok, placed = pcall(function() return PlaceBlueprintAtSawmill(sawmill) end)
            if ok then
                if placed then
                    Notify("Mod Sawmill", "Fill the blueprint!")
                else
                    Notify("Mod Sawmill", "Blueprint already placed — fill it if you haven't!")
                end
            else
                DebugLog("warn", "[ModTree] Mod Sawmill failed: " .. tostring(placed))
                Notify("Mod Sawmill", "Failed to place blueprint.")
            end

            done()
        end)
    end, false)

    ModSawmillBtn:AddTooltip(
        "Places a Floor2 blueprint at your sawmill's output end.\n" ..
        "After placement, fill the blueprint with wood planks\n" ..
        "so the modded log lands on a full surface."
    )
end

return ModTreeModule
]=],
            "ModTree"
        ))()
    end
    __modules["Shop"] = function()
        return assert(loadstring(
            [=[local ShopModule = {}

local Players           = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui        = game:GetService("StarterGui")
local Player            = Players.LocalPlayer

local _LOT = nil

function ShopModule.SetLOT(lot)
    _LOT = lot
end

local _ShopItems   = nil
local _cachedFunds = nil

local _quickPurchase = false
local _quickNeedsNear = false -- set when buying from afar fails

local function QuickStays()
    return _quickPurchase and not _quickNeedsNear
end

-- shorter LOT grab delays while quick purchasing (default LOT is 0.05 / 0.1)
local QUICK_LOT = { PreFireWait = 0.02, PostObjectDelay = 0.04 }
local function QuickLOTOpts()
    return _quickPurchase and QUICK_LOT or nil
end

-- LOT return-to-origin for shop moves: quick purchase never sends you home between items
-- (false while buying from here, true when parked at the cashier), nil = use the LOT setting
local function QuickReturnArg()
    if not _quickPurchase then return nil end
    return not QuickStays()
end
local _allowNuclearReset = false

local NPCs = {
    Thom    = workspace.Stores.WoodRUs.Thom,
    Corey   = workspace.Stores.FurnitureStore.Corey,
    Jenny   = workspace.Stores.CarStore.Jenny,
    Bob     = workspace.Stores.ShackShop.Bob,
    Timothy = workspace.Stores.FineArt.Timothy,
    Lincoln = workspace.Stores.LogicStore.Lincoln,
}

local Remote      = ReplicatedStorage.NPCDialog.PlayerChatted
local PromptChat  = ReplicatedStorage.NPCDialog.PromptChat
local Interact    = ReplicatedStorage.Interaction.ClientInteracted

local StoreConfigs = {
    WoodRUs = {
        NPCName     = "Thom",
        PlayerBuyCF = CFrame.new(262.1, 3.2,  64.8),
    },
    FurnitureStore = {
        NPCName     = "Corey",
        PlayerBuyCF = CFrame.new(481.4, 3.2, -1712.5),
    },
    CarStore = {
        NPCName     = "Jenny",
        PlayerBuyCF = CFrame.new(524.9, 3.2, -1466.6),
    },
    ShackShop = {
        NPCName     = "Bob",
        PlayerBuyCF = CFrame.new(256.7, 8.4, -2546.7),
    },
    FineArt = {
        NPCName     = "Timothy",
        PlayerBuyCF = CFrame.new(5232.4, -166.0, 737.3),
    },
    LogicStore = {
        NPCName     = "Lincoln",
        PlayerBuyCF = CFrame.new(4598.4, 7.0, -778.4),
    },
}

local CounterCache = {}

local function GetCounterPart(storeName)
    if CounterCache[storeName] ~= nil then
        return CounterCache[storeName] or nil
    end

    local config = StoreConfigs[storeName]
    if not config then CounterCache[storeName] = false; return nil end

    local npc   = NPCs[config.NPCName]
    local store = npc and npc.Parent
    if not store then CounterCache[storeName] = false; return nil end

    local counter = store:FindFirstChild("Counter")
    if not counter then CounterCache[storeName] = false; return nil end

    local part
    if counter:IsA("BasePart") then
        part = counter
    elseif counter:IsA("Model") then
        part = counter.PrimaryPart
        if not part then
            for _, desc in ipairs(counter:GetDescendants()) do
                if desc:IsA("BasePart") then part = desc; break end
            end
        end
    end

    CounterCache[storeName] = part or false
    return part or nil
end

local function ComputeDropCF(storeName, mainPart)
    local counterPart = GetCounterPart(storeName)
    if not counterPart then return nil end

    local up         = counterPart.CFrame.UpVector
    local surfaceTop = counterPart.Position + up * (counterPart.Size.Y / 2)
    local itemRise   = mainPart and (mainPart.Size.Y / 2) or 0
    return CFrame.new(surfaceTop + up * (itemRise + 0.05))
end

local GetFundsRemote = nil

local function FindRemoteRecursive(root, name)
    for _, child in ipairs(root:GetDescendants()) do
        if child.Name == name and child:IsA("RemoteFunction") then
            return child
        end
    end
    return nil
end

local function FetchFunds()
    if not GetFundsRemote then
        GetFundsRemote = FindRemoteRecursive(ReplicatedStorage, "GetFunds")
        if not GetFundsRemote then return nil end
    end
    local ok, result = pcall(function()
        return GetFundsRemote:InvokeServer()
    end)
    if ok and type(result) == "number" then return result end
    return nil
end

local NPCIDs = {}

local function FetchNPCID(npcName)
    local npc = NPCs[npcName]
    if not npc then return nil end

    if not npc:FindFirstChild("Dialog") then
        Instance.new("Dialog", npc)
    end

    local lastData
    local conn = PromptChat.OnClientEvent:Connect(function(active, chatData)
        -- CRITICAL: filter by NPC Character and only accept "open" events.
        -- The server's 1Hz proximity loop fires PromptChat for any nearby
        -- NPC. Without this filter, lastData can be set to a DIFFERENT
        -- NPC's data during our 5s wait — poisoning the ID cache and
        -- sending all future EndChats to the wrong NPC. That cached-wrong-ID
        -- state survives until rejoin.
        if active and chatData and chatData.Character == npc then
            lastData = chatData
        end
    end)

    pcall(function() PromptChat:FireServer(true, npc, npc.Dialog) end)
    local t = tick()
    repeat task.wait(0.05) until lastData or tick() - t > 5
    conn:Disconnect()

    pcall(function() PromptChat:FireServer(false, npc, npc.Dialog) end)
    task.wait(0.2)

    if lastData and lastData.Character == npc and lastData.ID then
        NPCIDs[npcName] = lastData.ID
        return lastData.ID
    end

    warn("[Shop] Failed to fetch ID for NPC:", npcName)
    return nil
end

local function EnsureNPCID(npcName)
    if NPCIDs[npcName] then return NPCIDs[npcName] end
    return FetchNPCID(npcName)
end

local function InvalidateNPCID(npcName)
    NPCIDs[npcName] = nil
end

local _fetchingIDs = false

local function FetchAllNPCIDs()
    -- a fetch is already running, wait for it instead of starting another
    if _fetchingIDs then
        repeat
            task.wait(0.1)
        until not _fetchingIDs
        return
    end
    _fetchingIDs = true
    pcall(function()
        for name, _ in pairs(NPCs) do
            if not NPCIDs[name] then
                FetchNPCID(name)
                task.wait(0.15)
            end
        end
    end)
    _fetchingIDs = false
end

local function FindNearestCashierToItem(mainPart)
    if not mainPart then return nil, nil end
    local itemPos  = mainPart.Position
    local bestNPC, bestName, bestDist = nil, nil, math.huge

    for name, npc in pairs(NPCs) do
        local head = npc:FindFirstChild("Head")
        if head then
            local dist = (head.Position - itemPos).Magnitude
            if dist < bestDist then
                bestDist = dist
                bestNPC  = npc
                bestName = name
            end
        end
    end

    return bestNPC, bestName
end

local function BuildNPCArg(npcName, npc)
    if not npc then return nil end
    if not npc:FindFirstChild("Dialog") then
        Instance.new("Dialog", npc)
    end
    local id = EnsureNPCID(npcName)
    if not id then return nil end
    return {
        ID        = id,
        Character = npc,
        Name      = npcName,
        Dialog    = npc.Dialog,
    }
end

local function GetNPCArgForItem(storeName, mainPart)
    local config = StoreConfigs[storeName]
    if config then
        local npc = NPCs[config.NPCName]
        if npc then
            local arg = BuildNPCArg(config.NPCName, npc)
            if arg then return arg, config.NPCName end
        end
    end

    if mainPart then
        local proxNPC, proxName = FindNearestCashierToItem(mainPart)
        if proxNPC and proxName then
            local arg = BuildNPCArg(proxName, proxNPC)
            if arg then return arg, proxName end
        end
    end

    return nil, nil
end

local INVOKE_TIMEOUT      = 4       -- per-call hard timeout (s)
local POST_TIMEOUT_SETTLE = 0.6     -- wait after timeout before cleanup EndChat
local CLEANUP_ENDCHATS    = 3       -- EndChats fired after a timeout
local CLEANUP_GAP         = 0.3     -- spacing between cleanup EndChats
local CLEANUP_CALL_BUDGET = 1.5     -- per-EndChat hard cap during cleanup

local _lastInvokeTimedOut = false

local function SafeInvoke(npcArg, action)
    local co       = coroutine.running()
    local done     = false
    local timedOut = false

    local fireThread = task.spawn(function()
        pcall(function()
            Remote:InvokeServer(npcArg, action)
        end)
        if not done then
            done = true
            task.spawn(co)
        end
    end)

    task.delay(INVOKE_TIMEOUT, function()
        if not done then
            done     = true
            timedOut = true
            pcall(task.cancel, fireThread)
            task.spawn(co)
        end
    end)

    coroutine.yield()
    _lastInvokeTimedOut = timedOut

    -- If we timed out on anything other than EndChat, the server is likely
    -- still processing our action. Wait for it to settle, then synchronously
    -- fire multiple EndChats so the late-arriving action gets cleared BEFORE
    -- the next iteration starts a new dialog. The async cleanup in the old
    -- version was the root of half the stuck-NPC cases.
    if timedOut and action ~= "EndChat" then
        task.wait(POST_TIMEOUT_SETTLE)
        for _ = 1, CLEANUP_ENDCHATS do
            local cleanupDone   = false
            local cleanupThread = task.spawn(function()
                pcall(function() Remote:InvokeServer(npcArg, "EndChat") end)
                cleanupDone = true
            end)
            local cleanupDeadline = tick() + CLEANUP_CALL_BUDGET
            while not cleanupDone and tick() < cleanupDeadline do
                task.wait(0.05)
            end
            if not cleanupDone then
                pcall(task.cancel, cleanupThread)
            end
            task.wait(CLEANUP_GAP)
        end
    end
end

-- Compat alias for any existing references
local SafeInvokeTracked = SafeInvoke

local POE_PRICE    = 10009000
local POE_TP_CF    = CFrame.new(1059.4, 17.2, 1130.3)
local POE_TIMEOUT  = 60
local POE_INTERVAL = 0.2

local function PurchasePowerOfEase()
    local funds = FetchFunds()
    if funds == nil then return end
    if funds < POE_PRICE then return end

    FetchAllNPCIDs()

    local char = Player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local returnCF = root.CFrame
    root.CFrame = POE_TP_CF
    task.wait(0.15)

    local bestDist = math.huge
    local bestNPC, bestName

    for name, npc in pairs(NPCs) do
        local store = npc.Parent
        if store and store:FindFirstChild("Counter") then
            local dist = (store.Counter.CFrame.p - root.Position).Magnitude
            if dist < bestDist then
                bestDist = dist
                bestNPC  = npc
                bestName = name
            end
        end
    end

    if not bestNPC then
        root.CFrame = returnCF
        return
    end

    if not bestNPC:FindFirstChild("Dialog") then
        Instance.new("Dialog", bestNPC)
    end

    local npcArg = BuildNPCArg(bestName, bestNPC)
    if not npcArg then
        root.CFrame = returnCF
        return
    end

    local deadline = tick() + POE_TIMEOUT

    while tick() < deadline do
        SafeInvoke(npcArg, "Initiate")
        SafeInvoke(npcArg, "ConfirmPurchase")
        SafeInvoke(npcArg, "EndChat")

        local newFunds = FetchFunds()
        if newFunds and newFunds < funds then break end

        task.wait(POE_INTERVAL)
    end

    task.wait(0.1)
    local returnChar = Player.Character
    local returnRoot = returnChar and returnChar:FindFirstChild("HumanoidRootPart")
    if returnRoot then returnRoot.CFrame = returnCF end
end

local SPAM_TIMEOUT       = 30
local CYCLE_GAP          = 0.05
local FAIL_BACKOFF_AFTER = 8
local FAIL_BACKOFF_WAIT  = 0.6
local ID_REFETCH_AFTER   = 16
local INNER_DEADLINE     = 3        -- per-Initiate confirm-spam window

-- Per-NPC recovery
local NPC_FAIL_THRESHOLD  = 3       -- DoPurchase failures before HardResetNPC
local NPC_NUCLEAR_AFTER   = 2       -- HardResetNPCs before forced respawn (if enabled)
local _npcFailStreak      = {}
local _npcResetStreak     = {}

local function IsSuccessParent(parent)
    if not parent then return false end
    if parent.Name == "PlayerModels" then return true end
    if parent == Player.Backpack     then return true end
    if parent == Player.Character    then return true end
    local current = parent
    while current do
        if current.Name == "PlayerModels" then return true end
        current = current.Parent
    end
    return false
end

local function CheckItemState(mainPart)
    if not mainPart then return "gone" end
    local parent = mainPart.Parent
    if IsSuccessParent(parent) then return "success" end
    if parent == nil then
        task.wait(0.12)
        local newParent = mainPart.Parent
        if IsSuccessParent(newParent) then return "success" end
        if newParent == nil             then return "gone"    end
    end
    return "pending"
end

local function FlushDialog(npcArg, count)
    count = count or 2
    for _ = 1, count do
        SafeInvoke(npcArg, "EndChat")
        task.wait(0.05)
    end
end


local function SpamPurchase(mainPart, npcArg, itemName, npcName, timeout, gap, onBought)
    local startTime = tick()
    -- runs once, the moment the item is ours (before the dialog is closed)
    local function Bought()
        local f = onBought
        onBought = nil
        if f then pcall(f) end
    end
    local deadline  = tick() + (timeout or SPAM_TIMEOUT)

    while tick() < deadline do
        local state = CheckItemState(mainPart)
        if state == "success" then Bought(); return true,  tick() - startTime end
        if state == "gone"    then return false, tick() - startTime end

        -- Open a fresh dialog session
        SafeInvoke(npcArg, "Initiate")
        if _lastInvokeTimedOut then
            -- SafeInvoke already did the synchronous cleanup. Refresh ID
            -- (it might be stale; filter in FetchNPCID prevents poisoning)
            -- and retry the outer loop.
            InvalidateNPCID(npcName)
            local newID = FetchNPCID(npcName)
            if newID then npcArg.ID = newID end
            task.wait(0.2)
            continue
        end

        -- Recheck immediately — Initiate alone can sometimes finalize state
        state = CheckItemState(mainPart)
        if state == "success" then Bought(); SafeInvoke(npcArg, "EndChat"); return true,  tick() - startTime end
        if state == "gone"    then SafeInvoke(npcArg, "EndChat"); return false, tick() - startTime end

        -- Fire ConfirmPurchase tightly until state changes or window expires
        local innerDeadline = tick() + INNER_DEADLINE
        while tick() < innerDeadline do
            state = CheckItemState(mainPart)
            if state == "success" then
                Bought()
                SafeInvoke(npcArg, "EndChat")
                return true, tick() - startTime
            end
            if state == "gone" then
                SafeInvoke(npcArg, "EndChat")
                return false, tick() - startTime
            end

            SafeInvoke(npcArg, "ConfirmPurchase")

            -- If ConfirmPurchase timed out, cleanup already fired. Bail
            -- out of the inner loop and let the outer loop restart cleanly.
            if _lastInvokeTimedOut then break end

            task.wait(gap or CYCLE_GAP)
        end

        -- Inner loop expired — close session and retry from Initiate
        SafeInvoke(npcArg, "EndChat")
        task.wait(0.2)
    end

    SafeInvoke(npcArg, "EndChat")
    return false, tick() - startTime
end

local function PositionForPurchase(mainPart, item, pressedCF, stay)
    local storeName = item.Store
    local config    = StoreConfigs[storeName]
    if not config then return nil, nil end

    local dropCF = ComputeDropCF(storeName, mainPart)
    if not dropCF then return nil, nil end

    local success = _LOT.TeleportMany({ { target = mainPart, goalCF = dropCF } }, QuickReturnArg(), QuickLOTOpts())
    if _LOT.IsBusy() then success = _LOT.WaitForBatch() end
    if not success then return nil, nil end

    local char = Player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return nil, nil end

    if not stay then root.CFrame = config.PlayerBuyCF end

    local npcArg, resolvedNPCName = GetNPCArgForItem(storeName, mainPart)
    if not npcArg or not npcArg.ID then return nil, nil end

    return npcArg, resolvedNPCName
end

-- quick purchase settings
local QUICK = {
    MaxTime   = 1,    -- max buy time for the quick move (s)
    CheckWait = 0.1,  -- wait before checking it landed (s)
    CycleGap  = 0.02, -- gap between ConfirmPurchase calls while quick purchasing (s)
    MaxOffset = 4,    -- max distance from goal to count as landed (studs)
    StayTimeout = 6,  -- max time to try buying from where you stand (s)
}

-- move the item directly, true if it stayed there
local function QuickMove(mainPart, goalCF, movedAt)
    if not movedAt then
        mainPart.CFrame = goalCF
        mainPart.AssemblyLinearVelocity = Vector3.new()
        mainPart.AssemblyAngularVelocity = Vector3.new()
        movedAt = tick()
    end
    -- only wait for whatever is left of the check window
    local remaining = QUICK.CheckWait - (tick() - movedAt)
    if remaining > 0 then task.wait(remaining) end
    return mainPart.Parent ~= nil and (mainPart.Position - goalCF.Position).Magnitude <= QUICK.MaxOffset
end

local function DoPurchase(mainPart, item, npcArg, resolvedNPCName, pressedCF)
    local stay = QuickStays()

    -- quick purchase: teleport the item the moment it becomes ours, before the
    -- cashier dialog is closed, instead of after
    local startedAt, earlyAt = tick(), nil
    local onBought
    if _quickPurchase then
        local earlyCF = pressedCF
        if not earlyCF and stay then
            local c = Player.Character
            local r = c and c:FindFirstChild("HumanoidRootPart")
            if r then earlyCF = r.CFrame * CFrame.new(0, 0, -3) end
        end
        if earlyCF then
            onBought = function()
                if tick() - startedAt < QUICK.MaxTime and mainPart and mainPart.Parent then
                    mainPart.CFrame = earlyCF
                    mainPart.AssemblyLinearVelocity = Vector3.new()
                    mainPart.AssemblyAngularVelocity = Vector3.new()
                    earlyAt = tick()
                end
            end
        end
    end

    local purchased, elapsed = SpamPurchase(
        mainPart, npcArg, item.Name, resolvedNPCName, stay and QUICK.StayTimeout or nil,
        _quickPurchase and QUICK.CycleGap or nil, onBought
    )

    -- buying from here failed, teleport to the cashier from now on
    if not purchased and stay and mainPart and mainPart.Parent then
        _quickNeedsNear = true
        print("[Shop] Quick Purchase could not buy from here, teleporting to the cashier from now on")
        local cfg = StoreConfigs[item.Store]
        local char = Player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if cfg and root then root.CFrame = cfg.PlayerBuyCF end
    end

    if purchased then
        local method = "none"
        if mainPart and mainPart.Parent then
            -- send the item to where Purchase was pressed
            local goalCF = pressedCF
            if stay and not pressedCF then
                local char = Player.Character
                local root = char and char:FindFirstChild("HumanoidRootPart")
                if root then goalCF = root.CFrame * CFrame.new(0, 0, -3) end
            end
            local moved = false
            if _quickPurchase and elapsed < QUICK.MaxTime then
                moved = QuickMove(mainPart, goalCF, earlyAt)
                if moved then method = "quick" end
            end
            -- fall back to lot if the quick move did not land
            if not moved and mainPart.Parent then
                _LOT.TeleportMany({ { target = mainPart, goalCF = goalCF } }, QuickReturnArg(), QuickLOTOpts())
                method = _quickPurchase and elapsed < QUICK.MaxTime and "quick failed, lot" or "lot"
            end
        end
        print(("[Shop] Purchased %s in %.2f secs (%s)"):format(item.Name, elapsed, method))
        -- only teleport back if we left (quick purchase waits until the batch is done)
        if not stay and not _quickPurchase then
            local returnChar = Player.Character
            local returnRoot = returnChar and returnChar:FindFirstChild("HumanoidRootPart")
            if returnRoot then
                returnRoot.CFrame = pressedCF * CFrame.new(0, 0, 3)
            end
        end
    end

    return purchased
end

local function LoadItemList()
    local lm = _G.LoadModule or getgenv().LoadModule
    if type(lm) ~= "function" then
        warn("[Shop] LoadModule not available")
        return nil
    end

    local storeMap = lm("LT2ItemList")
    if not storeMap then return nil end

    local ClientItemInfo = ReplicatedStorage:FindFirstChild("ClientItemInfo")
    if not ClientItemInfo then
        warn("[Shop] ClientItemInfo not found in ReplicatedStorage")
        return nil
    end

    local items = {}
    for _, entry in ipairs(storeMap) do
        local ok, err = pcall(function()
            local folder = ClientItemInfo:FindFirstChild(entry.BoxItemName)
            if not folder then return end

            local nameVal  = folder:FindFirstChild("ItemName")
            local imageVal = folder:FindFirstChild("ItemImage")
            local priceVal = folder:FindFirstChild("Price")

            if not (nameVal and imageVal and priceVal) then
                warn("[Shop] Incomplete ClientItemInfo for:", entry.BoxItemName)
                return
            end

            local price = (function()
                local raw = priceVal.Value
                if type(raw) == "number" then return raw end
                return tonumber(tostring(raw):gsub("[^%d]", "")) or 0
            end)()

            table.insert(items, {
                Name        = nameVal.Value,
                Image       = imageVal.Value,
                Price       = price,
                BoxItemName = entry.BoxItemName,
                Store       = entry.Store,
                IsBlueprint = entry.IsBlueprint == true,
            })
        end)
        if not ok then
            warn("[Shop] Failed to load entry:", entry.BoxItemName, "|", err)
        end
    end

    return #items > 0 and items or nil
end

local ShopItemsCache = {}

local function GetShopItemsForStore(storeName)
    if ShopItemsCache[storeName] ~= nil then
        return ShopItemsCache[storeName] or nil
    end

    local config = StoreConfigs[storeName]
    if not config then
        ShopItemsCache[storeName] = false
        return nil
    end

    local npc   = NPCs[config.NPCName]
    local store = npc and npc.Parent
    local anchor

    if store and store:FindFirstChild("Counter") then
        anchor = store.Counter.CFrame.p
    elseif store and store:IsA("Model") then
        local ok, piv = pcall(function() return store:GetPivot().Position end)
        if ok then anchor = piv end
    end

    if not anchor then
        ShopItemsCache[storeName] = false
        return nil
    end

    local stores = workspace:FindFirstChild("Stores")
    if not stores then
        ShopItemsCache[storeName] = false
        return nil
    end

    local bestContainer, bestDist = nil, math.huge

    for _, child in ipairs(stores:GetChildren()) do
        if child.Name ~= "ShopItems" then continue end

        local samplePos
        for _, desc in ipairs(child:GetDescendants()) do
            if desc:IsA("BasePart") then
                samplePos = desc.Position
                break
            end
        end

        if samplePos then
            local dist = (samplePos - anchor).Magnitude
            if dist < bestDist then
                bestDist      = dist
                bestContainer = child
            end
        end
    end

    ShopItemsCache[storeName] = bestContainer or false
    return bestContainer
end

local function ResolveItemParts(item, limit)
    local stores = workspace:FindFirstChild("Stores")
    if not stores then return {} end

    local results = {}

    local function searchContainer(shopItems)
        for _, box in ipairs(shopItems:GetChildren()) do
            if #results >= limit then break end
            if not (box:IsA("Model") and box.Name == "Box") then continue end

            local nameVal = box:FindFirstChild("BoxItemName")
            if not (nameVal and nameVal:IsA("StringValue")) then continue end
            if nameVal.Value ~= item.BoxItemName then continue end

            local main = box:FindFirstChild("Main")
            if main and main:IsA("BasePart") and not main.Anchored then
                table.insert(results, main)
            end
        end
    end

    local storeName = item.Store
    if storeName then
        local targetContainer = GetShopItemsForStore(storeName)
        if targetContainer then
            searchContainer(targetContainer)
            return results
        end
    end

    for _, child in ipairs(stores:GetChildren()) do
        if #results >= limit then break end
        if child.Name ~= "ShopItems" then continue end
        searchContainer(child)
    end

    return results
end

local function HardResetNPC(npcArg, npcName)
    warn("[Shop] HardResetNPC for", npcName)

    -- Step out of proximity briefly. Two reasons:
    --   1) Gets us out of the server's 1Hz prompt-fire window for this NPC,
    --      cleaning up the OnClientEvent stream before we refetch the ID.
    --   2) Defensive — if server chat state ties to proximity in any way
    --      not visible in the script, this gives that a chance to act.
    local char    = Player.Character
    local root    = char and char:FindFirstChild("HumanoidRootPart")
    local savedCF = root and root.CFrame
    if root then
        root.CFrame = root.CFrame * CFrame.new(0, 0, 40)
        task.wait(1.0)
    end

    -- Re-fetch the NPC ID from scratch (with the filtered FetchNPCID)
    InvalidateNPCID(npcName)
    local newID = FetchNPCID(npcName)
    if newID then npcArg.ID = newID end

    -- Spam EndChat to clear any pinned server-side dialog state
    for _ = 1, 5 do
        local d = false
        local t = task.spawn(function()
            pcall(function() Remote:InvokeServer(npcArg, "EndChat") end)
            d = true
        end)
        local deadline = tick() + CLEANUP_CALL_BUDGET
        while not d and tick() < deadline do task.wait(0.05) end
        if not d then pcall(task.cancel, t) end
        task.wait(0.3)
    end

    -- Restore position
    local rc = Player.Character
    local rr = rc and rc:FindFirstChild("HumanoidRootPart")
    if rr and savedCF then
        rr.CFrame = savedCF
        task.wait(0.3)
    end
end

local function NuclearReset()
    warn("[Shop] NuclearReset — forcing character respawn to free pinned ChattingPlayer")
    local char = Player.Character
    local hum  = char and char:FindFirstChildOfClass("Humanoid")
    if hum then hum.Health = 0 end

    local deadline = tick() + 10
    repeat
        task.wait(0.2)
    until (Player.Character
           and Player.Character:FindFirstChild("HumanoidRootPart"))
       or tick() > deadline
    task.wait(0.5)
end

local RESTOCK_POLL_RATE = 0.5
local RESTOCK_TIMEOUT   = 120

local _isBuying = false

-- quick purchase: after the order, fetch any box of ours still sitting at the counter
local function SweepCounter(item, goalCF)
    if not (item and item.BoxItemName and goalCF) then return 0 end
    local pm      = workspace:FindFirstChild("PlayerModels")
    local counter = GetCounterPart(item.Store)
    if not (pm and counter) then return 0 end

    local jobs = {}
    for _, m in ipairs(pm:GetChildren()) do
        if m:IsA("Model") and m.Name:find("Box Purchased by", 1, true)
           and (m.Name:find(Player.Name, 1, true) or m.Name:find(Player.DisplayName, 1, true)) then
            local v    = m:FindFirstChild("PurchasedBoxItemName")
            local main = m:FindFirstChild("Main")
            if v and v.Value == item.BoxItemName and main and main:IsA("BasePart")
               and (main.Position - counter.Position).Magnitude <= 40
               and (main.Position - goalCF.Position).Magnitude > QUICK.MaxOffset then
                table.insert(jobs, { target = main, goalCF = goalCF })
            end
        end
    end
    if #jobs == 0 then return 0 end

    if _LOT.IsBusy() then _LOT.WaitForBatch() end
    _LOT.TeleportMany(jobs, false, QuickLOTOpts())
    if _LOT.IsBusy() then _LOT.WaitForBatch() end
    print(("[Shop] Swept %d leftover item(s) off the counter"):format(#jobs))
    return #jobs
end

local function RunBuyLoop(item, totalQty, pressedCF, onDone)
    _isBuying = true
    FetchAllNPCIDs()

    local bought       = 0
    local restockTimer = 0
    local atCounter    = false -- quick purchase: already standing at the cashier

    while bought < totalQty and _isBuying do
        local stillNeed = totalQty - bought
        local parts     = ResolveItemParts(item, stillNeed)

        if #parts == 0 then
            task.wait(RESTOCK_POLL_RATE)
            restockTimer += RESTOCK_POLL_RATE
            if restockTimer >= RESTOCK_TIMEOUT then break end
            continue
        end

        restockTimer = 0

        for _, mainPart in ipairs(parts) do
            if not _isBuying      then break end
            if bought >= totalQty then break end
            if not mainPart or not mainPart.Parent then continue end
            if _LOT.IsBusy() then _LOT.WaitForBatch() end

            local npcArg, resolvedNPCName = PositionForPurchase(
                mainPart, item, pressedCF, QuickStays() or (_quickPurchase and atCounter)
            )
            if not npcArg then continue end
            if _quickPurchase and not QuickStays() then atCounter = true end

            local ok     = false
            local giveUp = tick() + 90

            while not ok and _isBuying and tick() < giveUp do
                if not mainPart or not mainPart.Parent then break end

                ok = DoPurchase(mainPart, item, npcArg, resolvedNPCName, pressedCF)

                if ok then
                    -- Success — clear failure tracking for this NPC
                    _npcFailStreak[resolvedNPCName]  = 0
                    _npcResetStreak[resolvedNPCName] = 0
                else
                    _npcFailStreak[resolvedNPCName] =
                        (_npcFailStreak[resolvedNPCName] or 0) + 1

                    if _npcFailStreak[resolvedNPCName] >= NPC_FAIL_THRESHOLD then
                        _npcFailStreak[resolvedNPCName]  = 0
                        _npcResetStreak[resolvedNPCName] =
                            (_npcResetStreak[resolvedNPCName] or 0) + 1

                        if _allowNuclearReset
                           and _npcResetStreak[resolvedNPCName] >= NPC_NUCLEAR_AFTER then
                            _npcResetStreak[resolvedNPCName] = 0
                            NuclearReset()
                            FetchAllNPCIDs()
                            -- Re-position at counter after respawn
                            npcArg, resolvedNPCName =
                                PositionForPurchase(mainPart, item, pressedCF, QuickStays())
                            if not npcArg then break end
                        else
                            HardResetNPC(npcArg, resolvedNPCName)
                            -- HardResetNPC restores position; re-pin at counter
                            local rChar = Player.Character
                            local rRoot = rChar and rChar:FindFirstChild("HumanoidRootPart")
                            local cfg   = StoreConfigs[item.Store]
                            if rRoot and cfg and not QuickStays() then
                                rRoot.CFrame = cfg.PlayerBuyCF
                                task.wait(0.15)
                            end
                        end
                    else
                        task.wait(0.3)
                    end
                end
            end

            if ok then bought += 1 end
        end
    end

    -- quick purchase: pick up anything of ours that got left on the counter
    if _quickPurchase and _isBuying and pressedCF then
        pcall(SweepCounter, item, pressedCF)
    end

    -- quick purchase: go back to where Purchase was pressed, once, after the whole order
    if _quickPurchase and pressedCF then
        local rChar = Player.Character
        local rRoot = rChar and rChar:FindFirstChild("HumanoidRootPart")
        if rRoot then rRoot.CFrame = pressedCF * CFrame.new(0, 0, 3) end
    end

    _isBuying = false
    if onDone then onDone() end
end

-- ============================================================
--  TRUCK AUTO BUY
--  Sit in your truck's driver seat, flip the truck over the boxes so they
--  fall into the bed (they become yours), teleport them all onto the counter,
--  check out once, then send everything home.
-- ============================================================
local TruckBuy = { running = false }

do
    local RunService = game:GetService("RunService")

    local holdConn, holdCF
    local truckModel, truckMain, pivotOffset
    local bedOff, bedSize, seatOff
    local savedOcclusion
    local StackPadding = 0   -- gap between boxes in the home grid (0 = touching, tidy)
    local noclipParts, noclipConn = {}, nil
    local placedCount = 0   -- boxes already put in the home grid (continues across rounds)
    local homeGroundY = nil -- ground height of the home grid (measured once per run)
    local placedBoxes = {}  -- boxes already sent to the home grid
    local homeTargets = {}  -- grid spot picked for each box
    local lastSendAt  = 0   -- when a box was last sent home

    local function Say(text)
        local ok = pcall(function() Notify("Antler", text, 3) end)
        if not ok then warn("[TruckBuy] " .. text) end
    end

    local function OwnedByMe(part)
        if type(isnetworkowner) == "function" then
            local ok, res = pcall(isnetworkowner, part)
            if ok then return res end
        end
        return part.ReceiveAge == 0
    end

    -- Keep the truck exactly where we want it (it "flies" and never falls)
    local function SetHold(mainCF)
        holdCF = mainCF
        if not holdConn then
            holdConn = RunService.Heartbeat:Connect(function()
                if holdCF and truckModel and truckModel.Parent and truckMain then
                    truckModel:PivotTo(holdCF * pivotOffset)
                    truckMain.AssemblyLinearVelocity  = Vector3.zero
                    truckMain.AssemblyAngularVelocity = Vector3.zero
                end
            end)
        end
    end

    -- Vehicle noclip: truck + our character stop colliding so flying through
    -- the store / shelves works smoothly. Everything is restored afterwards.
    local function EnableNoclip(model)
        noclipParts = {}
        local function grab(root)
            for _, v in ipairs(root:GetDescendants()) do
                if v:IsA("BasePart") and v.CanCollide then
                    table.insert(noclipParts, v)
                    v.CanCollide = false
                end
            end
        end
        grab(model)
        if Player.Character then grab(Player.Character) end

        noclipConn = RunService.Stepped:Connect(function()
            for _, v in ipairs(noclipParts) do
                if v.Parent and v.CanCollide then v.CanCollide = false end
            end
        end)
    end

    local function DisableNoclip()
        if noclipConn then noclipConn:Disconnect(); noclipConn = nil end
        for _, v in ipairs(noclipParts) do
            if v.Parent then v.CanCollide = true end
        end
        noclipParts = {}
    end

    -- Neat home grid: columns x rows per layer, layers stacked upward, all boxes
    -- facing the same way, resting on the ground. Continues where the last round ended.
    local function HomeGridCF(index, homeMainCF, uprightRot, sample, groundY)
        local bs       = sample.Size
        local cols, rows = 4, 4
        local perLayer = cols * rows
        local i        = index - 1
        local layer    = math.floor(i / perLayer)
        local inLayer  = i % perLayer
        local c        = inLayer % cols
        local r        = math.floor(inLayer / cols)

        local x = (c - (cols - 1) / 2) * (bs.X + StackPadding)
        local z = (r - (rows - 1) / 2) * (bs.Z + StackPadding)
        local y = bs.Y / 2 + layer * (bs.Y + StackPadding)

        -- Grid sits beside the truck's start position, on the ground
        local origin = homeMainCF.Position + uprightRot:VectorToWorldSpace(Vector3.new(14, 0, 0))
        return CFrame.new(origin.X, groundY, origin.Z) * uprightRot * CFrame.new(x, y, z)
    end

    local function FindGroundY(pos, ignore)
        local params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Exclude
        params.FilterDescendantsInstances = ignore
        local hit = workspace:Raycast(pos + Vector3.new(0, 5, 0), Vector3.new(0, -200, 0), params)
        return hit and hit.Position.Y or (pos.Y - 2)
    end

    -- Send boxes to the home grid and make sure they actually arrived
    -- (re-sends any that snapped back because of lag / lost ownership)
    local function PlaceHome(boxes, homeMainCF, uprightRot, model)
        if #boxes == 0 then return end

        if not homeGroundY then
            local ignore = { model, Player.Character }
            for _, b in ipairs(boxes) do
                if b.Parent then table.insert(ignore, b.Parent) end
            end
            homeGroundY = FindGroundY(
                homeMainCF.Position + uprightRot:VectorToWorldSpace(Vector3.new(14, 0, 0)),
                ignore
            )
        end

        local targets = {}
        for _, box in ipairs(boxes) do
            if box and box.Parent then
                local cf = homeTargets[box]
                if not cf then
                    placedCount = placedCount + 1
                    cf = HomeGridCF(placedCount, homeMainCF, uprightRot, boxes[1], homeGroundY)
                    homeTargets[box] = cf
                end
                targets[box] = cf
                placedBoxes[box] = true
            end
        end

        for _ = 1, 4 do
            -- let the last send settle, then check (no fixed 0.4s wait per pass)
            local settle = 0.3 - (tick() - lastSendAt)
            if settle > 0 then task.wait(settle) end
            local allThere = true
            for box, cf in pairs(targets) do
                if box.Parent and (box.Position - cf.Position).Magnitude > 3 then
                    allThere = false
                    box.CFrame = cf
                    box.AssemblyLinearVelocity  = Vector3.zero
                    box.AssemblyAngularVelocity = Vector3.zero
                end
            end
            if allThere then break end
            lastSendAt = tick()
        end
    end

    -- Send one box home the moment it is bought (PlaceHome still checks it later)
    local function SendHomeNow(box, homeMainCF, uprightRot, model)
        if not (box and box.Parent) or homeTargets[box] then return end
        if not homeGroundY then
            local ignore = { model, Player.Character, box.Parent }
            homeGroundY = FindGroundY(
                homeMainCF.Position + uprightRot:VectorToWorldSpace(Vector3.new(14, 0, 0)),
                ignore
            )
        end
        placedCount = placedCount + 1
        local cf = HomeGridCF(placedCount, homeMainCF, uprightRot, box, homeGroundY)
        homeTargets[box] = cf
        placedBoxes[box] = true
        box.CFrame = cf
        box.AssemblyLinearVelocity  = Vector3.zero
        box.AssemblyAngularVelocity = Vector3.zero
        lastSendAt = tick()
    end

    -- Find any boxes of this item we already own that are still sitting around the
    -- counter (bought, but not sent home yet because of lag) and send them home
    local function SweepLeftovers(item, homeMainCF, uprightRot, model)
        local pm      = workspace:FindFirstChild("PlayerModels")
        local counter = GetCounterPart(item.Store)
        if not (pm and counter) then return 0 end

        local found = {}
        for _, m in ipairs(pm:GetChildren()) do
            if m:IsA("Model") and m.Name:find("Box Purchased by", 1, true)
               and (m.Name:find(Player.Name, 1, true) or m.Name:find(Player.DisplayName, 1, true)) then
                local v    = m:FindFirstChild("PurchasedBoxItemName")
                local main = m:FindFirstChild("Main")
                if v and v.Value == item.BoxItemName and main and main:IsA("BasePart")
                   and (main.Position - counter.Position).Magnitude <= 40 then
                    table.insert(found, main)
                end
            end
        end

        PlaceHome(found, homeMainCF, uprightRot, model)
        return #found
    end

    local function ReleaseHold()
        if holdConn then holdConn:Disconnect(); holdConn = nil end
        holdCF = nil
    end

    local function InsideBed(bedWorldCF, pos)
        local rel = bedWorldCF:PointToObjectSpace(pos)
        return math.abs(rel.X) <= bedSize.X / 2 + 0.5
            and math.abs(rel.Y) <= bedSize.Y / 2 + 0.5
            and math.abs(rel.Z) <= bedSize.Z / 2 + 0.5
    end

    -- Grid positions on the counter surface for `count` boxes (capped to what fits)
    local function CounterSlots(counter, sample, count)
        local bs   = sample.Size
        local cols = math.max(1, math.floor(counter.Size.X / (bs.X + 0.3)))
        local rows = math.max(1, math.floor(counter.Size.Z / (bs.Z + 0.3)))
        local cap  = math.min(cols * rows, count)

        local slots = {}
        for i = 1, cap do
            local c = (i - 1) % cols
            local r = math.floor((i - 1) / cols)
            local x = (c - (cols - 1) / 2) * (bs.X + 0.3)
            local z = (r - (rows - 1) / 2) * (bs.Z + 0.3)
            local y = counter.Size.Y / 2 + bs.Y / 2 + 0.05
            table.insert(slots, counter.CFrame * CFrame.new(x, y, z))
        end
        return slots, cols * rows
    end

    local function FindTruck()
        local char = Player.Character
        local hum  = char and char:FindFirstChildOfClass("Humanoid")
        local seat = hum and hum.SeatPart
        if not seat then
            return nil, "Sit in your truck's driver seat first."
        end
        local pm = workspace:FindFirstChild("PlayerModels")
        local m  = seat
        while m and m.Parent ~= pm do m = m.Parent end
        if not (m and m:IsA("Model")) then
            return nil, "This seat isn't in one of your vehicles."
        end
        local info = m:FindFirstChild("BedInfo")
        local cfv  = info and info:FindFirstChild("CFrame")
        local szv  = info and info:FindFirstChild("Size")
        if not (cfv and szv and m.PrimaryPart) then
            return nil, "This vehicle has no cargo bed."
        end
        return m, nil, seat, cfv.Value, szv.Value
    end

    local function Cleanup(homeMainCF)
        TruckBuy.running = false
        if homeMainCF and truckModel and truckModel.Parent then
            SetHold(homeMainCF)
            task.wait(0.3)
        end
        ReleaseHold()
        DisableNoclip()
        pcall(function()
            if savedOcclusion then Player.DevCameraOcclusionMode = savedOcclusion end
        end)
        savedOcclusion = nil
    end

    local function BuyBox(box, npcArg, npcName, item, onBought)
        local giveUp = tick() + 90
        while TruckBuy.running and tick() < giveUp do
            if not box or not box.Parent then return false end

            local ok = SpamPurchase(box, npcArg, item.Name, npcName, nil,
                _quickPurchase and QUICK.CycleGap or nil, onBought)
            if ok then
                _npcFailStreak[npcName]  = 0
                _npcResetStreak[npcName] = 0
                return true
            end

            _npcFailStreak[npcName] = (_npcFailStreak[npcName] or 0) + 1
            if _npcFailStreak[npcName] >= NPC_FAIL_THRESHOLD then
                _npcFailStreak[npcName]  = 0
                _npcResetStreak[npcName] = (_npcResetStreak[npcName] or 0) + 1

                if _allowNuclearReset and _npcResetStreak[npcName] >= NPC_NUCLEAR_AFTER then
                    _npcResetStreak[npcName] = 0
                    Say("Cashier stuck. Respawning...")
                    NuclearReset()
                    TruckBuy.running = false   -- respawning drops us out of the seat
                    return false
                end

                -- Soft reset without moving the seated player
                InvalidateNPCID(npcName)
                local newID = FetchNPCID(npcName)
                if newID then npcArg.ID = newID end
                FlushDialog(npcArg, 3)
            else
                task.wait(0.3)
            end
        end
        return false
    end

    function TruckBuy.Stop()
        TruckBuy.running = false
    end

    function TruckBuy.Start(item, totalQty, onDone)
        if TruckBuy.running then return false, "Already running." end
        if _isBuying then return false, "Stop the normal Auto Buy first." end
        if not item then return false, "Select an item first." end
        if item.IsBlueprint then return false, "Blueprints aren't supported by Truck Auto Buy." end
        if not item.Store or not StoreConfigs[item.Store] then
            return false, "That item's store isn't supported."
        end

        local model, err, seat, bedCFv, bedSz = FindTruck()
        if not model then return false, err end

        local funds = FetchFunds()
        if funds == nil then return false, "Couldn't read your money." end
        if funds < item.Price then return false, "Need more money!" end
        if funds < item.Price * totalQty then
            totalQty = math.floor(funds / item.Price)
        end

        truckModel  = model
        truckMain   = model.PrimaryPart
        pivotOffset = truckMain.CFrame:ToObjectSpace(model:GetPivot())
        bedOff      = bedCFv
        bedSize     = bedSz
        seatOff     = truckMain.CFrame:ToObjectSpace(seat.CFrame).Position

        local homeMainCF = truckMain.CFrame
        local _, yaw     = homeMainCF:ToOrientation()
        local flipRot    = CFrame.Angles(0, yaw, math.pi)
        local uprightRot = CFrame.Angles(0, yaw, 0)
        local config     = StoreConfigs[item.Store]

        TruckBuy.running = true
        EnableNoclip(model)
        placedCount = 0
        homeGroundY = nil
        placedBoxes = {}
        homeTargets = {}

        -- Noclip camera so the truck flying around never blocks the view
        pcall(function()
            savedOcclusion = Player.DevCameraOcclusionMode
            Player.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Invisicam
        end)

        task.spawn(function()
            FetchAllNPCIDs()
            SetHold(homeMainCF)
            Say(("Truck Auto Buy started: 0 / %d"):format(totalQty))

            local bought, restockTimer, scoopFails = 0, 0, 0

            while TruckBuy.running and bought < totalQty do
                if not model.Parent or not (Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
                    and Player.Character:FindFirstChildOfClass("Humanoid").SeatPart) then
                    Say("You left the driver seat. Stopping.")
                    break
                end

                local need  = totalQty - bought
                local cands = ResolveItemParts(item, need)

                if #cands == 0 then
                    task.wait(RESTOCK_POLL_RATE)
                    restockTimer = restockTimer + RESTOCK_POLL_RATE
                    if restockTimer >= RESTOCK_TIMEOUT then
                        Say("Out of stock. Stopping.")
                        break
                    end
                    continue
                end
                restockTimer = 0

                local counter = GetCounterPart(item.Store)
                if not counter then
                    Say("Couldn't find the store counter.")
                    break
                end

                -- 1) Fly the truck above the boxes, upside down, bed facing down.
                --    Centered on the cluster of boxes near the first one, with the
                --    bed volume sitting on top of them (truck body above the item).
                local anchor = cands[1]
                local reach  = math.max(bedSize.X, bedSize.Z) / 2
                local sum, n, lowY = Vector3.zero, 0, anchor.Position.Y
                for _, p in ipairs(cands) do
                    if p.Parent and (p.Position - anchor.Position).Magnitude <= reach then
                        sum = sum + p.Position
                        n = n + 1
                        if p.Position.Y < lowY then lowY = p.Position.Y end
                    end
                end
                local center  = n > 0 and (sum / n) or anchor.Position
                local bedPos  = Vector3.new(center.X, lowY + bedSize.Y / 2 - anchor.Size.Y / 2 + 0.2, center.Z)
                local tPos    = bedPos - flipRot:VectorToWorldSpace(bedOff.Position)
                local scoopCF = CFrame.new(tPos) * flipRot
                SetHold(scoopCF)
                task.wait(0.35)

                -- 2) Collect every box inside the bed that we now own
                local bedWorld = scoopCF * bedOff
                local slots, _ = CounterSlots(counter, anchor, math.min(need, #cands))
                local batch    = {}
                local deadline = tick() + 1.5
                repeat
                    batch = {}
                    for _, p in ipairs(cands) do
                        if p.Parent and not p.Anchored and InsideBed(bedWorld, p.Position) and OwnedByMe(p) then
                            table.insert(batch, p)
                            if #batch >= #slots then break end
                        end
                    end
                    if #batch > 0 then break end
                    task.wait(0.1)
                until tick() > deadline or not TruckBuy.running

                if #batch == 0 then
                    scoopFails = scoopFails + 1
                    if scoopFails >= 3 then
                        Say("Couldn't take ownership of the boxes. Stopping.")
                        break
                    end
                    continue
                end
                scoopFails = 0

                -- 3) Teleport them all onto the counter at once
                for i, box in ipairs(batch) do
                    box.CFrame = slots[i]
                    box.AssemblyLinearVelocity  = Vector3.zero
                    box.AssemblyAngularVelocity = Vector3.zero
                end

                -- 4) Stay at the store. The truck only flies home once, at the end
                --    (Cleanup), instead of after every round. Bought boxes are
                --    teleported home in step 6.

                -- 5) Check out everything on the counter
                local npcArg, npcName = GetNPCArgForItem(item.Store, batch[1])
                if not npcArg or not npcArg.ID then
                    Say("Couldn't reach the cashier.")
                    break
                end

                local purchased = {}
                for _, box in ipairs(batch) do
                    if not TruckBuy.running then break end
                    if BuyBox(box, npcArg, npcName, item, function()
                        SendHomeNow(box, homeMainCF, uprightRot, model)
                    end) then
                        table.insert(purchased, box)
                    end
                end

                -- Count boxes that really got bought even if the purchase call
                -- timed out (lag): their parent is already PlayerModels
                local seen = {}
                for _, b in ipairs(purchased) do seen[b] = true end
                for _, b in ipairs(batch) do
                    if not seen[b] and b.Parent and IsSuccessParent(b.Parent) then
                        table.insert(purchased, b)
                    end
                end

                -- 6) Send everything bought to where we are (home), while the
                --    boxes are still yours
                PlaceHome(purchased, homeMainCF, uprightRot, model)
                SweepLeftovers(item, homeMainCF, uprightRot, model)

                bought = bought + #purchased
                if #purchased > 0 then
                    Say(("%d / %d bought"):format(math.min(bought, totalQty), totalQty))
                end
                if #purchased == 0 and TruckBuy.running then
                    task.wait(0.5)
                end
            end

            -- Last check: grab anything of ours still left around the counter
            pcall(function()
                if model.Parent then SweepLeftovers(item, homeMainCF, uprightRot, model) end
            end)

            Cleanup(homeMainCF)
            if bought >= totalQty then Say("Truck Auto Buy finished!") end
            if onDone then onDone() end
        end)

        return true
    end
end


local function PurchaseBlueprintPart(mainPart, item)
    local npcArg, resolvedNPCName = PositionForPurchase(mainPart, item, nil)
    if not npcArg then return false end
    local purchased, _ = SpamPurchase(mainPart, npcArg, item.Name, resolvedNPCName)
    return purchased
end

local BOX_OPEN_TIMEOUT = 10

local function OpenBlueprintBox(boxItemName)
    local PlayerModels = workspace:FindFirstChild("PlayerModels")
    if not PlayerModels then return false end

    local deadline = tick() + BOX_OPEN_TIMEOUT

    while tick() < deadline do
        for _, model in ipairs(PlayerModels:GetChildren()) do
            if model:IsA("Model") and model.Name:find("Box Purchased by") then
                local nameVal = model:FindFirstChild("PurchasedBoxItemName")
                if nameVal and nameVal.Value == boxItemName then
                    local char = Player.Character
                    local head = char and char:FindFirstChild("Head")
                    if head then
                        Interact:FireServer(model, "Open box", head.CFrame)
                        task.wait(0.5)
                        return true
                    end
                end
            end
        end
        task.wait(0.2)
    end

    warn("[Blueprints] Timed out waiting for box:", boxItemName)
    return false
end

local _isBuyingBlueprints = false

local function RunBlueprintLoop(ShopItems, onDone)
    _isBuyingBlueprints = true

    FetchAllNPCIDs()

    local char     = Player.Character
    local root     = char and char:FindFirstChild("HumanoidRootPart")
    local returnCF = root and root.CFrame

    local blueprints = {}
    for _, item in ipairs(ShopItems) do
        if item.IsBlueprint then
            table.insert(blueprints, item)
        end
    end

    if #blueprints == 0 then
        warn("[Blueprints] No blueprint items found in item list.")
        _isBuyingBlueprints = false
        if onDone then onDone() end
        return
    end

    print("[Blueprints] Found " .. #blueprints .. " blueprints to purchase.")

    for _, item in ipairs(blueprints) do
        if not _isBuyingBlueprints then break end

        local parts = ResolveItemParts(item, 1)
        if #parts == 0 then
            warn("[Blueprints] No stock found for:", item.Name, "— skipping.")
            continue
        end

        local mainPart = parts[1]
        if not mainPart or not mainPart.Parent then
            warn("[Blueprints] mainPart gone for:", item.Name, "— skipping.")
            continue
        end

        local blueprintsFolder = Player:FindFirstChild("PlayerBlueprints")
            and Player.PlayerBlueprints:FindFirstChild("Blueprints")
        if blueprintsFolder and blueprintsFolder:FindFirstChild(item.BoxItemName) then
            print("[Blueprints] Already owned, skipping:", item.Name)
            continue
        end

        local funds = FetchFunds()
        if funds == nil or funds < item.Price then
            warn("[Blueprints] Not enough funds for:", item.Name, "(need $" .. item.Price .. ")")
            continue
        end

        print("[Blueprints] Purchasing:", item.Name)
        local purchased = PurchaseBlueprintPart(mainPart, item)

        if purchased then
            print("[Blueprints] Purchased! Opening box for:", item.Name)
            local boxName = item.BoxItemName or item.Name
            OpenBlueprintBox(boxName)
        else
            warn("[Blueprints] Failed to purchase:", item.Name)
        end

        task.wait(0.2)
    end

    local returnChar = Player.Character
    local returnRoot = returnChar and returnChar:FindFirstChild("HumanoidRootPart")
    if returnRoot and returnCF then
        returnRoot.CFrame = returnCF
    end

    print("[Blueprints] All done!")
    _isBuyingBlueprints = false
    if onDone then onDone() end
end

local function ShopNotify(text)
    local ok = pcall(function() Notify("Antler", text, 3) end)
    if not ok then
        pcall(function()
            StarterGui:SetCore("SendNotification", { Title = "Antler", Text = text, Duration = 3 })
        end)
    end
end

function ShopModule.Init(Tab, lot)
    if lot ~= nil then _LOT = lot end

    _ShopItems = LoadItemList()
    local ShopItems = _ShopItems

    if not ShopItems or #ShopItems == 0 then
        Tab:CreateSection("Hardware Store")
        return
    end

    local SelectedItem = ShopItems[1]
    local Quantity     = 1

    local PurchaseBtn
    local Catalog

    local function RefreshFundsCache()
        task.spawn(function()
            local f = FetchFunds()
            if f ~= nil then _cachedFunds = f end
        end)
    end

    -- The selector row shows the item and the total price for the chosen quantity
    local function UpdateDisplay()
        if not SelectedItem then return end
        if Catalog and Catalog.SetDisplay then
            Catalog:SetDisplay(("%s  $%d"):format(SelectedItem.Name, SelectedItem.Price * Quantity))
        end
    end

    local function SetBuyingState(buying)
        if not PurchaseBtn then return end
        if buying then
            PurchaseBtn:SetFullText("Abort Purchase")
        else
            PurchaseBtn:SetFullText("Purchase")
            RefreshFundsCache()
            UpdateDisplay()
        end
    end

    Tab:CreateSection("Stores")

    Catalog = Tab:CreateImageSelector("Select an Item", {
        MultiSelect = false,
        VisibleRows = 3,
        SlotSize    = UDim2.new(0, 73, 0, 73),
    }, function(name)
        for _, item in pairs(ShopItems) do
            if item.Name == name then
                SelectedItem = item
                break
            end
        end
        UpdateDisplay()
    end)

    local BlueprintSlotObjs = {}
    local SlotRefs = {}

    for _, item in ipairs(ShopItems) do
        pcall(function()
            local slotObj = Catalog:AddSlot("", item.Name, "$" .. tostring(item.Price))
            SlotRefs[item.Name] = { slotObj = slotObj, item = item }
            if item.IsBlueprint then
                BlueprintSlotObjs[item.Name] = slotObj
            end
        end)
    end

    task.spawn(function()
        for _, item in ipairs(ShopItems) do
            task.wait()
            pcall(function()
                if not item.Image or item.Image == "" then return end
                local ref = SlotRefs[item.Name]
                if not ref or not ref.slotObj.ImageLabel then return end
                ref.slotObj.ImageLabel.Image = item.Image
            end)
        end
    end)

    Tab:CreateSlider("Quantity", 1, 1000, 1, function(val)
        Quantity = val
        UpdateDisplay()
    end)

    local TruckMode = false   -- set by the "Truck Auto Buy" toggle; Purchase uses it

    PurchaseBtn = Tab:CreateAction("Purchase", "", function()
        -- Pressing Purchase while a truck run is going stops it
        if TruckBuy.running then
            TruckBuy.Stop()
            return
        end
        if _isBuying then
            _isBuying = false
            return
        end

        -- Truck mode: the toggle is on, so Purchase does a truck run
        if TruckMode then
            local ok, err = TruckBuy.Start(SelectedItem, Quantity, function()
                SetBuyingState(false)
            end)
            if ok then
                SetBuyingState(true)
            else
                pcall(function() Notify("Antler", err or "Couldn't start.", 3) end)
            end
            return
        end

        if not SelectedItem                       then return end
        if _LOT == nil                            then return end
        if not SelectedItem.Store                 then return end
        if not StoreConfigs[SelectedItem.Store]   then return end
        if _LOT.IsBusy()                          then return end

        local funds = FetchFunds()
        if funds == nil then return end
        if funds < SelectedItem.Price then
            ShopNotify("Need more money!")
            return
        end

        local totalCost = SelectedItem.Price * Quantity
        local targetQty = Quantity
        if funds < totalCost then
            targetQty = math.floor(funds / SelectedItem.Price)
        end

        local char      = Player.Character
        local root      = char and char:FindFirstChild("HumanoidRootPart")
        local pressedCF = root and root.CFrame

        SetBuyingState(true)

        task.spawn(function()
            RunBuyLoop(SelectedItem, targetQty, pressedCF, function()
                SetBuyingState(false)
            end)
        end)
    end, false)

    Tab:CreateToggle("Truck Auto Buy", false, function(state)
        TruckMode = state
        if state then
            pcall(function()
                Notify("Antler", "Truck mode on: sit in your truck and press Purchase.", 3)
            end)
        else
            TruckBuy.Stop()
        end
    end)

    RefreshFundsCache()
    task.spawn(function()
        while true do
            task.wait(3)
            RefreshFundsCache()
        end
    end)

    UpdateDisplay()
    ShopModule.UpdateDisplay = UpdateDisplay

    Tab:CreateSection("Special")

    Tab:CreateAction("Power of Ease ($10,009,000)", "Buy", function()
        task.spawn(PurchasePowerOfEase)
    end, false)

    local BlueprintItems = {}
    for _, item in ipairs(ShopItems) do
        if item.IsBlueprint then
            table.insert(BlueprintItems, item)
        end
    end

    local function CheckAllBlueprintsOwned()
        if #BlueprintItems == 0 then return false end
        local playerBP = Player:FindFirstChild("PlayerBlueprints")
        if not playerBP then return false end
        local blueprintsFolder = playerBP:FindFirstChild("Blueprints")
        if not blueprintsFolder then return false end
        local owned = 0
        for _, item in ipairs(BlueprintItems) do
            if blueprintsFolder:FindFirstChild(item.BoxItemName) then
                owned += 1
            end
        end
        return owned >= #BlueprintItems
    end

    local BlueprintBtn

    local function GetTotalBlueprintCost()
        local blueprintsFolder = Player:FindFirstChild("PlayerBlueprints")
            and Player.PlayerBlueprints:FindFirstChild("Blueprints")
        local total = 0
        for _, item in ipairs(BlueprintItems) do
            local owned = blueprintsFolder and blueprintsFolder:FindFirstChild(item.BoxItemName)
            if not owned then
                total += tonumber(item.Price) or 0
            end
        end
        return total
    end

    local function UpdateBlueprintBtnState()
        if not BlueprintBtn then return end
        if _isBuyingBlueprints then return end
        local allOwned = CheckAllBlueprintsOwned()
        BlueprintBtn:SetDisabled(allOwned)
        if allOwned then
            BlueprintBtn:SetText("All Owned")
        else
            local total = GetTotalBlueprintCost()
            if total > 0 then
                BlueprintBtn:SetText("$" .. tostring(total))
            else

                BlueprintBtn:SetText(#BlueprintItems .. " blueprints")
            end
        end
    end

    BlueprintBtn = Tab:CreateAction("Purchase All Blueprints", "Buy", function()
        if _isBuyingBlueprints then
            _isBuyingBlueprints = false
            UpdateBlueprintBtnState()
            return
        end
        BlueprintBtn:SetText("Stop")
        task.spawn(function()
            RunBlueprintLoop(ShopItems, function()
                UpdateBlueprintBtnState()
            end)
        end)
    end, false)

    UpdateBlueprintBtnState()

    local RUKIRY_ITEMS = {
        { BoxItemName = "CanOfWorms", GoalCF = CFrame.new(317.3, 46.0, 1918.1) },
        { BoxItemName = "BagOfSand",  GoalCF = CFrame.new(319.5, 46.0, 1914.9) },
        { BoxItemName = "LightBulb",  GoalCF = CFrame.new(322.4, 43.6, 1916.4) },
    }

    local RUKIRY_PLAYER_CF = CFrame.new(320.6, 45.8, 1919.2)

    local RukiryBtn
    local _isBuyingRukiry = false

    local function PurchaseRukiryItem(mainPart, item, goalCF)
        local npcArg, resolvedNPCName = PositionForPurchase(mainPart, item, nil)
        if not npcArg then return false end

        local purchased, _ = SpamPurchase(mainPart, npcArg, item.Name, resolvedNPCName)

        if purchased then
            task.wait(0.05)

            local PlayerModels = workspace:FindFirstChild("PlayerModels")
            local existingModels = {}
            if PlayerModels then
                for _, m in ipairs(PlayerModels:GetChildren()) do
                    existingModels[m] = true
                end
            end

            local boxModel = mainPart and mainPart.Parent
            if boxModel and boxModel:IsA("Model") then
                local ch   = Player.Character
                local head = ch and ch:FindFirstChild("Head")
                if head then
                    Interact:FireServer(boxModel, "Open box", head.CFrame)
                end
            end

            local spawnedPart = nil
            local deadline = tick() + 5
            while tick() < deadline do
                task.wait(0.1)
                if PlayerModels then
                    for _, m in ipairs(PlayerModels:GetChildren()) do
                        if not existingModels[m] and m:IsA("Model") then
                            local itemNameVal = m:FindFirstChild("ItemName")
                            if not (itemNameVal and itemNameVal.Value == item.BoxItemName) then continue end
                            local ownerFolder = m:FindFirstChild("Owner")
                            local ownerString = ownerFolder and ownerFolder:FindFirstChild("OwnerString")
                            if not (ownerString and ownerString.Value == Player.Name) then continue end
                            local foundMain = m:FindFirstChild("Main")
                            if foundMain then
                                spawnedPart = foundMain
                                break
                            end
                        end
                    end
                end
                if spawnedPart then break end
            end

            if spawnedPart and spawnedPart.Parent then
                _LOT.TeleportMany({ { target = spawnedPart, goalCF = goalCF } })
                if _LOT.IsBusy() then _LOT.WaitForBatch() end
            else
                warn("[Rukiry] Could not find spawned item after box open")
            end
        end

        return purchased
    end

    local function RunRukiryLoop()
        _isBuyingRukiry = true
        FetchAllNPCIDs()

        local returnChar = Player.Character
        local returnRoot = returnChar and returnChar:FindFirstChild("HumanoidRootPart")
        local rukiryReturnCF = returnRoot and returnRoot.CFrame

        for _, rukiryItem in ipairs(RUKIRY_ITEMS) do
            if not _isBuyingRukiry then break end

            local itemDef = nil
            for _, shopItem in ipairs(ShopItems) do
                if shopItem.BoxItemName == rukiryItem.BoxItemName then
                    itemDef = shopItem
                    break
                end
            end

            if not itemDef then
                warn("[Rukiry] Item not found in list:", rukiryItem.BoxItemName)
                continue
            end

            local funds = FetchFunds()
            if funds == nil or funds < itemDef.Price then
                warn("[Rukiry] Not enough funds for:", itemDef.Name, "(need $" .. itemDef.Price .. ")")
                continue
            end

            local parts = ResolveItemParts(itemDef, 1)
            if #parts == 0 then
                warn("[Rukiry] No stock found for:", itemDef.Name)
                continue
            end

            local mainPart = parts[1]
            if not mainPart or not mainPart.Parent then
                warn("[Rukiry] mainPart gone for:", itemDef.Name)
                continue
            end

            print("[Rukiry] Purchasing:", itemDef.Name)
            local purchased = PurchaseRukiryItem(mainPart, itemDef, rukiryItem.GoalCF)

            if purchased then
                print("[Rukiry] Placed:", itemDef.Name)
            else
                warn("[Rukiry] Failed:", itemDef.Name)
            end

            task.wait(0.2)
        end

        local retChar = Player.Character
        local retRoot = retChar and retChar:FindFirstChild("HumanoidRootPart")
        if retRoot then retRoot.CFrame = RUKIRY_PLAYER_CF end

        print("[Rukiry] Waiting for axe to spawn...")
        local axeModel    = nil
        local axeDeadline = tick() + 20
        while tick() < axeDeadline do
            task.wait(0.2)
            local PlayerModels = workspace:FindFirstChild("PlayerModels")
            if not PlayerModels then continue end

            local ch   = Player.Character
            local root = ch and ch:FindFirstChild("HumanoidRootPart")

            for _, m in ipairs(PlayerModels:GetChildren()) do
                if not (m:IsA("Model") and m.Name == "Model") then continue end
                local toolName = m:FindFirstChild("ToolName")
                if not (toolName and toolName.Value == "Rukiryaxe") then continue end
                local ownerFolder = m:FindFirstChild("Owner")
                local ownerString = ownerFolder and ownerFolder:FindFirstChild("OwnerString")
                if not (ownerString and ownerString.Value == "") then continue end
                local lastInteraction = ownerFolder and ownerFolder:FindFirstChild("LastInteraction")
                if not (lastInteraction and lastInteraction.Value == 0) then continue end
                if root then
                    local handle = m:FindFirstChild("Handle") or m.PrimaryPart
                    if handle and (handle.Position - root.Position).Magnitude > 50 then continue end
                end
                axeModel = m
                break
            end

            if axeModel then break end
        end

        if axeModel then
            local handle = axeModel:FindFirstChild("Handle") or axeModel.PrimaryPart
            if handle then
                print("[Rukiry] Found axe, teleporting and picking up...")
                _LOT.TeleportMany({ { target = handle, goalCF = handle.CFrame * CFrame.new(0, -1, 0) } })
                if _LOT.IsBusy() then _LOT.WaitForBatch() end
                task.wait(0.1)
                Interact:FireServer(axeModel, "Pick up tool", handle.CFrame)
                print("[Rukiry] Axe picked up!")
                task.wait(0.1)
                local rc = Player.Character
                local rr = rc and rc:FindFirstChild("HumanoidRootPart")
                if rr and rukiryReturnCF then
                    rr.CFrame = rukiryReturnCF
                    print("[Rukiry] Returned to original position.")
                end
            else
                warn("[Rukiry] Axe found but no Handle/PrimaryPart")
            end
        else
            warn("[Rukiry] Axe did not spawn within timeout")
        end

        print("[Rukiry] Done!")
        _isBuyingRukiry = false
        RukiryBtn:SetText("$7,400")
    end

    RukiryBtn = Tab:CreateAction("Purchase Rukiry Axe", "$7,400", function()
        if _isBuyingRukiry then
            _isBuyingRukiry = false
            RukiryBtn:SetText("$7,400")
            return
        end
        RukiryBtn:SetText("Stop")
        task.spawn(RunRukiryLoop)
    end, false)

    Tab:CreateSection("Settings")

    local QuickPurchaseToggle = Tab:CreateToggle("Quick Purchase", false, function(state)
        _quickPurchase = state
        _quickNeedsNear = false
    end)

    QuickPurchaseToggle:AddTooltip(
        "If an item is purchased within 1 second of being teleported to\n" ..
        "the counter, its CFrame is set directly instead of using LOT.\n" ..
        "Faster, but may cause failures on slow servers.\n" ..
        "If the item does not land, it falls back to LOT.\n" ..
        "Buys from where you stand instead of the cashier spot.\n" ..
        "Items are sent to where you pressed Purchase, and you are\n" ..
        "only sent back once the whole order is done.\n" ..
        "Anything of yours left on the counter is fetched at the end.\n" ..
        "\n" ..
        "⚠ Warning: this may cause failures."
    )

    local AutoRespawnToggle = Tab:CreateToggle("Auto Respawn", false, function(state)
        _allowNuclearReset = state
    end)

    AutoRespawnToggle:AddTooltip(
        "If a cashier stays stuck after multiple soft resets, respawn\n" ..
        "your character to free it so buying can continue."
    )

    local function GetBlueprintsFolder()
        local playerBP = Player:FindFirstChild("PlayerBlueprints")
        return playerBP and playerBP:FindFirstChild("Blueprints")
    end

    local function UpdateBlueprintSlots()
        local bpFolder = GetBlueprintsFolder()
        for _, item in ipairs(BlueprintItems) do
            local owned = bpFolder ~= nil and bpFolder:FindFirstChild(item.BoxItemName) ~= nil
            local slotObj = BlueprintSlotObjs[item.Name]
            if slotObj then slotObj:SetEnabled(not owned) end
        end
    end

    local _bpFolderConns = {}

    local function WireBlueprintFolder(folder)
        for _, c in ipairs(_bpFolderConns) do c:Disconnect() end
        _bpFolderConns = {}
        if not folder then return end
        table.insert(_bpFolderConns, folder.ChildAdded:Connect(function()
            UpdateBlueprintSlots()
            UpdateBlueprintBtnState()
        end))
        table.insert(_bpFolderConns, folder.ChildRemoved:Connect(function()
            UpdateBlueprintSlots()
            UpdateBlueprintBtnState()
        end))
    end

    local function WatchPlayerBlueprints()
        local playerBP = Player:FindFirstChild("PlayerBlueprints")
        if not playerBP then
            Player.ChildAdded:Connect(function(child)
                if child.Name ~= "PlayerBlueprints" then return end
                local sub = child:FindFirstChild("Blueprints")
                if sub then
                    WireBlueprintFolder(sub)
                    UpdateBlueprintSlots()
                    UpdateBlueprintBtnState()
                else
                    child.ChildAdded:Connect(function(subchild)
                        if subchild.Name == "Blueprints" then
                            WireBlueprintFolder(subchild)
                            UpdateBlueprintSlots()
                            UpdateBlueprintBtnState()
                        end
                    end)
                end
            end)
            return
        end

        local folder = playerBP:FindFirstChild("Blueprints")
        if folder then
            WireBlueprintFolder(folder)
        else
            playerBP.ChildAdded:Connect(function(child)
                if child.Name == "Blueprints" then
                    WireBlueprintFolder(child)
                    UpdateBlueprintSlots()
                    UpdateBlueprintBtnState()
                end
            end)
        end

        Player.ChildRemoved:Connect(function(child)
            if child.Name == "PlayerBlueprints" then
                for _, c in ipairs(_bpFolderConns) do c:Disconnect() end
                _bpFolderConns = {}
                UpdateBlueprintSlots()
                UpdateBlueprintBtnState()
                WatchPlayerBlueprints()
            end
        end)
    end

    WatchPlayerBlueprints()
    UpdateBlueprintSlots()
    UpdateBlueprintBtnState()
end

function ShopModule.GetItems()
    return _ShopItems
end

-- how many of an item the shops have right now (and its price)
function ShopModule.GetStock(itemName)
    if not _ShopItems then return nil end
    for _, i in ipairs(_ShopItems) do
        if i.Name == itemName then
            return #ResolveItemParts(i, 9999), i.Price
        end
    end
    return nil
end

function ShopModule.GetFunds()
    return FetchFunds()
end

function ShopModule.IsBuying()
    return _isBuying
end

-- stop a purchase that is running
function ShopModule.Stop()
    _isBuying = false
end

function ShopModule.PurchaseItem(itemName, quantity, pressedCF, onDone)
    if _isBuying               then return false, "already buying"    end
    if not _ShopItems          then return false, "not initialised"   end

    local item
    for _, i in ipairs(_ShopItems) do
        if i.Name == itemName then item = i; break end
    end

    if not item                     then return false, "item not found"    end
    if not item.Store               then return false, "item has no store" end
    if not StoreConfigs[item.Store] then return false, "no store config"   end

    quantity  = math.max(1, quantity or 1)
    pressedCF = pressedCF or (function()
        local c = Player.Character
        local r = c and c:FindFirstChild("HumanoidRootPart")
        return r and r.CFrame
    end)()

    task.spawn(function()
        RunBuyLoop(item, quantity, pressedCF, onDone)
    end)

    return true
end

-- fetch cashier ids on load
task.spawn(FetchAllNPCIDs)

return ShopModule
]=],
            "Shop"
        ))()
    end
    __modules["LT2ItemList"] = function()
        return assert(loadstring(
            [=[return {

    { BoxItemName = "BasicHatchet",  Store = "WoodRUs" },
    { BoxItemName = "Axe1",          Store = "WoodRUs" },
    { BoxItemName = "Axe2",          Store = "WoodRUs" },
    { BoxItemName = "Axe3",          Store = "WoodRUs" },
    { BoxItemName = "SilverAxe",     Store = "WoodRUs" },

    { BoxItemName = "StraightConveyor",           Store = "WoodRUs" },
    { BoxItemName = "TightTurnConveyor",           Store = "WoodRUs" },
    { BoxItemName = "TiltConveyor",               Store = "WoodRUs" },
    { BoxItemName = "ConveyorFunnel",             Store = "WoodRUs" },
    { BoxItemName = "ConveyorSwitch",             Store = "WoodRUs" },
    { BoxItemName = "StraightSwitchConveyorLeft", Store = "WoodRUs" },
    { BoxItemName = "StraightSwitchConveyorRight",Store = "WoodRUs" },
    { BoxItemName = "LogSweeper",                 Store = "WoodRUs" },
    { BoxItemName = "ConveyorSupports",           Store = "WoodRUs" },
    { BoxItemName = "TightTurnConveyorSupports",  Store = "WoodRUs" },

    { BoxItemName = "Sawmill",   Store = "WoodRUs" },
    { BoxItemName = "Sawmill2",  Store = "WoodRUs" },
    { BoxItemName = "Sawmill3",  Store = "WoodRUs" },
    { BoxItemName = "Sawmill4",  Store = "WoodRUs" },
    { BoxItemName = "Sawmill4L", Store = "WoodRUs" },
    { BoxItemName = "ChopSaw",   Store = "WoodRUs" },

    { BoxItemName = "Wire",                   Store = "WoodRUs"       },
    { BoxItemName = "IcicleWireMaple",        Store = "FurnitureStore" },
    { BoxItemName = "IcicleWireCandy",        Store = "FurnitureStore" },
    { BoxItemName = "IcicleWireHalloween",    Store = "FurnitureStore" },
    { BoxItemName = "IcicleWireHalloweenGreen", Store = "FurnitureStore" },
    { BoxItemName = "IcicleWireAmber",        Store = "FurnitureStore" },
    { BoxItemName = "IcicleWireBlue",         Store = "FurnitureStore" },
    { BoxItemName = "IcicleWireGreen",        Store = "FurnitureStore" },
    { BoxItemName = "IcicleWireRed",          Store = "FurnitureStore" },
    { BoxItemName = "NeonWireWhite",          Store = "LogicStore"    },
    { BoxItemName = "NeonWireRed",            Store = "LogicStore"    },
    { BoxItemName = "NeonWireOrange",         Store = "LogicStore"    },
    { BoxItemName = "NeonWireYellow",         Store = "LogicStore"    },
    { BoxItemName = "NeonWireGreen",          Store = "LogicStore"    },
    { BoxItemName = "NeonWireCyan",           Store = "LogicStore"    },
    { BoxItemName = "NeonWireBlue",           Store = "LogicStore"    },
    { BoxItemName = "NeonWireViolet",         Store = "LogicStore"    },
    { BoxItemName = "Button0",        Store = "WoodRUs"    },
    { BoxItemName = "Lever0",         Store = "WoodRUs"    },
    { BoxItemName = "PressurePlate",  Store = "WoodRUs"    },
    { BoxItemName = "GateNOT",        Store = "LogicStore" },
    { BoxItemName = "SignalSustain",  Store = "LogicStore" },
    { BoxItemName = "SignalDelay",    Store = "LogicStore" },
    { BoxItemName = "GateAND",        Store = "LogicStore" },
    { BoxItemName = "GateOR",         Store = "LogicStore" },
    { BoxItemName = "GateXOR",        Store = "LogicStore" },
    { BoxItemName = "ClockSwitch",    Store = "LogicStore" },
    { BoxItemName = "WoodChecker",    Store = "LogicStore" },
    { BoxItemName = "Laser",          Store = "LogicStore" },
    { BoxItemName = "LaserReceiver",  Store = "LogicStore" },
    { BoxItemName = "Hatch",          Store = "LogicStore" },

    { BoxItemName = "UtilityTruck",  Store = "WoodRUs"  },
    { BoxItemName = "UtilityTruck2", Store = "CarStore"  },
    { BoxItemName = "Pickup1",       Store = "CarStore"  },
    { BoxItemName = "SmallTrailer",  Store = "CarStore"  },
    { BoxItemName = "Trailer2",      Store = "CarStore"  },

    { BoxItemName = "Seat_Armchair",    Store = "FurnitureStore" },
    { BoxItemName = "Seat_Loveseat",    Store = "FurnitureStore" },
    { BoxItemName = "Bed1",             Store = "FurnitureStore" },
    { BoxItemName = "FloorLamp1",       Store = "FurnitureStore" },
    { BoxItemName = "Lamp1",            Store = "FurnitureStore" },
    { BoxItemName = "WallLight1",       Store = "FurnitureStore" },
    { BoxItemName = "WallLight2",       Store = "FurnitureStore" },
    { BoxItemName = "Refridgerator",    Store = "FurnitureStore" },
    { BoxItemName = "Stove",            Store = "FurnitureStore" },
    { BoxItemName = "Dishwasher",       Store = "FurnitureStore" },
    { BoxItemName = "Toilet",           Store = "FurnitureStore" },
    { BoxItemName = "FireworkLauncher", Store = "FurnitureStore" },
    { BoxItemName = "GlassDoor1",       Store = "FurnitureStore" },
    { BoxItemName = "GlassPane4",       Store = "FurnitureStore" },
    { BoxItemName = "GlassPane3",       Store = "FurnitureStore" },
    { BoxItemName = "GlassPane2",       Store = "FurnitureStore" },
    { BoxItemName = "GlassPane1",       Store = "FurnitureStore" },

    { BoxItemName = "Painting3", Store = "FineArt" },
    { BoxItemName = "Painting2", Store = "FineArt" },
    { BoxItemName = "Painting1", Store = "FineArt" },
    { BoxItemName = "Painting7", Store = "FineArt" },
    { BoxItemName = "Painting6", Store = "FineArt" },
    { BoxItemName = "Painting9", Store = "FineArt" },
    { BoxItemName = "Painting8", Store = "FineArt" },

    { BoxItemName = "BagOfSand",   Store = "WoodRUs"    },
    { BoxItemName = "CanOfWorms",  Store = "ShackShop"  },
    { BoxItemName = "LightBulb",   Store = "FurnitureStore" },
    { BoxItemName = "Dynamite",    Store = "ShackShop"  },
    { BoxItemName = "WorkLight",   Store = "WoodRUs"    },

    { BoxItemName = "Wall2Tall",         Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Wall2",             Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Wall2Short",        Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Wall2TallThin",     Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Wall2Thin",         Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Wall2ShortThin",    Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Wall2TallCorner",   Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Wall2Corner",       Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Wall2ShortCorner",  Store = "WoodRUs", IsBlueprint = true },

    { BoxItemName = "Wall1Tall",         Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Wall1",             Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Wall1Short",        Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Wall1TallThin",     Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Wall1Thin",         Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Wall1ShortThin",    Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Wall1TallCorner",   Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Wall1Corner",       Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Wall1ShortCorner",  Store = "WoodRUs", IsBlueprint = true },

    { BoxItemName = "Wall3Tall",         Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Wall3",             Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Wall3TallThin",     Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Wall3Thin",         Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Wall3TallCorner",   Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Wall3Corner",       Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Floor1Large",  Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Floor1",       Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Floor1Small",  Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Floor1Tiny",   Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Floor2Large",  Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Floor2",       Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Floor2Small",  Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Floor2Tiny",   Store = "WoodRUs", IsBlueprint = true },

    { BoxItemName = "Wedge1",       Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Wedge1_Thin",  Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Wedge2",       Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Wedge2_Thin",  Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Wedge3",       Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Wedge3_Thin",  Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Wedge4",       Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Wedge4_Thin",  Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Wedge5",       Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Wedge5_Thin",  Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Wedge6",       Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Wedge6_Thin",  Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Wedge7",       Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Wedge7_Thin",  Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Wedge8",       Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Wedge8_Thin",  Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Wedge9",       Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Wedge9_Thin",  Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Wedge10",      Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Wedge10_Thin", Store = "WoodRUs", IsBlueprint = true },

    { BoxItemName = "Stair1",  Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Stair2",  Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Ladder1", Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Post",    Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Door1",   Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Door2",   Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Door3",   Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Table1",  Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Table2",  Store = "WoodRUs", IsBlueprint = true },
    { BoxItemName = "Chair1",  Store = "WoodRUs", IsBlueprint = true },

    { BoxItemName = "Cabinet1CornerWide",  Store = "FurnitureStore", IsBlueprint = true },
    { BoxItemName = "Cabinet1",            Store = "FurnitureStore", IsBlueprint = true },
    { BoxItemName = "Cabinet1Thin",        Store = "FurnitureStore", IsBlueprint = true },
    { BoxItemName = "Cabinet1CornerTight", Store = "FurnitureStore", IsBlueprint = true },
    { BoxItemName = "CounterTop1",         Store = "FurnitureStore", IsBlueprint = true },
    { BoxItemName = "CounterTop1Thin",     Store = "FurnitureStore", IsBlueprint = true },
    { BoxItemName = "CounterTop1Sink",     Store = "FurnitureStore", IsBlueprint = true },
}
]=],
            "LT2ItemList"
        ))()
    end
    dx.LoadModule = function(name)
        local fn = __modules[name]
        if not fn then
            warn("[wood] missing module " .. tostring(name))
            return nil
        end
        local ok, res = pcall(fn)
        if not ok then
            warn("[wood] module error (" .. tostring(name) .. "): " .. tostring(res))
            return nil
        end
        return res
    end
end

-- bridge
dx.Lib = {}
function dx.Lib:Notify(title, text)
    Notify(tostring(title), tostring(text), 3)
end

-- null
local nullObj
nullObj = setmetatable({}, {
    __index = function()
        return function(self)
            return self
        end
    end,
})
dx.Null = nullObj

-- adapter
local flagCount = 0
local function newFlag()
    flagCount = flagCount + 1
    return "dxflag" .. flagCount
end

function dx.MakeTab(luaTab)
    local T = {}
    local cur

    local function sec()
        if not cur then
            cur = luaTab:section("Options", true)
        end
        return cur
    end

    function T:CreateSection(name)
        cur = luaTab:section(tostring(name), true)
        return nullObj
    end

    function T:CreateRow()
        return self
    end

    function T:CreateInfoBox()
        return nullObj
    end

    function T:CreateToggle(title, default, cb)
        local f = sec():Toggle(title, newFlag(), default or false, function(state)
            if cb then
                cb(state and true or false)
            end
        end)
        f.AddTooltip = function(self)
            return self
        end
        f.SetDisabled = function(self) end
        return f
    end

    function T:CreateAction(title, btnText, cb)
        local obj = { Disabled = false }
        local function label(t)
            if t and t ~= "" then
                return title .. "  [" .. t .. "]"
            end
            return title
        end
        local handle = sec():Button(label(btnText), function()
            if obj.Disabled then
                return
            end
            if cb then
                cb()
            end
        end)
        function obj:SetText(t)
            if handle and handle.Btn then
                handle.Btn.Text = label(t)
            end
        end
        function obj:SetFullText(t)
            if handle and handle.Btn then
                handle.Btn.Text = t
            end
        end
        function obj:SetDisabled(d)
            self.Disabled = d and true or false
            if handle and handle.Btn then
                handle.Btn.TextTransparency = d and 0.5 or 0
            end
        end
        function obj:AddTooltip()
            return self
        end
        return obj
    end

    function T:CreateSlider(title, min, max, default, cb, decimals)
        local precise = decimals ~= nil and decimals > 0
        local f = sec():Slider(title, newFlag(), default or min, min, max, precise, function(v)
            if cb then
                cb(v)
            end
        end)
        f.SetDisabled = function(self) end
        return f
    end

    function T:CreateDropdown(title, options, default, cb)
        local list, disabled = {}, {}
        local d
        local function rebuild()
            local o = {}
            for _, n in ipairs(list) do
                if not disabled[n] then
                    o[#o + 1] = n
                end
            end
            d:SetOptions(o)
        end
        d = sec():Dropdown(title, newFlag(), {}, function(v)
            if cb then
                cb(v)
            end
        end)
        for _, n in ipairs(options or {}) do
            list[#list + 1] = tostring(n)
        end
        rebuild()
        local obj = {}
        function obj:SetOptionDisabled(n, state)
            disabled[n] = state and true or nil
            rebuild()
        end
        function obj:AddOption(n, idx)
            n = tostring(n)
            if idx then
                table.insert(list, math.min(idx, #list + 1), n)
            else
                list[#list + 1] = n
            end
            rebuild()
        end
        function obj:RemoveOption(n)
            for i, v in ipairs(list) do
                if v == n then
                    table.remove(list, i)
                    break
                end
            end
            rebuild()
        end
        function obj:SetOptions(o)
            list = {}
            for _, v in ipairs(o) do
                list[#list + 1] = tostring(v)
            end
            rebuild()
        end
        function obj:SetSelected(n)
            d:SetSelected(n)
        end
        if default then
            obj:SetSelected(default)
        end
        return obj
    end

    function T:CreateImageSelector(title, cfg, cb)
        local entries, byDisplay = {}, {}
        local pending = false
        local d
        local function rebuild()
            pending = false
            local o = {}
            byDisplay = {}
            for _, e in ipairs(entries) do
                if e.enabled then
                    local s = e.name .. "  " .. e.price
                    o[#o + 1] = s
                    byDisplay[s] = e.name
                end
            end
            d:SetOptions(o)
        end
        local function queue()
            if not pending then
                pending = true
                task.defer(rebuild)
            end
        end
        d = sec():Dropdown(title, newFlag(), {}, function(v)
            local n = byDisplay[v]
            if n and cb then
                cb(n)
            end
        end, true)
        local obj = {}
        -- custom selector text
        function obj:SetDisplay(text)
            pcall(function()
                d:SetSelected(text)
            end)
        end
        function obj:AddSlot(img, name, price)
            local e = { name = name, price = price or "", enabled = true }
            entries[#entries + 1] = e
            queue()
            local slot = { ImageLabel = { Image = "" } }
            function slot:SetEnabled(en)
                e.enabled = en and true or false
                queue()
            end
            return slot
        end
        return obj
    end

    for _, name in ipairs({ "CreateToggle", "CreateAction", "CreateSlider", "CreateDropdown", "CreateImageSelector" }) do
        local fn = T[name]
        T[name] = function(self, ...)
            local ok, res = pcall(fn, self, ...)
            if ok then
                return res
            end
            warn("[wood] " .. name .. " failed: " .. tostring(res))
            return nullObj
        end
    end

    return T
end

_G.LoadModule = dx.LoadModule
getgenv().LoadModule = dx.LoadModule

dx.ready = false

task.spawn(function()
    _G.LT2Axes = dx.LoadModule("LT2Axes")
    task.wait()
    dx.LOT = dx.LoadModule("LooseObjectTeleport")
    task.wait()
    local ok, err = pcall(function()
        if dx.LOT and dx.LOT.Init then
            dx.LOT.Init(dx.Null, dx.Lib)
        end
    end)
    if not ok then
        warn("[wood] selection init failed: " .. tostring(err))
    end
    task.wait()
    dx.ready = true

    local woodDeadline = tick() + 20
    repeat
        task.wait()
    until dx.woodTab or tick() > woodDeadline
    local woodUi = dx.MakeTab(dx.woodTab)
    local tree = dx.LoadModule("Tree")
    task.wait()
    local ok2, err2 = pcall(function()
        if tree and tree.Init then
            tree.Init(woodUi, dx.LOT)
        end
    end)
    if not ok2 then
        warn("[wood] tree init failed: " .. tostring(err2))
    end

    task.wait()
    local modTree = dx.LoadModule("ModTree")
    task.wait()
    local ok3, err3 = pcall(function()
        if modTree and modTree.Init then
            modTree.Init(woodUi, dx.LOT, dx.Lib)
        end
    end)
    if not ok3 then
        warn("[wood] mod tree init failed: " .. tostring(err3))
    end
end)

-- player
task.wait()
local Player = window:Tab("Player", "6022668898")

local movement = Player:section("Acceleration", true)

movement:Slider("Walkspeed", "Walkspeed Slider", 16, 16, 500, false, function(value)
    getgenv().Speed = value
    speed()
end)

movement:Slider("JumpPower", "JumpPower Slider", 50, 50, 500, false, function(value)
    LocalPlayer.Character.Humanoid.JumpPower = value
end)

movement:Slider("HipHeight", "", 0, 0, 150, false, function(value)
    game.Players.LocalPlayer.Character.Humanoid.HipHeight = value
end)

local movement = Player:section("Humanoid", true)

movement:Keybind("Flight", Enum.KeyCode.Q, function()
    if ToggleFlight then
        ToggleFlight()
    end
end)

game:GetService("UserInputService").JumpRequest:connect(function()
    if getgenv().InfiniteJumpEnabled then
        game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

movement:Toggle("Infinite Jump", "Inf Jump", false, function(state)
    print("Toggled", value)
    getgenv().InfiniteJumpEnabled = state
end)

movement:Toggle("NoClip", "NoClip", false, function(state)
    if state then
        noclip()
    else
        clip()
    end
end)

movement:Button("Safe Death", function()
    SafeSuicide()
end)

movement:Button("Sky Launch", function()
    game.Players.LocalPlayer.Character.Humanoid.HipHeight = "200"
    wait(0.1)
    game.Players.LocalPlayer.Character.Humanoid.HipHeight = "0"
end)

movement:Toggle("Light", "Light", false, function(Value)
    Light(Value)
end)

local misc = Player:section("Tools", true)

misc:Toggle("Hard Dragger", "Dragger", false, function(Value)
    HardDragger(Value)
end)

misc:Toggle("BTools", "", false, function(state)
    if state then
        BTools()
    else
        btoolsdisable()
    end
end)

local camera = Player:section("Camera", true)

camera:Slider("Zoom Distance", "ZOOOOOM OUT!", 128, 128, 2000, false, function(value)
    game:GetService("Players").LocalPlayer.CameraMaxZoomDistance = value
end)

camera:Slider("FOV", "FOV Slider", 70, 70, 120, false, function(value)
    game:GetService("Workspace").Camera.FieldOfView = value
end)

-- world
task.wait()
local WorldTab = window:Tab("World", "6034452648")

local worlds = WorldTab:section("Environment", true)

local nightToggle
local dayToggle = worlds:Toggle("Always Day", "AlwaysDay", false, function(Value)
    Day = Value
    if Value then
        Night = false
        if nightToggle then
            nightToggle:SetState(false)
        end
    end
    RefreshTimeMode()
end)

nightToggle = worlds:Toggle("Always Night", "AlwaysNight", false, function(Value)
    Night = Value
    if Value then
        Day = false
        dayToggle:SetState(false)
    end
    RefreshTimeMode()
end)

worlds:Toggle("Remove Fog", "text", false, function(Value)
    if Value then
        game.Lighting.FogStart = math.huge
        game.Lighting.FogEnd = math.huge
    else
        game.Lighting.FogStart = 0
    end
end)

worlds:Toggle("Shadows", "text", true, function(Value)
    game:GetService("Lighting").GlobalShadows = Value
end)

worlds:Toggle("Spook", "text", false, function(Value)
    game:GetService("Lighting").Spook.Value = Value
end)

worlds:Toggle("Remove Snow Boulders", "text", false, function(Value)
    for i, v in next, game.Workspace.Region_Snow.PartSpawner:GetChildren() do
        if v.Name == "Boulder" then
            if Value then
                v.Transparency = 1
                v.CanCollide = false
            else
                v.Transparency = 0
                v.CanCollide = true
            end
        end
    end
end)

local enhancedOriginal = {}
local function ToggleEnhanced(state)
    local Lighting = game:GetService("Lighting")
    if state then
        enhancedOriginal.Brightness = Lighting.Brightness
        enhancedOriginal.ExposureCompensation = Lighting.ExposureCompensation

        Lighting.Brightness = 3
        Lighting.ExposureCompensation = 0.5

        local bloom = Lighting:FindFirstChild("EnhancedBloom") or Instance.new("BloomEffect", Lighting)
        bloom.Name = "EnhancedBloom"
        bloom.Intensity = 1
        bloom.Size = 24
        bloom.Threshold = 2
        bloom.Enabled = true

        local cc = Lighting:FindFirstChild("EnhancedCC") or Instance.new("ColorCorrectionEffect", Lighting)
        cc.Name = "EnhancedCC"
        cc.Contrast = 0.1
        cc.Saturation = 0.15
        cc.TintColor = Color3.fromRGB(255, 253, 245)
        cc.Enabled = true

        local rays = Lighting:FindFirstChild("EnhancedRays") or Instance.new("SunRaysEffect", Lighting)
        rays.Name = "EnhancedRays"
        rays.Intensity = 0.1
        rays.Spread = 1
        rays.Enabled = true
    else
        Lighting.Brightness = enhancedOriginal.Brightness or 2
        Lighting.ExposureCompensation = enhancedOriginal.ExposureCompensation or 0
        for _, n in ipairs({ "EnhancedBloom", "EnhancedCC", "EnhancedRays" }) do
            local e = Lighting:FindFirstChild(n)
            if e then
                e.Enabled = false
            end
        end
    end
end

worlds:Toggle("Enhanced Visuals", "EnhancedVisuals", false, function(value)
    ToggleEnhanced(value)
end)

worlds:Slider("Brightness", "FOV Slider", 0, 0, 6, false, function(value)
    Brightness(value)
end)

worlds:Slider("Color Strenght", "FOV Slider", 0, 0, 5, false, function(value)
    game:GetService("Lighting").ColorCorrection.Saturation = value
end)

local worlds = WorldTab:section("Miscellienaous", true)

worlds:Toggle("Lower Bridge", "text", false, function(bridge)
    if bridge then
        BridgeDown()
    else
        BridgeUp()
    end
end)

worlds:Button("Better Graphics", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/dTg3MtwM", true))()
end)

local water = WorldTab:section("Water", true)

water:Button("Water GodMode", function()
    game:GetService("Players").LocalPlayer.PlayerGui.Scripts.CharacterFloat:Destroy()
end)

water:Button("Better Water", function()
    for i, v in next, game.Workspace:GetDescendants() do
        if v:IsA("Part") and v.Name == "SeaSand" then
            v.Size = Vector3.new(2048, 60, 2048)
        end
    end

    for i, v in next, game.Workspace:GetDescendants() do
        if v:IsA("Part") and v.Name == "Water" then
            v.Size = Vector3.new(20480, 6, 20080)
            game.Workspace.Terrain:fillBlock(v.CFrame, v.Size, Enum.Material.Water)
            v:Destroy()
        end
    end
end)

water:Toggle("Walk On Water", "text", false, function(value)
    for i, v in next, game.Workspace.Water:GetChildren() do
        if v.Name == "Water" then
            if value then
                v.CanCollide = true
            else
                v.CanCollide = false
            end
        end
    end
end)

water:Toggle("Remove Water", "text", false, function(value)
    for i, v in next, game.Workspace.Water:GetChildren() do
        if v.Name == "Water" then
            if value then
                v.Transparency = 1
            else
                v.Transparency = 0
            end
        end
    end
end)

-- property
task.wait()
local SlotTab = window:Tab("Property", "6035107936")

local fastload = SlotTab:section("Property Loading", true)

fastload:Slider("Slot Number", "", 1, 1, 6, false, function(value)
    slot = value
end)

fastload:Button("Load Base", function()
    LoadSlot(slot)
end)

fastload:Button("Deload Current Base", function()
    game:GetService("ReplicatedStorage").LoadSaveRequests.RequestLoad:InvokeServer(math.huge)
    Notify("Antler", "Succesful! Deloaded Base", 2)
end)

skil = fastload:Toggle("Fast Load", " ", false, function(state)
    if state then
        skipLoading = true
    else
        skipLoading = false
    end
    return skipLoading
end)

fastload:Toggle("Disable Load Teleport", " ", false, function(state)
    if state then
        LoadTeleportOff()
    else
        game.Players.LocalPlayer.Character.Head:Destroy()
    end
end)

local loadtimer = fastload:Label("Canload:")

task.spawn(function()
    while task.wait(0.5) do
        if
            game:GetService("ReplicatedStorage").LoadSaveRequests.ClientMayLoad:InvokeServer(game.Players.LocalPlayer)
        then
            loadtimer.Text = "You Can Load!"
        else
            loadtimer.Text = "You Cannot Load!"
        end
    end
end)

local slot = SlotTab:section("Property", true)

local PropRemotes = game:GetService("ReplicatedStorage"):WaitForChild("PropertyPurchasing")
local autoBuyProp, autoBuyMax = false, false
local propRun, maxRun = 0, 0

local function GetMyProperty()
    for _, p in ipairs(workspace.Properties:GetChildren()) do
        local o = p:FindFirstChild("Owner")
        if o and o.Value == game.Players.LocalPlayer then
            return p
        end
    end
    return nil
end

local function GetFreePlots()
    local t = {}
    for _, p in ipairs(workspace.Properties:GetChildren()) do
        local o = p:FindFirstChild("Owner")
        if p.Name == "Property" and o and o.Value == nil and p:FindFirstChild("OriginSquare") then
            table.insert(t, p)
        end
    end
    return t
end

local function CountLandParts(prop)
    local n = 0
    for _, v in ipairs(prop:GetChildren()) do
        if v:IsA("BasePart") then
            n = n + 1
        end
    end
    return n
end

-- purchase square rules
local function GetExpandSquares(prop)
    local origin = prop:FindFirstChild("OriginSquare")
    if not origin then
        return {}
    end
    local parts = {}
    for _, v in ipairs(prop:GetChildren()) do
        if v:IsA("BasePart") then
            table.insert(parts, v)
        end
    end
    local result = {}
    for _, part in ipairs(parts) do
        for dx = -1, 1 do
            for dz = -1, 1 do
                local cf = part.CFrame * CFrame.new(Vector3.new(dx, 0, dz) * part.Size.X)
                local ok = dx ^ 2 + dz ^ 2 ~= 2
                local rel = origin.CFrame:ToObjectSpace(cf).Position
                if math.abs(rel.X) > part.Size.X * 2.5 or math.abs(rel.Z) > part.Size.Z * 2.5 then
                    ok = false
                end
                if ok then
                    for _, o in ipairs(parts) do
                        if (o.Position - cf.Position).Magnitude < part.Size.X / 2 then
                            ok = false
                            break
                        end
                    end
                end
                if ok then
                    for _, o in ipairs(result) do
                        if (o.Position - cf.Position).Magnitude < part.Size.X / 2 then
                            ok = false
                            break
                        end
                    end
                end
                if ok then
                    table.insert(result, cf)
                end
            end
        end
    end
    return result
end

slot:Button("Buy Property", function()
    -- press again to cancel
    if autoBuyProp then
        autoBuyProp = false
        propRun = propRun + 1
        Notify("Antler", "Property buying cancelled.", 2)
        return
    end
    autoBuyProp = true
    propRun = propRun + 1
    local my = propRun
    task.spawn(function()
        local deadline = tick() + 120
        while autoBuyProp and propRun == my and tick() < deadline do
            if GetMyProperty() then
                Notify("Antler", "You already own a property!", 3)
                break
            end
            local free = GetFreePlots()
            if #free > 0 then
                local plot = free[math.random(#free)]
                pcall(function()
                    PropRemotes.ClientPurchasedProperty:FireServer(plot, plot.OriginSquare.Position)
                end)
                local waitUntil = tick() + 3
                repeat
                    task.wait(0.1)
                until GetMyProperty() or tick() > waitUntil
                if GetMyProperty() then
                    Notify("Antler", "Property purchased!", 3)
                    break
                end
            end
            task.wait(1)
        end
        if propRun == my then
            autoBuyProp = false
        end
    end)
end)

slot:Button("Buy Max Land", function()
    -- press again to cancel
    if autoBuyMax then
        autoBuyMax = false
        maxRun = maxRun + 1
        Notify("Antler", "Land buying cancelled.", 2)
        return
    end
    autoBuyMax = true
    maxRun = maxRun + 1
    local my = maxRun
    task.spawn(function()
        local fails = 0
        while autoBuyMax and maxRun == my do
            local prop = GetMyProperty()
            if not prop then
                Notify("Antler", "You don't own a property yet!", 3)
                break
            end
            local squares = GetExpandSquares(prop)
            if #squares == 0 then
                Notify("Antler", "Your land is already maxed!", 3)
                break
            end
            local before = CountLandParts(prop)
            pcall(function()
                PropRemotes.ClientExpandedProperty:FireServer(prop, squares[1])
            end)
            local waitUntil = tick() + 3
            repeat
                task.wait(0.1)
            until CountLandParts(prop) ~= before or tick() > waitUntil
            if CountLandParts(prop) == before then
                fails = fails + 1
                if fails >= 3 then
                    Notify("Antler", "Couldn't buy more land (not enough money?)", 4)
                    break
                end
            else
                fails = 0
            end
            task.wait(0.3)
        end
        if maxRun == my then
            autoBuyMax = false
        end
    end)
end)

slot:Button("Sell Sold Sign", function()
    SellSoldSign()
end)

slot:Button("Teleport To Base", function()
    TeleportToBase()
end)

-- waypoints
task.wait()
local TeleportTab = window:Tab("Waypoints", "2790556871")

local teleports = TeleportTab:section("Locations", true)

teleports:Dropdown("Teleport to Area", "Location", locations, function(Value)
    local WaypointsPositions = {
        ["The Den"] = CFrame.new(323, 49, 1930),
        ["Lighthouse"] = CFrame.new(1464.8, 356.3, 3257.2),
        ["Safari"] = CFrame.new(111.853, 11.0005, -998.805),
        ["Bridge"] = CFrame.new(112.308, 11.0005, -782.358),
        ["Bob's Shack"] = CFrame.new(260, 8, -2542),
        ["EndTimes Cave"] = CFrame.new(113, -214, -951),
        ["The Swamp"] = CFrame.new(-1209, 132, -801),
        ["The Cabin"] = CFrame.new(1244, 66, 2306),
        ["Volcano"] = CFrame.new(-1585, 625, 1140),
        ["Boxed Cars"] = CFrame.new(509, 5.2, -1463),
        ["Tiaga Peak"] = CFrame.new(1560, 410, 3274),
        ["Land Store"] = CFrame.new(258, 5, -99),
        ["Link's Logic"] = CFrame.new(4605, 3, -727),
        ["Palm Island"] = CFrame.new(2549, -5, -42),
        ["Palm Island 2"] = CFrame.new(1960, -5.900, -1501),
        ["Palm Island 3"] = CFrame.new(4344, -5.900, -1813),
        ["Fine Art Shop"] = CFrame.new(5207, -166, 719),
        ["SnowGlow Biome"] = CFrame.new(-1086.85, -5.89978, -945.316),
        ["Cave"] = CFrame.new(3581, -179, 430),
        ["Shrine Of Sight"] = CFrame.new(-1600, 195, 919),
        ["Fancy Furnishings"] = CFrame.new(491, 13, -1720),
        ["Docks"] = CFrame.new(1114, 3.2, -197),
        ["Strange Man"] = CFrame.new(1061, 20, 1131),
        ["Wood Dropoff"] = CFrame.new(323.406, -2.8, 134.734),
        ["Snow Biome"] = CFrame.new(889.955, 59.7999, 1195.55),
        ["Wood RUs"] = CFrame.new(265, 5, 57),
        ["Green Box"] = CFrame.new(-1668.05, 351.174, 1475.39),
        ["Spawn"] = CFrame.new(172, 2, 74),
        ["Cherry Meadow"] = CFrame.new(220.9, 59.8, 1305.8),
        ["Bird Cave"] = CFrame.new(4813.1, 33.5, -978.8),
    }
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = WaypointsPositions[Value]
end)

local teleports = TeleportTab:section("Teleport to Player", true)

teleports:Dropdown("Choose Player", "Player Name", AllPlayers, function(Value)
    TeleportToPlayer(Value)
end)

local teleports = TeleportTab:section("Teleport to Players Base", true)

teleports:Dropdown("Select Player Base", "Player", AllPlayers, function(Value)
    TeleportToBase(Value)
end)

-- auto buy
task.wait()
dx.shopTab = window:Tab("Auto Buy", "6031265976")

-- auto buy wood
dx.woodTab = window:Tab("Wood", "6034503369")

task.spawn(function()
    local deadline = tick() + 20
    repeat
        task.wait()
    until dx.ready or tick() > deadline
    task.wait(1)
    local shop = dx.LoadModule("Shop")
    dx.Shop = shop
    local ok, err = pcall(function()
        if shop and shop.Init then
            shop.Init(dx.MakeTab(dx.shopTab), dx.LOT)
        end
    end)
    if not ok then
        warn("[auto buy] shop init failed: " .. tostring(err))
    end
end)

-- vehicle
task.wait()
local VehTab = window:Tab("Vehicle", "6034744029")

local veh = VehTab:section("Vehicle Adjusments", true)

veh:Slider("Vehicle Speed", "", 1, 1, 5, false, function(Val)
    VehicleSpeed(Val)
end)

veh:Slider("Vehicle Fly Speed", "", 5, 5, 50, false, function(value)
    iyflyspeed = value
    vehicleflyspeed = value
end)

local veh = VehTab:section("Vehicle Modifications", true)

veh:Toggle("Vehicle Fly", " ", false, function(v)
    if v == true then
        player = game.Players.LocalPlayer
        humanoid = player.Character.Humanoid
        if humanoid.Seated then
            local CurrentSeat = player.Character.Humanoid.SeatPart
            if CurrentSeat and CurrentSeat.Parent.Type.Value == "Vehicle" then
                nf()
                wait()
                sFLY(true)
            end
        end
    else
        nf()
    end
end)

veh:Button("Flip Vehicle", function()
    flip()
end)

veh:Button("Sit in Any Vehicle", function()
    anyvehicle()
end)

colorcarselceted = {
    "Silver",
    "Dark red",
    "Sand red",
    "Sand yellow metalic",
    "Lemon metalic",
    "Gun metalic",
    "Earth orange",
    "Earth yellow",
    "Brick yellow",
    "Rust",
    "Really black",
    "Faded green",
    "Sand green",
    "Black metalic",
    "Dark grey metallic",
    "Dark grey",
    "Hot pink",
    "Medium stone grey",
    "Mid grey",
}

local vehcolorspawner = VehTab:section("Vehicle Spawner", true)

local selectcolcar
local text = true
local abortspawn = false
local clickcar

vehcolorspawner:Dropdown("Car Colors", "Car Colors", colorcarselceted, function(SelectColour)
    selectcolcar = SelectColour
end)

vehcolorspawner:Button("Start Vehicle Spawner", function(v)
    if v then
        Notify("Vehicle Spawner", "Select Vehicle!", 4)
        local clicktoselect
        clicktoselect = Mouse.Button1Up:Connect(function()
            if Mouse.Target and Mouse.Target.Parent.Type and Mouse.Target.Parent.Type.Value == "Vehicle Spot" then
                local bob = Instance.new("SelectionBox", Mouse.Target.Parent)
                bob.Name = "Selection"
                bob.Adornee = bob.Parent
                bob.SurfaceTransparency = 1
                bob.LineThickness = 0.02
                bob.SurfaceColor3 = Color3.fromRGB(0, 0, 0)
                bob.Color3 = Color3.fromRGB(255, 255, 255)
                clickcar = Mouse.Target.Parent:FindFirstChild("ButtonRemote_SpawnButton", true)
            end
        end)
        repeat
            task.wait()
        until clickcar ~= nil
        clicktoselect:Disconnect()
        clicktoselect = nil
        local Car
        local a = game:GetService("Workspace").PlayerModels.ChildAdded:connect(function(v)
            v:WaitForChild("Owner")
            if v:WaitForChild("PaintParts") and v.Owner.Value == game.Players.LocalPlayer then
                Car = v.PaintParts.Part
            end
        end)
        local oldcolor
        repeat
            task.wait(0.45)
            game.ReplicatedStorage.Interaction.RemoteProxy:FireServer(clickcar)
            repeat
                wait()
            until Car ~= oldcolor
            oldcolor = Car
        until Car.BrickColor.Name == selectcolcar or abortspawn == false
    else
        test = true
    end
end)

vehcolorspawner:Button("Abort", function()
    abortspawn = false
    wait(0.5)
    abortspawn = true
end)

-- build
task.wait()
local BuildTab = window:Tab("Build", "6035067834")
local function InitBuilder()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local LocalPlayer = Players.LocalPlayer

    -- state
    local BuilderOn = false
    local ToolMode = "Move" -- move or rotate
    local AxesMode = "World" -- world or local
    local MoveStep = 0 -- stud snap, 0 is free
    local SnapAngle = 0 -- degree snap, 0 is free
    local KeepOriginal = false -- keep original
    local HoldToSelect = true -- hold to select
    local HoldTime = 0.4 -- hold time
    local BuildFor = LocalPlayer -- plot owner
    local GridSnap = false -- plot grid snap
    local AlignMode = "Center All"
    local history = {} -- undo history

    local selected -- selected model
    local fresh = nil -- spawned blueprint or build
    local PlaceGroup -- placing a build file
    local fileBuild = false -- positioning a build file
    local groupToken = 0
    local origCF -- reference cframe
    local targetCF -- ghost cframe
    local ghost -- preview clone
    local ghostRadius = 4
    local placing = false
    local drag = nil -- active drag
    local hdrag = nil -- held handle
    local tapStart = nil

    -- clean up old load
    for _, n in ipairs({ "AntlerBuilderGhost" }) do
        local old = workspace:FindFirstChild(n)
        if old then
            old:Destroy()
        end
    end
    local ghostFolder = Instance.new("Folder")
    ghostFolder.Name = "AntlerBuilderGhost"
    ghostFolder.Parent = workspace

    -- hidden holder for blueprint reference
    local oldRef = ReplicatedStorage:FindFirstChild("AntlerBuilderRef")
    if oldRef then
        oldRef:Destroy()
    end
    local refFolder = Instance.new("Folder")
    refFolder.Name = "AntlerBuilderRef"
    refFolder.Parent = ReplicatedStorage

    -- align target
    local alignTarget, alignBox
    local pickingTarget = false
    local function ClearAlignTarget()
        alignTarget, pickingTarget = nil, false
        if alignBox then
            alignBox:Destroy()
            alignBox = nil
        end
    end
    local function SetAlignTarget(model)
        ClearAlignTarget()
        alignTarget = model
        local h = Instance.new("Highlight")
        h.Adornee = model
        h.FillTransparency = 1
        h.OutlineColor = Color3.fromRGB(0, 220, 255)
        h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        h.Parent = ghostFolder
        alignBox = h
    end

    -- item helpers
    local function GetItemName(model)
        local obj = model:FindFirstChild("ItemName")
        if obj and tostring(obj.Value) ~= "" then
            return tostring(obj.Value)
        end
        return model.Name
    end

    local function GetStructureCFrame(model)
        return (model.PrimaryPart and model.PrimaryPart.CFrame)
            or (model:FindFirstChild("MainCFrame") and model.MainCFrame.Value)
            or (model:FindFirstChild("BuildDependentWood") and model.BuildDependentWood.CFrame)
            or model:GetPivot()
    end

    -- 4th argument is the wood class
    local function TreeValueOf(model)
        local bwc = model:FindFirstChild("BlueprintWoodClass")
        if bwc then
            return bwc.Value
        end
        return nil
    end

    local function IsMine(model)
        local ownerFolder = model:FindFirstChild("Owner")
        if not ownerFolder then
            return false
        end
        local ownerStr = ownerFolder:FindFirstChild("OwnerString")
        return ownerFolder.Value == LocalPlayer or (ownerStr ~= nil and ownerStr.Value == LocalPlayer.Name)
    end

    -- plot owner, falls back to you
    local function PlotOwner()
        if BuildFor and BuildFor.Parent then
            return BuildFor
        end
        BuildFor = LocalPlayer
        return LocalPlayer
    end

    -- model owned by us or the plot owner
    local function IsMineOrPlot(model)
        if IsMine(model) then
            return true
        end
        local ownerFolder = model:FindFirstChild("Owner")
        if not ownerFolder then
            return false
        end
        local po = PlotOwner()
        local ownerStr = ownerFolder:FindFirstChild("OwnerString")
        return ownerFolder.Value == po or (ownerStr ~= nil and ownerStr.Value == po.Name)
    end

    -- use the game's move check
    local permission
    pcall(function()
        permission = require(ReplicatedStorage:WaitForChild("Interaction", 5):WaitForChild("InteractionPermission", 5))
    end)
    local function CanMove(model)
        if permission then
            local ok, res = pcall(function()
                return permission:UserCanInteract(LocalPlayer, model, "MoveStructure")
            end)
            if ok then
                return res and true or false
            end
        end
        return IsMine(model)
    end

    -- structure, furniture, blueprint or nil
    local function KindOf(model)
        if model:FindFirstChild("PurchasedBoxItemName") then
            return nil
        end
        local typeVal = model:FindFirstChild("Type")
        local v = typeVal and typeVal.Value
        if v == "Structure" or v == "Vehicle Spot" then
            return "Structure"
        end
        if v == "Furniture" then
            return "Furniture"
        end
        if v == "Blueprint" then
            return "Blueprint"
        end
        return nil
    end

    local function ModelFromPart(part)
        local pm = workspace:FindFirstChild("PlayerModels")
        if not pm then
            return nil
        end
        local m = part
        while m and m.Parent ~= pm do
            m = m.Parent
        end
        if m and m:IsA("Model") then
            return m
        end
        return nil
    end

    -- ghost
    local function ClearGhost()
        if ghost then
            ghost:Destroy()
            ghost = nil
        end
    end

    local function UpdateGhost()
        if ghost and selected and selected.Parent and origCF and targetCF then
            local delta = targetCF * origCF:Inverse()
            ghost:PivotTo(delta * selected:GetPivot())
        end
    end

    local function MakeGhost(model)
        local c = model:Clone()
        local function soften(d)
            d.Anchored = true
            d.CanCollide = false
            d.CanTouch = false
            d.CanQuery = false
            d.CastShadow = false
            if d.Transparency < 0.5 then
                d.Transparency = 0.5
            end
        end
        if c:IsA("BasePart") then
            soften(c)
        end
        for _, d in ipairs(c:GetDescendants()) do
            if d:IsA("BasePart") then
                soften(d)
            elseif d:IsA("LuaSourceContainer") or d:IsA("Sound") then
                d:Destroy()
            end
        end
        c.Parent = ghostFolder
        local ok, size = pcall(function()
            return c:GetExtentsSize()
        end)
        ghostRadius = (ok and size) and math.max(size.Magnitude / 2, 2) or 4
        return c
    end

    local function DropFresh()
        fileBuild = false
        groupToken = groupToken + 1 -- stop build in progress
        if fresh then
            pcall(function()
                fresh.ref:Destroy()
            end)
            fresh = nil
        end
    end

    local function ClearSelection()
        DropFresh()
        history = {}
        drag = nil
        hdrag = nil
        selected = nil
        origCF = nil
        targetCF = nil
        ClearGhost()
    end

    local function SelectModel(model)
        DropFresh()
        history = {}
        ClearGhost()
        selected = model
        origCF = GetStructureCFrame(model)
        targetCF = origCF
        ghost = MakeGhost(model)
        UpdateGhost()
    end

    -- spawn blueprint
    local function SpawnBlueprint(name)
        local items = ReplicatedStorage:FindFirstChild("ClientItemInfo")
        local info = items and items:FindFirstChild(name)
        local tpl = info and (info:FindFirstChild("PlacingModel") or info:FindFirstChild("Model"))
        if not tpl then
            Notify("Antler", "Couldn't find the model for " .. name, 3)
            return false
        end

        ClearSelection() -- drop earlier blueprint

        local ref = tpl:Clone()
        for _, d in ipairs(ref:GetDescendants()) do
            if d:IsA("LuaSourceContainer") or d:IsA("Sound") then
                d:Destroy()
            end
        end
        ref.Parent = refFolder

        local cam = workspace.CurrentCamera
        local char = LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local base = root and root.Position or (cam and cam.CFrame.Position) or Vector3.zero
        local look = root and root.CFrame.LookVector or (cam and cam.CFrame.LookVector) or Vector3.new(0, 0, -1)
        local flat = Vector3.new(look.X, 0, look.Z)
        flat = (flat.Magnitude > 0.01) and flat.Unit or Vector3.new(0, 0, -1)
        local pos = base + flat * 12

        local params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Exclude
        params.FilterDescendantsInstances = { ghostFolder, char }
        local hit = workspace:Raycast(pos + Vector3.new(0, 60, 0), Vector3.new(0, -200, 0), params)

        local okB, bbCF, bbSize = pcall(function()
            return ref:GetBoundingBox()
        end)
        local ref0 = GetStructureCFrame(ref)
        local ground = hit and hit.Position.Y or pos.Y
        local half = (okB and bbSize) and bbSize.Y / 2 or 2
        local center = Vector3.new(pos.X, ground + half, pos.Z)

        fresh = {
            name = name,
            ref = ref,
            respawn = function()
                SpawnBlueprint(name)
            end,
        }
        selected = ref
        origCF = ref0
        targetCF = ref0 + (center - ((okB and bbCF) and bbCF.Position or ref0.Position))
        ghost = MakeGhost(ref)
        UpdateGhost()
        return true
    end

    -- grid snap and align
    local GRID = 2.5 -- grid cell size
    local plotSquares, plotTime = {}, 0

    local function RefreshPlot()
        if tick() - plotTime < 2 and #plotSquares > 0 then
            return
        end
        plotTime = tick()
        plotSquares = {}
        local props = workspace:FindFirstChild("Properties")
        for _, prop in ipairs(props and props:GetChildren() or {}) do
            local owner = prop:FindFirstChild("Owner")
            if owner and owner.Value == PlotOwner() then
                for _, sq in ipairs(prop:GetChildren()) do
                    if sq:IsA("BasePart") then
                        table.insert(plotSquares, sq)
                    end
                end
                break
            end
        end
    end

    local function GetBox(model)
        local ok, cf, size = pcall(model.GetBoundingBox, model)
        if ok then
            return cf, size
        end
    end

    -- half box size per axis
    local function BoxInFrame(boxCF, boxSize, F)
        local R = boxCF.Rotation
        local axes = { R.XVector, R.YVector, R.ZVector }
        local fx = { F.XVector, F.YVector, F.ZVector }
        local s = { boxSize.X, boxSize.Y, boxSize.Z }
        local half = {}
        for i = 1, 3 do
            local h = 0
            for j = 1, 3 do
                h = h + math.abs(fx[i]:Dot(axes[j])) * s[j] / 2
            end
            half[i] = h
        end
        return half
    end

    -- snap edges to grid
    local function ApplyGrid(dir, ghostFresh)
        if not (GridSnap and ghost and selected and targetCF) then
            return
        end
        if not ghostFresh then
            UpdateGhost()
        end
        local bbCF, bbSize = GetBox(ghost)
        if not bbCF then
            return
        end
        RefreshPlot()

        local c = bbCF.Position
        local sq, best = nil, math.huge
        for _, s in ipairs(plotSquares) do
            if s.Parent then
                local lp = s.CFrame:PointToObjectSpace(c)
                local dx = math.max(math.abs(lp.X) - s.Size.X / 2, 0)
                local dz = math.max(math.abs(lp.Z) - s.Size.Z / 2, 0)
                local d = dx * dx + dz * dz
                if d < best then
                    best, sq = d, s
                end
            end
        end
        if not sq then
            return
        end

        local half = BoxInFrame(bbCF, bbSize, sq.CFrame.Rotation)
        local lp = sq.CFrame:PointToObjectSpace(c)
        local function snap(v, halfExt, halfPlot)
            local lo = (v - halfExt) + halfPlot -- low edge from plot corner
            lo = math.floor(lo / GRID + 0.5) * GRID
            return lo + halfExt - halfPlot
        end
        local nx, nz = lp.X, lp.Z
        if not dir or math.abs(dir:Dot(sq.CFrame.XVector)) > 0.1 then
            nx = snap(lp.X, half[1], sq.Size.X / 2)
        end
        if not dir or math.abs(dir:Dot(sq.CFrame.ZVector)) > 0.1 then
            nz = snap(lp.Z, half[3], sq.Size.Z / 2)
        end

        local world = sq.CFrame:PointToWorldSpace(Vector3.new(nx, lp.Y, nz))
        targetCF = targetCF + (world - c)
        UpdateGhost()
    end

    local function PushHistory(cf)
        table.insert(history, cf or targetCF)
        if #history > 30 then
            table.remove(history, 1)
        end
    end

    local function Undo()
        local prev = table.remove(history)
        if not (prev and selected and selected.Parent) then
            return false
        end
        targetCF = prev
        UpdateGhost()
        return true
    end

    -- align to target
    local function DoAlign(mode)
        if not (selected and selected.Parent and ghost and targetCF) then
            Notify("Antler", "Select an item first.", 2)
            return
        end
        if not (alignTarget and alignTarget.Parent) then
            Notify("Antler", "Pick an align target first.", 2)
            return
        end
        PushHistory()
        UpdateGhost()
        local refCF, refSize = GetBox(alignTarget)
        local selCF, selSize = GetBox(ghost)
        if not (refCF and selCF) then
            return
        end

        if mode == "Match Rotation" then
            local before = selCF.Position
            targetCF = CFrame.new(targetCF.Position) * GetStructureCFrame(alignTarget).Rotation
            UpdateGhost()
            local afterCF = GetBox(ghost)
            if afterCF then
                targetCF = targetCF + (before - afterCF.Position)
            end
            UpdateGhost()
            return
        end

        local F = (AxesMode == "Local") and refCF.Rotation or CFrame.new()
        local fAxes = { F.XVector, F.YVector, F.ZVector }
        local refHalf = BoxInFrame(refCF, refSize, F)
        local selHalf = BoxInFrame(selCF, selSize, F)
        local d = selCF.Position - refCF.Position
        local idx = { X = 1, Y = 2, Z = 3 }
        local move = Vector3.new()

        local cAxis = mode:match("^Center (%u)$")
        local sign, tAxis = mode:match("^Touch ([%+%-])(%u)$")
        if mode == "Center All" then
            for i = 1, 3 do
                move = move - fAxes[i] * d:Dot(fAxes[i])
            end
        elseif cAxis then
            local i = idx[cAxis]
            move = -fAxes[i] * d:Dot(fAxes[i])
        elseif tAxis then
            local i = idx[tAxis]
            local want = (sign == "+" and 1 or -1) * (refHalf[i] + selHalf[i])
            move = fAxes[i] * (want - d:Dot(fAxes[i]))
        end
        targetCF = targetCF + move
        UpdateGhost()
    end

    -- handles
    local GuiService = game:GetService("GuiService")
    local Camera = workspace.CurrentCamera

    -- clean up old load
    pcall(function()
        local pg = LocalPlayer:FindFirstChild("PlayerGui")
        local oldGui = pg and pg:FindFirstChild("AntlerBuilderHandles")
        if oldGui then
            oldGui:Destroy()
        end
        local oldProxy = Camera and Camera:FindFirstChild("AntlerBuilderProxy")
        if oldProxy then
            oldProxy:Destroy()
        end
    end)

    local HANDLE_MIN_PX = 12
    local MOVE_COLOR = Color3.fromRGB(0, 100, 255)
    local AXIS_COLORS = { X = Color3.new(1, 0, 0), Y = Color3.new(0, 1, 0), Z = Color3.new(0, 0, 1) }
    local SideToAxis = { Top = "Z", Bottom = "Z", Left = "Y", Right = "Y", Front = "X", Back = "X" }
    local AxisToSide = { X = "Front", Y = "Right", Z = "Top" }

    local gui = Instance.new("ScreenGui")
    gui.Name = "AntlerBuilderHandles"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.DisplayOrder = 998
    gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    -- part the handles draw on
    local proxy = Instance.new("Part")
    proxy.Name = "AntlerBuilderProxy"
    proxy.Anchored = true
    proxy.CanCollide = false
    proxy.CanQuery = false
    proxy.CanTouch = false
    proxy.Transparency = 1
    proxy.Parent = Camera

    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Exclude

    local moveBtns, arcBtns = {}, {}
    local circles, arrows = {}, {}
    local hstates, hflags = {}, {}
    local hCF, hSize -- handle frame and size
    local arrowsFolder = Instance.new("Folder")
    arrowsFolder.Name = "MoveArrows"
    local circlesFolder = Instance.new("Folder")
    circlesFolder.Name = "AxisCircles"
    local conns = {}

    local function incMultiple(n, inc)
        if inc <= 0 then
            return n
        end
        local diff = n % inc
        local lower = n - diff
        local upper = lower + inc
        if math.abs(n - lower) <= math.abs(n - upper) then
            return lower
        end
        return upper
    end

    local function touchScale()
        return UserInputService.MouseEnabled and 1 or 1.6
    end

    local function pxToWorld(depth)
        return math.tan(math.rad(Camera.FieldOfView) / 2) * 2 * depth / Camera.ViewportSize.X * 14
    end

    local function toViewport(point)
        local v, on = Camera:WorldToViewportPoint(point)
        local p = Vector2.new(v.X, v.Y)
        if v.Z < 0 then
            p = Camera.ViewportSize - p
        end
        return p, v.Z, on
    end

    local function handleSize(depth)
        local studWidth = 2 * math.tan(math.rad(Camera.FieldOfView) / 2) * depth
        local pxPerStud = Camera.ViewportSize.X / studWidth
        local s = math.max(HANDLE_MIN_PX, 0.5 * pxPerStud) * touchScale()
        if s ~= s then
            return HANDLE_MIN_PX
        end
        return math.min(s, 150)
    end

    local function makeArrow(color)
        local arrow = { head = {}, color = color }
        local function cyl()
            local c = Instance.new("CylinderHandleAdornment")
            c.Adornee = proxy
            c.AlwaysOnTop = true
            c.ZIndex = 1
            c.Color3 = color
            c.Transparency = 0.1
            c.Radius, c.Height = 0, 0
            c.Visible = false
            c.Parent = arrowsFolder
            return c
        end
        arrow.shaft = cyl()
        for i = 1, 24 do
            arrow.head[i] = cyl()
        end
        return arrow
    end

    local function styleHandle(btn)
        local fl = hflags[btn]
        if not fl then
            return
        end
        if btn:GetAttribute("HitOnly") then
            local arrow = arrows[btn]
            if arrow then
                local col = arrow.color
                if fl.hover or fl.press then
                    col = col:Lerp(Color3.new(1, 1, 1), 0.45)
                end
                local tr = fl.blocked and 0.8 or (fl.press and 0 or 0.1)
                arrow.shaft.Color3, arrow.shaft.Transparency = col, tr
                for _, c in ipairs(arrow.head) do
                    c.Color3, c.Transparency = col, tr
                end
            end
            return
        end
        local t = 0.33
        if fl.hover or fl.press then
            t = 0
        end
        if fl.blocked then
            t = 0.85
        end
        btn.BackgroundTransparency = t
        btn.TextTransparency = t
        local sc = btn:FindFirstChild("UIScale")
        if sc then
            sc.Scale = fl.press and 0.85 or 1
        end
    end

    local function setFlag(btn, key, value)
        local fl = hflags[btn]
        if not fl then
            fl = {}
            hflags[btn] = fl
        end
        if fl[key] == value then
            return
        end
        fl[key] = value
        styleHandle(btn)
    end

    local function checkObstacle(btn, pos2, depth)
        local ray = Camera:ViewportPointToRay(pos2.X, pos2.Y)
        local hit = workspace:Raycast(ray.Origin, ray.Direction * (depth - 0.25), rayParams)
        setFlag(btn, "blocked", hit ~= nil)
    end

    local function makeHandle(text, color, name)
        local btn = Instance.new("TextButton")
        btn.Name = name
        btn.AnchorPoint = Vector2.new(0.5, 0.5)
        btn.Size = UDim2.fromOffset(HANDLE_MIN_PX, HANDLE_MIN_PX)
        btn.BackgroundColor3 = color
        btn.BackgroundTransparency = 0.33
        btn.Text = text
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 14
        btn.AutoButtonColor = false
        btn.Interactable = true
        btn.Visible = false
        btn.ZIndex = 1
        btn.Parent = gui
        Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
        local grad = Instance.new("UIGradient", btn)
        grad.Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.fromRGB(190, 190, 190))
        grad.Rotation = 90
        Instance.new("UIScale", btn)

        if text == ">" then
            -- move handle
            btn.Text = ""
            btn.BackgroundTransparency = 1
            btn:SetAttribute("HitOnly", true)
        else
            btn.TextScaled = true
            local pad = Instance.new("UIPadding", btn)
            pad.PaddingLeft, pad.PaddingRight = UDim.new(0.2, 0), UDim.new(0.2, 0)
            pad.PaddingTop, pad.PaddingBottom = UDim.new(0.2, 0), UDim.new(0.2, 0)
        end

        hflags[btn] = {}
        return btn
    end

    -- handle frame
    local function HandleFrame()
        local s = ghostRadius * 1.5
        local size = Vector3.new(s, s, s)
        if AxesMode == "Local" then
            return targetCF, size
        end
        return CFrame.new(targetCF.Position), size
    end

    local function updateMoveHandle(btn, face)
        local cf, size = hCF, hSize
        local n = Vector3.FromNormalId(face)
        local half = (size * n / 2).Magnitude
        local faceVP, faceDepth = toViewport((cf * CFrame.new(half * n)).Position)
        local dist = half + math.max(2 * (math.max(1, pxToWorld(faceDepth)) * touchScale()), size.Magnitude * 0.15)
        local hcf = cf * CFrame.new(dist * n)
        local hVP, hDepth, onScreen = toViewport(hcf.Position)

        btn.Visible = onScreen
        -- handle sizing
        local px = handleSize(hDepth)
        local Lpx = math.clamp(px * 4, 48, 170)
        -- tap area
        local hit = math.clamp(Lpx * 0.8, 44, 90) * (UserInputService.MouseEnabled and 1 or 1.3)
        local midVP = toViewport((cf * CFrame.new((dist + Lpx * (pxToWorld(hDepth) / 14) * 0.4) * n)).Position)
        btn.Size = UDim2.fromOffset(hit, hit)
        btn.Position = UDim2.fromOffset(midVP.X, midVP.Y)

        local arrow = arrows[btn]
        if arrow then
            local L = Lpx * (pxToWorld(hDepth) / 14)
            if not onScreen or L ~= L or L <= 0 then
                arrow.shaft.Visible = false
                for _, c in ipairs(arrow.head) do
                    c.Visible = false
                end
            else
                local up = (math.abs(n.Y) > 0.9) and Vector3.xAxis or Vector3.yAxis
                local function put(c, along, len, radius)
                    local p = n * (dist - L * 0.1 + along + len / 2)
                    c.CFrame = CFrame.lookAt(p, p + n, up)
                    c.Height, c.Radius = len, radius
                    c.Visible = true
                end
                local shaftLen, headLen = L * 0.78, L * 0.22
                put(arrow.shaft, 0, shaftLen, L * 0.016)
                local steps = #arrow.head
                local seg = headLen / steps
                for i, c in ipairs(arrow.head) do
                    put(c, shaftLen + (i - 1) * seg, seg * 1.2, L * 0.07 * (1 - (i - 0.5) / steps))
                end
            end
        end

        local d = hVP - faceVP
        if d.Magnitude > 0.001 then
            btn.Rotation = math.deg(math.atan2(d.Y, d.X))
        end

        local st = hstates[btn] or {}
        hstates[btn] = st
        st.PlaneNormal = (face == Enum.NormalId.Top or face == Enum.NormalId.Bottom) and cf.LookVector or cf.UpVector
        st.HandleCFrame = hcf
        st.HandleNormal = (hcf.Position - cf.Position).Unit
        st.AdorneeVP = faceVP
        st.HandleVP = hVP
        checkObstacle(btn, hVP, hDepth)
    end

    local function updateArcHandle(btn, face)
        local cf, size = hCF, hSize
        local _, depth = toViewport(cf.Position)
        local radius = size.Magnitude / 2 + 2 * (math.max(1, pxToWorld(depth)) * touchScale())
        local hcf = cf * CFrame.new(radius * Vector3.FromNormalId(face))
        local hVP, hDepth, onScreen = toViewport(hcf.Position)

        btn.Visible = onScreen
        local px = handleSize(hDepth)
        local hit = px + (UserInputService.MouseEnabled and 0 or 6)
        btn.Size = UDim2.fromOffset(hit, hit)
        btn.Position = UDim2.fromOffset(hVP.X, hVP.Y)

        local st = hstates[btn] or {}
        hstates[btn] = st
        st.HandleCFrame = hcf
        st.PlaneNormal = (cf * Vector3.FromAxis(Enum.Axis[SideToAxis[face.Name]]) - cf.Position).Unit
        st.AdorneeCFrame = cf
        checkObstacle(btn, hVP, hDepth)
    end

    local function updateCircle(axisName, slices)
        local cf, size = hCF, hSize
        local axisVec = Vector3.FromAxis(Enum.Axis[axisName])
        local sideVec = Vector3.FromNormalId(Enum.NormalId[AxisToSide[axisName]])
        local _, depth = toViewport(cf.Position)
        local radius = size.Magnitude / 2 + 2 * (math.max(1, pxToWorld(depth)) * touchScale())
        local step = 2 * math.pi / #slices
        local tanHalf = math.tan(math.rad(Camera.FieldOfView) / 2)
        for i, adorn in ipairs(slices) do
            local a = CFrame.fromAxisAngle(axisVec, step * (i - 1)) * (sideVec * radius)
            local b = CFrame.fromAxisAngle(axisVec, step * i) * (sideVec * radius)
            local mid = a:Lerp(b, 0.5)
            local _, d = toViewport(cf * mid)
            adorn.Radius = 1.5 * (tanHalf * 2 * d / Camera.ViewportSize.X) / 2
            adorn.CFrame = CFrame.new(mid, b) * CFrame.new(0, 0, adorn.Radius / 2)
            adorn.Height = (b - a).Magnitude
        end
    end

    -- drag
    local function onMoveDrag(face, dist)
        local d = drag
        if not d or not selected then
            return
        end
        if not d.pushed then
            d.pushed = true
            PushHistory(d.startCF)
        end
        dist = incMultiple(dist, MoveStep)
        local dir = d.hCF:VectorToWorldSpace(Vector3.FromNormalId(face))
        targetCF = d.startCF + dir * dist
        UpdateGhost()
        if GridSnap then
            ApplyGrid(dir, true)
        end
    end

    local function onRotateDrag(axisName, rotation)
        local d = drag
        if not d or not selected then
            return
        end
        if not d.pushed then
            d.pushed = true
            PushHistory(d.startCF)
        end
        local deg = incMultiple(math.deg(rotation), SnapAngle) % 360
        local rad = math.rad(deg)
        if AxesMode == "Local" then
            targetCF = d.startCF * CFrame.fromAxisAngle(Vector3.FromAxis(Enum.Axis[axisName]), rad)
        else
            targetCF = CFrame.fromAxisAngle(Vector3.FromAxis(Enum.Axis[axisName]), rad)
                    * (d.startCF - d.startCF.Position)
                + d.startCF.Position
        end
        UpdateGhost()
    end

    local function finishHandleDrag()
        for _, k in ipairs({ "dragMove", "btnMove", "dragEnd" }) do
            if conns[k] then
                conns[k]:Disconnect()
                conns[k] = nil
            end
        end
        local h = hdrag
        hdrag = nil
        drag = nil
        if h and h.btn then
            setFlag(h.btn, "press", false)
            if not UserInputService.MouseEnabled then
                setFlag(h.btn, "hover", false)
                if h.axisName then
                    for _, c in ipairs(circles[h.axisName]) do
                        c.Transparency = 0.4
                    end
                end
            end
        end
    end

    local function beginHandleDrag(kind, btn, face, x, y)
        if hdrag or placing then
            return
        end
        if not (selected and selected.Parent and targetCF and hCF) then
            return
        end
        local st = hstates[btn]
        if not st then
            return
        end
        local inset = GuiService:GetGuiInset()
        local h = { kind = kind, btn = btn }
        local planeN, hcf = st.PlaneNormal, st.HandleCFrame

        if kind == "Move" then
            local handleN, origin = st.HandleNormal, hcf.Position
            local dir2 = (st.HandleVP - st.AdorneeVP).Unit
            local proj = dir2:Dot(Vector2.new(x, y) - st.AdorneeVP) * dir2 + st.AdorneeVP
            local ray = Camera:ViewportPointToRay(proj.X, proj.Y)
            local denom = ray.Direction:Dot(planeN)
            if math.abs(denom) < 1e-4 then
                return
            end
            local start = handleN:Dot((origin - ray.Origin):Dot(planeN) / denom * ray.Direction + ray.Origin - origin)
            drag = { startCF = targetCF, hCF = hCF }

            h.process = function(p)
                local d2 = (st.HandleVP - st.AdorneeVP).Unit
                local c = st.AdorneeVP - inset
                local pr = d2:Dot(p - c) * d2 + c
                local r = Camera:ScreenPointToRay(pr.X, pr.Y)
                local dn = r.Direction:Dot(planeN)
                if math.abs(dn) < 1e-4 then
                    return
                end
                local dist = handleN:Dot((origin - r.Origin):Dot(planeN) / dn * r.Direction + r.Origin - origin) - start
                onMoveDrag(face, dist)
            end
        else
            local adCF = st.AdorneeCFrame
            local axisName = SideToAxis[face.Name]
            h.axisName = axisName
            local ray = Camera:ViewportPointToRay(x, y)
            local denom = ray.Direction:Dot(planeN)
            if math.abs(denom) < 1e-4 then
                return
            end
            local hit = (hcf.Position - ray.Origin):Dot(planeN) / denom * ray.Direction + ray.Origin
            local s = adCF:PointToObjectSpace(hit)
            -- freeze ring frame while rotating
            drag = { startCF = targetCF, hCF = adCF, frozen = true }

            h.process = function(p)
                local r = Camera:ScreenPointToRay(p.X, p.Y)
                local dn = r.Direction:Dot(planeN)
                if math.abs(dn) < 1e-4 then
                    return
                end
                local o = adCF:PointToObjectSpace((hcf.Position - r.Origin):Dot(planeN) / dn * r.Direction + r.Origin)
                local a
                if axisName == "X" then
                    a = math.atan2(o.Y, -o.Z) - math.atan2(s.Y, -s.Z)
                elseif axisName == "Y" then
                    a = math.atan2(o.X, o.Z) - math.atan2(s.X, s.Z)
                else
                    a = math.atan2(-o.X, o.Y) - math.atan2(-s.X, s.Y)
                end
                onRotateDrag(axisName, a)
            end
        end

        hdrag = h
        setFlag(btn, "press", true)
        conns.dragMove = UserInputService.InputChanged:Connect(function(inp)
            if not drag then
                return
            end
            local t = inp.UserInputType
            if t == Enum.UserInputType.MouseMovement or t == Enum.UserInputType.Touch then
                h.process(Vector2.new(inp.Position.X, inp.Position.Y))
            end
        end)
        conns.btnMove = btn.MouseMoved:Connect(function(px, py)
            if not drag then
                return
            end
            h.process(Vector2.new(px, py) - inset)
        end)
        conns.dragEnd = UserInputService.InputEnded:Connect(function(inp)
            local t = inp.UserInputType
            if t == Enum.UserInputType.MouseButton1 or t == Enum.UserInputType.Touch then
                finishHandleDrag()
            end
        end)
    end

    local function IsPointer(input)
        local t = input.UserInputType
        return t == Enum.UserInputType.MouseButton1 or t == Enum.UserInputType.Touch
    end

    -- move handles
    for _, face in ipairs(Enum.NormalId:GetEnumItems()) do
        local btn = makeHandle(">", MOVE_COLOR, face.Name)
        arrows[btn] = makeArrow(MOVE_COLOR)
        btn.MouseButton1Down:Connect(function(x, y)
            beginHandleDrag("Move", btn, face, x, y)
        end)
        btn.MouseButton1Up:Connect(finishHandleDrag)
        btn.MouseEnter:Connect(function()
            setFlag(btn, "hover", true)
        end)
        btn.MouseLeave:Connect(function()
            setFlag(btn, "hover", false)
        end)
        moveBtns[face] = btn
    end

    -- rotate handles
    for _, axis in ipairs(Enum.Axis:GetEnumItems()) do
        local folder = Instance.new("Folder", circlesFolder)
        folder.Name = axis.Name
        local slices = {}
        for i = 1, 60 do
            local c = Instance.new("CylinderHandleAdornment")
            c.Transparency = 0.4
            c.Color3 = AXIS_COLORS[axis.Name]
            c.Radius = 0
            c.Height = 0
            c.Adornee = proxy
            c.Parent = folder
            slices[i] = c
        end
        circles[axis.Name] = slices
    end

    for _, face in ipairs(Enum.NormalId:GetEnumItems()) do
        local axisName = SideToAxis[face.Name]
        local btn = makeHandle(axisName, AXIS_COLORS[axisName], face.Name)
        btn.TextSize = 12
        btn.MouseButton1Down:Connect(function(x, y)
            beginHandleDrag("Rotate", btn, face, x, y)
        end)
        btn.MouseButton1Up:Connect(finishHandleDrag)
        btn.MouseEnter:Connect(function()
            setFlag(btn, "hover", true)
            for _, c in ipairs(circles[axisName]) do
                c.Transparency = 0
            end
        end)
        btn.MouseLeave:Connect(function()
            setFlag(btn, "hover", false)
            for _, c in ipairs(circles[axisName]) do
                c.Transparency = 0.4
            end
        end)
        arcBtns[face] = btn
    end

    -- place handles each frame
    RunService.RenderStepped:Connect(function()
        Camera = workspace.CurrentCamera
        local on = (BuilderOn or fileBuild) and selected and selected.Parent and targetCF and Camera and true or false
        local moveOn = on and (fileBuild or ToolMode == "Move")
        local rotOn = on and not fileBuild and ToolMode == "Rotate"

        if not moveOn then
            for _, b in pairs(moveBtns) do
                b.Visible = false
            end
        end
        if not rotOn then
            for _, b in pairs(arcBtns) do
                b.Visible = false
            end
        end
        if (circlesFolder.Parent ~= nil) ~= rotOn then
            circlesFolder.Parent = rotOn and gui or nil
        end
        if (arrowsFolder.Parent ~= nil) ~= moveOn then
            arrowsFolder.Parent = moveOn and gui or nil
        end
        if proxy.Parent ~= Camera and Camera then
            proxy.Parent = Camera
        end
        if not on then
            return
        end

        -- keep ring in place on rotate
        if drag and drag.frozen then
            local _, sz = HandleFrame()
            hCF, hSize = drag.hCF, sz
        else
            hCF, hSize = HandleFrame()
        end
        proxy.CFrame = hCF
        proxy.Size = Vector3.new(math.max(hSize.X, 0.2), math.max(hSize.Y, 0.2), math.max(hSize.Z, 0.2))

        -- fade handles behind things
        local char = LocalPlayer.Character
        local close = (Camera.CFrame.Position - Camera.Focus.Position).Magnitude <= 0.6
        local ignore = { proxy, ghostFolder, selected }
        if close and char then
            table.insert(ignore, char)
        end
        rayParams.FilterDescendantsInstances = ignore

        if moveOn then
            for face, b in pairs(moveBtns) do
                updateMoveHandle(b, face)
            end
        else
            for face, b in pairs(arcBtns) do
                updateArcHandle(b, face)
            end
            for axisName, slices in pairs(circles) do
                updateCircle(axisName, slices)
            end
        end
    end)

    -- tap to select
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed or not BuilderOn or drag or placing then
            return
        end
        if not IsPointer(input) then
            return
        end
        tapStart = { pos = Vector2.new(input.Position.X, input.Position.Y), time = tick(), type = input.UserInputType }
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            tapStart.view = UserInputService:GetMouseLocation()
        else
            tapStart.view = tapStart.pos
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if not IsPointer(input) then
            return
        end
        if hdrag then
            tapStart = nil
            return
        end
        local ts = tapStart
        tapStart = nil
        if not ts or not BuilderOn or placing then
            return
        end
        if ts.type ~= input.UserInputType then
            return
        end
        local moved = (Vector2.new(input.Position.X, input.Position.Y) - ts.pos).Magnitude
        local held = tick() - ts.time
        if moved > 14 then
            return
        end
        if HoldToSelect then
            if held < HoldTime then
                return
            end -- ignore quick taps
        elseif held > 0.6 then
            return
        end

        local cam = workspace.CurrentCamera
        if not cam then
            return
        end
        local ray = cam:ViewportPointToRay(ts.view.X, ts.view.Y)
        local params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Exclude
        params.FilterDescendantsInstances = { ghostFolder, LocalPlayer.Character }
        local hit = workspace:Raycast(ray.Origin, ray.Direction * 1000, params)
        if not hit then
            return
        end

        local model = ModelFromPart(hit.Instance)
        if not model then
            return
        end
        if pickingTarget then
            if model == selected then
                Notify("Antler", "Pick a different item to align to.", 2)
                return
            end
            SetAlignTarget(model)
            Notify("Antler", "Align target: " .. GetItemName(model), 2)
            return
        end
        if not CanMove(model) then
            Notify("Antler", "You can't move that one.", 2)
            return
        end
        if not KindOf(model) then
            local tv = model:FindFirstChild("Type")
            Notify("Antler", "Can't move that kind of item (" .. tostring(tv and tv.Value or "?") .. ").", 3)
            return
        end

        SelectModel(model)
        Notify("Antler", "Selected " .. GetItemName(model), 2)
    end)

    -- place
    local function PlaceFresh()
        if fresh and fresh.group then
            if PlaceGroup then
                PlaceGroup()
            end
            return
        end
        if placing or not (fresh and targetCF) then
            return
        end
        local ps = ReplicatedStorage:FindFirstChild("PlaceStructure")
        local remote = ps and ps:FindFirstChild("ClientPlacedBlueprint")
        local pm = workspace:FindFirstChild("PlayerModels")
        if not (remote and pm) then
            Notify("Antler", "Placement remotes not found.", 3)
            return
        end

        if GridSnap then
            ApplyGrid(nil)
        end
        placing = true
        task.spawn(function()
            local name = fresh and fresh.name
            local newCF = targetCF
            if not name then
                placing = false
                return
            end

            local before = {}
            for _, m in ipairs(pm:GetChildren()) do
                before[m] = true
            end

            local function matches(m)
                if KindOf(m) ~= "Blueprint" then
                    return false
                end
                local ownerFolder = m:FindFirstChild("Owner")
                if ownerFolder and not IsMineOrPlot(m) then
                    return false
                end
                local iname = m:FindFirstChild("ItemName")
                if iname and iname.Value ~= "" and iname.Value ~= name then
                    return false
                end
                return true
            end

            local found
            local deadline, retryAt = tick() + 9, 0
            while tick() < deadline and not found do
                if tick() >= retryAt then
                    remote:FireServer(name, newCF, PlotOwner())
                    retryAt = tick() + 4
                end
                for _, m in ipairs(pm:GetChildren()) do
                    if not before[m] and matches(m) then
                        found = m
                        break
                    end
                end
                task.wait()
            end

            placing = false
            if found then
                Notify("Antler", "Placed " .. name .. "!", 2)
            else
                Notify("Antler", "Placement was not confirmed (Blueprint: " .. name .. ").", 4)
            end
        end)
    end

    local function PlaceSelected()
        if fresh then
            PlaceFresh()
            return
        end
        if placing then
            return
        end
        if not (selected and selected.Parent and targetCF) then
            Notify("Antler", "Tap something to select it first!", 2)
            return
        end

        local ps = ReplicatedStorage:FindFirstChild("PlaceStructure")
        local ia = ReplicatedStorage:FindFirstChild("Interaction")
        local kind = KindOf(selected)
        local remote = ps
            and (
                (kind == "Blueprint") and ps:FindFirstChild("ClientPlacedBlueprint")
                or ps:FindFirstChild("ClientPlacedStructure")
            )
        local destroyRemote = ia and ia:FindFirstChild("DestroyStructure")
        local pm = workspace:FindFirstChild("PlayerModels")
        if not (kind and remote and pm) then
            Notify("Antler", "Placement remotes not found.", 3)
            return
        end

        if GridSnap then
            ApplyGrid(nil)
        end
        placing = true
        task.spawn(function()
            local src = selected
            local newCF = targetCF
            local itemName = GetItemName(src)
            local treeValue = TreeValueOf(src)

            -- same calls as the move button
            local ownerArg = (PlotOwner() ~= LocalPlayer and PlotOwner())
                or (src:FindFirstChild("Owner") and src.Owner.Value)
                or LocalPlayer
            local function fire()
                if kind == "Blueprint" then
                    remote:FireServer(itemName, newCF, ownerArg, src, true)
                else
                    remote:FireServer(itemName, newCF, ownerArg, treeValue, src, true)
                end
            end

            local function matches(m)
                if KindOf(m) ~= kind then
                    return false
                end
                local ownerFolder = m:FindFirstChild("Owner")
                if ownerFolder and not IsMineOrPlot(m) then
                    return false
                end
                local iname = m:FindFirstChild("ItemName")
                if iname and iname.Value ~= "" and iname.Value ~= itemName then
                    return false
                end
                return true
            end

            -- server may move the original
            local function movedInPlace()
                if not src.Parent then
                    return false
                end
                local ok, cf = pcall(GetStructureCFrame, src)
                return ok and cf and (cf.Position - newCF.Position).Magnitude < 0.25
            end

            local before = {}
            for _, m in ipairs(pm:GetChildren()) do
                before[m] = true
            end

            local newModel
            local inPlace = false
            local deadline, retryAt = tick() + 10, 0
            while tick() < deadline and not newModel and not inPlace do
                if tick() >= retryAt then
                    fire()
                    retryAt = tick() + 2
                end
                for _, m in ipairs(pm:GetChildren()) do
                    if not before[m] and m ~= src and matches(m) then
                        newModel = m
                        break
                    end
                end
                if not newModel and movedInPlace() then
                    inPlace = true
                end
                task.wait()
            end

            if not newModel and not inPlace then
                placing = false
                Notify("Antler", "Placement was not confirmed (" .. kind .. ": " .. itemName .. ").", 4)
                return
            end

            if inPlace then
                -- same model, new position
                if BuilderOn and src.Parent then
                    SelectModel(src)
                end
            elseif not KeepOriginal then
                -- remove original if still there
                task.wait(0.3)
                if destroyRemote and src.Parent then
                    pcall(destroyRemote.FireServer, destroyRemote, src)
                end
                -- continue with new model
                if BuilderOn then
                    SelectModel(newModel)
                end
            end

            placing = false
            Notify("Antler", KeepOriginal and "Copy placed!" or "Placed!", 2)
        end)
    end

    -- build mode
    local TweenService = game:GetService("TweenService")
    local BG, TEXT, MUTED = Color3.fromRGB(40, 40, 40), Color3.new(1, 1, 1), Color3.fromRGB(150, 150, 150)
    local modeOpen, modeGui, wasOn, uiWasOpen = false, nil, false, true
    local lucide
    local CloseMode

    -- filled icons, outline fallback
    local FILLED = {
        ["settings"] = "gearshapeFill",
        ["move"] = "arrowUpAndDownAndArrowLeftAndRight",
        ["rotate-3d"] = "rotate3dFill",
        ["rotate-ccw"] = "arrowCounterclockwiseCircleFill",
        ["undo"] = "arrowUturnBackwardCircleFill",
        ["check"] = "checkmarkCircleFill",
        ["circle-x"] = "xmarkCircleFill",
        ["x"] = "xmark",
        ["grid-3x3"] = "squareGrid3x3Fill",
        ["boxes"] = "pencilAndRulerFill",
        ["align-center-horizontal"] = "alignHorizontalCenterFill",
        ["chevron-down"] = "arrowtriangleDownFill",
    }
    local filled

    local function icon(name)
        if filled == nil then
            local ok, res = pcall(function()
                return loadstring(
                    game:HttpGet("https://raw.githubusercontent.com/Footagesus/Icons/main/sfsymbols/dist/Icons.lua")
                )()
            end)
            filled = (ok and type(res) == "table") and res or false
        end
        local key = FILLED[name]
        if filled and key and filled[key] then
            return filled[key]
        end

        -- outline fallback
        if lucide == nil then
            local ok, res = pcall(function()
                return loadstring(
                    game:HttpGet("https://raw.githubusercontent.com/Footagesus/Icons/main/lucide/dist/Icons.lua")
                )()
            end)
            lucide = (ok and type(res) == "table") and res or false
        end
        return lucide and lucide[name] or nil
    end

    local function tween(obj, time, props)
        TweenService:Create(obj, TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
    end

    -- press animation
    local function press(btn, target)
        target = target or btn
        local sc = Instance.new("UIScale", target)
        btn.MouseButton1Down:Connect(function()
            tween(sc, 0.08, { Scale = 0.92 })
        end)
        local function up()
            tween(sc, 0.15, { Scale = 1 })
        end
        btn.MouseButton1Up:Connect(up)
        btn.MouseLeave:Connect(up)
    end

    local function BuildModeBar()
        local gui = Instance.new("ScreenGui")
        gui.Name = "AntlerBuildMode"
        gui.ResetOnSpawn = false
        gui.IgnoreGuiInset = true
        gui.DisplayOrder = 999
        gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
        modeGui = gui

        local bar = Instance.new("Frame")
        bar.AnchorPoint = Vector2.new(0.5, 1)
        bar.BackgroundColor3 = BG
        bar.BorderSizePixel = 0
        bar.Active = true -- block taps through the bar
        bar.Parent = gui
        Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 10)

        local row = Instance.new("Frame")
        row.BackgroundTransparency = 1
        row.Size = UDim2.fromScale(1, 1)
        row.Parent = bar
        local layout = Instance.new("UIListLayout")
        layout.FillDirection = Enum.FillDirection.Horizontal
        layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        layout.VerticalAlignment = Enum.VerticalAlignment.Center
        layout.Padding = UDim.new(0, 2)
        layout.Parent = row

        local function label(parent, text, size)
            local t = Instance.new("TextLabel")
            t.BackgroundTransparency = 1
            t.Font = Enum.Font.GothamMedium
            t.TextSize = size
            t.TextColor3 = TEXT
            t.Text = text
            t.Parent = parent
            return t
        end

        -- tag above bar
        local tag = label(bar, "", 13)
        tag.AnchorPoint = Vector2.new(0.5, 1)
        tag.Position = UDim2.new(0.5, 0, 0, -6)
        tag.AutomaticSize = Enum.AutomaticSize.XY
        tag.BackgroundTransparency = 0
        tag.BackgroundColor3 = BG
        tag.Visible = false
        Instance.new("UICorner", tag).CornerRadius = UDim.new(0, 6)
        local tpad = Instance.new("UIPadding", tag)
        tpad.PaddingLeft, tpad.PaddingRight = UDim.new(0, 8), UDim.new(0, 8)
        tpad.PaddingTop, tpad.PaddingBottom = UDim.new(0, 4), UDim.new(0, 4)

        local stamp, lastBtn = 0, nil
        local function say2(text, b)
            stamp += 1
            local mine = stamp
            lastBtn = b or lastBtn
            tag.Text = text
            if lastBtn and lastBtn.Parent then
                local k = bar.AbsoluteSize.X / math.max(1, bar.Size.X.Offset)
                local x = (lastBtn.AbsolutePosition.X + lastBtn.AbsoluteSize.X / 2 - bar.AbsolutePosition.X) / k
                tag.Position = UDim2.new(0, x, 0, -6)
            end
            tag.Visible = true
            task.delay(2, function()
                if stamp == mine then
                    tag.Visible = false
                end
            end)
        end

        -- popup panels
        local panel, panelName
        local refresh
        local function closePanel()
            local old = panel
            panel, panelName = nil, nil
            if refresh then
                refresh()
            end
            if old then
                tween(old, 0.12, { GroupTransparency = 1, Position = UDim2.new(0.5, 0, 0, -28) })
                task.delay(0.14, function()
                    old:Destroy()
                end)
            end
        end

        local function newPanel(name, title, width)
            local same = panelName == name
            closePanel()
            if same then
                return nil
            end
            local p = Instance.new("CanvasGroup")
            p.GroupTransparency = 1
            p.AnchorPoint = Vector2.new(0.5, 1)
            p.Position = UDim2.new(0.5, 0, 0, -28)
            p.Size = UDim2.fromOffset(width, 0)
            p.AutomaticSize = Enum.AutomaticSize.Y
            p.BackgroundColor3 = BG
            p.BorderSizePixel = 0
            p.Active = true
            p.Parent = bar
            Instance.new("UICorner", p).CornerRadius = UDim.new(0, 10)
            local pad = Instance.new("UIPadding", p)
            pad.PaddingLeft, pad.PaddingRight = UDim.new(0, 8), UDim.new(0, 8)
            pad.PaddingTop, pad.PaddingBottom = UDim.new(0, 8), UDim.new(0, 8)
            local l = Instance.new("UIListLayout")
            l.Padding = UDim.new(0, 4)
            l.SortOrder = Enum.SortOrder.LayoutOrder
            l.Parent = p
            if title then
                local head = label(p, title, 12)
                head.Size = UDim2.new(1, 0, 0, 16)
                head.TextColor3 = Color3.fromRGB(160, 165, 175)
                head.TextXAlignment = Enum.TextXAlignment.Left
                head.LayoutOrder = 0
            end
            panel, panelName = p, name
            if refresh then
                refresh()
            end
            tween(p, 0.18, { GroupTransparency = 0, Position = UDim2.new(0.5, 0, 0, -40) })
            return p
        end

        -- chip row
        local function chipGrid(p, order, title, options, cols, current, apply)
            local holder = Instance.new("Frame")
            holder.BackgroundTransparency = 1
            holder.LayoutOrder = order
            holder.Parent = p
            local rows = math.ceil(#options / cols)
            holder.Size = UDim2.new(1, 0, 0, (title and 20 or 0) + rows * 32)
            if title then
                local t = label(holder, title, 12)
                t.Size = UDim2.new(1, 0, 0, 16)
                t.TextXAlignment = Enum.TextXAlignment.Left
            end
            local g = Instance.new("Frame")
            g.BackgroundTransparency = 1
            g.Position = UDim2.fromOffset(0, title and 20 or 0)
            g.Size = UDim2.new(1, 0, 1, title and -20 or 0)
            g.Parent = holder
            local gl = Instance.new("UIGridLayout")
            gl.CellSize = UDim2.new(1 / cols, -4, 0, 28)
            gl.CellPadding = UDim2.fromOffset(4, 4)
            gl.SortOrder = Enum.SortOrder.LayoutOrder
            gl.Parent = g
            local list = {}
            local function paint()
                for _, e in ipairs(list) do
                    local on = current and tostring(e[2]) == tostring(current())
                    tween(e[1], 0.15, { BackgroundTransparency = on and 0.8 or 0.95 })
                end
            end
            for i, o in ipairs(options) do
                local c = Instance.new("TextButton")
                c.LayoutOrder = i
                c.AutoButtonColor = false
                c.BackgroundColor3 = Color3.new(1, 1, 1)
                c.BackgroundTransparency = (current and tostring(o) == tostring(current())) and 0.8 or 0.95
                c.BorderSizePixel = 0
                c.Font = Enum.Font.GothamMedium
                c.TextSize = 12
                c.TextColor3 = TEXT
                c.TextWrapped = true
                c.Text = tostring(o)
                c.Parent = g
                Instance.new("UICorner", c).CornerRadius = UDim.new(0, 8)
                press(c)
                table.insert(list, { c, o })
                c.Activated:Connect(function()
                    apply(o)
                    paint()
                end)
            end
        end

        -- toggle row
        local function switch(p, order, title, current, apply)
            local b = Instance.new("TextButton")
            b.Size = UDim2.new(1, 0, 0, 32)
            b.LayoutOrder = order
            b.AutoButtonColor = false
            b.BackgroundColor3 = Color3.new(1, 1, 1)
            b.BackgroundTransparency = 0.95
            b.BorderSizePixel = 0
            b.Font = Enum.Font.GothamMedium
            b.TextSize = 14
            b.TextColor3 = TEXT
            b.TextXAlignment = Enum.TextXAlignment.Left
            b.Text = "  " .. title
            b.Parent = p
            Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
            local pill = Instance.new("Frame")
            pill.AnchorPoint = Vector2.new(1, 0.5)
            pill.Position = UDim2.new(1, -10, 0.5, 0)
            pill.Size = UDim2.fromOffset(34, 18)
            pill.BorderSizePixel = 0
            pill.Parent = b
            Instance.new("UICorner", pill).CornerRadius = UDim.new(1, 0)
            local knob = Instance.new("Frame")
            knob.AnchorPoint = Vector2.new(0, 0.5)
            knob.Position = UDim2.new(0, 2, 0.5, 0)
            knob.Size = UDim2.fromOffset(14, 14)
            knob.BorderSizePixel = 0
            knob.Parent = pill
            Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)
            press(b)
            local function paint()
                local on = current()
                tween(pill, 0.15, { BackgroundColor3 = on and TEXT or Color3.fromRGB(80, 80, 80) })
                tween(knob, 0.15, {
                    BackgroundColor3 = on and BG or Color3.fromRGB(200, 200, 200),
                    Position = UDim2.new(0, on and 18 or 2, 0.5, 0),
                })
            end
            paint()
            b.Activated:Connect(function()
                apply(not current())
                paint()
                if refresh then
                    refresh()
                end
            end)
        end

        local function textRow(p, order, text, onTap)
            local b = Instance.new("TextButton")
            b.Size = UDim2.new(1, 0, 0, 32)
            b.LayoutOrder = order
            b.AutoButtonColor = false
            b.BackgroundColor3 = Color3.new(1, 1, 1)
            b.BackgroundTransparency = 0.95
            b.BorderSizePixel = 0
            b.Font = Enum.Font.GothamMedium
            b.TextSize = 14
            b.TextColor3 = TEXT
            b.TextXAlignment = Enum.TextXAlignment.Left
            b.Text = "  " .. text
            b.Parent = p
            Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
            press(b)
            b.Activated:Connect(onTap)
            return b
        end

        -- stepper row
        local function stepper(p, order, title, getList, current, apply, show, valueWidth)
            local row = Instance.new("Frame")
            row.LayoutOrder = order
            row.Size = UDim2.new(1, 0, 0, 32)
            row.BackgroundColor3 = Color3.new(1, 1, 1)
            row.BackgroundTransparency = 0.95
            row.BorderSizePixel = 0
            row.Parent = p
            Instance.new("UICorner", row).CornerRadius = UDim.new(0, 8)

            local t = label(row, title, 13)
            t.Position = UDim2.fromOffset(10, 0)
            t.Size = UDim2.new(1, -20, 1, 0)
            t.TextXAlignment = Enum.TextXAlignment.Left

            local box = Instance.new("Frame")
            box.AnchorPoint = Vector2.new(1, 0.5)
            box.Position = UDim2.new(1, -4, 0.5, 0)
            box.Size = UDim2.fromOffset(52 + (valueWidth or 56), 26)
            box.BackgroundTransparency = 1
            box.Parent = row

            local function arrow(text, x)
                local b = Instance.new("TextButton")
                b.Size = UDim2.fromOffset(26, 26)
                b.Position = UDim2.fromOffset(x, 0)
                b.AutoButtonColor = false
                b.BackgroundColor3 = Color3.new(1, 1, 1)
                b.BackgroundTransparency = 0.9
                b.BorderSizePixel = 0
                b.Font = Enum.Font.GothamBold
                b.TextSize = 15
                b.TextColor3 = TEXT
                b.Text = text
                b.Parent = box
                Instance.new("UICorner", b).CornerRadius = UDim.new(0, 7)
                press(b)
                return b
            end
            local left = arrow("<", 0)
            local right = arrow(">", 26 + (valueWidth or 56))

            local val = label(box, "", 13)
            val.Position = UDim2.fromOffset(26, 0)
            val.Size = UDim2.fromOffset(valueWidth or 56, 26)
            val.TextTruncate = Enum.TextTruncate.AtEnd

            local function paint()
                val.Text = show(current())
            end
            local function step(dir)
                local list = getList()
                if #list == 0 then
                    return
                end
                local idx = 1
                local cur = current()
                for i, v in ipairs(list) do
                    if v == cur then
                        idx = i
                        break
                    end
                end
                idx = ((idx - 1 + dir) % #list) + 1
                apply(list[idx])
                paint()
            end
            left.Activated:Connect(function()
                step(-1)
            end)
            right.Activated:Connect(function()
                step(1)
            end)
            paint()
        end

        local function playerList()
            local list = { LocalPlayer }
            local others = {}
            for _, pl in ipairs(Players:GetPlayers()) do
                if pl ~= LocalPlayer then
                    table.insert(others, pl)
                end
            end
            table.sort(others, function(a, b)
                return a.Name:lower() < b.Name:lower()
            end)
            for _, pl in ipairs(others) do
                table.insert(list, pl)
            end
            return list
        end

        -- build for dropdown
        local function playerDropdown(p, order)
            local holder = Instance.new("Frame")
            holder.LayoutOrder = order
            holder.Size = UDim2.new(1, 0, 0, 0)
            holder.AutomaticSize = Enum.AutomaticSize.Y
            holder.BackgroundTransparency = 1
            holder.Parent = p
            local hl = Instance.new("UIListLayout")
            hl.Padding = UDim.new(0, 4)
            hl.SortOrder = Enum.SortOrder.LayoutOrder
            hl.Parent = holder

            local head = Instance.new("TextButton")
            head.LayoutOrder = 1
            head.Size = UDim2.new(1, 0, 0, 32)
            head.AutoButtonColor = false
            head.BackgroundColor3 = Color3.new(1, 1, 1)
            head.BackgroundTransparency = 0.95
            head.BorderSizePixel = 0
            head.Text = ""
            head.Parent = holder
            Instance.new("UICorner", head).CornerRadius = UDim.new(0, 8)
            press(head)

            local lbl = label(head, "Build For:", 13)
            lbl.Position = UDim2.fromOffset(10, 0)
            lbl.Size = UDim2.new(0, 70, 1, 0)
            lbl.TextXAlignment = Enum.TextXAlignment.Left

            local value = label(head, "", 13)
            value.AnchorPoint = Vector2.new(1, 0.5)
            value.Position = UDim2.new(1, -30, 0.5, 0)
            value.Size = UDim2.new(1, -112, 1, 0)
            value.TextXAlignment = Enum.TextXAlignment.Right
            value.TextTruncate = Enum.TextTruncate.AtEnd

            local chev
            local chevImg = icon("chevron-down")
            if chevImg then
                chev = Instance.new("ImageLabel")
                chev.Image = chevImg
                chev.ImageColor3 = MUTED
                chev.BackgroundTransparency = 1
            else
                chev = label(head, "v", 12)
                chev.TextColor3 = MUTED
            end
            chev.AnchorPoint = Vector2.new(1, 0.5)
            chev.Position = UDim2.new(1, -8, 0.5, 0)
            chev.Size = UDim2.fromOffset(16, 16)
            chev.Parent = head

            local function paintValue()
                value.Text = PlotOwner().Name
            end
            paintValue()

            local list
            local function closeList()
                if list then
                    list:Destroy()
                    list = nil
                end
                tween(chev, 0.12, { Rotation = 0 })
            end

            local function openList()
                closeList()
                local players = playerList()
                local rowH = 28
                list = Instance.new("ScrollingFrame")
                list.LayoutOrder = 2
                list.Size = UDim2.new(1, 0, 0, math.min(#players * (rowH + 3) + 4, 128))
                list.BackgroundColor3 = Color3.new(1, 1, 1)
                list.BackgroundTransparency = 0.97
                list.BorderSizePixel = 0
                list.CanvasSize = UDim2.new()
                list.AutomaticCanvasSize = Enum.AutomaticSize.Y
                list.ScrollBarThickness = 3
                list.Parent = holder
                Instance.new("UICorner", list).CornerRadius = UDim.new(0, 8)
                local lp = Instance.new("UIPadding", list)
                lp.PaddingTop, lp.PaddingBottom = UDim.new(0, 2), UDim.new(0, 2)
                lp.PaddingLeft, lp.PaddingRight = UDim.new(0, 4), UDim.new(0, 4)
                local ll = Instance.new("UIListLayout")
                ll.Padding = UDim.new(0, 3)
                ll.SortOrder = Enum.SortOrder.LayoutOrder
                ll.Parent = list

                for i, pl in ipairs(players) do
                    local b = Instance.new("TextButton")
                    b.LayoutOrder = i
                    b.Size = UDim2.new(1, 0, 0, rowH)
                    b.AutoButtonColor = false
                    b.BackgroundColor3 = Color3.new(1, 1, 1)
                    b.BackgroundTransparency = (pl == PlotOwner()) and 0.8 or 0.95
                    b.BorderSizePixel = 0
                    b.Font = Enum.Font.GothamMedium
                    b.TextSize = 13
                    b.TextColor3 = TEXT
                    b.TextXAlignment = Enum.TextXAlignment.Left
                    b.Text = "  " .. pl.Name
                    b.Parent = list
                    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 7)
                    press(b)
                    b.Activated:Connect(function()
                        BuildFor = pl
                        plotTime = 0
                        paintValue()
                        closeList()
                    end)
                end
                tween(chev, 0.12, { Rotation = 180 })
            end

            head.Activated:Connect(function()
                if list then
                    closeList()
                else
                    openList()
                end
            end)
        end

        local function openOptions()
            local p = newPanel("options", "Settings", 300)
            if not p then
                return
            end

            playerDropdown(p, 1)

            chipGrid(p, 2, "Axes", { "World", "Local" }, 2, function()
                return AxesMode
            end, function(o)
                AxesMode = o
            end)

            stepper(p, 3, "Move snap", function()
                return { "Free", 0.25, 0.5, 1, 2.5, 5 }
            end, function()
                return MoveStep == 0 and "Free" or MoveStep
            end, function(o)
                MoveStep = (o == "Free") and 0 or o
            end, function(v)
                return tostring(v)
            end)

            stepper(p, 4, "Rotation snap", function()
                return { "Free", 1, 5, 10, 15, 22.5, 30, 45, 90 }
            end, function()
                return SnapAngle == 0 and "Free" or SnapAngle
            end, function(o)
                SnapAngle = (o == "Free") and 0 or o
            end, function(v)
                return (v == "Free") and "Free" or (tostring(v) .. "°")
            end)

            switch(p, 5, "Snap to plot grid (no overlap)", function()
                return GridSnap
            end, function(v)
                GridSnap = v
            end)
            switch(p, 6, "Copy (keep original)", function()
                return KeepOriginal
            end, function(v)
                KeepOriginal = v
            end)
            switch(p, 7, "Hold to select", function()
                return HoldToSelect
            end, function(v)
                HoldToSelect = v
            end)

            stepper(p, 8, "Hold time (s)", function()
                return { 0.25, 0.4, 0.6, 1 }
            end, function()
                return HoldTime
            end, function(o)
                HoldTime = o
            end, function(v)
                return tostring(v)
            end)
        end

        local function openAlign()
            local p = newPanel("align", "Align to another item", 300)
            if not p then
                return
            end
            textRow(p, 1, "Pick align target (hold an item)", function()
                pickingTarget = true
                say2("Press and hold the item to align to")
            end)
            chipGrid(
                p,
                2,
                nil,
                {
                    "Center All",
                    "Center X",
                    "Center Y",
                    "Center Z",
                    "Touch +X",
                    "Touch -X",
                    "Touch +Y",
                    "Touch -Y",
                    "Touch +Z",
                    "Touch -Z",
                    "Match Rotation",
                },
                3,
                nil,
                function(o)
                    AlignMode = o
                    DoAlign(o)
                end
            )
            textRow(p, 3, "Clear align target", function()
                ClearAlignTarget()
            end)
        end

        -- blueprints panel
        local CATEGORY_ORDER = { Walls = 1, Floors = 2, Doors = 3, Wedges = 4, Furniture = 5, Other = 6 }

        local function naturalKey(n)
            return (
                n:lower():gsub("%d+", function(d)
                    return string.format("%06d", tonumber(d))
                end)
            )
        end

        local function ownedBlueprints()
            local list = {}
            local pb = LocalPlayer:FindFirstChild("PlayerBlueprints")
            local bps = pb and pb:FindFirstChild("Blueprints")
            if bps then
                for _, b in ipairs(bps:GetChildren()) do
                    local cat = b:FindFirstChild("ItemCategory")
                    table.insert(list, { name = b.Name, cat = CATEGORY_ORDER[cat and cat.Value or ""] or 7 })
                end
            end
            if #list == 0 then
                local items = ReplicatedStorage:FindFirstChild("ClientItemInfo")
                for _, it in ipairs(items and items:GetChildren() or {}) do
                    local t = it:FindFirstChild("Type")
                    if t and t.Value == "Blueprint" then
                        table.insert(list, { name = it.Name, cat = 7 })
                    end
                end
            end
            table.sort(list, function(a, b)
                if a.cat ~= b.cat then
                    return a.cat < b.cat
                end
                return naturalKey(a.name) < naturalKey(b.name)
            end)
            return list
        end

        -- blueprint preview
        local function makeThumb(parent, name, size, pos)
            local items = ReplicatedStorage:FindFirstChild("ClientItemInfo")
            local info = items and items:FindFirstChild(name)
            local tpl = info and (info:FindFirstChild("PlacingModel") or info:FindFirstChild("Model"))

            if tpl and tpl:IsA("Model") then
                local vp = Instance.new("ViewportFrame")
                vp.BackgroundColor3 = Color3.new(0, 0, 0)
                vp.BackgroundTransparency = 0.7
                vp.BorderSizePixel = 0
                vp.Size, vp.Position = size, pos
                vp.Ambient = Color3.fromRGB(190, 190, 190)
                vp.LightColor = Color3.fromRGB(255, 255, 255)
                vp.Parent = parent
                Instance.new("UICorner", vp).CornerRadius = UDim.new(0, 8)

                local m = tpl:Clone()
                for _, d in ipairs(m:GetDescendants()) do
                    if d:IsA("LuaSourceContainer") or d:IsA("Sound") then
                        d:Destroy()
                    end
                end
                m.Parent = vp
                local okB, cf, sz = pcall(function()
                    return m:GetBoundingBox()
                end)
                if okB then
                    local cam = Instance.new("Camera")
                    cam.FieldOfView = 40
                    local dist = (sz.Magnitude / 2) / math.tan(math.rad(20)) * 1.05
                    cam.CFrame = CFrame.lookAt(cf.Position + Vector3.new(1, 0.75, 1).Unit * dist, cf.Position)
                    cam.Parent = vp
                    vp.CurrentCamera = cam
                end
                return vp
            end

            local img = Instance.new("ImageLabel")
            img.BackgroundTransparency = 1
            img.Size, img.Position = size, pos
            img.ScaleType = Enum.ScaleType.Fit
            local iv = info and info:FindFirstChild("ItemImage")
            img.Image = iv and iv.Value or ""
            img.Parent = parent
            return img
        end

        local function openBlueprints()
            local p = newPanel("blueprints", nil, 332)
            if not p then
                return
            end

            local title = label(p, "Blueprints", 15)
            title.Font = Enum.Font.GothamBold
            title.Size = UDim2.new(1, 0, 0, 20)
            title.LayoutOrder = 0

            local search = Instance.new("TextBox")
            search.LayoutOrder = 1
            search.Size = UDim2.new(1, 0, 0, 28)
            search.BackgroundColor3 = Color3.new(1, 1, 1)
            search.BackgroundTransparency = 0.95
            search.BorderSizePixel = 0
            search.ClearTextOnFocus = false
            search.Font = Enum.Font.GothamMedium
            search.TextSize = 13
            search.TextColor3 = TEXT
            search.PlaceholderText = "Search..."
            search.PlaceholderColor3 = MUTED
            search.Text = ""
            search.TextXAlignment = Enum.TextXAlignment.Left
            search.Parent = p
            Instance.new("UICorner", search).CornerRadius = UDim.new(0, 8)
            local sp = Instance.new("UIPadding", search)
            sp.PaddingLeft = UDim.new(0, 10)

            local body = Instance.new("Frame")
            body.LayoutOrder = 2
            body.BackgroundTransparency = 1
            body.Size = UDim2.new(1, 0, 0, 190)
            body.Parent = p

            -- left list
            local scroll = Instance.new("ScrollingFrame")
            scroll.BackgroundColor3 = Color3.new(1, 1, 1)
            scroll.BackgroundTransparency = 0.97
            scroll.BorderSizePixel = 0
            scroll.Size = UDim2.new(1, -96, 1, 0)
            scroll.CanvasSize = UDim2.new()
            scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
            scroll.ScrollBarThickness = 3
            scroll.Parent = body
            Instance.new("UICorner", scroll).CornerRadius = UDim.new(0, 8)
            local spad = Instance.new("UIPadding", scroll)
            spad.PaddingLeft, spad.PaddingTop, spad.PaddingBottom = UDim.new(0, 5), UDim.new(0, 5), UDim.new(0, 5)
            local grid = Instance.new("UIGridLayout")
            grid.CellSize = UDim2.fromOffset(64, 80)
            grid.CellPadding = UDim2.fromOffset(5, 5)
            grid.SortOrder = Enum.SortOrder.LayoutOrder
            grid.Parent = scroll

            -- right preview
            local pv = Instance.new("Frame")
            pv.AnchorPoint = Vector2.new(1, 0)
            pv.Position = UDim2.new(1, 0, 0, 0)
            pv.Size = UDim2.new(0, 90, 1, 0)
            pv.BackgroundColor3 = Color3.new(1, 1, 1)
            pv.BackgroundTransparency = 0.95
            pv.BorderSizePixel = 0
            pv.Parent = body
            Instance.new("UICorner", pv).CornerRadius = UDim.new(0, 8)
            local pvName = label(pv, "Tap a blueprint", 11)
            pvName.AnchorPoint = Vector2.new(0.5, 1)
            pvName.Position = UDim2.new(0.5, 0, 1, -6)
            pvName.Size = UDim2.new(1, -8, 0, 30)
            pvName.TextWrapped = true
            pvName.TextColor3 = MUTED
            local pvThumb

            local function setPreview(name)
                if pvThumb then
                    pvThumb:Destroy()
                    pvThumb = nil
                end
                pvName.Text = name
                pvName.TextColor3 = TEXT
                pvThumb = makeThumb(pv, name, UDim2.new(1, -12, 0, 100), UDim2.fromOffset(6, 6))
            end

            local cards, selectedCard = {}, nil
            local function highlight(card)
                if selectedCard then
                    tween(selectedCard, 0.12, { BackgroundTransparency = 0.95 })
                end
                selectedCard = card
                if card then
                    tween(card, 0.12, { BackgroundTransparency = 0.8 })
                end
            end

            search:GetPropertyChangedSignal("Text"):Connect(function()
                local q = search.Text:lower()
                for _, c in ipairs(cards) do
                    c.btn.Visible = (q == "") or (c.name:lower():find(q, 1, true) ~= nil)
                end
            end)

            -- build cards in batches
            task.spawn(function()
                for i, bp in ipairs(ownedBlueprints()) do
                    if not body.Parent then
                        return
                    end
                    local c = Instance.new("TextButton")
                    c.LayoutOrder = i
                    c.AutoButtonColor = false
                    c.BackgroundColor3 = Color3.new(1, 1, 1)
                    c.BackgroundTransparency = (fresh and fresh.name == bp.name) and 0.8 or 0.95
                    c.BorderSizePixel = 0
                    c.Text = ""
                    c.Parent = scroll
                    Instance.new("UICorner", c).CornerRadius = UDim.new(0, 8)
                    press(c)
                    makeThumb(c, bp.name, UDim2.new(1, -8, 0, 50), UDim2.fromOffset(4, 4))
                    local nm = label(c, bp.name, 10)
                    nm.Position = UDim2.fromOffset(2, 56)
                    nm.Size = UDim2.new(1, -4, 0, 22)
                    nm.TextWrapped = true
                    nm.TextTruncate = Enum.TextTruncate.AtEnd
                    table.insert(cards, { btn = c, name = bp.name })
                    if fresh and fresh.name == bp.name then
                        selectedCard = c
                        setPreview(bp.name)
                    end
                    c.Activated:Connect(function()
                        if SpawnBlueprint(bp.name) then
                            highlight(c)
                            setPreview(bp.name)
                            say2("Move it, then press Place")
                        end
                    end)
                    if i % 6 == 0 then
                        task.wait()
                    end
                end
            end)
        end

        local btns = {}
        refresh = function()
            for _, b in ipairs(btns) do
                if b.active and b.tint then
                    tween(b.tint, 0.15, { [b.prop] = b.active() and TEXT or MUTED })
                end
            end
        end

        local function add(name, text, action, active)
            local b = Instance.new("TextButton")
            b.Size = UDim2.fromOffset(38, 38)
            b.Text = ""
            b.AutoButtonColor = false
            b.BackgroundColor3 = Color3.new(1, 1, 1)
            b.BackgroundTransparency = 1
            b.BorderSizePixel = 0
            b.Parent = row
            Instance.new("UICorner", b).CornerRadius = UDim.new(0, 9)
            local tintObj, tintProp
            local img = icon(name)
            if img then
                local i = Instance.new("ImageLabel")
                i.AnchorPoint = Vector2.new(0.5, 0.5)
                i.Position = UDim2.fromScale(0.5, 0.5)
                i.Size = UDim2.fromOffset(22, 22)
                i.BackgroundTransparency = 1
                i.Image = img
                i.ImageColor3 = MUTED
                i.Parent = b
                tintObj, tintProp = i, "ImageColor3"
            else
                local t = label(b, text, 10)
                t.Size = UDim2.fromScale(1, 1)
                t.TextWrapped = true
                t.TextColor3 = MUTED
                tintObj, tintProp = t, "TextColor3"
            end
            press(b)
            local rec = { frame = b, active = active, tint = tintObj, prop = tintProp }
            table.insert(btns, rec)
            b.Activated:Connect(function()
                if name ~= "settings" and name ~= "align-center-horizontal" and name ~= "boxes" then
                    closePanel()
                end
                say2(text, b)
                action(rec)
                refresh()
            end)
            return rec
        end

        add("x", "Close", function()
            CloseMode()
        end)
        add("move", "Move", function()
            ToolMode = "Move"
        end, function()
            return ToolMode == "Move"
        end)
        add("rotate-3d", "Rotate", function()
            ToolMode = "Rotate"
        end, function()
            return ToolMode == "Rotate"
        end)
        add("boxes", "Blueprints", function()
            openBlueprints()
        end, function()
            return panelName == "blueprints"
        end)
        add("settings", "Settings", function()
            openOptions()
        end, function()
            return panelName == "options"
        end)
        add("grid-3x3", "Grid snap", function()
            GridSnap = not GridSnap
            say2(GridSnap and "Grid snap: on (no overlap)" or "Grid snap: off (free)")
        end, function()
            return GridSnap
        end)
        add("align-center-horizontal", "Align", function()
            openAlign()
        end, function()
            return panelName == "align"
        end)
        add("undo", "Undo", function()
            if not Undo() then
                say2("Nothing to undo")
            end
        end)
        add("rotate-ccw", "Reset", function()
            if fresh then
                fresh.respawn()
            elseif selected and origCF then
                PushHistory()
                targetCF = origCF
                UpdateGhost()
            else
                say2("Nothing selected")
            end
        end)
        add("check", "Place", function()
            PlaceSelected()
        end)
        add("circle-x", "Deselect", function()
            ClearSelection()
            say2("Selection cleared")
        end)

        refresh()

        -- narrow screens
        local width = #btns * 40 + 12
        bar.Size = UDim2.fromOffset(width, 46)
        local scale = Instance.new("UIScale", bar)
        local function fit()
            local cam = workspace.CurrentCamera
            if cam then
                scale.Scale = math.min(1, (cam.ViewportSize.X - 16) / width)
            end
        end
        fit()
        bar.Position = UDim2.new(0.5, 0, 1, 70)
        tween(bar, 0.3, { Position = UDim2.new(0.5, 0, 1, -12) })
        if workspace.CurrentCamera then
            workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(fit)
        end
        task.delay(0.4, function()
            say2("Press and hold an item to select it")
        end)
    end

    local function OpenMode()
        if modeOpen then
            return
        end
        modeOpen = true
        wasOn = BuilderOn
        BuilderOn = true
        pcall(function()
            uiWasOpen = ui.mainframe.Visible
            ui.mainframe.Visible = false
        end)
        BuildModeBar()
    end

    CloseMode = function()
        if not modeOpen then
            return
        end
        modeOpen = false
        BuilderOn = wasOn
        ClearSelection()
        ClearAlignTarget()
        pcall(function()
            ui.mainframe.Visible = uiWasOpen
        end)
        local g = modeGui
        modeGui = nil
        if g then
            local f = g:FindFirstChildOfClass("Frame")
            if f then
                tween(f, 0.2, { Position = UDim2.new(0.5, 0, 1, 70) })
            end
            task.delay(0.25, function()
                g:Destroy()
            end)
        end
    end

    -- build files
    local BUILD_FOLDER = "Antler/Build Files"
    local UsePlacedItems = false -- use placed items as source
    local AB = { on = false, tried = false } -- auto buy missing items from the shops

    -- make sure the build folder exists
    local function EnsureBuildFolder()
        if not (makefolder and isfolder) then
            return
        end
        pcall(function()
            if not isfolder("Antler") then
                makefolder("Antler")
            end
            if not isfolder(BUILD_FOLDER) then
                makefolder(BUILD_FOLDER)
            end
        end)
    end
    EnsureBuildFolder()

    local function ListBuildFiles()
        EnsureBuildFolder()
        local names, map = {}, {}
        if listfiles and isfolder and isfolder(BUILD_FOLDER) then
            local ok, files = pcall(listfiles, BUILD_FOLDER)
            for _, path in ipairs(ok and files or {}) do
                local file = path:match("([^/\\]+)$")
                if file then
                    local shown = file:gsub("%.[Tt][Xx][Tt]$", "")
                    if not map[shown] then
                        map[shown] = file
                        table.insert(names, shown)
                    end
                end
            end
        end
        table.sort(names, function(a, b)
            return a:lower() < b:lower()
        end)
        return names, map
    end

    -- parse build file
    local function ParseBuildFile(text)
        local entries, propRelative = {}, false
        local section, seenFirst = nil, false
        for rawLine in (text .. "\n"):gmatch("(.-)\r?\n") do
            local line = rawLine:match("^%s*(.-)%s*$")
            if line ~= "" and line:sub(1, 2) ~= "--" then
                local low = line:lower()
                if not seenFirst and (low == "true" or low == "false") then
                    seenFirst = true
                    propRelative = (low == "true")
                else
                    seenFirst = true
                    local header = line:match("^%[(.-)%]$")
                    if header then
                        section = header:lower()
                    else
                        local fields = {}
                        for part in (line .. "|"):gmatch("([^|]*)|") do
                            table.insert(fields, (part:match("^%s*(.-)%s*$")))
                        end
                        local name = fields[1]
                        if name and name ~= "" and name ~= "Wire" and fields[2] then
                            local nums = {}
                            for n in fields[2]:gmatch("[^,%s]+") do
                                table.insert(nums, tonumber(n))
                            end
                            local valid = (#nums == 12)
                            for i = 1, #nums do
                                if nums[i] == nil then
                                    valid = false
                                end
                            end
                            if valid then
                                local tree = fields[3]
                                if tree == "" then
                                    tree = nil
                                end
                                table.insert(entries, {
                                    name = name,
                                    rel = CFrame.new(table.unpack(nums)),
                                    tree = tree,
                                    furniture = (section == "furniture"),
                                })
                            end
                        end
                    end
                end
            end
        end
        return entries, propRelative
    end

    local function PlotCenterOf(player)
        local props = workspace:FindFirstChild("Properties")
        for _, pr in ipairs(props and props:GetChildren() or {}) do
            local o = pr:FindFirstChild("Owner")
            if o and o.Value == player then
                local origin = pr:FindFirstChild("OriginSquare", true)
                if origin and origin:IsA("BasePart") then
                    return origin.Position
                end
            end
        end
        return nil
    end

    -- planks and sources
    local PlankMin, PlankMax = 1, 2 -- plank volume range
    local allPlanks, plankIndex = {}, 1

    -- all owned planks
    local function ScanPlanks()
        allPlanks, plankIndex = {}, 1
        local pmF = workspace:FindFirstChild("PlayerModels")
        for _, m in ipairs(pmF and pmF:GetChildren() or {}) do
            if m.Name == "Plank" and m:IsA("Model") and IsMine(m) then
                local tc = m:FindFirstChild("TreeClass")
                local part = m:FindFirstChild("Main") or m:FindFirstChildWhichIsA("BasePart")
                if part and part:IsA("BasePart") then
                    local sz = part.Size
                    local vol = math.floor(sz.X * sz.Y * sz.Z * 10 + 0.5) / 10
                    table.insert(allPlanks, {
                        model = m,
                        part = part,
                        volume = vol,
                        treeClass = (tc and tc:IsA("StringValue")) and tc.Value or "",
                    })
                end
            end
        end
    end

    local function FilteredPlanks()
        local out = {}
        for _, e in ipairs(allPlanks) do
            if e.part.Parent and e.volume >= PlankMin and e.volume <= PlankMax then
                table.insert(out, e)
            end
        end
        return out
    end

    -- next plank of wood type
    local function NextPlank(treeClass)
        local list = FilteredPlanks()
        if #list == 0 then
            return nil
        end
        if treeClass and treeClass ~= "" then
            for attempt = 1, #list do
                local idx = ((plankIndex - 1 + attempt - 1) % #list) + 1
                if list[idx].treeClass == treeClass then
                    plankIndex = (idx % #list) + 1
                    return list[idx]
                end
            end
        end
        local idx = ((plankIndex - 1) % #list) + 1
        plankIndex = (idx % #list) + 1
        return list[idx]
    end

    -- item counts available to build
    local function SourceCounts()
        local have, furn = {}, {}
        local pmF = workspace:FindFirstChild("PlayerModels")
        for _, m in ipairs(pmF and pmF:GetChildren() or {}) do
            if m:IsA("Model") and IsMine(m) then
                local box = m:FindFirstChild("PurchasedBoxItemName")
                if box then
                    have[box.Value] = (have[box.Value] or 0) + 1
                else
                    local kind = KindOf(m)
                    local iname = m:FindFirstChild("ItemName")
                    local nm = iname and iname.Value or ""
                    if nm ~= "" then
                        if kind == "Furniture" then
                            furn[nm] = (furn[nm] or 0) + 1
                        elseif kind == "Structure" and UsePlacedItems then
                            have[nm] = (have[nm] or 0) + 1
                        end
                    end
                end
            end
        end
        return have, furn
    end

    -- pre-build checks
    local function Preflight(entries)
        local have, furn = SourceCounts()
        local needStruct, woodNeeded, furnNeeded = {}, 0, {}

        for _, e in ipairs(entries) do
            if e.tree then
                if (have[e.name] or 0) == 0 then
                    woodNeeded = woodNeeded + 1
                end
            elseif e.furniture then
                furnNeeded[e.name] = true
            else
                needStruct[e.name] = (needStruct[e.name] or 0) + 1
            end
        end

        if woodNeeded > 0 and dx and dx.LOT then
            local planks = FilteredPlanks()
            if #planks < woodNeeded then
                return false,
                    ("Not enough planks, need %d, have %d in volume range %d-%d"):format(
                        woodNeeded,
                        #planks,
                        PlankMin,
                        PlankMax
                    )
            end
        end

        local missing = {}
        for name, need in pairs(needStruct) do
            local h = have[name] or 0
            if h < need then
                table.insert(missing, ("%s: need %d, have %d"):format(name, need, h))
            end
        end
        if #missing > 0 then
            table.sort(missing)
            return false, "Missing items: " .. table.concat(missing, "; ")
        end

        local missingF = {}
        for name in pairs(furnNeeded) do
            if (furn[name] or 0) == 0 then
                table.insert(missingF, name)
            end
        end
        if #missingF > 0 then
            table.sort(missingF)
            return false, "Missing furniture (not owned): " .. table.concat(missingF, ", ")
        end
        return true
    end

    -- items the build needs that we do not own enough of (name -> how many short)
    AB.Missing = function(entries)
        local have = SourceCounts()
        local need, missing = {}, {}
        for _, e in ipairs(entries) do
            if not e.tree and not e.furniture then
                need[e.name] = (need[e.name] or 0) + 1
            end
        end
        for name, n in pairs(need) do
            local h = have[name] or 0
            if h < n then
                missing[name] = n - h
            end
        end
        return missing
    end

    -- check the shops for the missing items and buy what is in stock (yields until done)
    AB.Run = function(entries, token)
        local missing = AB.Missing(entries)
        if next(missing) == nil then
            return false
        end

        local shop = dx and dx.Shop
        if not (shop and shop.GetItems and shop.GetStock and shop.PurchaseItem) then
            Notify("Antler", "The shop module is not loaded yet.", 4)
            return false
        end

        local byBox = {}
        for _, it in ipairs(shop.GetItems() or {}) do
            if it.BoxItemName then
                byBox[it.BoxItemName] = it
            end
        end

        local names = {}
        for name in pairs(missing) do
            table.insert(names, name)
        end
        table.sort(names)

        local funds = shop.GetFunds and shop.GetFunds()
        local plan, notSold, lowStock, noFunds = {}, {}, {}, {}
        for _, name in ipairs(names) do
            local need = missing[name]
            local it = byBox[name]
            if not it then
                table.insert(notSold, name)
            else
                local stock = shop.GetStock(it.Name) or 0
                local qty = math.min(need, stock)
                if qty < need then
                    table.insert(lowStock, ("%s (need %d, shop has %d)"):format(it.Name, need, stock))
                end
                if qty > 0 and funds and it.Price then
                    local afford = math.floor(funds / it.Price)
                    if afford < qty then
                        table.insert(noFunds, it.Name)
                        qty = afford
                    end
                    funds = funds - qty * it.Price
                end
                if qty > 0 then
                    table.insert(plan, { item = it, qty = qty })
                end
            end
        end

        if #notSold > 0 then
            Notify("Antler", "Not sold in any shop: " .. table.concat(notSold, ", "), 6)
        end
        if #lowStock > 0 then
            Notify("Antler", "Low stock: " .. table.concat(lowStock, ", "), 6)
        end
        if #noFunds > 0 then
            Notify("Antler", "Cannot afford all of: " .. table.concat(noFunds, ", "), 6)
        end
        if #plan == 0 then
            return false
        end

        local bought = false
        for idx, p in ipairs(plan) do
            if token ~= groupToken then
                break
            end
            local waited = tick()
            while shop.IsBuying and shop.IsBuying() and tick() - waited < 15 do
                task.wait(0.2)
            end
            Notify("Antler", ("Buying %s x%d (%d/%d)"):format(p.item.Name, p.qty, idx, #plan), 3)

            local finished = false
            local ok, why = shop.PurchaseItem(p.item.Name, p.qty, nil, function()
                finished = true
            end)
            if not ok then
                Notify("Antler", ("Could not buy %s: %s"):format(p.item.Name, tostring(why)), 4)
            else
                bought = true
                local limit = tick() + 60 + p.qty * 10
                while not finished and tick() < limit do
                    if token ~= groupToken then
                        if shop.Stop then
                            shop.Stop()
                        end
                        break
                    end
                    task.wait(0.25)
                end
                if not finished and shop.Stop and token == groupToken then
                    shop.Stop() -- gave up waiting (out of stock or too slow)
                end
            end
        end
        return bought
    end

    -- show the build as one ghost
    local function SpawnGroup(entries, propRel, label)
        local items = ReplicatedStorage:FindFirstChild("ClientItemInfo")
        if not items then
            Notify("Antler", "Item info not found.", 3)
            return false
        end

        ClearSelection() -- drop earlier blueprint

        local cam = workspace.CurrentCamera
        local char = LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")

        local originCF, onGround = nil, false
        if propRel then
            local c = PlotCenterOf(PlotOwner())
            if c then
                originCF = CFrame.new(c)
            else
                Notify(
                    "Antler",
                    "This file is saved relative to a property, but none was found. Placing it in front of you.",
                    4
                )
            end
        end
        if not originCF then
            local base = root and root.Position or (cam and cam.CFrame.Position) or Vector3.zero
            local look = root and root.CFrame.LookVector or (cam and cam.CFrame.LookVector) or Vector3.new(0, 0, -1)
            local flat = Vector3.new(look.X, 0, look.Z)
            flat = (flat.Magnitude > 0.01) and flat.Unit or Vector3.new(0, 0, -1)
            local pos = base + flat * 18
            local params = RaycastParams.new()
            params.FilterType = Enum.RaycastFilterType.Exclude
            params.FilterDescendantsInstances = { ghostFolder, char }
            local hit = workspace:Raycast(pos + Vector3.new(0, 60, 0), Vector3.new(0, -200, 0), params)
            originCF = CFrame.new(pos.X, hit and hit.Position.Y or pos.Y, pos.Z)
            onGround = true
        end

        local gm = Instance.new("Model")
        gm.Name = "BuildGroup"
        local origin = Instance.new("Part")
        origin.Name = "Origin"
        origin.Size = Vector3.new(1, 1, 1)
        origin.Transparency = 1
        origin.Anchored, origin.CanCollide, origin.CanQuery, origin.CanTouch = true, false, false, false
        origin.CFrame = originCF
        origin.Parent = gm
        gm.PrimaryPart = origin

        -- no collide or hit
        local function soften(d)
            d.Anchored = true
            d.CanCollide = false
            d.CanTouch = false
            d.CanQuery = false
        end

        -- copy owned items to keep textures
        local ownedByKey, ownedByName = {}, {}
        local pmFolder = workspace:FindFirstChild("PlayerModels")
        for _, m in ipairs(pmFolder and pmFolder:GetChildren() or {}) do
            if m:IsA("Model") and not m:FindFirstChild("PurchasedBoxItemName") and KindOf(m) and IsMine(m) then
                local iname = m:FindFirstChild("ItemName")
                local nm = iname and iname.Value or ""
                if nm ~= "" then
                    local bwc = m:FindFirstChild("BlueprintWoodClass")
                    local key = nm .. "|" .. tostring(bwc and bwc.Value or "")
                    if not ownedByKey[key] then
                        ownedByKey[key] = m
                    end
                    if not ownedByName[nm] then
                        ownedByName[nm] = m
                    end
                end
            end
        end
        local function ownedSource(e)
            local m = ownedByKey[e.name .. "|" .. tostring(e.tree or "")] or ownedByName[e.name]
            if m and m.Parent then
                return m
            end
            return nil
        end

        local missing, built = {}, 0
        for i, e in ipairs(entries) do
            local info = items:FindFirstChild(e.name)
            -- real item model
            local tpl = nil
            if info then
                local real = info:FindFirstChild("Model")
                if real and real:IsA("Model") then
                    tpl = real
                else
                    tpl = info:FindFirstChildOfClass("Model") or info:FindFirstChild("PlacingModel")
                end
            end
            local source = ownedSource(e) or tpl -- real item, template fallback
            if source then
                local c = source:Clone()
                if c:IsA("BasePart") then
                    soften(c)
                end
                for _, d in ipairs(c:GetDescendants()) do
                    if d:IsA("BasePart") then
                        soften(d)
                    elseif d:IsA("LuaSourceContainer") or d:IsA("Sound") then
                        d:Destroy()
                    end
                end
                local prim = c:IsA("Model") and c.PrimaryPart or nil
                local refCF = prim and prim.CFrame or c:GetPivot()
                local offset = refCF:ToObjectSpace(c:GetPivot())
                c:PivotTo(originCF * e.rel * offset)
                c.Parent = gm
                built = built + 1
            else
                missing[e.name] = true
            end
            if i % 12 == 0 then
                task.wait()
            end
        end

        gm.Parent = ghostFolder

        -- put build on the ground
        if onGround then
            local okB, bbCF, bbSize = pcall(function()
                return gm:GetBoundingBox()
            end)
            if okB then
                local shift = (originCF.Position.Y - (bbCF.Position.Y - bbSize.Y / 2))
                local up = Vector3.new(0, shift, 0)
                originCF = originCF + up
                gm:PivotTo(gm:GetPivot() + up)
            end
        end

        local ref = Instance.new("Model")
        ref.Name = "BuildGroupRef"
        local refOrigin = origin:Clone()
        refOrigin.CFrame = originCF
        refOrigin.Parent = ref
        ref.PrimaryPart = refOrigin
        ref.Parent = refFolder

        fresh = {
            group = entries,
            ref = ref,
            name = label,
            respawn = function()
                SpawnGroup(entries, propRel, label)
            end,
        }
        selected = ref
        origCF = originCF
        targetCF = originCF
        ghost = gm
        fileBuild = true -- set after clearselection

        local okS, size = pcall(function()
            return gm:GetExtentsSize()
        end)
        ghostRadius = (okS and size) and math.min(math.max(size.Magnitude / 2, 3), 30) or 6
        UpdateGhost()

        local missingList = {}
        for n in pairs(missing) do
            table.insert(missingList, n)
        end
        if #missingList > 0 then
            table.sort(missingList)
            Notify("Antler", "No model for: " .. table.concat(missingList, ", "), 5)
        end
        return built > 0
    end

    -- place each item of the build
    PlaceGroup = function()
        if placing or not (fresh and fresh.group and targetCF) then
            return
        end
        local ps = ReplicatedStorage:FindFirstChild("PlaceStructure")
        local rBlueprint = ps and ps:FindFirstChild("ClientPlacedBlueprint")
        local rStructure = ps and ps:FindFirstChild("ClientPlacedStructure")
        local pm = workspace:FindFirstChild("PlayerModels")
        if not (rBlueprint and rStructure and pm) then
            Notify("Antler", "Placement remotes not found.", 3)
            return
        end

        ScanPlanks()
        local okPre, why = Preflight(fresh.group)

        -- auto buy: look in the shops for whatever is missing, buy it, then try again
        if not okPre and AB.on and not AB.tried then
            AB.tried = true
            placing = true
            local abToken = groupToken
            local group = fresh.group
            task.spawn(function()
                local ok, err = pcall(AB.Run, group, abToken)
                if not ok then
                    warn("[Build] auto buy failed: " .. tostring(err))
                end
                placing = false
                if ok then
                    task.wait(0.5) -- let the bought boxes show up
                end
                if abToken == groupToken and fresh and fresh.group == group then
                    PlaceGroup()
                else
                    AB.tried = false
                end
            end)
            return
        end
        AB.tried = false

        if not okPre then
            Notify("Antler", why, 7)
            return
        end

        placing = true
        groupToken = groupToken + 1
        local myToken = groupToken
        local entries = fresh.group
        local base = targetCF
        local owner = PlotOwner()
        local LOT = dx and dx.LOT

        task.spawn(function()
            local total, placedCount = #entries, 0
            local missingSrc, usedSrc, madeModels = {}, {}, {}
            local anyBlueprint, noPlank = false, 0

            local function snapshot()
                local s = {}
                for _, m in ipairs(pm:GetChildren()) do
                    s[m] = true
                end
                return s
            end

            local function findNew(before, test)
                for _, m in ipairs(pm:GetChildren()) do
                    if not before[m] and test(m) then
                        return m
                    end
                end
                return nil
            end

            local function sameItem(m, name)
                local iname = m:FindFirstChild("ItemName")
                return iname ~= nil and iname.Value == name
            end

            local function findSource(e)
                if e.furniture then
                    for _, m in ipairs(pm:GetChildren()) do
                        if
                            m:IsA("Model")
                            and not usedSrc[m]
                            and not madeModels[m]
                            and not m:FindFirstChild("PurchasedBoxItemName")
                            and KindOf(m) == "Furniture"
                            and sameItem(m, e.name)
                            and IsMine(m)
                        then
                            return m, false
                        end
                    end
                    return nil
                end
                for _, m in ipairs(pm:GetChildren()) do
                    local box = m:FindFirstChild("PurchasedBoxItemName")
                    if box and box.Value == e.name and not usedSrc[m] and IsMine(m) then
                        return m, true
                    end
                end
                if UsePlacedItems then
                    for _, m in ipairs(pm:GetChildren()) do
                        if
                            m:IsA("Model")
                            and not usedSrc[m]
                            and not madeModels[m]
                            and not m:FindFirstChild("PurchasedBoxItemName")
                            and KindOf(m) == "Structure"
                            and sameItem(m, e.name)
                            and IsMine(m)
                        then
                            return m, false
                        end
                    end
                end
                return nil
            end

            local function center(bp)
                if bp.PrimaryPart then
                    return bp.PrimaryPart.Position
                end
                local sum, count = Vector3.new(), 0
                for _, p in ipairs(bp:GetDescendants()) do
                    if p:IsA("BasePart") then
                        sum = sum + p.Position
                        count = count + 1
                    end
                end
                return count > 0 and (sum / count) or Vector3.new()
            end

            -- teleport plank into blueprint
            local function fillWithPlank(bp, tree)
                if not LOT then
                    return
                end
                local entry = NextPlank(tree)
                if not entry then
                    noPlank = noPlank + 1
                    return
                end

                local sent = false
                for _ = 1, 6 do
                    if myToken ~= groupToken then
                        return
                    end
                    if LOT.TeleportObjectTo(entry.part, CFrame.new(center(bp))) ~= false then
                        sent = true
                        break
                    end
                    task.wait(0.25)
                end
                if not sent then
                    noPlank = noPlank + 1
                    return
                end
                if LOT.WaitForBatch then
                    LOT.WaitForBatch()
                end

                local deadline = tick() + 3
                while bp and bp.Parent and tick() < deadline and myToken == groupToken do
                    if entry.part and entry.part.Parent then
                        entry.part.CFrame = CFrame.new(center(bp))
                        entry.part.AssemblyLinearVelocity = Vector3.zero
                        entry.part.AssemblyAngularVelocity = Vector3.zero
                    end
                    task.wait(0.1)
                end
            end

            for i, e in ipairs(entries) do
                if myToken ~= groupToken then
                    break
                end
                local worldCF = base * e.rel
                local before = snapshot()
                local made

                if e.tree then
                    anyBlueprint = true
                    local deadline, retryAt = tick() + 9, 0
                    while tick() < deadline and not made and myToken == groupToken do
                        if tick() >= retryAt then
                            rBlueprint:FireServer(e.name, worldCF, owner)
                            retryAt = tick() + 4
                        end
                        made = findNew(before, function(m)
                            return KindOf(m) == "Blueprint" and sameItem(m, e.name)
                        end)
                        task.wait()
                    end
                    if made then
                        fillWithPlank(made, e.tree)
                    end
                else
                    local src, boxed = findSource(e)
                    if not src then
                        missingSrc[e.name] = (missingSrc[e.name] or 0) + 1
                    else
                        usedSrc[src] = true
                        local deadline, retryAt = tick() + 9, 0
                        while tick() < deadline and not made and myToken == groupToken do
                            if tick() >= retryAt then
                                if boxed then
                                    rStructure:FireServer(e.name, worldCF, owner, nil, src, false, true)
                                elseif e.furniture then
                                    rStructure:FireServer(e.name, worldCF, owner, false, src, true)
                                else
                                    local bwc = src:FindFirstChild("BlueprintWoodClass")
                                    rStructure:FireServer(e.name, worldCF, owner, bwc and bwc.Value or false, src, true)
                                end
                                retryAt = tick() + 2
                            end
                            made = findNew(before, function(m)
                                local k = KindOf(m)
                                if e.furniture then
                                    return k == "Furniture" and sameItem(m, e.name)
                                end
                                return k ~= nil and k ~= "Blueprint" and k ~= "Furniture" and sameItem(m, e.name)
                            end)
                            task.wait()
                        end
                    end
                end

                if made then
                    madeModels[made] = true
                    placedCount = placedCount + 1
                end
                if i % 10 == 0 or i == total then
                    Notify("Antler", ("Building %d / %d"):format(i, total), 1.5)
                end
            end

            placing = false
            if myToken ~= groupToken then
                Notify("Antler", ("Build cancelled (%d placed)."):format(placedCount), 3)
                return
            end

            local msg = ("Done! %d / %d placed."):format(placedCount, total)
            local parts = {}
            for n, c in pairs(missingSrc) do
                table.insert(parts, n .. " x" .. c)
            end
            table.sort(parts)
            if #parts > 0 then
                msg = msg .. " Missing: " .. table.concat(parts, ", ")
            end
            Notify("Antler", msg, 6)
            if anyBlueprint and not LOT then
                Notify("Antler", "Blueprints are placed empty (the teleport module is not loaded).", 5)
            elseif noPlank > 0 then
                Notify("Antler", noPlank .. " blueprint(s) could not be filled (no plank).", 5)
            end
            ClearSelection() -- remove preview
        end)
    end

    -- ui
    local modeSec = BuildTab:section("Build Mode", true)
    modeSec:Button("Build Mode", function()
        if modeOpen then
            CloseMode()
        else
            OpenMode()
        end
    end)
end
InitBuilder()

-- settings
task.wait()
local SettingsTab = window:Tab("Settings", "6034509993")

local themeSection = SettingsTab:section("Themes", true)

themeDropdown = themeSection:Dropdown("Theme", "theme", themeNames, function(Value)
    ApplyTheme(Value)
    if uiReady then
        SaveConfig("default")
    end
end)
themeDropdown:SetSelected(currentTheme)

local customSection = SettingsTab:section("Custom Theme", true)
local colorLabels = {
    BackgroundColor = "Background",
    AccentColor = "Accent",
    GrayContrastColor = "Section",
    DarkContrastColor = "Dark",
    TextColor = "Text",
}
syncing = true
for _, key in ipairs(themeKeys) do
    pickers[key] = customSection:ColorPicker(colorLabels[key], themes[currentTheme][key], function(color)
        SetCustomColor(key, color)
    end)
end
syncing = false

local reloadSection = SettingsTab:section("Auto Reload", true)

autoToggle = reloadSection:Toggle("Reload On Teleport", "autoreload", autoReload, function(Value)
    autoReload = Value
    if uiReady then
        SaveConfig("default")
        if Value and not FileExists(scriptFile) then
            Notify("Antler", "Put " .. scriptFile .. " in your executor workspace folder", 4)
        end
    end
end)

scriptBox = reloadSection:Textbox("Script File", "scriptfile", scriptFile, function(Value)
    local clean = tostring(Value):gsub("[^%w_%-%./ ]", "")
    if clean ~= "" then
        scriptFile = clean
        SaveConfig("default")
    end
end)

local configSection = SettingsTab:section("Configs", true)
local configName = "default"

configSection:Textbox("Config Name", "configname", "default", function(Value)
    local clean = tostring(Value):gsub("[^%w_%-]", "")
    if clean ~= "" then
        configName = clean
    end
end)

configSection:Button("Save Config", function()
    if SaveConfig(configName) then
        Notify("Antler", "Saved config " .. configName, 2)
    else
        Notify("Antler", "Could not save config", 2)
    end
end)

configSection:Button("Load Config", function()
    if LoadConfig(configName) then
        themeDropdown:SetSelected(currentTheme)
        Notify("Antler", "Loaded config " .. configName, 2)
    else
        Notify("Antler", "Config not found", 2)
    end
end)

local set = SettingsTab:section("Game Settings", true)
set:Button("Server Hop", function()
    local module =
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LeoKholYt/roblox/main/lk_serverhop.lua"))()

    module:Teleport(13822889)
end)

set:Button("Rejoin", function()
    local game_id = 13822889
    game:GetService("TeleportService"):Teleport(game_id, game.Players.LocalPlayer)
end)

set:Button("Kill Roblox", function()
    game:Shutdown()
end)

set:Toggle("Anti-AFK", "Anti AFK", true, function(Val)
    AntiAFK(Val)
end)

set:Toggle("LT2 Music", "", true, function(Value)
    game.Players.LocalPlayer.Music.Value = Value
end)

set:Keybind("Toggle Sit", Enum.KeyCode.LeftAlt, function(Value)
    local PlayerHumanoid = game.Workspace[game.Players.LocalPlayer.Name].Humanoid
    PlayerHumanoid.Sit = true
end)

local set = SettingsTab:section("UI", true)

set:Button("Destroy GUI", function()
    ui.screengui:Destroy()
end)

set:Keybind("Toggle UI", Enum.KeyCode.Home, function(Value)
    ToggleUILib()
end)

-- welcome
uiReady = true
ui.notify("notify", "Antler loaded", 4)
