require "/scripts/colorutil.lua"
require "/scripts/util.lua"

flag = false
bodyColors = {}

function init()

end

function update(dt)
  local holder = entity.id()
  if holder then
	if flag == false then
			bodyColors = extractTone(holder)
			dexed = hextorgb(bodyColors[2])
			hsl = rgbtohsl(dexed)
			hsl[2] = 0.7
			hsl[3] = 0.45
			prepGlow = hsltorgb(hsl)
			flag = true
			end
		end

  animator.setLightColor("glow", {prepGlow[1], prepGlow[2], prepGlow[3]})
  animator.setLightActive("glow", true)
end

function uninit()
end
