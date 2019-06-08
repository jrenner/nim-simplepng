import src/simplepng
import math

var p = initPixels(600, 600)
#p.fill(255, 0, 128, 255)
var n = 0
for pixel in p.mitems:
  n += 1
  let n1 = sin(n.float / 100.0)
  let r = (n1*100).uint8
  let n2 = cos(n.float / 50.0)
  let g = 0'u8
  let b = (n2*50).uint8
  let a = 255'u8
  pixel.setColor(r, g, b, a)



#for i, item in p.datatoString():
  #echo "i: {i:>4}, item: {item.uint8:>3}".fmt
simplePNG("./example.png", p)
echo "wrote example: example.png"
