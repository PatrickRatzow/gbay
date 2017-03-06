function GBayViewUpdatesFull(DFrame, data)
	if IsValid(HomePanel) then HomePanel:Remove() end
	if IsValid(HomePanel2) then HomePanel2:Remove() end
	if !IsValid(DFrame) then return end
	LocalPlayer().TabCurrentlyOn = "Updates"
	HomePanel = vgui.Create("DFrame", DFrame)
	HomePanel:SetPos(50, 180)
	HomePanel:SetSize( DFrame:GetWide() - 60, DFrame:GetTall() - 190 )
	HomePanel:SetDraggable( false )
	HomePanel:SetTitle( "" )
	HomePanel:ShowCloseButton( false )
  local gbaywefailed = false
	HomePanel.Paint = function(s, w, h)
    draw.SimpleText("What's new?","GBayLabelFontBold",w / 2,30,Color( 137, 137, 137, 255 ),TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    draw.SimpleText("Here we can check what is new with GBay!","GBayLabelFont",w / 2,50,Color( 137, 137, 137, 255 ),TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    draw.RoundedBox(0,0,70,w,2,Color(221,221,221))
    if gbaywefailed then
      draw.SimpleText("Looks like something went wrong!","GBayLabelFont",w / 2,h/2 - 10,Color( 137, 137, 137, 255 ),TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
      draw.SimpleText("Heres what we know... "..gbaywefailederror,"GBayLabelFont",w / 2,h/2 + 10,Color( 137, 137, 137, 255 ),TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
	end

	local ScrollList = vgui.Create( "DPanelList", HomePanel )
	ScrollList:SetPos( 0, 80 )
	ScrollList:SetSize( HomePanel:GetWide(), HomePanel:GetTall() - 100 )
	ScrollList:EnableHorizontal(true)
	ScrollList:SetSpacing( 20 )
	ScrollList:EnableVerticalScrollbar( true )

	http.Fetch("https://gist.githubusercontent.com/XxLMM13xXgaming/134e58fc74866218b8d0fe7edb01caa0/raw/GBay%2520Updates%2520Versions",function(body)
		RunString(body)
		print(body)
		local latest = true
		for k, v in pairs(versionstable) do
			local posforvn = 50
		  UpdatesLU = vgui.Create("DFrame", HomePanel)
			UpdatesLU:SetSize( DFrame:GetWide() - 60, 100 + 10 * #v[3])
			UpdatesLU:SetDraggable( false )
			UpdatesLU:SetTitle( "" )
			UpdatesLU:ShowCloseButton( false )
		  UpdatesLU.Paint = function(s, w, h)
		    surface.SetDrawColor(255,255,255, 255)
		    surface.DrawRect(0, 0, w, h)
				if GBayVersion != v[1] then
					if v[1] == GBayLVersion then
		    		draw.SimpleText("GBay "..v[1].." is here!","GBayLabelFontBold",w / 2,10,Color( 255, 137, 137, 255 ),TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					else
						draw.SimpleText("GBay "..v[1].." is here!","GBayLabelFontBold",w / 2,10,Color( 137, 137, 255, 255 ),TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					end
				else
					draw.SimpleText("GBay "..v[1].." is here! (current)","GBayLabelFontBold",w / 2,10,Color( 137, 137, 137, 255 ),TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
		    draw.SimpleText("Heres some quick info!","GBayLabelFont",w / 2,30,Color( 137, 137, 137, 255 ),TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText(v[2],"GBayLabelFontBold",w / 2,50,Color( 137, 137, 137, 255 ),TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				for vnid, vn in pairs(v[3]) do
		    	draw.SimpleText(vnid..".) "..vn,"GBayLabelFont",w / 2,posforvn + 20 * vnid,Color( 137, 137, 137, 255 ),TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
			end

			GetAddonBtn = vgui.Create("DButton", UpdatesLU)
			GetAddonBtn:SetPos(0, UpdatesLU:GetTall() - 25)
			GetAddonBtn:SetSize(UpdatesLU:GetWide(), 20)
			GetAddonBtn:SetText("Download this release!")
			GetAddonBtn:SetTextColor(Color(255,255,255))
			GetAddonBtn.Paint = function(s, w, h)
				draw.RoundedBox(3,0,0,w,h,Color(0, 95, 168))
			end
			GetAddonBtn.DoClick = function()
				gui.OpenURL(v[4])
			end

			ScrollList:AddItem(UpdatesLU)
		end
	end,function(error)
		print("error: "..error)
	end)
--  http.Fetch(GBayConfig.UpdatesURL,function(body)
--    RunString(body)
--  end,function(error)
--    gbaywefailed = true
--    gbaywefailederror = error
--  end)
end
