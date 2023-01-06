function love.load()
    json = require 'libraries.json'
    --love.filesystem.createDirectory("palletes")
    --love.filesystem.createDirectory("export")
    --love.filesystem.createDirectory("images")

    -- load a json file with the pallete --
    --palleteFile = love.filesystem.read("palletes/pallete.json")
    palleteFile = io.open("palletes/pallete.json", "r")
    palleteData = palleteFile:read("*all")
    pallete = json.decode(palleteData)

    -- read all the files in the folder --
    ImageFiles = love.filesystem.getDirectoryItems("images")

    -- load the image in the folder --
    for f = 1, #ImageFiles, 1 do
        -- load image --
        imagedata = love.image.newImageData("images/" .. ImageFiles[f])
        image = love.graphics.newImage(imagedata)
        width, height = imagedata:getDimensions()

        -- create map --
        imageMap = {}
        for y = 1, height, 1 do
            imageMap[y] = {}
            for x = 1, width, 1 do
                r, g, b, a = imagedata:getPixel(x - 1, y - 1)
                R, G, B, A = love.math.colorToBytes(r, g, b, a)
                for c = 1, #pallete, 1 do
                    red = pallete[c][1]
                    green = pallete[c][2]
                    blue = pallete[c][3]
                    alpha = pallete[c][4]
                    if A == nil then
                        A = 255
                    end
                    if R == red or G == green or B == blue or A == alpha then
                        imageMap[y][x] = c
                    end
                end
            end
        end
        spritedata = json.encode(imageMap)
        --spritefile = love.filesystem.newFile("export/" .. string.gsub(ImageFiles[f], ".png", "") .. ".spr", "w")
        spritefile = io.open("export/" .. string.gsub(ImageFiles[f], ".png", "") .. ".spr", "w")
        spritefile:write(spritedata)
        spritefile:close()
    end
	love.event.quit()
end
