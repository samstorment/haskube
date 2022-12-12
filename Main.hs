-- run: `ghci Main.hs`
-- do: `scramble "F R U B L D F2 R2 U' L' D" cube` (or any scramble string)

import Data.List (transpose, words)
import Data.Maybe (fromMaybe)
import Data.Char (toLower)
import qualified Data.Map as Map

-- store faces as a list of rows, represent rows as strings of colors
green  = ["ggg", "ggg", "ggg"]
red    = ["rrr", "rrr", "rrr"]
white  = ["www", "www", "www"]
yellow = ["yyy", "yyy", "yyy"]
orange = ["ooo", "ooo", "ooo"]
blue   = ["bbb", "bbb", "bbb"]

-- solved cube. Order goes F R U D L B
cube = [green, red, white, yellow, orange, blue]
scram = scramble "L B D R2 F U2 R B' D' L' B2 D2 R2 B2 D L2 F U' L2 F U' R B2 D' R2" cube

-- takes in a list of moves (alg) and applies them to the cube one by one. list could look like [f, r, u, r', u', f'] where those are each functions that turn the cube
scrambleFunc alg cube = foldl (\cube move -> move cube) cube alg

-- takes in an algorithm string in the form "f r u r' u' f'" and converts it to a list of functions (moves) like [f, r, u, r', u', f']
stringToAlg algStr = map (\move -> fromMaybe id (Map.lookup move moves)) (words algStr)

-- scrambles the cube by using the passed in algorithm string. that string takes the form "f r u r' u' f'". can also be upper case
scramble algStr = scrambleFunc (stringToAlg algStr)

-- 6 functions below return the cube face for each side
front = head
right cube = cube !! 1
up cube = cube !! 2
down cube = cube !! 3
left cube = cube !! 4
back = last

-- Face rotations
f cube = [faf cube, raf cube, uaf cube, daf cube, laf cube, back cube]
r = y' . f . y
u = x . f . x'
d = x' . f . x
l = y . f . y'
b = y2 . f . y2

f' = f . f . f
r' = y' . f' . y
u' = x . f' . x'
d' = x' . f' . x
l' = y . f' . y'
b' = y2 . f' . y2

f2 = f . f
r2 = y' . f2 . y
u2 = x . f2 . x'
d2 = x' . f2 . x
l2 = y . f2 . y'
b2 = y2 . f2 . y2

-- Cube rotations
y cube = [right cube, back cube, rotate (up cube), rotate' (down cube), front cube, left cube]
y' = y . y . y
y2 = y . y

x cube = [down cube, rotate (right cube), front cube, rotate2 (back cube), rotate' (left cube), rotate2 (up cube)]
x' = x . x . x
x2 = x . x

z = y . x . y'
z' = z . z . z
z2 = z . z

-- Slices
m = l' . r . x'
m' = m . m . m
m2 = m . m

e = u . d' . y'
e' = e . e . e
e2 = e . e

s = b . f' . z
s' = s . s . s
s2 = s . s

-- Wide Turns
fw = f . s
rw = r . m'
uw = u . e'
dw = d . e
lw = l . m
bw = b . s'

fw' = fw . fw . fw
rw' = rw . rw . rw
uw' = uw . uw . uw
dw' = dw . dw . dw
lw' = lw . lw . lw
bw' = bw . bw . bw

fw2 = fw . fw
rw2 = rw . rw
uw2 = uw . uw
dw2 = dw . dw
lw2 = lw . lw
bw2 = bw . bw

-- rotates the colors of a face clockwise, but only the FACE, not the up, right, left, bottom of the face
rotate face = map reverse (transpose face)
rotate' = rotate . rotate . rotate
rotate2 = rotate . rotate 

-- generates faces of the cube AFTER a front rotation. Thats why thhe naming here goes: <Face-direction After Front-move>, so something like raf means "right after front"
-- there is no `baf` for back after front because the Back face is not affected by a Front move
-- there are no `far` (front after right) or `lau` (left after up) because we use a combination of F moves and x and y rotations to generate every other move
-- this approach is less efficient but was fun to implement and is significantly less code than manually transforming the cube for each move type
faf cube = rotate (front cube)
raf cube = replaceFirstInList (last (up cube)) (right cube)
uaf cube = init (up cube) ++ [reverse (map last (left cube))]
daf cube = reverse (map head (right cube)) : tail (down cube)
laf cube = replaceLastInList (head (down cube)) (left cube)

-- helper that takes a list and a list of lists, goes through each list element of the 1d list, replacing the head of each 2d list with the current element
replaceFirstInList _ [] = []
replaceFirstInList [] xs = xs
replaceFirstInList (s:tr) (x:xs) = (s : tail x) : replaceFirstInList tr xs

-- does the same as above but replaces last in list
replaceLastInList _ [] = []
replaceLastInList [] xs = xs
replaceLastInList (s:tr) (x:xs) = (init x ++ [s]) : replaceLastInList tr xs

moves = Map.fromList [
    -- face rotations
    ("F", f),
    ("R", r),
    ("U", u),
    ("D", d),
    ("L", l),
    ("B", b),
    
    ("F'", f'),
    ("R'", r'),
    ("U'", u'),
    ("D'", d'),
    ("L'", l'),
    ("B'", b'),

    ("F2", f2),
    ("R2", r2),
    ("U2", u2),
    ("D2", d2),
    ("L2", l2),
    ("B2", b2),

    -- cube rotation
    ("x",  x),
    ("x'", x'),
    ("x2", x2),

    ("y",  y),
    ("y'", y'),
    ("y2", y2),

    ("z",  z),
    ("z'", z'),
    ("z2", z2),

    -- slices
    ("M",  m),
    ("M'", m'),
    ("M2", m2),

    ("E",  e),
    ("E'", e'),
    ("E2", e2),

    ("S",  s),
    ("S'", s'),
    ("S2", s2),

    -- wide
    ("f", fw),
    ("r", rw),
    ("u", uw),
    ("d", dw),
    ("l", lw),
    ("b", bw),
    
    ("f'", fw'),
    ("r'", rw'),
    ("u'", uw'),
    ("d'", dw'),
    ("l'", lw'),
    ("b'", bw'),

    ("f2", fw2),
    ("r2", rw2),
    ("u2", uw2),
    ("d2", dw2),
    ("l2", lw2),
    ("b2", bw2)
    ]
