# Space Invaders
A one player Space Invaders game written in Processing.

## Instructions for running
To play this Space Invaders game, you must have processing version 2.2.1. This version of processing can be downloaded at https://processing.org/download/.  
Once you have this version of processing, download the _"SpaceInvaders"_ folder.  
After downloading the folder, right click on the _"SpaceInvaders.pde"_ inside the folder and select _"open with > Processing"_.
This will open up a processing sketch, and if you hit the play symbol/triangle on the top of the sketch, the game will open up for you to begin playing.

## Description
This is a game where a player's objective is to shoot _"Invaders"_ as they move closer to the player. To get the highscore, the player must shoot as many Invaders as possible. Each Invader shot gives the player more points for their _"Score"_.  
  Once all Invaders on the screen have been shot, the player advances to the next level, where the Invaders move faster. There are an infinite amount of levels (But good luck getting past level 4).  
  When a player is shot by an Invader or the Invaders make it all the way to the player, the player loses one of his three lives. If a player loses all three lives, its _"GAME OVER"_. Once the game is over the player moves to the High Score screen and if they have achieved a High Score, they are prompted to put their initials in for their score to be saved.
  The skinniest Invaders, at the back of the pack, shoot projectiles at the player. Each level, one of these Invaders will emit a power-up when he is shot by the player. Power ups give the player a special ability for 30 seconds.

## Motivation
In our _"Programming Project"_ module in first year, we were tasked with implementing the different components of a space invaders game. This was our first big project and our first exposure to classes in object oriented programming.  
  For full marks in the module it was only necessary to be able to move objects around on the screen, make objects disappear, import gifs, to allow users to move and shoot objects, and initiate a game over. However this was our first experience of writing a program with a graphical element to it, which I was very excited about. I was very motivated to make the design and feel of the game as cool as possible. I introduced music, sounds, lives, levels, points, power ups and scores to my program.

## Problems
Unfortunately, the biggest problem faced when developing the game was making it _"Fun"_. How fast the Space Invaders move is a function of the constant _"SPACE_INVADER_SPEED"_ as well as the current level. When _"SPACE_INVADER_SPEED"_ is initialised to 1, the game is too easy for a player to be interested until the end of level 1. When _"SPACE_INVADER_SPEED"_ is initialised to 2, the game is too difficult for a player to be interested as they reach _"GAME OVER"_ quite quickly.  
  I got carried away with trying to pimp out the game with cool features and designs while developing it, testing out all the different things I could do with Processing. I did not have time before shelfing the game to really put in the effort to make it fun. Ideally the curve of how difficult the game gets over time could be tuned to be as fun as possible, but I have not tried to come up with the function to make this happen.

## Future of Project
This project has been shelved.  
  I was developing this game for several weeks. Towards the end of the space invaders part of the module, I was developing a 2-Player mode. However it was not finished before we moved on to another project, so that element was scratched. This 2-Player mode was to make the game a lot more fun.  
  I have begun working on different projects that I feel are more important, so the current state of the game is unlikely to be updated.
   
## Built With
* Processing
