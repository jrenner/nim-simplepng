import nimPNG
import base64
import strformat
import strutils
import random

type
  Pixel* = ref object
    r*, g*, b*, a*: uint8

  Pixels* = ref object
    width*: int
    height*: int
    data: seq[Pixel]

proc getPixel*(pixels: var Pixels, x, y: int): var Pixel =
  let idx = (pixels.width * y) + x
  result = pixels.data[idx]

template `[]`*(pixels: var Pixels, x, y: int): var Pixel =
  getPixel(pixels, x, y)
  


proc initPixels*(width, height: int): Pixels =
  result = Pixels(width: width, height: height, data: @[])
  for i in 0..<(width*height):
    result.data.add(Pixel())
  assert result.data.len == width*height

proc setColor*(p: var Pixel, r, g, b, a: uint8) =
  p.r = r
  p.g = g
  p.b = b
  p.a = a

template setColor*(p: var Pixel, r, g, b, a: int) =
  p.setColor(r.uint8, g.uint8, b.uint8, a.uint8)

template setColor*(p: var Pixel, r, g, b, a: float) =
  let rr = (r*255).uint8
  let gg = (g*255).uint8
  let bb = (b*255).uint8
  let aa = (a*255).uint8
  p.setColor(rr, gg, bb, aa)

proc fill*(pixels: var Pixels, r, g, b, a: uint8) =
  for i in 0..<pixels.data.len:
    pixels.data[i].setColor(r, g, b, a)
  

proc dataToString*(pix: Pixels): string =
  result = newString(pix.height * pix.width * 4)
  var i = 0
  for pixel in pix.data:
    result[i] = pixel.r.char; i += 1
    result[i] = pixel.g.char; i += 1
    result[i] = pixel.b.char; i += 1
    result[i] = pixel.a.char; i += 1


proc simplePNG*(filepath: string, pixels: Pixels) =
  let dataString: string = pixels.dataToString()
  discard savePNG(filepath, dataString, colorType=LCT_RGBA, 8, pixels.width, pixels.height)

iterator items*(pixels: Pixels): Pixel {.inline.} =
  var i = 0
  while i < pixels.data.len:
    yield pixels.data[i]
    inc(i)

iterator mitems*(pixels: var Pixels): var Pixel {.inline.} =
  var i = 0
  while i < pixels.data.len:
    yield pixels.data[i]
    inc(i)
