function extractTone(pid)
    directives = ""
    bodyColors = {}

    local portrait = world.entityPortrait(pid, "full")
    for k, v in pairs(portrait) do
        if string.find(portrait[k].image, "body.png") then
            local body_image =  portrait[k].image
            local directive_location = string.find(body_image, "replace")
            directives = string.sub(body_image,directive_location)
        end
    end

    --bodyColor1 = string.sub(directives, 16 ,21 )
    --bodyColor2 = string.sub(directives, 30 ,35 )
    --bodyColor3 = string.sub(directives, 44 ,49 )
    --bodyColor4 = string.sub(directives, 58 ,63 )
    --sb.logInfo("%s, %s, %s, %s", bodyColor1, bodyColor2, bodyColor3, bodyColor4)

    for i = 1, 4 do
        table.insert(bodyColors, i, string.sub(directives, (16 + (14 * (i - 1))), 21 + (14 * (i - 1))))
    end
    --for k, v in ipairs(bodyColors) do sb.logInfo("%s, %s", k, v) end
    return bodyColors
end

--replace;806319=0d500f;f6b919=17dc0d;fde03f=63f574;fff8b5=c7ffdc?replace;951500=417356;be1b00=6bb383;f32200=daffe5;dc1f00=97ecb0
--Body1=BodyColor1; Body2=BodyColor2; Body3=BodyColor3; Body4=BodyColor4; Hair1=HairColor1
--len = 127

function hextorgb(hex) -- Hexer Dexer RGBexer
    dexedhex = {}

    if string.len(hex) ~= 6 then
        sb.logWarn("Invalid hexadecimal color length! hextorgb() implementations must be passed 6-character variables.")
        return nil
    else
--        hex1 = string.sub(hex, 1, 2)
--        hex2 = string.sub(hex, 3, 4)
--        hex3 = string.sub(hex, 5, 6)

        for i = 1, 3 do
            table.insert(dexedhex, i, tonumber(string.sub(hex, 1 + (2 * (i - 1)), 2 + (2 * (i - 1))), 16))
            -- woah, mathematics
        end

--        redChannel = tonumber(chan1, 16)
--        greenChannel = tonumber(chan2, 16)
--        blueChannel = tonumber(chan3, 16)

        return dexedhex
    end
end

function rgbtohsl(rgb)
    rgbp = {0, 0, 0}
    for k, v in ipairs(rgb) do
        rgbp[k] = rgb[k] / 255
    end

    cmax = math.max(rgbp[1], rgbp[2], rgbp[3])
    cmin = math.min(rgbp[1], rgbp[2], rgbp[3])
    delta = cmax - cmin

    if delta == 0 then
        h = 0
    elseif cmax == rgbp[1] then
        h = 60 * (((rgbp[2] - rgbp[3]) / delta) % 6)
    elseif cmax == rgbp[2] then
        h = 60 * (((rgbp[3] - rgbp[1]) / delta) + 2)
    elseif cmax == rgbp[3] then
        h = 60 * (((rgbp[1] - rgbp[2]) / delta) + 4)
    end

    l = (cmax + cmin) / 2

    if delta == 0 then
        s = 0
    elseif delta > 0 or delta < 0 then
        s = (delta / (1 - math.abs((2 * l) - 1)))
    end

    hsl = {h, s, l}

    return hsl
end

function hsltorgb(hsl)
    c = (1 - math.abs((2 * hsl[3]) -1)) * hsl[2]

    x = c * (1 - math.abs((hsl[1]/60) % 2 - 1))

    m = hsl[3] - c/2

    rgbp = {}
    if 0 <= hsl[1] and hsl[1] < 60 then
        table.insert(rgbp, c)
        table.insert(rgbp, x)
        table.insert(rgbp, 0)
    elseif 60 <= hsl[1] and hsl[1] < 120 then
        table.insert(rgbp, x)
        table.insert(rgbp, c)
        table.insert(rgbp, 0)
    elseif 120 <= hsl[1] and hsl[1] < 180 then
        table.insert(rgbp, 0)
        table.insert(rgbp, c)
        table.insert(rgbp, x)
    elseif 180 <= hsl[1] and hsl[1] < 240 then
        table.insert(rgbp, 0)
        table.insert(rgbp, x)
        table.insert(rgbp, c)
    elseif 240 <= hsl[1] and hsl[1] < 300 then
        table.insert(rgbp, x)
        table.insert(rgbp, 0)
        table.insert(rgbp, c)
    elseif 300 <= hsl[1] and hsl[1] < 360 then
        table.insert(rgbp, c)
        table.insert(rgbp, 0)
        table.insert(rgbp, x)
    end

    rgb = {}
    for k, v in ipairs(rgbp) do
        table.insert(rgb, (v+m) * 255)
    end

    return rgb
end

