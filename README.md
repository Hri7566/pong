# PÖNG
by Hri7566

Made with [LÖVE](https://love2d.org "LÖVE - Free 2D Game Engine").

The Bit fonts are from [here](http://www.mattlag.com/bitfonts/ "Matt LaGrandeur - BitFonts").

## Instructions

Running on Linux: Use the correct AppImage in the console using the provided *.love file as an argument.

Running on Windows: Run pong.exe (not love.exe).

A macOS app is also provided.

## Usage

Use this code however you like, just don't modify [LÖVE](https://love2d.org "LÖVE - Free 2D Game Engine") itself.

## Changelog

### Updates in v1.3.1:
 + Removed "David Mode" joke

### Updates in v1.3:
 + Fixed a bug where singleplayer allows the player to move twice as fast
 + Added a config menu
   + Added ability to change controls
   + Added "David Mode" (red/blue colorblind mode)
     + All blue colors will change to green when enabled
 + Fixed blurry text filtering

### Updates in v1.2.1:
 + Fixed a bug where buttons were clickable anywhere
 + Added a new but unused menu
 + Changed button colors to make text more visible

### Updates in v1.2:
 + Ball and players are now classes
   + Due to this, the ball is now blue everywhere instead of just the main menu in debug mode
   + Ball and players are now defined in main.lua instead of the individual gamemode files
 + Fixed the 1-player score font

### Updates in v1.1.1:
 + Fixed issue that prevented a 2-player game from ending after deuce
 + Fixed bug where scores would not reset after a finished game
 + Changed score font to better resemble the original PONG arcade game

### Updates in v1.1:
 + Added colors in main menu
 + Added debug mode
   + Click the ball in the main menu to activate debug features
 + Fixed pseudo-randomness not being very random