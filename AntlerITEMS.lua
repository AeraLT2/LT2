local library = {}
local Objects = {BackgroundColor = {}, AccentColor = {}, TextColor = {}, GrayContrastColor = {}, DarkContrastColor = {}}
local ObjectsSearch = {}
local Highlighted = {}
local showsearch = true
--["http://www.roblox.com/asset/?id=5865572413","http://www.roblox.com/asset/?id=5865316406","http://www.roblox.com/asset/?id=5868605950","http://www.roblox.com/asset/?id=6021404469","http://www.roblox.com/asset/?id=5054982349","http://www.roblox.com/asset/?id=5118428654","rbxassetid://4695575676","http://www.roblox.com/asset/?id=5674514673","rbxassetid://5113592272","rbxassetid://5113600420"]

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
local txts = game:GetService("TextService")
local playergui = game:GetService("Players").LocalPlayer.PlayerGui
local categoryopacity,categorytopacity = 0,0
local textcolorsave = Color3.fromRGB(255,255,255)

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

	if game:GetService("CoreGui"):FindFirstChild("Azure") then
		game:GetService("CoreGui").Azure:Destroy()
	end

	local firstcategory = true

	local categoryopendname

	local main = {}

	main.screengui = library.create("ScreenGui" ,{
		Name = "Azure",
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
			ts:Create(Notifications[2], TweenInfo.new(0.08), {Size = UDim2.new(0, 350, 0, 0)}):Play()
			wait(.09)
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
			NotificationTemplate.ImageColor3 = Color3.fromRGB(40, 40, 40)
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
			NotificationTemplate.ImageColor3 = Color3.fromRGB(40, 40, 40)
			NotificationTemplate.ScaleType = Enum.ScaleType.Slice
			NotificationTemplate.SliceCenter = Rect.new(100, 100, 100, 100)
			NotificationTemplate.SliceScale = 0.060

			NotificationTemplate.MouseEnter:Connect(function()
				ts:Create(NotificationTemplate, TweenInfo.new(0.1), {ImageColor3 = Color3.fromRGB(80,80,80)}):Play()
			end)
			NotificationTemplate.MouseLeave:Connect(function()
				ts:Create(NotificationTemplate, TweenInfo.new(0.1), {ImageColor3 = Color3.fromRGB(40, 40, 40)}):Play()
			end)
			NotificationTemplate.MouseButton1Click:Connect(function()
				ts:Create(NotificationTemplate, TweenInfo.new(0.08), {Size = UDim2.new(0, 350, 0, 0)}):Play()
				wait(.09)
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
		Text.TextColor3 = Color3.fromRGB(255, 255, 255)
		Text.TextSize = 14.000
		Text.TextWrapped = true
		Text.TextXAlignment = Enum.TextXAlignment.Left
		
		Icon.Name = "Icon"
		Icon.Parent = NotificationTemplate
		Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Icon.BackgroundTransparency = 1.000
		Icon.Position = UDim2.new(0, 8, 0, 5)
		Icon.Size = UDim2.new(0, 23, 0, 23)
		
		Title.Name = "Title"
		Title.Parent = NotificationTemplate
		Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Title.BackgroundTransparency = 1.000
		Title.Position = UDim2.new(0, 40, 0, 5)
		Title.Size = UDim2.new(0, 310, 0, 23)
		Title.Font = Enum.Font.GothamBold
		Title.Text = "Notification"
		Title.TextColor3 = Color3.fromRGB(255, 255, 255)
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
		NotificationTemplate.Name = #Notifications+1
		ts:Create(NotificationTemplate, TweenInfo.new(0.08), {Size = UDim2.new(0, 350, 0, 65)}):Play()
		spawn(function()
			delay((Duration or 4),function()
				if not returnwhat then
					if CallBack then 
						CallBack(false)
					end
				end
				ts:Create(NotificationTemplate, TweenInfo.new(0.08), {Size = UDim2.new(0, 350, 0, 0)}):Play()
				wait(.09)
				NotificationTemplate:Destroy()
			end)
		end)
		return NotificationTemplate
	end

	main.mainframe = library.create("ImageLabel", {
		Name = "MainFrame",
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1.000,
		AnchorPoint = Vector2.new(0.5,0.5),
		Position = UDim2.new(0.5, 0,0.5, 0),
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
		main.mainframe:TweenPosition(UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y), 'Out', 'Linear', 0.01, true)
	end

	main.navbar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
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
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
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
		Text = "Azure",
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
		Position = UDim2.new(0, 12, 0, 5),
		Size = UDim2.new(0, 25, 0, 3),
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
		Position = UDim2.new(0, 12, 0, 13),
		Size = UDim2.new(0, 25, 0, 3),
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
		Position = UDim2.new(0, 12, 0, 21),
		Size = UDim2.new(0, 25, 0, 3),
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
		Image = "http://www.roblox.com/asset/?id=5868605950",
		ImageColor3 = Themes.TextColor,
	})
	table.insert(Objects.TextColor, main.closebuttonmark)

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
					local distance = Vector2.new(mouse.X, mouse.Y) - sP;
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
				if (Check.UserInputType == Enum.UserInputType.MouseButton1 or Check.UserInputType == Enum.UserInputType.Touch) then
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
		PaddingTop = UDim.new(0,8),
		PaddingBottom = UDim.new(0,8),
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
		Image = "http://www.roblox.com/asset/?id=5868605950",
		ImageColor3 = Themes.TextColor,
	})
	table.insert(Objects.TextColor, main.closebuttonmarksearch)

	main.searchicon = library.create("ImageLabel", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1.000,
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0, 26, 0, 28),
		Image = "http://www.roblox.com/asset/?id=6021404469",
		ImageColor3 = Themes.TextColor,
	})
	table.insert(Objects.TextColor, main.searchicon)

	main.searchbox = library.create("TextBox", {
		Name = "SearchBox",
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 8, 0, -38),
		Size = UDim2.new(0.8, 0, 1, 0),
		PlaceholderColor3 = Color3.fromRGB(255, 255, 255),
		Text = "Search...",
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

	main.searchbox.Focused:Connect(function()
		main.mainframe["Categories"][categoryopendname].ScrollingFrame.Visible = false
	end)

	main.searchbox.Changed:Connect(function()
		
		local searchtext = main.searchbox.Text:lower()

		if searchtext ~= "" and main.searchbox.Position == UDim2.new(0, 8, 0, 0) then 
			for i,v in pairs(main.categories:GetChildren()) do 
				v.ScrollingFrame.Visible = false
			end
			for i,v in pairs(Highlighted) do 
				v.TextColor3 = textcolorsave
			end
			for i,v in pairs(ObjectsSearch) do
				local text = v:FindFirstChildOfClass("TextLabel")
				local answers = 0
				if text and text.Text:gsub("%s", ""):lower():sub(1, #searchtext) == searchtext then
					answers = answers + 1
					for i,v in pairs(main.categories:GetChildren()) do
						v.ScrollingFrame.Visible = false
					end
					if answers == 1 then
						if v.Name:lower():find("section") then
							text.TextColor3 = Color3.fromRGB(0,255,0)
							table.insert(Highlighted, text)
							v.Parent.Parent.ScrollingFrame.Visible = false
							main.mainframe["Categories"][v.Parent.Parent.Name].ScrollingFrame.Visible = true
						elseif v.Name:lower():find("button") then
							text.TextColor3 = Color3.fromRGB(0,255,0)
							table.insert(Highlighted, text)
							main.mainframe["Categories"][v.Parent.Parent.Parent.Parent.Name].ScrollingFrame.Visible = true
						elseif v.Name:lower():find("toggle") then
							text.TextColor3 = Color3.fromRGB(0,255,0)
							table.insert(Highlighted, text)
							main.mainframe["Categories"][v.Parent.Parent.Parent.Name].ScrollingFrame.Visible = true
						elseif v.Name:lower():find("slider") then
							text.TextColor3 = Color3.fromRGB(0,255,0)
							table.insert(Highlighted, text)
							main.mainframe["Categories"][v.Parent.Parent.Parent.Name].ScrollingFrame.Visible = true
						elseif v.Name:lower():find("textbox") then
							text.TextColor3 = Color3.fromRGB(0,255,0)
							table.insert(Highlighted, text)
							main.mainframe["Categories"][v.Parent.Parent.Parent.Name].ScrollingFrame.Visible = true
						elseif v.Name:lower():find("label") then
							text.TextColor3 = Color3.fromRGB(0,255,0)
							table.insert(Highlighted, text)
							main.mainframe["Categories"][v.Parent.Parent.Parent.Name].ScrollingFrame.Visible = true
						elseif v.Name:lower():find("keybind") then
							text.TextColor3 = Color3.fromRGB(0,255,0)
							table.insert(Highlighted, text)
							main.mainframe["Categories"][v.Parent.Parent.Parent.Name].ScrollingFrame.Visible = true
						elseif v.Parent.Name:lower():find("dropdown") then
							text.TextColor3 = Color3.fromRGB(0,255,0)
							table.insert(Highlighted, text)
							main.mainframe["Categories"][v.Parent.Parent.Parent.Parent.Name].ScrollingFrame.Visible = true
						elseif v.Name:lower():find("colorpicker") then
							text.TextColor3 = Color3.fromRGB(0,255,0)
							table.insert(Highlighted, text)
							main.mainframe["Categories"][v.Parent.Parent.Parent.Name].ScrollingFrame.Visible = true
						end
					else 
						for i,v in pairs(main.categories:GetChildren()) do
							v.ScrollingFrame.Visible = false
						end
					end
				end
			end
		elseif searchtext == "" and main.searchbox.Position == UDim2.new(0, 8, 0, 0) then 
			for i,v in pairs(Highlighted) do 
				v.TextColor3 = textcolorsave
			end 
		end
	end)

	main.categorybutton.MouseButton1Click:Connect(function()
		showcategories = not showcategories
		if showcategories then
			main.categoryhandlerscrolling.Visible = true
			ts:Create(main.categorybuttonframe, TweenInfo.new(0.1), {Size = UDim2.new(0, 0, 0, 28)}):Play()
			wait(.1)
			ts:Create(main.closebuttonmark, TweenInfo.new(0.1), {Size = UDim2.new(0, 25, 0, 25)}):Play()
			for i,v in pairs(main.mainframe["Categories"]:GetChildren()) do 
				v.ScrollingFrame.Visible = false
			end

			for i,v in pairs(main.categoryhandlerscrolling:GetChildren()) do 
				if v:IsA("Frame") then 
					for a,b in pairs(v:GetChildren()) do 
						ts:Create(b, TweenInfo.new(0.15), {ImageTransparency = categoryopacity}):Play()
						ts:Create(b.Text, TweenInfo.new(0.15), {TextTransparency = categorytopacity}):Play()
						wait(.02)
					end
				end
			end
		else
			ts:Create(main.closebuttonmark, TweenInfo.new(0.1), {Size = UDim2.new(0, 0, 0, 0)}):Play()
			wait(.1)
			ts:Create(main.categorybuttonframe, TweenInfo.new(0.1), {Size = UDim2.new(0, 30, 0, 28)}):Play()
			for i,v in pairs(main.categoryhandlerscrolling:GetChildren()) do
				if v:IsA("Frame") then 
					for a,b in pairs(v:GetChildren()) do 
						ts:Create(b, TweenInfo.new(0.15), {ImageTransparency = 1}):Play()
						ts:Create(b.Text, TweenInfo.new(0.15), {TextTransparency = 1}):Play()
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

		local searchpp = false

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
			TextSize = 18.000,
			TextXAlignment = Enum.TextXAlignment.Left,
		})
		table.insert(Objects.TextColor, category.text)

		category.categorycontainer = library.create("ImageLabel", {
			Name = name.."Container",
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
			CanvasSize = UDim2.new(0,0,0,8),
			ScrollBarThickness = 0,
		})

		category.categoryscrollinglayout = library.create("UIListLayout", {
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 8),
		})

		category.categoryscrollingpadding = library.create("UIPadding", {
			PaddingTop = UDim.new(0, 8),
			PaddingBottom = UDim.new(0,8),
		})

		category.categorybutton.MouseButton1Click:Connect(function()
			ts:Create(category.categorybutton, TweenInfo.new(0.08), {Position = UDim2.new(0, 2, 0, 3)}):Play()
			wait(.09)
			ts:Create(category.categorybutton, TweenInfo.new(0.08), {Position = UDim2.new(0, 0, 0, 0)}):Play()
			showcategories = false
			ts:Create(main.closebuttonmark, TweenInfo.new(0.1), {Size = UDim2.new(0, 0, 0, 0)}):Play()
			wait(.1)
			ts:Create(main.categorybuttonframe, TweenInfo.new(0.1), {Size = UDim2.new(0, 30, 0, 28)}):Play()
			for i,v in pairs(main.categoryhandlerscrolling:GetChildren()) do
				if v:IsA("Frame") then 
					for a,b in pairs(v:GetChildren()) do
						ts:Create(b, TweenInfo.new(0.15), {ImageTransparency = 1}):Play()
						ts:Create(b.Text, TweenInfo.new(0.15), {TextTransparency = 1}):Play()
						wait()
					end
				end
			end
			category.categoryscrolling.Visible = true
			main.categoryhandlerscrolling.Visible = false 
			categoryopendname = name.."Container"
		end)

		function category.section(name)

			local sections = {}

			sections.section = library.create("ImageLabel", {
				Name = name.."Section",
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
				TextSize = 18.000,
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
					Name = name.."Button",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1.000,
					Position = UDim2.new(0.0155339809, 0, 0.0204081628, 0),
					Size = UDim2.new(0.964, 0, 0, 35),
				})

				buttons.button = library.create("ImageButton", {
					Name = name.."Button",
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
					TextSize = 18.000,
					TextXAlignment = Enum.TextXAlignment.Center,		
				})
				table.insert(Objects.TextColor, buttons.text)

				buttons.button.MouseButton1Click:Connect(function()
					if animated then 
						ts:Create(buttons.button, TweenInfo.new(0.08), {Size = UDim2.new(0.96, 0, 0, 30)}):Play()
						wait(.09)
						ts:Create(buttons.button, TweenInfo.new(0.08), {Size = UDim2.new(1, 0, 0, 35)}):Play()
					end
					
					if callback then 
						callback()
					end
				end)

				sections.section.Size = sections.section.Size + UDim2.new(0, 0, 0, 43)
				category.categoryscrolling.CanvasSize = category.categoryscrolling.CanvasSize + UDim2.new(0, 0, 0, 43)

				buttons.buttonback.Parent = sections.section
				buttons.button.Parent = buttons.buttonback
				buttons.text.Parent = buttons.button

				return buttons

			end

			function sections.toggle(name, callback, default)

				local toggles = {}

				local toggled = false

				toggles.toggle = library.create("ImageButton", {
					Name = name.."Toggle",
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
					TextSize = 18.000,
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
					callback(default)
					if toggled then 
						ts:Create(toggles.show, TweenInfo.new(0.1), {
							Position = UDim2.new(0.5, 0, 0.115, 0)
						}):Play()
					else
						ts:Create(toggles.show, TweenInfo.new(0.1), {
							Position = UDim2.new(0.1, 0, 0.115, 0)
						}):Play()
					end
				end 

				toggles.toggle.MouseButton1Click:Connect(function()
					toggled = not toggled

					if toggled then 
						ts:Create(toggles.show, TweenInfo.new(0.1), {
							Position = UDim2.new(0.5, 0, 0.115, 0)
						}):Play()
					else
						ts:Create(toggles.show, TweenInfo.new(0.1), {
							Position = UDim2.new(0.1, 0, 0.115, 0)
						}):Play()
					end

					callback(toggled)

				end)

				function toggles:ChangeState(NewState)
					toggled = NewState

					if toggled then 
						ts:Create(toggles.show, TweenInfo.new(0.1), {
							Position = UDim2.new(0.5, 0, 0.115, 0)
						}):Play()
					else
						ts:Create(toggles.show, TweenInfo.new(0.1), {
							Position = UDim2.new(0.1, 0, 0.115, 0)
						}):Play()
					end

					callback(toggled)
				end 

				sections.section.Size = sections.section.Size + UDim2.new(0, 0, 0, 43)
				category.categoryscrolling.CanvasSize = category.categoryscrolling.CanvasSize + UDim2.new(0, 0, 0, 43)

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
					Name = name.."Slider",
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
					TextSize = 18.000,
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
						TextSize = 18.000,
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
						TextSize = 18.000,
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
								ts:Create(sliders.inner, TweenInfo.new(0.05), {Size = UDim2.new(1, 0, 0, 6)}):Play()
								ts:create(sliders.circle, TweenInfo.new(0.05), {Position = UDim2.new(1, -7, 0, -3)}):Play()
							elseif number >= min and number <= max then 
								Value = number
								if callback then
									callback(number)
								end
								local scale = (number - min) / (max - min)
								ts:Create(sliders.inner, TweenInfo.new(0.05), {Size = UDim2.new(scale, 0, 0, 6)}):Play()
								ts:create(sliders.circle, TweenInfo.new(0.05), {Position = UDim2.new(scale, -7, 0, -3)}):Play()
							end 
						end 
					end
					sliders.value:GetPropertyChangedSignal("Text"):Connect(function()
						if not sliders.value:IsFocused() then apply() end
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
						ts:create(sliders.circletransparency, TweenInfo.new(0.1), {ImageTransparency = 0.9}):Play()
					end
				end)

				sliders.circle.MouseLeave:Connect(function()
					if not connection then 
						ts:create(sliders.circletransparency, TweenInfo.new(0.1), {ImageTransparency = 1}):Play()
					end
				end)

				if tonumber(default) and not overmax then
					sliders.value.Text = tostring(default)
					if callback then
						callback(default)
					end
					local scale = (default - min) / (max - min)
					ts:Create(sliders.inner, TweenInfo.new(0.05), {Size = UDim2.new(scale, 0, 0, 6)}):Play()
					ts:create(sliders.circle, TweenInfo.new(0.05), {Position = UDim2.new(scale, -7, 0, -3)}):Play()
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
					ts:Create(sliders.inner, TweenInfo.new(0.05), {Size = UDim2.new(scale, 0, 0, 6)}):Play()
					ts:create(sliders.circle, TweenInfo.new(0.05), {Position = UDim2.new(scale, -7, 0, -3)}):Play()
				end

				local precise = (min%1 > 0)
				sliders.slider.MouseButton1Down:Connect(function()
					ts:create(sliders.circletransparency, TweenInfo.new(0.1), {ImageTransparency = 0.7}):Play()

					connection = rs.Heartbeat:Connect(function()
						local scale = math.clamp(mouse.X - sliders.slider.AbsolutePosition.X, 0, sliders.slider.AbsoluteSize.X) / sliders.slider.AbsoluteSize.X
						if precise then
							Value = string.format("%.1f", min + ((max - min) * scale))
						else
							Value = math.floor(min + ((max - min) * scale))
						end
						sliders.value.Text = tostring(Value)

						if callback then
							callback(Value)
						end

						ts:Create(sliders.inner, TweenInfo.new(0.05), {Size = UDim2.new(scale, 0, 0, 6)}):Play()
						ts:create(sliders.circle, TweenInfo.new(0.05), {Position = UDim2.new(scale, -8, 0, -3)}):Play()
					end)

					uis.InputEnded:Connect(function(Check)
						if (Check.UserInputType == Enum.UserInputType.MouseButton1 or Check.UserInputType == Enum.UserInputType.Touch) then
							if connection then
								ts:create(sliders.circletransparency, TweenInfo.new(0.1), {ImageTransparency = 1}):Play()
								connection:Disconnect()
								connection = nil
							end
						end
					end)

				end)

				sections.section.Size = sections.section.Size + UDim2.new(0, 0, 0, 58)
				category.categoryscrolling.CanvasSize = category.categoryscrolling.CanvasSize + UDim2.new(0, 0, 0, 58)

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
					Name = name.."Textbox",
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
					TextSize = 18.000,
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
				category.categoryscrolling.CanvasSize = category.categoryscrolling.CanvasSize + UDim2.new(0, 0, 0, 43)

				textboxes.background.Parent = sections.section
				textboxes.text.Parent = textboxes.background
				textboxes.textboxbox.Parent = textboxes.background
				textboxes.textbox.Parent = textboxes.textboxbox

				return textboxes

			end 

			function sections.label(name)

				local labels = {}

				labels.background = library.create("ImageLabel", {
					Name = name.."Label",
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
					TextSize = 18.000,
					Text = name,
					TextXAlignment = Enum.TextXAlignment.Left,
				})
				table.insert(Objects.TextColor, labels.text)

				sections.section.Size = sections.section.Size + UDim2.new(0, 0, 0, 43)
				category.categoryscrolling.CanvasSize = category.categoryscrolling.CanvasSize + UDim2.new(0, 0, 0, 43)

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
					Name = name.."KeyBind",
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
					TextSize = 18.000,
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
					TextSize = 18.000,
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
								wait(.1)
								changing = false
							end
						elseif i.KeyCode == Enum.KeyCode.Backspace then
							keybinds.key.Text = "None"
							bind = nil
							if connection then
								connection:Disconnect()
								connection = nil 
								wait(.1)
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
					if child.Name == "Azure" then 
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
				category.categoryscrolling.CanvasSize = category.categoryscrolling.CanvasSize + UDim2.new(0, 0, 0, 43)

				return keybinds

			end

			function sections.dropdown(name, callback, options, playerlist, search, beforeopen)
				if search then 
					
					local tableA = {}

					local dropdowns = {}

					local listopend = false

					local SearchLock = true

					local selectedvalue 

					if options and not playerlist then
						tableA = {}
						tableA = options
					elseif options and playerlist then 
						tableA = {}
						for i,v in pairs(options) do 
							table.insert(tableA, v)
						end 
						local list = game:GetService("Players")
						for a,b in pairs(list:GetChildren()) do 
							if b:IsA("Player") then
								table.insert(tableA, b.Name)
							end 
						end
					elseif not options and playerlist then 
						tableA = {}
						local list = game:GetService("Players")
						for a,b in pairs(list:GetChildren()) do 
							if b:IsA("Player") then
								table.insert(tableA, b.Name)
							end 
						end
					end

					dropdowns.background = library.create("ImageLabel", {
						Name = name.."DropDown",
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
						Active = false,
						BackgroundColor3 = Color3.fromRGB(248, 248, 248),
						BackgroundTransparency = 1.000,
						BorderSizePixel = 0,
						Position = UDim2.new(0.00800000038, 0, 0, 0),
						Selectable = false,
						Size = UDim2.new(0.9, 0, 1, 0),
						Font = Enum.Font.GothamBold,
						TextColor3 = Color3.fromRGB(255, 255, 255),
						TextSize = 18.000,
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
						ImageColor3 = Color3.fromRGB(math.floor(Themes.GrayContrastColor.r * 255) - 3, math.floor(Themes.GrayContrastColor.g * 255) - 3, math.floor(Themes.GrayContrastColor.b * 255) - 3),
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
							ts:Create(dropdowns.arrow, TweenInfo.new(0.1), {Rotation = 90}):Play()
							ts:Create(sections.section, TweenInfo.new(0.1), {Size = sections.section.Size - UDim2.new(0, 0, 0, 125)}):Play()
							ts:Create(category.categoryscrolling, TweenInfo.new(0.1), {CanvasSize = category.categoryscrolling.CanvasSize - UDim2.new(0, 0, 0, 125)}):Play()
							ts:Create(dropdowns.background, TweenInfo.new(0.1), {Size = UDim2.new(0.964, 0, 0, 30)}):Play()
						else
							ts:Create(dropdowns.arrow, TweenInfo.new(0.1), {Rotation = 0}):Play()
							ts:Create(sections.section, TweenInfo.new(0.1), {Size = sections.section.Size + UDim2.new(0, 0, 0, 125)}):Play()
							ts:Create(dropdowns.list, TweenInfo.new(0.1), {CanvasSize = UDim2.new(0, 0, 0, dropdowns.list["UIListLayout"].AbsoluteContentSize.Y) + UDim2.new(0, 0, 0, 26)}):Play()
							ts:Create(category.categoryscrolling, TweenInfo.new(0.1), {CanvasSize = category.categoryscrolling.CanvasSize + UDim2.new(0, 0, 0, 125)}):Play()
							ts:Create(category.categoryscrolling, TweenInfo.new(0.1), {CanvasPosition = category.categoryscrolling.CanvasPosition + Vector2.new(0, 125)}):Play()
							ts:Create(dropdowns.background, TweenInfo.new(0.1), {Size = UDim2.new(0.964, 0, 0, 154)}):Play()
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
								TextSize = 18,
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

					local Found = {}
					local searchtable = {}

					for f,h in pairs(tableA) do
						table.insert(searchtable, string.lower(h))
					end

					RefreshList()

					dropdowns.textbox.Focused:Connect(function()
						SearchLock = false
						if not listopend then 
							if beforeopen then 
								local newtable = beforeopen()
								tableA = newtable
								for f,h in pairs(tableA) do
									table.insert(searchtable, string.lower(h))
								end
							end
							if options and playerlist then 
								tableA = {}
								for i,v in pairs(options) do 
									table.insert(tableA, v)
								end 
								local list = game:GetService("Players")
								for a,b in pairs(list:GetChildren()) do 
									if b:IsA("Player") then
										table.insert(tableA, b.Name)
									end 
								end
							elseif not options and playerlist then 
								tableA = {}
								local list = game:GetService("Players")
								for i,v in pairs(list:GetChildren()) do 
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

					dropdowns.arrow.MouseButton1Click:Connect(function()
						listopend = not listopend
						if beforeopen then 
							local newtable = beforeopen()
							tableA = newtable
							for f,h in pairs(tableA) do
								table.insert(searchtable, string.lower(h))
							end
						end
						if options and playerlist then 
							tableA = {}
							for i,v in pairs(options) do 
								table.insert(tableA, v)
							end 
							local list = game:GetService("Players")
							for a,b in pairs(list:GetChildren()) do 
								if b:IsA("Player") then
									table.insert(tableA, b.Name)
								end 
							end
						elseif not options and playerlist then 
							tableA = {}
							local list = game:GetService("Players")
							for i,v in pairs(list:GetChildren()) do 
								if v:IsA("Player") then
									table.insert(tableA, v.Name)
								end
							end
						end
						HideShowList()
						RefreshList()
					end)

					local function Edit()
						for i in pairs(Found) do
							Found[i] = nil
						end
						for h, l in pairs(dropdowns.list:GetChildren()) do
							if not l:IsA("UIListLayout") and not l:IsA("UIPadding") then
								l.Visible = false
							end
						end
						dropdowns.textbox.Text = string.lower(dropdowns.textbox.Text)
					end

					local function Search()
						local Results = {}
						local num
						for i, v in pairs(searchtable) do
							if string.find(v, dropdowns.textbox.Text, 1, true) then
								table.insert(Found, v)
							end
						end
						for a, b in pairs(dropdowns.list:GetChildren()) do
							for c, d in pairs(Found) do
								if d == b.Name then
									b.Visible = true
								end
							end
						end
						for p, n in pairs(dropdowns.list:GetChildren()) do
							if not n:IsA("UIListLayout") and not n:IsA("UIPadding") and n.Visible == true then
								table.insert(Results, n)
								for c, d in pairs(Results) do
									num = c
								end
							end
						end
						if num ~= nil then
							num = num * 40
							dropdowns.list.CanvasSize = UDim2.new(0, 0, 0, num) + UDim2.new(0, 0, 0, 20)
							num = 0
						end
					end

					local function Nil()
						for i, v in pairs(dropdowns.list:GetChildren()) do
							if not v:IsA("UIListLayout") and not v:IsA("UIPadding") and v.Visible == false then
								ts:Create(dropdowns.list, TweenInfo.new(0.1), {
									CanvasSize = UDim2.new(0, 0, 0, dropdowns.list["UIListLayout"].AbsoluteContentSize.Y) + UDim2.new(0, 0, 0, 26)
								}):Play()
								v.Visible = true
							end 
						end
					end

					dropdowns.textbox.Changed:connect(function()
						if not SearchLock then
							Edit()
							Search()
						end
						if dropdowns.textbox.Text == "" then
							Nil()
							ts:Create(dropdowns.list, TweenInfo.new(0.1), {
								CanvasSize = UDim2.new(0, 0, 0, dropdowns.list["UIListLayout"].AbsoluteContentSize.Y) + UDim2.new(0, 0, 0, 26)
							}):Play()
						end
					end)

					dropdowns.textbox.FocusLost:connect(function()
						SearchLock = true
						if dropdowns.textbox.Text == "" then
							ts:Create(dropdowns.list, TweenInfo.new(0.1), {
								CanvasSize = UDim2.new(0, 0, 0, dropdowns.list["UIListLayout"].AbsoluteContentSize.Y) + UDim2.new(0, 0, 0, 26)
							}):Play()
							SearchLock = true
							Nil()
							dropdowns.textbox.Text = name
						end
					end)

					sections.section.Size = sections.section.Size + UDim2.new(0, 0, 0, 38)
					category.categoryscrolling.CanvasSize = category.categoryscrolling.CanvasSize + UDim2.new(0, 0, 0, 38)
	
					dropdowns.background.Parent = sections.section
					dropdowns.background2.Parent = dropdowns.background
					dropdowns.arrow.Parent = dropdowns.background2
					dropdowns.textbox.Parent = dropdowns.background2	
					dropdowns.backgroundlist.Parent = dropdowns.background
					dropdowns.list.Parent = dropdowns.backgroundlist
					dropdowns.listlayout.Parent = dropdowns.list 
					dropdowns.listpadding.Parent = dropdowns.list

				else

					local dropdowns = {}
					
					local tableA = {}

					local listopend = false

					local SearchLock = true

					local selectedvalue 

					if options and not playerlist then
						tableA = {}
						tableA = options
					elseif options and playerlist then 
						tableA = {}
						for i,v in pairs(options) do 
							table.insert(tableA, v)
						end 
						local list = game:GetService("Players")
						for a,b in pairs(list:GetChildren()) do 
							if b:IsA("Player") then
								table.insert(tableA, b.Name)
							end 
						end
					elseif not options and playerlist then 
						tableA = {}
						local list = game:GetService("Players")
						for a,b in pairs(list:GetChildren()) do 
							if b:IsA("Player") then
								table.insert(tableA, b.Name)
							end 
						end
					end

					dropdowns.background = library.create("ImageLabel", {
						Name = name.."DropDown",
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
						TextSize = 18.000,
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
						ImageColor3 = Color3.fromRGB(math.floor(Themes.GrayContrastColor.r * 255) - 3, math.floor(Themes.GrayContrastColor.g * 255) - 3, math.floor(Themes.GrayContrastColor.b * 255) - 3),
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
							ts:Create(dropdowns.arrow, TweenInfo.new(0.1), {Rotation = 90}):Play()
							ts:Create(sections.section, TweenInfo.new(0.1), {Size = sections.section.Size - UDim2.new(0, 0, 0, 125)}):Play()
							ts:Create(category.categoryscrolling, TweenInfo.new(0.1), {CanvasSize = category.categoryscrolling.CanvasSize - UDim2.new(0, 0, 0, 125)}):Play()
							ts:Create(dropdowns.background, TweenInfo.new(0.1), {Size = UDim2.new(0.964, 0, 0, 30)}):Play()
						else
							ts:Create(dropdowns.arrow, TweenInfo.new(0.1), {Rotation = 0}):Play()
							ts:Create(sections.section, TweenInfo.new(0.1), {Size = sections.section.Size + UDim2.new(0, 0, 0, 125)}):Play()
							ts:Create(dropdowns.list, TweenInfo.new(0.1), {CanvasSize = UDim2.new(0, 0, 0, dropdowns.list["UIListLayout"].AbsoluteContentSize.Y) + UDim2.new(0, 0, 0, 26)}):Play()
							ts:Create(category.categoryscrolling, TweenInfo.new(0.1), {CanvasSize = category.categoryscrolling.CanvasSize + UDim2.new(0, 0, 0, 125)}):Play()
							ts:Create(category.categoryscrolling, TweenInfo.new(0.1), {CanvasPosition = category.categoryscrolling.CanvasPosition + Vector2.new(0, 125)}):Play()
							ts:Create(dropdowns.background, TweenInfo.new(0.1), {Size = UDim2.new(0.964, 0, 0, 154)}):Play()
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
								TextSize = 18,
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
							tableA = newtable
							RefreshList()
						end
						if options and playerlist then 
							tableA = {}
							for i,v in pairs(options) do 
								table.insert(tableA, v)
							end 
							local list = game:GetService("Players")
							for a,b in pairs(list:GetChildren()) do 
								if b:IsA("Player") then
									table.insert(tableA, b.Name)
								end 
							end
						elseif not options and playerlist then 
							tableA = {}
							local list = game:GetService("Players")
							for a,b in pairs(list:GetChildren()) do 
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
							tableA = newtable
							RefreshList()
						end
						if options and playerlist then 
							tableA = {}
							for i,v in pairs(options) do 
								table.insert(tableA, v)
							end 
							local list = game:GetService("Players")
							for a,b in pairs(list:GetChildren()) do 
								if b:IsA("Player") then
									table.insert(tableA, b.Name)
								end 
							end
						elseif not options and playerlist then 
							tableA = {}
							local list = game:GetService("Players")
							for a,b in pairs(list:GetChildren()) do 
								if b:IsA("Player") then
									table.insert(tableA, b.Name)
								end 
							end
						end
						HideShowList()
					end)

					sections.section.Size = sections.section.Size + UDim2.new(0, 0, 0, 38)
					category.categoryscrolling.CanvasSize = category.categoryscrolling.CanvasSize + UDim2.new(0, 0, 0, 38)
	
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
					Name = name.."ColorPicker",
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
					TextSize = 18.000,
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
					ImageColor3 = Color3.fromRGB(255,255,255),
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
					Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 0, 0))}
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

					for i,v in pairs(main.mainframe:GetChildren()) do
						if v.Name == "colorframe" then
							ts:Create(v, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 265)}):Play()
						end
					end

					if pickeropen then 
						ts:Create(colorpickers.framebackground, TweenInfo.new(0.3), {Size = UDim2.new(0, 220, 0, 265)}):Play()
					end
				end)

				local h,s,v = 0,0,1
				local color = Color3.fromRGB(255,255,255)
				local r,g,b = 255,255,255
				local opacity = 1

				local hueconnection
				local darknessconnection
				local alphaconnection

				local function Update()

					colorpickers.RBox.Text = math.floor(r)
					colorpickers.GBox.Text = math.floor(g)
					colorpickers.BBox.Text = math.floor(b)
					
					ts:Create(colorpickers.huering, TweenInfo.new(0.12), {Position = UDim2.new(0.147, 0, h, -6)}):Play()
					ts:Create(colorpickers.darknessring, TweenInfo.new(0.12), {Position = UDim2.new(s, -6, 1 - v, -6)}):Play()
					ts:Create(colorpickers.alpharing, TweenInfo.new(0.12), {Position = UDim2.new(opacity, -6, 0.125, 0)}):Play()

					colorpickers.darknesspicker.ImageColor3 = Color3.fromHSV(h,1,1)

					colorpickers.button.ImageColor3 = Color3.fromRGB(r,g,b)
					colorpickers.button.ImageTransparency = 1 - opacity

					local colorvalue = Color3.fromHSV(h,s,v)
					local opacityvalue = 1 - opacity

					if callback then 
						callback(colorvalue, opacityvalue)
					end
				end

				colorpickers.huepicker.MouseButton1Down:Connect(function()
					hueconnection = rs.Heartbeat:Connect(function()
						h = 1 - math.clamp(1 - ((mouse.Y - colorpickers.huepicker.AbsolutePosition.Y) / colorpickers.huepicker.AbsoluteSize.Y), 0, 1)
						color = Color3.fromHSV(h,s,v)

						r,g,b = math.floor(color.r * 255), math.floor(color.g * 255), math.floor(color.b * 255)

						Update()
					end)
				end)

				colorpickers.darknesspicker.MouseButton1Down:Connect(function()
					darknessconnection = rs.Heartbeat:Connect(function()
						s = math.clamp((mouse.X - colorpickers.darknesspicker.AbsolutePosition.X) / colorpickers.darknesspicker.AbsoluteSize.X, 0, 1)
						v = 1 - math.clamp((mouse.Y - colorpickers.darknesspicker.AbsolutePosition.Y) / colorpickers.darknesspicker.AbsoluteSize.Y, 0, 1)
						color = Color3.fromHSV(h,s,v)

						r,g,b = math.floor(color.r * 255), math.floor(color.g * 255), math.floor(color.b * 255)

						Update()
					end)
				end)
				
				colorpickers.alphapicker.MouseButton1Down:Connect(function()
					alphaconnection = rs.Heartbeat:Connect(function()
						opacity = math.clamp(mouse.X - colorpickers.alphapicker.AbsolutePosition.X, 0, colorpickers.alphapicker.AbsoluteSize.X) / colorpickers.alphapicker.AbsoluteSize.X

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
							local color = Color3.fromRGB(r,g,b)
							h,s,v = Color3.toHSV(color)
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
							local color = Color3.fromRGB(r,g,b)
							h,s,v = Color3.toHSV(color)
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
							local color = Color3.fromRGB(r,g,b)
							h,s,v = Color3.toHSV(color)
							Update()
						end
					end 
				end)

				if default then 
					r,g,b = default.r * 255, default.g * 255, default.b * 255
					h,s,v = Color3.toHSV(default)
					Update()
				end

				if opacitydefault then 
					opacity = opacitydefault
					Update()
				end

				function colorpickers:SetColor(Color)
					r,g,b = Color.r * 255, Color.g * 255, Color.b * 255
					h,s,v = Color3.toHSV(Color)
					Update()
				end

				uis.InputEnded:Connect(function(Mouse)
					if (Mouse.UserInputType == Enum.UserInputType.MouseButton1 or Mouse.UserInputType == Enum.UserInputType.Touch) then
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
				category.categoryscrolling.CanvasSize = category.categoryscrolling.CanvasSize + UDim2.new(0, 0, 0, 43)
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
			for i,v in pairs(main.categoryhandlerscrolling:GetChildren()) do
				if v:IsA("Frame") then 
					for a,b in pairs(v:GetChildren()) do
						ts:Create(b, TweenInfo.new(0.15), {ImageTransparency = 1}):Play()
						ts:Create(b.Text, TweenInfo.new(0.15), {TextTransparency = 1}):Play()
						wait()
					end
				end
			end
			category.categoryscrolling.Visible = true
			main.categoryhandlerscrolling.Visible = false 
			categoryopendname = name.."Container"
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
			ts:Create(main.categorybutton, TweenInfo.new(0), {Position = UDim2.new(1, -35, 0, -28)}):Play()
			ts:Create(main.logo, TweenInfo.new(0), {Position = UDim2.new(0, 8, 0, -28)}):Play()
			ts:Create(main.searchbutton, TweenInfo.new(0.1), {Position = UDim2.new(1, -35, 0, 4)}):Play()
			ts:Create(main.searchicon, TweenInfo.new(0.1), {Size = UDim2.new(0, 0, 0, 28)}):Play()
			ts:Create(main.searchbox, TweenInfo.new(0), {Position = UDim2.new(0, 8, 0, 0)}):Play()
			main.mainframe["Categories"][categoryopendname].ScrollingFrame.Visible = false
			wait(.1)
			ts:Create(main.closebuttonmarksearch, TweenInfo.new(0.1), {Size = UDim2.new(0, 25, 0, 25)}):Play()
		else
			ts:Create(main.categorybutton, TweenInfo.new(0), {Position = UDim2.new(1, -35, 0, 4)}):Play()
			ts:Create(main.logo, TweenInfo.new(0), {Position = UDim2.new(0, 8, 0, 0)}):Play()
			ts:Create(main.searchbutton, TweenInfo.new(0.1), {Position = UDim2.new(1, -72, 0, 4)}):Play()
			ts:Create(main.closebuttonmarksearch, TweenInfo.new(0.1), {Size = UDim2.new(0, 0, 0, 0)}):Play()
			ts:Create(main.closebuttonmarksearch, TweenInfo.new(0.1), {Size = UDim2.new(0, 0, 0, 0)}):Play()
			ts:Create(main.searchbox, TweenInfo.new(0), {Position = UDim2.new(0, 8, 0, -38)}):Play()
			wait(.1)
			for i,v in pairs(main.categories:GetChildren()) do 
				v.ScrollingFrame.Visible = false
			end
			for i,v in pairs(Highlighted) do 
				v.TextColor3 = textcolorsave
			end 
			main.mainframe["Categories"][categoryopendname].ScrollingFrame.Visible = true
			ts:Create(main.searchicon, TweenInfo.new(0.1), {Size = UDim2.new(0, 26, 0, 28)}):Play()
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
		for i,v in pairs(Objects.TextColor) do 
			if v:IsA("TextLabel") or v:IsA("TextButton") or v:IsA("TextBox") then
				textcolorsave = Color
				if v.Parent and v.Parent.Parent and v.Parent.Parent.Parent and v.Parent.Parent.Parent.Name == "CategoryHandlerScrolling" then 
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
			end 
		end  
	elseif Theme == "BackgroundColor" then 
		for i,v in pairs(Objects.BackgroundColor) do
			if v:IsA("Frame") or v:IsA("TextButton") or v:IsA("ScrollingFrame") then
				v.BackgroundColor3 = Color
				v.BackgroundTransparency = TransparencyValue
			elseif v:IsA("ImageLabel") then 
				v.ImageColor3 = Color
				v.ImageTransparency = TransparencyValue
			end
		end
	elseif Theme == "GrayContrastColor" then 
		for i,v in pairs(Objects.GrayContrastColor) do 
			if v:IsA("ImageLabel") then
				if v.Name ~= "Backgroundlist" then 
					v.ImageColor3 = Color 
					v.ImageTransparency = TransparencyValue
				else 
					v.ImageColor3 = Color3.fromRGB(math.floor(Color.r * 255) - 3, math.floor(Color.g * 255) - 3, math.floor(Color.b * 255) - 3)
					v.ImageTransparency = TransparencyValue
				end
			end 
		end 
	elseif Theme == "DarkContrastColor" then 
		for i,v in pairs(Objects.DarkContrastColor) do
			if v:IsA("ImageLabel") or v:IsA("ImageButton") then 
				v.ImageColor3 = Color 
				v.ImageTransparency = TransparencyValue
			end 
		end
	elseif Theme == "AccentColor" then
		for i,v in pairs(Objects.AccentColor) do 
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



-- window
local ui = library.initiate({default = UDim2.new(0, 572, 0, 353)})

-- press Z to show / hide the window (ignored while typing in a textbox)
uis.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.Z then
        ui.mainframe.Visible = not ui.mainframe.Visible
    end
end)

-- items tab
-- select loose items, then teleport or sort them
do
    local source = [==[
local LooseObjectTeleport = {}

local UIS          = game:GetService("UserInputService")
local RunService   = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local GuiService   = game:GetService("GuiService")
local ContextActionService = game:GetService("ContextActionService")
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
    -- Teleport timing
    OwnershipTimeout = 1,
    FallbackWait     = 0.5,
    PreFireWait      = 0.05,
    PostObjectDelay  = 0.1,
    ProximityRadius  = 10,

    -- Selection look
    SelectionColor   = Color3.fromRGB(33, 84, 185),
    OutlineThickness = 0.04,
    FillTransparency = 0.75,

    -- Sorting
    StackX       = 5,
    StackY       = 1,
    StackZ       = 2,
    StackPadding = 0.1,
    PyramidMode  = false,

    -- Behaviour
    KeepSelected   = false,
    ReturnToOrigin = true,
    MatchPlankSize = true,
    TruckTp        = false,

    -- Delete
    DeleteDelay    = 0,
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

    DeleteMode      = false,
    DeleteCategory  = "Everything Placed",
    DeleteBusy      = false,
    DeleteCancel    = false,
    DeleteArmedAt   = 0,

    StackMode         = false,
    StackPreviewParts = {},
    StackPreviewBoxes = {},
    StackPreviewConn  = nil,
    StackStartBtn     = nil,
    StackRotation     = CFrame.new(),
    ItemRotation      = CFrame.new(),

    Library        = nil,
    BatchCompleted = NewSignal(),
}

local TapPos, TapTarget = nil, nil

-- Position of the in-game aim cursor (TargetGui.Cross), in viewport pixels.
-- Falls back to the real mouse on PC, then to the last tap / screen centre.
local CrossRef
local function GetAimPos()
    if not (CrossRef and CrossRef.Parent) then
        local gui = Player:FindFirstChild("PlayerGui") and Player.PlayerGui:FindFirstChild("TargetGui")
        CrossRef  = gui and gui:FindFirstChild("Cross") or nil
    end
    local gui = CrossRef and CrossRef:FindFirstAncestorOfClass("ScreenGui")
    if CrossRef and gui and gui.Enabled then
        -- the game draws this cursor without the top-bar inset, so add it back
        local point = CrossRef.AbsolutePosition + CrossRef.AbsoluteSize * CrossRef.AnchorPoint
        return point + GuiService:GetGuiInset()
    end
    if UIS.MouseEnabled and not UIS.TouchEnabled then
        return UIS:GetMouseLocation()
    end
    return TapPos or (Camera.ViewportSize / 2)
end

local function TapRay()
    local pos = State.StackMode and GetAimPos() or TapPos or (Camera.ViewportSize / 2)
    return Camera:ViewportPointToRay(pos.X, pos.Y)
end

-- Exclude the character and every preview model (models cover their descendants).
local function BuildRayExclude()
    local exclude = {}
    if Player.Character then table.insert(exclude, Player.Character) end
    for _, preview in ipairs(State.StackPreviewParts) do
        table.insert(exclude, preview)
    end
    return exclude
end

local function TapRaycast()
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = BuildRayExclude()
    local ray = TapRay()
    return workspace:Raycast(ray.Origin, ray.Direction * 500, params), ray
end

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

-- Delete mode: pick placed items (structures, wires, furniture...) by category
local DELETE_CATEGORIES = {
    "Everything Placed", "Wood Structures", "Hard Structures",
    "Blueprints", "Wires", "Furniture", "Loose Items",
}

-- the item model (direct child of PlayerModels) a part belongs to
local function DeleteTopModel(inst)
    local playerModels = workspace:FindFirstChild("PlayerModels")
    if not playerModels then return nil end
    while inst and inst.Parent and inst.Parent ~= playerModels do
        inst = inst.Parent
    end
    if inst and inst.Parent == playerModels and inst:IsA("Model") then
        return inst
    end
    return nil
end

local function DeleteCategoryMatches(model)
    local typeVal = model:FindFirstChild("Type")
    local t = typeVal and typeVal.Value
    local cat = State.DeleteCategory
    if cat == "Wood Structures" then
        return t == "Structure" and model:FindFirstChild("BuildDependentWood") ~= nil
    elseif cat == "Hard Structures" then
        return t == "Structure" and model:FindFirstChild("BuildDependentWood") == nil
    elseif cat == "Blueprints" then
        return t == "Blueprint"
    elseif cat == "Wires" then
        return t == "Wire"
    elseif cat == "Furniture" then
        return t == "Furniture"
    elseif cat == "Loose Items" then
        return t == "Loose Item"
    end
    return t == "Structure" or t == "Blueprint" or t == "Wire" or t == "Furniture" or t == "Vehicle Spot"
end

-- only your own items, only the chosen category
local function getDeleteData(target)
    if not target or not target:IsA("BasePart") then return nil end
    if Player.Character and target:IsDescendantOf(Player.Character) then return nil end
    local model = DeleteTopModel(target)
    if not model then return nil end
    if GetOwnerIdentity(model) ~= Player.Name then return nil end
    if not DeleteCategoryMatches(model) then return nil end
    local main = model:FindFirstChild("Main") or model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")
    if not main then return nil end
    return main, model.Name, model
end

local function getObjectData(target)
    if State.DeleteMode then return getDeleteData(target) end
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

local function FindTapTarget()
    local center = TapPos or (Camera.ViewportSize / 2)
    local offsets = {
        Vector2.new(0, 0),
        Vector2.new(6, 0), Vector2.new(-6, 0), Vector2.new(0, 6), Vector2.new(0, -6),
    }
    local exclude = {}
    if Player.Character then table.insert(exclude, Player.Character) end
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.IgnoreWater = true
    params.FilterDescendantsInstances = exclude
    for _, off in ipairs(offsets) do
        local p = center + off
        local ray = Camera:ViewportPointToRay(p.X, p.Y)
        local result = workspace:Raycast(ray.Origin, ray.Direction * 500, params)
        if result and getObjectData(result.Instance) then
            return result.Instance
        end
    end
    return nil
end

local function NewSelectionBox(adornee, thickness, fillTransparency)
    local box               = Instance.new("SelectionBox")
    box.Color3              = Settings.SelectionColor
    box.SurfaceColor3       = Settings.SelectionColor
    box.LineThickness       = thickness
    box.SurfaceTransparency = fillTransparency
    box.Adornee             = adornee
    box.Parent              = game:GetService("CoreGui")
    return box
end

local function UpdateVisuals()
    local wanted = {}
    for _, obj in ipairs(State.SelectedObjects) do
        if obj and obj.Parent then wanted[obj] = true end
    end

    for obj, box in pairs(State.SelectionBoxes) do
        if not wanted[obj] then
            box:Destroy()
            State.SelectionBoxes[obj] = nil
        end
    end

    for obj in pairs(wanted) do
        if not State.SelectionBoxes[obj] then
            local adornee = State.DeleteMode and DeleteTopModel(obj) or obj
            State.SelectionBoxes[obj] = NewSelectionBox(adornee, Settings.OutlineThickness, Settings.FillTransparency)
        end
    end

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

-- ============================================================
--  TRUCK TP
--  Sit in your truck's driver seat. It flies over the items upside
--  down so they end up in the bed (which gives you ownership of all
--  of them), then every item is teleported to its goal at once.
-- ============================================================
local function NotifyItems(text)
    if State.Library then State.Library:Notify("Items", text) end
end

local function OwnedByMe(part)
    if type(isnetworkowner) == "function" then
        local ok, res = pcall(isnetworkowner, part)
        if ok then return res end
    end
    return part.ReceiveAge == 0
end

-- Returns { model, bedCF, bedSize } for the vehicle we're sitting in, or nil + reason.
local function FindTruck()
    local hum  = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
    local seat = hum and hum.SeatPart
    if not seat then return nil, "Sit in your truck's driver seat first." end

    local playerModels = workspace:FindFirstChild("PlayerModels")
    local model = seat
    while model and model.Parent ~= playerModels do model = model.Parent end
    if not (model and model:IsA("Model")) then
        return nil, "This seat isn't in one of your vehicles."
    end

    local info = model:FindFirstChild("BedInfo")
    local cf   = info and info:FindFirstChild("CFrame")
    local size = info and info:FindFirstChild("Size")
    if not (cf and size and model.PrimaryPart) then
        return nil, "This vehicle has no cargo bed."
    end
    return { model = model, bedCF = cf.Value, bedSize = size.Value }
end

local TRUCK = {
    GroupRadius  = 6,     -- before the final grab, every item must be this close to its spot
    ArriveRadius = 3,     -- a sent item counts as "arrived" within this many studs
    FixDistance  = 1.5,   -- fix pass: further than this from its spot = out of place
    FixTilt      = 0.97,  -- fix pass: up-vector dot below this = tipped over
    StraySlack   = 4,     -- extra studs around the stack that still count as "inside"
    Settle       = 0.2,   -- time a send gets to land before it is checked (same wait the normal teleport uses to verify)
    FixSettle    = 0.5,   -- time the finished stack gets to settle (or flop) before checking
    MaxVisits    = 3,     -- failed visits before an item is skipped
}

local function Flat(v) return Vector3.new(v.X, 0, v.Z) end

local function ZeroVelocity(part)
    part.AssemblyLinearVelocity  = Vector3.zero
    part.AssemblyAngularVelocity = Vector3.zero
end

-- Holds the truck where we tell it (session.hold), noclips truck + character,
-- and puts everything back on Stop().
local function StartTruckSession(model, homeCF)
    local main        = model.PrimaryPart
    local pivotOffset = main.CFrame:ToObjectSpace(model:GetPivot())
    local session     = { hold = homeCF }

    local holdConn = RunService.Heartbeat:Connect(function()
        if model.Parent then
            model:PivotTo(session.hold * pivotOffset)
            ZeroVelocity(main)
        end
    end)

    local noclipParts = {}
    for _, root in ipairs({ model, Player.Character }) do
        for _, v in ipairs(root:GetDescendants()) do
            if v:IsA("BasePart") and v.CanCollide then
                v.CanCollide = false
                table.insert(noclipParts, v)
            end
        end
    end
    local noclipConn = RunService.Stepped:Connect(function()
        for _, v in ipairs(noclipParts) do
            if v.Parent and v.CanCollide then v.CanCollide = false end
        end
    end)

    local savedOcclusion
    pcall(function()
        savedOcclusion = Player.DevCameraOcclusionMode
        Player.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Invisicam
    end)

    function session:Stop()
        self.hold = homeCF
        task.wait(Settings.PostObjectDelay)  -- let the truck get home
        holdConn:Disconnect()
        noclipConn:Disconnect()
        for _, v in ipairs(noclipParts) do
            if v.Parent then v.CanCollide = true end
        end
        pcall(function()
            if savedOcclusion then Player.DevCameraOcclusionMode = savedOcclusion end
        end)
    end

    return session
end

--[[
    Truck Tp, in phases:
      1. GATHER   send every item to its spot, check it is really there, retry strays
      2. OWN+DROP own every item (now all grouped), then put them all in place at once
      3. FIX      if the stack flopped, re-own whatever is off and put it back in one go
      4. STRAYS   anything still outside the stack area gets one more try
    jobs = { { target = Part, goalCF = CFrame }, ... }
]]
local function RunTruckBatch(jobs, onHover)
    local truck, err = FindTruck()
    if not truck then
        NotifyItems(err)
        State.BatchCompleted:_Fire(false, 0)
        return false
    end

    local model, bedCF, bedSize = truck.model, truck.bedCF, truck.bedSize
    local homeCF  = model.PrimaryPart.CFrame
    local _, yaw  = homeCF:ToOrientation()
    local upright = CFrame.Angles(0, yaw, 0)             -- bed facing up
    local flipped = CFrame.Angles(0, yaw, math.pi)       -- bed facing down
    local bandHalf = math.max(bedSize.Y / 2 - 0.5, 1.5)

    State.IsBusy         = true
    State.BatchCancelled = false
    local session = StartTruckSession(model, homeCF)

    local hoverOnly = onHover ~= nil          -- delete mode: act on whatever the bed is over, no gathering
    local held, recent, failed = {}, {}, 0   -- held[job] = we own it; recent = sent, not yet confirmed
    local lastPos = homeCF.Position

    -- where the finished stack is
    local stackCenter = Vector3.zero
    for _, job in ipairs(jobs) do stackCenter += job.goalCF.Position end
    stackCenter /= math.max(#jobs, 1)
    local stackRadius = TRUCK.StraySlack
    for _, job in ipairs(jobs) do
        stackRadius = math.max(stackRadius,
            Flat(job.goalCF.Position - stackCenter).Magnitude + TRUCK.StraySlack)
    end

    ------------------------------------------------------------------
    -- helpers
    ------------------------------------------------------------------
    local function StillSeated()
        local hum = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
        return model.Parent and hum and hum.SeatPart
    end

    local function Send(job)
        if hoverOnly then
            onHover(job)                      -- delete mode: act on the item where it is
        else
            job.target.CFrame = job.goalCF
            ZeroVelocity(job.target)
            table.insert(recent, job)
        end
        job.done = true
        held[job] = nil
    end

    -- claim an item if we own it: send it now, or just remember we hold it
    local function TryClaim(job, sendNow)
        local p = job.target
        local reached = if p.Anchored then hoverOnly else OwnedByMe(p)   -- placed items can't be owned
        if reached then
            if sendNow then Send(job) else held[job] = true end
            return true
        end
        held[job] = nil
        return false
    end

    local function SendHeld(list)
        for _, job in ipairs(list) do
            if held[job] and job.target.Parent then Send(job) end
        end
    end

    -- stay until what we just sent has really arrived; resend anything that snapped back
    local function ConfirmArrival()
        if #recent == 0 then return end
        for _ = 1, 3 do
            task.wait(TRUCK.Settle)
            local allThere = true
            for _, job in ipairs(recent) do
                local p = job.target
                if p.Parent and (p.Position - job.goalCF.Position).Magnitude > TRUCK.ArriveRadius then
                    allThere = false
                    p.CFrame = job.goalCF
                    ZeroVelocity(p)
                end
            end
            if allThere then break end
        end
        table.clear(recent)
    end

    -- plan one stop: the group of items to visit and where the truck goes for them
    local function PlanVisit(pending)
        -- closest unowned item first (shortest route)
        local anchor, best = pending[1].target, math.huge
        for _, job in ipairs(pending) do
            local d = (job.target.Position - lastPos).Magnitude
            if d < best then anchor, best = job.target, d end
        end

        -- Ownership comes from items sitting INSIDE the bed, so only group items that really
        -- fit in the bed's box together (measured in the bed's own axes), at a similar height.
        local toBed = upright * bedCF.Rotation
        local ordered = table.clone(pending)
        table.sort(ordered, function(a, b)
            return (a.target.Position - anchor.Position).Magnitude < (b.target.Position - anchor.Position).Magnitude
        end)

        local cluster = {}
        local loX, hiX, loZ, hiZ =  math.huge, -math.huge, math.huge, -math.huge
        local minBottom, maxTop  =  math.huge, -math.huge
        for _, job in ipairs(ordered) do
            local p   = job.target
            local rel = toBed:VectorToObjectSpace(p.Position)
            local nLoX, nHiX = math.min(loX, rel.X), math.max(hiX, rel.X)
            local nLoZ, nHiZ = math.min(loZ, rel.Z), math.max(hiZ, rel.Z)
            local fits = (nHiX - nLoX) <= bedSize.X - 1
                and (nHiZ - nLoZ) <= bedSize.Z - 1
                and math.abs(p.Position.Y - anchor.Position.Y) <= bandHalf
            if #cluster == 0 or fits then
                table.insert(cluster, job)
                loX, hiX, loZ, hiZ = nLoX, nHiX, nLoZ, nHiZ
                minBottom = math.min(minBottom, p.Position.Y - p.Size.Y / 2)
                maxTop    = math.max(maxTop,    p.Position.Y + p.Size.Y / 2)
            end
        end

        -- centre the bed on the group's bounding box
        local mid    = toBed:VectorToWorldSpace(Vector3.new((loX + hiX) / 2, 0, (loZ + hiZ) / 2))
        local center = Vector3.new(mid.X, 0, mid.Z)

        -- first visit: truck upside down, bed facing down over the items. Retries change the
        -- height, and the last resort is right way up with the bed under the items.
        local attempt = 0
        for _, job in ipairs(cluster) do attempt = math.max(attempt, job.tries or 0) end

        local rot, bedY
        if attempt == 0 and (maxTop - minBottom) <= bedSize.Y - 0.4 then
            rot, bedY = flipped, minBottom + 0.2 + bedSize.Y / 2   -- items at the bed's bottom
        elseif attempt <= 1 then
            rot, bedY = flipped, (minBottom + maxTop) / 2          -- centered on the items
        else
            rot, bedY = upright, minBottom - 0.2 + bedSize.Y / 2   -- right way up, bed under them
        end

        local bedPos = Vector3.new(center.X, bedY, center.Z)
        return cluster, CFrame.new(bedPos - rot:VectorToWorldSpace(bedCF.Position)) * rot, bedPos
    end

    --[[
        Visit the items in `list` group by group until we own them.
          sendNow = true : each item goes to its spot the moment we own it
          sendNow = false: items are only held, so the caller can move them all at once
          quick           : short look at each stop, misses are not retried
    ]]
    local function Collect(list, sendNow, countFailures, quick)
        -- same pacing as the normal teleport: a short pre-wait, then at most OwnershipTimeout
        local settle   = Settings.PreFireWait
        local maxDwell = quick and Settings.OwnershipTimeout / 2 or Settings.OwnershipTimeout

        for _ = 1, #list * 3 + 10 do
            if State.BatchCancelled then return end
            if not StillSeated() then
                NotifyItems("You left the driver seat. Stopping.")
                State.BatchCancelled = true
                return
            end

            local pending = {}
            for _, job in ipairs(list) do
                if job.target.Parent and not job.skipped and not job.done
                    and not (quick and job.quickMiss) and not TryClaim(job, sendNow or hoverOnly) then
                    table.insert(pending, job)
                end
            end
            if #pending == 0 then
                if sendNow then ConfirmArrival() end
                return
            end

            local cluster, scoopCF, bedPos = PlanVisit(pending)
            session.hold = scoopCF
            lastPos      = bedPos

            -- let the truck arrive, then wait (frame by frame) until the group is ours
            task.wait(settle)
            local deadline = tick() + maxDwell
            repeat
                local all = true
                for _, job in ipairs(cluster) do
                    if not held[job] and not job.done and job.target.Parent
                        and not TryClaim(job, sendNow) then
                        all = false
                    end
                end
                if all then break end
                RunService.Heartbeat:Wait()
            until tick() > deadline or State.BatchCancelled

            for _, job in ipairs(cluster) do
                if not held[job] and not job.done and job.target.Parent then
                    if quick then
                        job.quickMiss = true
                    else
                        job.tries = (job.tries or 0) + 1
                        if job.tries >= TRUCK.MaxVisits then
                            job.skipped = true
                            if countFailures then failed += 1 end
                        end
                    end
                end
            end

            if hoverOnly then SendHeld(cluster) end      -- delete this chunk before moving on
            if sendNow then ConfirmArrival() end
        end
    end

    local function Requeue(list, full)
        for _, job in ipairs(list) do
            job.done, job.quickMiss = false, nil
            if full then job.tries, job.skipped = 0, nil end
            held[job] = nil
        end
    end

    -- own `list` first, then put all of it in place at once
    local function OwnThenPlace(list, countFailures)
        Collect(list, false, countFailures)
        if State.BatchCancelled then return false end
        SendHeld(list)
        ConfirmArrival()
        return true
    end

    ------------------------------------------------------------------
    -- phases
    ------------------------------------------------------------------
    local function NotGrouped()
        local list = {}
        for _, job in ipairs(jobs) do
            local p = job.target
            if p.Parent and not job.skipped
                and (p.Position - job.goalCF.Position).Magnitude > TRUCK.GroupRadius then
                table.insert(list, job)
            end
        end
        return list
    end

    local function Misplaced()
        local list = {}
        for _, job in ipairs(jobs) do
            local p = job.target
            if job.done and p.Parent then
                local off  = (p.Position - job.goalCF.Position).Magnitude > TRUCK.FixDistance
                local tilt = p.CFrame.UpVector:Dot(job.goalCF.UpVector) < TRUCK.FixTilt
                if off or tilt then table.insert(list, job) end
            end
        end
        return list
    end

    local function Strays()
        local list = {}
        for _, job in ipairs(jobs) do
            local p = job.target
            if p.Parent and Flat(p.Position - stackCenter).Magnitude > stackRadius then
                table.insert(list, job)
            end
        end
        return list
    end

    local ok, runErr = pcall(function()
        if hoverOnly then
            Collect(jobs, false, true)         -- own each chunk in the bed, delete it, move on
            return
        end

        -- 1) GATHER: quick passes first, then proper waits, until everything is near its spot
        for pass = 1, 6 do
            if State.BatchCancelled then return end
            local todo = NotGrouped()
            if #todo == 0 then break end
            Requeue(todo)
            Collect(todo, true, pass >= 3, pass < 3)
        end
        if State.BatchCancelled then return end

        Requeue(jobs)                          -- everything gets re-owned in the next step
        for _, job in ipairs(jobs) do job.tries = 0 end

        -- 2) OWN + DROP: it's all grouped now, so own every item and place the stack at once
        if not OwnThenPlace(jobs, true) then return end

        -- 3) FIX: re-place whatever flopped, all in one go
        for _ = 1, 3 do
            task.wait(TRUCK.FixSettle)
            local bad = Misplaced()
            if #bad == 0 then break end
            Requeue(bad, true)
            if not OwnThenPlace(bad, false) then return end
        end

        -- 4) STRAYS: anything still outside the stack area gets one more try
        for _ = 1, 2 do
            local strays = Strays()
            if #strays == 0 or State.BatchCancelled then break end
            Requeue(strays, true)
            if not OwnThenPlace(strays, false) then return end
        end

        local outside = #Strays()
        if outside > 0 then
            NotifyItems(("%d item(s) are still outside the stack area."):format(outside))
        end
    end)
    if not ok then warn("[LOT] Truck Tp error: " .. tostring(runErr)) end

    session:Stop()
    State.IsBusy = false
    if failed > 0 then
        NotifyItems(("%d item(s) couldn't be grabbed."):format(failed))
    end

    local success = ok and not State.BatchCancelled
    State.BatchCompleted:_Fire(success, #jobs)
    return success
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

    if Settings.TruckTp then
        return RunTruckBatch(jobs)
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
    frame.BackgroundColor3       = Settings.SelectionColor
    frame.BackgroundTransparency = 0.7
    frame.BorderSizePixel        = 0
    frame.Visible                = false
    frame.ZIndex                 = 10
    frame.Parent                 = sg

    local stroke           = Instance.new("UIStroke")
    stroke.Color           = Settings.SelectionColor:Lerp(Color3.new(1, 1, 1), 0.45)
    stroke.Thickness       = 2
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
    local selectedSet, seen, added = {}, {}, {}
    for _, o in ipairs(State.SelectedObjects) do selectedSet[o] = true end

    for _, obj in ipairs(playerModels:GetDescendants()) do
        if obj:IsA("BasePart") then
            local main = getObjectData(obj)
            if main and not seen[main] then
                seen[main] = true
                local screenPos, onScreen = Camera:WorldToScreenPoint(main.Position)
                local sx, sy = screenPos.X + inset.X, screenPos.Y + inset.Y
                if onScreen and screenPos.Z > 0 and sx >= minX and sx <= maxX and sy >= minY and sy <= maxY then
                    if selectedSet[main] then
                        selectedSet[main] = nil
                    else
                        selectedSet[main] = true
                        table.insert(added, main)
                    end
                end
            end
        end
    end

    local result = {}
    for _, o in ipairs(State.SelectedObjects) do
        if selectedSet[o] then table.insert(result, o) end
    end
    for _, o in ipairs(added) do table.insert(result, o) end
    State.SelectedObjects = result

    UpdateVisuals()
end

-- Drag-to-select. Works with touch (finger down, drag, release) and mouse (hold left click).
local LASSO_ACTION = "ItemsLassoSelect"

local function LassoPointerPos(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        return Vector2.new(input.Position.X, input.Position.Y) + GuiService:GetGuiInset()
    end
    return UIS:GetMouseLocation()
end

local function UnbindLasso()
    ContextActionService:UnbindAction(LASSO_ACTION)
    if State.LassoUpdateConn then
        State.LassoUpdateConn:Disconnect()
        State.LassoUpdateConn = nil
    end
    State.LassoDragging = false
    State.LassoInput    = nil
    if State.LassoFrame then State.LassoFrame.Visible = false end
end

local function BindLasso()
    UnbindLasso()
    if not State.LassoFrame then InitLassoGui() end

    -- follow the finger / mouse while dragging
    State.LassoUpdateConn = RunService.RenderStepped:Connect(function()
        if State.LassoDragging and State.LassoInput then
            State.LassoLastPos = LassoPointerPos(State.LassoInput)
            UpdateLassoFrame(State.LassoLastPos)
        end
    end)

    -- high priority + Sink: the drag doesn't also spin the camera
    ContextActionService:BindActionAtPriority(LASSO_ACTION, function(_, inputState, input)
        local sink = Enum.ContextActionResult.Sink

        if inputState == Enum.UserInputState.Begin then
            if State.LassoDragging then return sink end
            State.LassoDragging = true
            State.LassoInput    = input
            State.LassoStartPos = LassoPointerPos(input)
            State.LassoLastPos  = State.LassoStartPos
            return sink
        end

        local mine = State.LassoDragging and State.LassoInput
            and input.UserInputType == State.LassoInput.UserInputType
            and (input.UserInputType ~= Enum.UserInputType.Touch or input == State.LassoInput)
        if not mine then return sink end

        if inputState == Enum.UserInputState.End then
            local endPos = LassoPointerPos(input)
            State.LassoDragging = false
            State.LassoInput    = nil
            if State.LassoFrame then State.LassoFrame.Visible = false end
            SelectObjectsInLassoRect(State.LassoStartPos, endPos)
        elseif inputState == Enum.UserInputState.Cancel then
            State.LassoDragging = false
            State.LassoInput    = nil
            if State.LassoFrame then State.LassoFrame.Visible = false end
        end
        return sink
    end, false, Enum.ContextActionPriority.High.Value, Enum.UserInputType.Touch, Enum.UserInputType.MouseButton1)
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

-- Capacity of the current sort grid / pyramid, capped by how many items are selected.
local function GetStackCount()
    local capacity = Settings.PyramidMode
        and GetPyramidCapacity(Settings.StackX, Settings.StackZ)
        or  (Settings.StackX * Settings.StackY * Settings.StackZ)
    return math.min(capacity, #State.SelectedObjects)
end

-- First valid selected item: its model, part size and model bounding-box size.
local function GetReferenceItem()
    for _, obj in ipairs(State.SelectedObjects) do
        if obj and obj.Parent then
            local model = obj:FindFirstAncestorOfClass("Model") or obj.Parent
            local _, bbSize = model:GetBoundingBox()
            return model, obj.Size, bbSize
        end
    end
end

-- Grid or pyramid positions for a given origin.
local function GetLayoutPositions(origin, itemSize, count, stackRotation)
    if Settings.PyramidMode then
        return GetPyramidPositions(origin, itemSize, Settings.StackX, Settings.StackZ, count, stackRotation)
    end
    return GetStackPositions(origin, itemSize, Settings.StackX, Settings.StackY, Settings.StackZ, count, stackRotation)
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
    if State.DeleteMode then
        NotifyItems("Turn off Delete Mode to sort items.")
        return
    end

    local ok, why = AllSelectedSameType()
    if not ok then
        if State.Library then State.Library:Notify("Items", why) end
        return
    end

    local refModel, refSize, refBBSize = GetReferenceItem()
    if not refModel then return end

    ClearStackPreview()

    local function AddPreview()
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
        clone.PrimaryPart = clone:FindFirstChild("Main") or clone:FindFirstChildWhichIsA("BasePart")
        clone.Parent = workspace
        table.insert(State.StackPreviewParts, clone)
        table.insert(State.StackPreviewBoxes, NewSelectionBox(clone, Settings.OutlineThickness, Settings.FillTransparency))
    end

    local function RemovePreview()
        local clone = table.remove(State.StackPreviewParts)
        local box   = table.remove(State.StackPreviewBoxes)
        if box   then box:Destroy()   end
        if clone then clone:Destroy() end
    end

    -- keep the number of preview items in step with the current settings
    local function SyncPreviewCount()
        local want = GetStackCount()
        while #State.StackPreviewParts < want do AddPreview() end
        while #State.StackPreviewParts > want do RemovePreview() end
    end

    State.StackMode = true
    SetStackBtnLabel("Stop")

    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Exclude

    State.StackPreviewConn = RunService.RenderStepped:Connect(function()
        if not State.StackMode then return end

        SyncPreviewCount()
        rayParams.FilterDescendantsInstances = BuildRayExclude()
        local unitRay = TapRay()
        local result  = workspace:Raycast(unitRay.Origin, unitRay.Direction * 500, rayParams)

        local itemSize = RotatedBoundingSize(refSize, State.ItemRotation)
        local origin   = result
            and (result.Position + Vector3.new(0, RotatedBoundingSize(refBBSize, State.ItemRotation).Y * 0.5, 0))
            or  (unitRay.Origin + unitRay.Direction * 40)

        local positions = GetLayoutPositions(origin, itemSize, #State.StackPreviewParts, State.StackRotation)
        for i, preview in ipairs(State.StackPreviewParts) do
            if positions[i] then
                preview:PivotTo(CFrame.new(positions[i]) * State.StackRotation * State.ItemRotation)
            end
        end
    end)
end

local function PerformStackExecute(hitPos)
    if not State.StackMode then return end
    if not AllSelectedSameType() then StopStackMode() return end

    local refModel, refSize, refBBSize = GetReferenceItem()
    if not refModel then StopStackMode() return end

    local stackCount   = GetStackCount()
    local stackRot     = State.StackRotation
    local itemRot      = State.ItemRotation

    local origin = hitPos + Vector3.new(0, RotatedBoundingSize(refBBSize, itemRot).Y * 0.5, 0)
    local goals  = GetLayoutPositions(origin, RotatedBoundingSize(refSize, itemRot), stackCount, stackRot)

    StopStackMode(true)

    local jobs = {}
    for i = 1, stackCount do
        local obj = State.SelectedObjects[i]
        if obj and obj.Parent then
            table.insert(jobs, {
                target = obj,
                goalCF = CFrame.new(goals[i] or origin) * stackRot * itemRot,
            })
        end
    end

    task.spawn(function()
        SetStackBtnLabel("Stop")
        RunBatch(jobs)
        SetStackBtnLabel("Start")
        if not Settings.KeepSelected then State.SelectedObjects = {} end
        UpdateVisuals()
    end)
end

local function PerformSingleSelect()
    local main = getObjectData(TapTarget)
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
    local _, _, targetModel = getObjectData(TapTarget)
    if not targetModel then return end

    local targetItemName  = GetItemName(targetModel)
    if not targetItemName then return end
    local targetOwnerIden = GetOwnerIdentity(targetModel)
    local targetSig       = GetModelSignature(targetModel)
    local targetTreeClass = GetTreeClass(targetModel)
    local targetSizeY     = GetMainPartSizeY(targetModel)

    local playerModels = workspace:FindFirstChild("PlayerModels")
    if not playerModels then return end

    local selectedSet = {}
    for _, o in ipairs(State.SelectedObjects) do selectedSet[o] = true end

    local seen, added = {}, {}
    for _, obj in ipairs(playerModels:GetDescendants()) do
        if obj:IsA("Model")
            and GetItemName(obj) == targetItemName
            and GetOwnerIdentity(obj) == targetOwnerIden
            and GetTreeClass(obj) == targetTreeClass
        then
            local okSize = true
            if Settings.MatchPlankSize and targetSizeY ~= nil then
                local sy = GetMainPartSizeY(obj)
                okSize = sy ~= nil and math.abs(sy - targetSizeY) <= 1
            end
            if okSize and GetModelSignature(obj) == targetSig then
                local rawPart = obj:FindFirstChild("Main") or obj:FindFirstChildWhichIsA("BasePart")
                if rawPart then
                    local main = getObjectData(rawPart)
                    if main and not seen[main] then
                        seen[main] = true
                        if selectedSet[main] then
                            selectedSet[main] = nil
                        else
                            selectedSet[main] = true
                            table.insert(added, main)
                        end
                    end
                end
            end
        end
    end

    local result = {}
    for _, o in ipairs(State.SelectedObjects) do
        if selectedSet[o] then table.insert(result, o) end
    end
    for _, o in ipairs(added) do table.insert(result, o) end
    State.SelectedObjects = result

    UpdateVisuals()
end

local function PerformClear()
    if State.StackMode then StopStackMode() end
    State.SelectedObjects = {}
    State.BatchCancelled  = true
    UpdateVisuals()
end

local DeleteBtn

local function ResetDeleteArm()
    State.DeleteArmedAt = 0
    if DeleteBtn then DeleteBtn:SetText("Delete") end
end

-- fires the game's DestroyStructure remote for every selected item
local function PerformDelete()
    if State.DeleteBusy then
        State.DeleteCancel = true
        return
    end
    if not State.DeleteMode then
        NotifyItems("Turn on Delete Mode first.")
        return
    end

    local models, seen = {}, {}
    for _, part in ipairs(State.SelectedObjects) do
        local model = part and DeleteTopModel(part)
        if model and not seen[model] then
            seen[model] = true
            table.insert(models, model)
        end
    end
    if #models == 0 then
        NotifyItems("Nothing selected to delete.")
        return
    end

    -- two presses, so a stray tap can't wipe a build
    if State.DeleteArmedAt == 0 or tick() - State.DeleteArmedAt > 5 then
        State.DeleteArmedAt = tick()
        if DeleteBtn then DeleteBtn:SetText("Confirm " .. #models) end
        NotifyItems(("Press again within 5 seconds to delete %d item(s)."):format(#models))
        local armed = State.DeleteArmedAt
        task.delay(5.1, function()
            if State.DeleteArmedAt == armed and not State.DeleteBusy then
                ResetDeleteArm()
            end
        end)
        return
    end
    ResetDeleteArm()

    State.DeleteBusy   = true
    State.DeleteCancel = false
    if DeleteBtn then DeleteBtn:SetText("Stop") end

    task.spawn(function()
        local remote  = ReplicatedStorage:WaitForChild("Interaction"):WaitForChild("DestroyStructure")
        local pending = models
        local BATCH   = 5

        local function Gone(m) return not m:IsDescendantOf(workspace) end

        -- Never gives up on its own: fire a few, wait until the server has really removed
        -- them, then do the next few. Leftovers are retried (slower each time) until
        -- everything is gone or you press Stop.
        local pass, idle = 0, 0
        while #pending > 0 and not State.DeleteCancel do
            pass += 1
            local before = #pending

            local i = 1
            while i <= #pending and not State.DeleteCancel do
                local batch = {}
                for j = i, math.min(i + BATCH - 1, #pending) do
                    local m = pending[j]
                    if not Gone(m) then
                        pcall(remote.FireServer, remote, m)
                        table.insert(batch, m)
                    end
                end

                -- wait for this batch to disappear (or time out, then it gets retried next pass)
                local deadline = tick() + math.min(0.5 + pass * 0.25, 3)
                repeat
                    task.wait(0.05)
                    local all = true
                    for _, m in ipairs(batch) do
                        if not Gone(m) then all = false break end
                    end
                until all or tick() > deadline or State.DeleteCancel

                if Settings.DeleteDelay > 0 then task.wait(Settings.DeleteDelay) end
                i += BATCH
            end

            local left = {}
            for _, m in ipairs(pending) do
                if not Gone(m) then table.insert(left, m) end
            end
            pending = left

            if #pending == before then idle += 1 else idle = 0 end
            if #pending > 0 and not State.DeleteCancel then
                if idle == 5 then
                    NotifyItems(("%d item(s) aren't going away, still trying. Press Stop to give up."):format(#pending))
                end
                task.wait(math.min(0.5 * pass, 3))
            end
        end

        -- if you stopped it, list what is left (F9 console)
        for _, model in ipairs(pending) do
            local t = model:FindFirstChild("Type")
            warn(("[Delete] still in world: %s | Type=%s | Owner=%s"):format(
                model.Name, t and tostring(t.Value) or "?", tostring(GetOwnerIdentity(model))))
        end

        local deleted   = #models - #pending
        local cancelled = State.DeleteCancel
        State.DeleteBusy   = false
        State.DeleteCancel = false

        -- keep only what is still in the world
        local keep = {}
        for _, part in ipairs(State.SelectedObjects) do
            if part and part:IsDescendantOf(workspace) then table.insert(keep, part) end
        end
        State.SelectedObjects = keep
        UpdateVisuals()

        if DeleteBtn then DeleteBtn:SetText("Delete") end
        if cancelled then
            NotifyItems(("Stopped after %d item(s)."):format(deleted))
        elseif #pending > 0 then
            NotifyItems(("Deleted %d item(s), %d couldn't be deleted."):format(deleted, #pending))
        else
            NotifyItems(("Deleted %d item(s)."):format(deleted))
        end
    end)
end

local function PerformExecute()
    if State.IsBusy then
        State.BatchCancelled = true
        return
    end

    if State.DeleteMode then
        NotifyItems("Turn off Delete Mode to teleport items.")
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

function LooseObjectTeleport.TeleportMany(jobs, returnToOrigin)
    assert(type(jobs) == "table", "LOT.TeleportMany: expected table of jobs")
    if State.IsBusy then warn("LOT.TeleportMany: ignored — batch running.") return false end
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
    UnbindLasso()
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

    -- Selection tools
    Tab:CreateSection("Selection Tools")
    ClickToggle = Tab:CreateToggle("Click Selection", false, function(val)
        State.ClickSelectMode = val
        if val then DisableOtherSelectionModes("click") end
    end)
    GroupToggle = Tab:CreateToggle("Group Selection", false, function(val)
        State.GroupSelectMode = val
        if val then DisableOtherSelectionModes("group") end
    end)
    LassoToggle = Tab:CreateToggle("Lasso Selection", false, function(val)
        State.LassoMode = val
        if val then
            DisableOtherSelectionModes("lasso")
            BindLasso()
        else
            UnbindLasso()
        end
    end)

    Tab:CreateToggle("Truck Tp", false, function(val)
        Settings.TruckTp = val
        if val then NotifyItems("Truck Tp on: sit in your truck's driver seat, then teleport or place a stack.") end
    end):AddTooltip("Uses your truck to take ownership of everything in the bed and teleport the whole batch at once. You must be sitting in the truck.")

    local MainRow = Tab:CreateRow()
    MainRow:CreateAction("Clear Selection", "Clear", PerformClear)
    State.TpBtn = MainRow:CreateAction("Teleport Selection", "Start", function()
        task.spawn(PerformExecute)
    end)


    -- Sorting
    Tab:CreateSection("Sorting")
    Tab:CreateSlider("X", 1, 40, Settings.StackX, function(val) Settings.StackX = val end)
    Tab:CreateSlider("Y", 1, 20, Settings.StackY, function(val) Settings.StackY = val end)
    Tab:CreateSlider("Z", 1, 40, Settings.StackZ, function(val) Settings.StackZ = val end)
    Tab:CreateSlider("Padding (tenths)", 0, 10, math.floor(Settings.StackPadding * 10 + 0.5), function(val)
        Settings.StackPadding = val / 10
    end)

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

    Tab:CreateAction("Place Stack", "Place", function()
        if not State.StackMode or State.IsBusy then return end
        local result, ray = TapRaycast()
        local hit = result and result.Position or (ray.Origin + ray.Direction * 40)
        task.spawn(PerformStackExecute, hit)
    end)
    Tab:CreateAction("Rotate (X)", "Rotate", function()
        if State.StackMode then
            State.ItemRotation = State.ItemRotation * CFrame.Angles(0, math.rad(90), 0)
        end
    end)
    Tab:CreateAction("Rotate (Y)", "Rotate", function()
        if State.StackMode then
            State.ItemRotation = State.ItemRotation * CFrame.Angles(math.rad(90), 0, 0)
        end
    end)
    Tab:CreateToggle("Pyramid Sorter", false, function(val)
        Settings.PyramidMode = val
    end):AddTooltip("Stacks objects into a pyramid shape. Y layer is unused in pyramid mode.")

    -- Delete
    Tab:CreateSection("Delete")
    Tab:CreateToggle("Delete Mode", false, function(val)
        if State.StackMode then StopStackMode(true) end
        State.SelectedObjects = {}
        UpdateVisuals()
        State.DeleteMode = val
        ResetDeleteArm()
        if val then
            NotifyItems("Delete Mode: pick a category, then select with Click / Group / Lasso Selection. Only your own items can be picked.")
        end
    end):AddTooltip("While on, the selection tools pick your placed items (not loose logs) in the chosen category. Press Delete Selected twice to confirm.")

    Tab:CreateDropdown("Category", DELETE_CATEGORIES, State.DeleteCategory, function(val)
        State.DeleteCategory = val
        State.SelectedObjects = {}
        UpdateVisuals()
        ResetDeleteArm()
    end)

    Tab:CreateSlider("Delete Delay (ms)", 0, 300, math.floor(Settings.DeleteDelay * 1000 + 0.5), function(val)
        Settings.DeleteDelay = (tonumber(val) or 50) / 1000
    end):AddTooltip("Pause between deletes. Lower is faster, higher is safer for big deletes.")

    local DeleteRow = Tab:CreateRow()
    DeleteBtn = DeleteRow:CreateAction("Delete Selected", "Delete", function()
        task.spawn(PerformDelete)
    end)

    -- Settings
    Tab:CreateSection("Settings")
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


    -- Tap handling (click / group select)
    local tapStart, tapTime, tapKind, tapInput
    local lastAct = 0

    table.insert(State.Connections, UIS.InputBegan:Connect(function(input, processed)
        if processed then return end
        local kind = input.UserInputType
        if kind ~= Enum.UserInputType.Touch and kind ~= Enum.UserInputType.MouseButton1 then return end
        tapKind = kind
        tapInput = input
        tapStart = Vector2.new(input.Position.X, input.Position.Y)
        tapTime = tick()
    end))

    table.insert(State.Connections, UIS.InputEnded:Connect(function(input)
        if input.UserInputType ~= tapKind then return end
        if tapKind == Enum.UserInputType.Touch and input ~= tapInput then return end
        tapKind = nil
        if State.IsBusy then return end
        if not (State.StackMode or State.GroupSelectMode or State.ClickSelectMode) then return end
        local pos = Vector2.new(input.Position.X, input.Position.Y)
        if (pos - tapStart).Magnitude > 25 or tick() - tapTime > 0.6 then return end
        if tick() - lastAct < 0.2 then return end
        lastAct = tick()
        TapPos = pos + GuiService:GetGuiInset()
        if State.StackMode then return end
        TapTarget = FindTapTarget()
        if State.GroupSelectMode then
            task.spawn(PerformGroupSelect)
        elseif State.ClickSelectMode then
            PerformSingleSelect()
        end
    end))

    UpdateVisuals()
end

function LooseObjectTeleport.Unload()
    StopStackMode(true)
    UnbindLasso()
    for _, conn in ipairs(State.Connections) do conn:Disconnect() end
    for _, v in pairs(State.SelectionBoxes) do v:Destroy() end
    if State.LassoGui then State.LassoGui:Destroy() end
end

return LooseObjectTeleport
]==]

    ------------------------------------------------------------------
    -- Adapter: maps the Items module's Tab API onto this UI library
    ------------------------------------------------------------------
    local tab = ui.category("Items")
    local cur
    local null = setmetatable({}, {__index = function() return function(self) return self end end})

    local function sec()
        if not cur then cur = tab.section("Items") end
        return cur
    end

    local api = {}

    function api:CreateSection(name)
        cur = tab.section(tostring(name))
        return null
    end

    function api:CreateRow()
        return self
    end

    function api:CreateToggle(title, default, cb)
        local state = default == true
        local t = sec().toggle(title, function(v)
            state = v and true or false
            if cb then cb(state) end
        end, default == true or nil)
        local obj = {}
        function obj:SetState(v)
            v = v and true or false
            if state == v then return end -- avoid redundant callbacks / re-entrancy
            t:ChangeState(v)
        end
        function obj:GetState() return state end
        function obj:AddTooltip() return self end
        return obj
    end

    function api:CreateAction(title, btnText, cb)
        local obj = {}
        local function label(t)
            if t and t ~= "" then return title .. "  [" .. t .. "]" end
            return title
        end
        local b = sec().button(label(btnText), function()
            if cb then cb() end
        end, true)
        if b and b.text then
            b.text.TextSize = 15
            b.text.TextTruncate = Enum.TextTruncate.AtEnd
        end
        function obj:SetText(t)
            if b and b.text then b.text.Text = label(t) end
        end
        function obj:AddTooltip() return self end
        return obj
    end

    function api:CreateDropdown(title, options, default, cb)
        local list = {}
        for _, o in ipairs(options) do table.insert(list, o) end
        local d = sec().dropdown(title, function(v)
            if cb then cb(v) end
        end, list)
        if d and d.textbox and default then
            d.textbox.Text = default
        end
        local obj = {}
        function obj:AddTooltip() return self end
        return obj
    end

    function api:CreateSlider(title, min, max, default, cb)
        default = math.clamp(tonumber(default) or min, min, max)
        sec().slider(title, function(v)
            if cb then cb(tonumber(v)) end
        end, min, max, default, true)
        local obj = {}
        function obj:AddTooltip() return self end
        return obj
    end

    for _, name in ipairs({"CreateToggle", "CreateAction", "CreateSlider", "CreateDropdown"}) do
        local fn = api[name]
        api[name] = function(self, ...)
            local ok, res = pcall(fn, self, ...)
            if ok then return res end
            warn("[items] " .. name .. " failed: " .. tostring(res))
            return null
        end
    end

    ------------------------------------------------------------------
    -- Load + run
    ------------------------------------------------------------------
    local lib = {}
    function lib:Notify(title, text)
        ui.notify("notify", tostring(text), 3)
    end

    local ok, module = pcall(function() return loadstring(source)() end)
    if ok and module then
        local ok2, err = pcall(module.Init, api, lib)
        if not ok2 then warn("[items] init failed: " .. tostring(err)) end
    else
        warn("[items] load failed: " .. tostring(module))
    end
end
