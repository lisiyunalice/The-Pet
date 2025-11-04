Animal Ball
2D Game Group Project in Godot 4

Objective
Animal Ball is a short 2D single-player game made with Godot 4.
The player takes care of a small chick living on a farm. There are three main stats — Energy, Hunger, and Happiness — that slowly go down over time.
To keep the chick healthy, players need to play three mini-games to refill these stats. The goal is to make sure the chick stays alive and happy until the end of the game.

Game Concept
Setting and Story
The game takes place on a farm where you raise a chick.
As time passes, the chick’s energy, hunger, and happiness drop, and you need to help it recover by playing small games connected to each stat.
The main page shows the chick and three bars that represent its current status.

Core Gameplay
Each stat connects to a different mini-game:
Energy – Flappy Chick
The chick flies between pipes to get points.
Getting more than 100 points means success and restores Energy.
You can exit or restart anytime.

Hunger – Feeding Game
The player clicks to feed the chick and fill up its Hunger bar.
Keep clicking until the chick is full.
When full, the chick becomes happy and the stat restores.

Happiness – Merging Game
You drop and merge balls to reach a higher score.
If you reach the target score in time, Happiness goes up.
The player switches between mini-games to keep all stats up.
The game ends when all stats are stable, or one drops to zero.

Design Goals
Make a simple, easy-to-understand game with short, clear goals.
Keep it visually cute and farm-themed.
Have a few quick mini-games that are easy to play but fun to repeat.
Keep the whole playtime under 15 minutes.

Inspirations
Flappy Bird – for the flying challenge.
Merge Big Watermelon – for the merging puzzle.
Tamagotchi – for the pet care idea.

Task Division
Alice (Siyun Li): Energy mini-game (Flappy Chick)
Junxin: Hunger mini-game (Feeding)
J: Happiness mini-game (Merging)
Dai: Main page, chick design, and all scene transitions
Each member coded one part of the game and added it to the main project.

Anticipated Challenges
Getting the transitions between main menu and mini-games to work smoothly.
Keeping the stat system connected between scenes.
Making sure the score and success conditions work properly.
Debugging scene order and UI layer issues.
We used simple scripts and tested often to make sure each mini-game worked before linking everything together.

What We Learned
How to connect multiple scenes and use signals in Godot.
How to keep variables shared across mini-games.
How to make simple interactive UI and track scores.
How to work together and use GitHub to share progress.

Tutorial Design
There’s no written tutorial — players learn by doing.
The main screen and icons show clearly what to click.
Each mini-game shows basic hints (like pipes, falling balls, or food), so players understand what to do after trying once.

Technical Info
Engine: Godot 4
Platform: PC (single player)
Resolution: 1152 × 648
Playtime: 5–15 minutes
Sound: None
Controls: Mouse and keyboard
