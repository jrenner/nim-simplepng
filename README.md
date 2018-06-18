# nim-simplepng
Wrapper around nimpng for simple writing of PNG files

# example

```nim
# create 600 width, 600 height image
var p = initPixels(600, 600)
# set it to all white, full alpha
p.fill(255, 255, 255, 255)
var n = 0
# use sin and cos to create a pattern for writing to the image
for pixel in p.mitems:
    n += 1
    let n1 = sin(n.float / 100.0)
    let r = (n1*100).uint8
    let n2 = cos(n.float / 50.0)
    let g = 0'u8
    let b = (n2*50).uint8
    let a = 255'u8
    # set RGBA values for this pixel
    pixel.setColor(r, g, b, a)



#for i, item in p.datatoString():
#echo "i: {i:>4}, item: {item.uint8:>3}".fmt
# save file to disk
simplePNG("/tmp/what.png", p)
```


