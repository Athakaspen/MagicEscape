This is the source code to a 2D Point-and Click Adventure Game called Rainbow Escape. I designed and created it in one week for the S&T Spring 2023 Game Jam.

Play it here: https://athakaspen.itch.io/rainbow-escape

The game features over 10 puzzles, 2 minigames, an inventory system, more than 25 interactable screens, and even an original story. It takes most players around 30-40 minutes to complete.  
I built an extremely flexible system for handling all user click interactions, called `ClickableArea.gd`. This allowed me to focus most of my effort on puzzle design and environment art.


- Click interactions and mouse cursor updates are handled by `ClickableArea.gd`
- Each `ClickableArea.gd` emits a signal which is linked to unique functionality in each screen (see `/Screens/`)
- Some scenes overlay on top of the current screen, handled by the `create_overlay(path)` function in `/Tools/ScreenManager.gd`
- `Overlays/PROFishing.tscn` contains the GOTY-worthy fishing minigame
