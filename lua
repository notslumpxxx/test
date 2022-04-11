loadstring(game:HttpGet("https://raw.githubusercontent.com/progamergamerpro12041/UI-OUTLINE/main/border%20line"))()

local DiscordLib = loadstring(game:HttpGet"https://raw.githubusercontent.com/notslumpxx/BETA-UI/main/.lua")()

local win = DiscordLib:Window("Luna Hub Explorer")

local serv = win:Server("Luna Da Hood", "")

local btns = serv:Channel("Main Scripts")

FLYMODE = 'Default'
FLYSPEED = 20
btns:Button("Fly ( X )", function()
        if FLYMODE == 'Default' then
            local plr = game.Players.LocalPlayer
            local Humanoid = plr.Character:FindFirstChildWhichIsA('Humanoid')
            local mouse = plr:GetMouse()
            localplayer = plr
            if workspace:FindFirstChild("Core") then
                workspace.Core:Destroy()
            end
            local Core = Instance.new("Part")
            Core.Name = "Core"
            Core.Size = Vector3.new(0.05, 0.05, 0.05)
            spawn(function()
                Core.Parent = workspace
                local Weld = Instance.new("Weld", Core)
                Weld.Part0 = Core
                Weld.Part1 = localplayer.Character.LowerTorso
                Weld.C0 = CFrame.new(0, 0, 0)
            end)
            workspace:WaitForChild("Core")
            local torso = workspace.Core
            flying = true
            local speed=FLYSPEED
            local keys={a=false,d=false,w=false,s=false}
            local e1
            local e2
            local function start()
                local pos = Instance.new("BodyPosition",torso)
                local gyro = Instance.new("BodyGyro",torso)
                pos.Name="EPIXPOS"
                pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
                pos.position = torso.Position
                gyro.maxTorque = Vector3.new(15e15, 15e15, 15e15)
                gyro.cframe = torso.CFrame
                repeat
                    wait()
                    Humanoid.PlatformStand=true
                    local new=gyro.cframe - gyro.cframe.p + pos.position
                    if not keys.w and not keys.s and not keys.a and not keys.d then
                        speed=FLYSPEED
                    end
                    if keys.w then
                        new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
                        speed=speed
                    end
                    if keys.s then
                        new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
                        speed=speed
                    end
                    if keys.d then
                        new = new * CFrame.new(speed,0,0)
                        speed=speed
                    end
                    if keys.a then
                        new = new * CFrame.new(-speed,0,0)
                        speed=speed
                    end
                    if speed>FLYSPEED then
                        speed=FLYSPEED
                    end
                    pos.position=new.p
                    if keys.w then
                        gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(-math.rad(speed),0,0)
                    elseif keys.s then
                        gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(math.rad(speed),0,0)
                    else
                        gyro.cframe = workspace.CurrentCamera.CoordinateFrame
                    end
                until flying == false
                if gyro then gyro:Destroy() end
                if pos then pos:Destroy() end
                flying=false
                Humanoid.PlatformStand=false
                speed=FLYSPEED
            end
            e1=mouse.KeyDown:connect(function(key)
                if not torso or not torso.Parent then flying=false e1:disconnect() e2:disconnect() return end
                if key=="w" then
                    keys.w=true
                elseif key=="s" then
                    keys.s=true
                elseif key=="a" then
                    keys.a=true
                elseif key=="d" then
                    keys.d=true
                elseif key=="x" then
                    if flying==true then
                        flying=false
                    else
                        flying=true
                        start()
                    end
                end
            end)
            e2=mouse.KeyUp:connect(function(key)
                if key=="w" then
                    keys.w=false
                elseif key=="s" then
                    keys.s=false
                elseif key=="a" then
                    keys.a=false
                elseif key=="d" then
                    keys.d=false
                end
            end)
            start()
        else
            repeat wait() until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:findFirstChild("Head") and game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
            local mouse = game.Players.LocalPlayer:GetMouse()
            repeat wait() until mouse
            local plr = game.Players.LocalPlayer
            local torso = plr.Character.Head
            local flying = false
            local deb = true
            local ctrl = {f = 0, b = 0, l = 0, r = 0}
            local lastctrl = {f = 0, b = 0, l = 0, r = 0}
            local maxspeed = 5000
            local speed = 5000
            function Fly()
                local bg = Instance.new("BodyGyro", torso)
                bg.P = 9e4
                bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
                bg.cframe = torso.CFrame
                local bv = Instance.new("BodyVelocity", torso)
                bv.velocity = Vector3.new(0,0.1,0)
                bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
                repeat wait()
                    plr.Character:FindFirstChildWhichIsA('Humanoid').PlatformStand = true
                    if ctrl.l + ctrl.r ~= 100000 or ctrl.f + ctrl.b ~= 10000 then
                        speed = speed+.0+(speed/maxspeed)
                        if speed > maxspeed then
                            speed = maxspeed
                        end
                    elseif not (ctrl.l + ctrl.r ~= 5 or ctrl.f + ctrl.b ~= 5) and speed ~= 5 then
                        speed = speed-5
                        if speed > 5 then
                            speed = -2
                        end
                    end
                    if (ctrl.l + ctrl.r) ~= 5 or (ctrl.f + ctrl.b) ~= 5 then
                        bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
                        lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
                    elseif (ctrl.l + ctrl.r) == 5 and (ctrl.f + ctrl.b) == 5 and speed ~= 5 then
                        bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
                    else
                        bv.velocity = Vector3.new(0,0.1,0)
                    end
                    bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
                until not flying
                ctrl = {f = 0, b = 0, l = 0, r = 0}
                lastctrl = {f = 0, b = 0, l = 0, r = 0}
                speed = 5
                bg:Destroy()
                bv:Destroy()
                plr.Character:FindFirstChildWhichIsA('Humanoid').PlatformStand = false
            end
            mouse.KeyDown:connect(function(key)
                if key:lower() == "x" then
                    if flying then flying = false
                    else
                        flying = true
                        Fly()
                    end
                elseif key:lower() == "w" then
                    ctrl.f = FLYSPEED
                elseif key:lower() == "s" then
                    ctrl.b = -FLYSPEED
                elseif key:lower() == "a" then
                    ctrl.l = -FLYSPEED
                elseif key:lower() == "d" then
                    ctrl.r = FLYSPEED
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
    end)
btns:Button("Fly Type", function()
            if FLYMODE == 'Default' then
            FLYMODE = 'IY'
        game.StarterGui:SetCore("SendNotification", {
        Title = "Luna",
        Text = 'Fly ( Glitchy ) / Reset To Change.',
        Duration = 2,
        })
        else
            FLYMODE = 'Default'
        game.StarterGui:SetCore("SendNotification", {
        Title = "Luna",
        Text = 'Default Fly / Reset To Change.',
        Duration = 2,
        })
        end
    end)
    
btns:Button("Fly Speed [+]", function()
        FLYSPEED = FLYSPEED + 1
        game.StarterGui:SetCore("SendNotification", {
        Title = "Luna",
        Text = " [+] The Fly Speed Is Now, " ..(tostring(FLYSPEED))..".",
        Duration = 1,
    })
    end)
    
btns:Button("Fly Speed [-]", function()
        FLYSPEED = FLYSPEED - 1
        game.StarterGui:SetCore("SendNotification", {
        Title = "Luna",
        Text = " [-] The Fly Speed Is Now, " ..(tostring(FLYSPEED))..".",
        Duration = 1,
    })
end)


win:Server("Main", "http://www.roblox.com/asset/?id=6031075938")
