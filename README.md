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

### Currently Supported Moves

Single turn clockwise moves

* (F)ront 
* (R)ight 
* (U)p 
* (D)own 
* (L)eft 
* (B)ack

Double turn moves

* F2
* R2
* U2
* D2
* L2
* B2

Single turn counterclockwise moves

* F'
* R'
* U'
* D'
* L'
* B'

Cube rotations

* x
* x'
* x2
* y
* y'
* y2


### Currently Unsupported Moves

Cube rotations

* z
* z'
* z2

Slice Moves

* M
* E
* S
* M'
* E'
* S'

Double Layer Moves (And their double turn and counterclockwise variants)

* f
* r
* u
* d
* l
* b
