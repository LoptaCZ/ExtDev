
TOOL.Category		= "[EXTDEV]"
TOOL.Name			= "#Tool.extdev_props.props"
TOOL.Command		= nil
TOOL.ConfigName		= ""

if CLIENT then
	language.Add("Tool.extdev_props.props","World Prop Maker")
	language.Add("Tool.extdev_props.name","World Prop Maker")
	language.Add("Tool.extdev_props.desc","Creates/Removes props.")
	language.Add("Tool.extdev_props.0","Left Click to add prop to world props.")
	language.Add("Tool.extdev_props.1","Right Click to remove from world props.")
end

function TOOL:LeftClick(trace)
	//
end

function TOOL:RightClick(trace)
	//
end

function TOOL:Reload(trace)
	//
end
