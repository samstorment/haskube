# Overview

Basic Rubik's cube scrambler built with Haskell. My introduction to Haskell and many functional programming concepts.

Project assumes glasgow haskell compiler is installed. Download reccomendations are [here](https://www.haskell.org/downloads/). GHCup is current reccomendation and installs many useful components of the Haskell toolchain.

## Run

```bash
ghci Main.hs
```

## How to Use

The cube is made up of an array of 6 faces. Those faces are green, red, white, yellow, orange, blue which represents the Front, Right, Up, Down, Left, and Back faces respectively. Running `cube` in ghci will print the default solved cube state shown below:

```haskell
----------F-------------------R-------------------U-------------------D-------------------L-------------------B----------
[["ggg","ggg","ggg"],["rrr","rrr","rrr"],["www","www","www"],["yyy","yyy","yyy"],["ooo","ooo","ooo"],["bbb","bbb","bbb"]]
```

You can scramble the cube by calling the `scramble` function and giving it a string that represents a Rubik's Cube scramble as well as the cube you'd like to scramble. 

```haskell
-- scramble the default solved cube state
scramble "R L U D F B R' L' U' D' F' B' R2 L2 U2 D2 F2 B2" cube

-- assign a scramble to a variable, then scramble again 
myScrambledCube = scramble "F R U R' U' F'" cube
scramble "F U R U' R' F'" myScrambledCube
```

## How turns are represented in code

Every turn is built off of the `f`, `x`, and `y` functions. On a real rubik's cube a right turn is identical to doing a clockwise y rotation, a single clockwise front turn, then a counterclockwise y rotation. We model this exactly the same in our code using function composition. It's important to remember that the right most functions are called first in a function composition chain, so if we wanted to do the scramble `F R U R' U' F'`, we'd represent that as `f' u' r' u r f` in our code.

## Cube notation

Basic explanation of cube scramble strings, what moves are available, and what moves are currently missing.

### Single Face moves

| Move Name | Description                          |
|-----------|-------------------------------       |
| F         | Front clockwise 90 degrees           |
| R         | Right clockwise 90 degrees           |
| U         | Up clockwise 90 degrees              |
| D         | Down clockwise 90 degrees            |
| L         | Left clockwise 90 degrees            |
| B         | Back clockwise 90 degrees            |
| F'        | Front counterclockwise 90 degrees    |
| R'        | Right counterclockwise 90 degrees    |
| U'        | Up counterclockwise 90 degrees       |
| D'        | Down counterclockwise 90 degrees     |
| L'        | Left counterclockwise 90 degrees     |
| B'        | Back counterclockwise 90 degrees     |
| F2        | Front 180 degrees                    |
| R2        | Right 180 degrees                    |
| U2        | Up 180 degrees                       |
| D2        | Down 180 degrees                     |
| L2        | Left 180 degrees                     |
| B2        | Back 180 degrees                     |


### Full Cube rotations

| Move Name | Description                   |
|-----------|-------------------------------|
| x         | Rotate cube clockwise 90 degrees in R direction                                      |
| y         | Rotate cube clockwise 90 degrees in U direction                                      |
| z         | Rotate cube clockwise 90 degrees in F direction                                      |
| x'        | Rotate cube counterclockwise 90 degrees in R direction                               |
| y'        | Rotate cube counterclockwise 90 degrees in U direction                               |
| z'        | Rotate cube counterclockwise 90 degrees in F direction                               |
| x2        | Rotate cube 180 degrees in R direction                                               |
| y2        | Rotate cube 180 degrees in U direction                                               |
| z2        | Rotate cube 180 degrees in F direction                                               |


### Slice Moves

| Move Name | Description                   |
|-----------|-------------------------------|
| M         | Rotate middle layer between L and R clockwise 90 degrees in L direction |
| E         | Rotate middle layer between U and D clockwise 90 degrees in D direction |
| S         | Rotate middle layer between F and B clockwise 90 degrees in F direction |
| M'        | Rotate middle layer between L and R counterclockwise 90 degrees in L direction |
| E'        | Rotate middle layer between U and D counterclockwise 90 degrees in D direction |
| S'        | Rotate middle layer between F and B counterclockwise 90 degrees in F direction |
| M2        | Rotate middle layer between L and R 180 degrees in L direction |
| E2        | Rotate middle layer between U and D 180 degrees in D direction |
| S2        | Rotate middle layer between F and B 180 degrees in F direction |


### Wide Moves (two layers at once)

| Move Name | Description                                     |
|-----------|-------------------------------                  |
| f         | Front two layers clockwise 90 degrees           |
| r         | Right two layers clockwise 90 degrees           |
| u         | Top two layers clockwise 90 degrees             |
| d         | Bottom two layers clockwise 90 degrees          |
| l         | Left two layers clockwise 90 degrees            |
| b         | Back two layers clockwise 90 degrees            |
| f'        | Front two layers counterclockwise 90 degrees    |
| r'        | Right two layers counterclockwise 90 degrees    |
| u'        | Top two layers counterclockwise 90 degrees      |
| d'        | Bottom two layers counterclockwise 90 degrees   |
| l'        | Left two layers counterclockwise 90 degrees     |
| b'        | Back two layers counterclockwise 90 degrees     |
| f2        | Front two layers 180 degrees                    |
| r2        | Right two layers 180 degrees                    |
| u2        | Top two layers 180 degrees                      |
| d2        | Bottom two layers 180 degrees                   |
| l2        | Left two layers 180 degrees                     |
| b2        | Back two layers 180 degrees                     |