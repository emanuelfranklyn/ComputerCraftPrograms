# ComputerCraftPrograms
Programs created / modified by me for ComputerCraft. 

# ElevatorX (Not completly custom ambiant)
## A program that allows you to control your elevator (up to 16 floors) using only 1 computer. 
### Use environment:
  - Each floor must have 1 monitor that will be used to call the elevator (Tested only with advanced monitors) 
  - Your elevator must have a block that emits a redstone signal (so that the program knows the position of the elevator 
  - On each floor, the redstone signal emission block of the elevator must be in contact with a colored cable (project-red) 
  - The colored cables of each floor must be connected in a bundled cable suitable for them following the order of colors (White, Orange, Magenta, Light blue ...) 
  - the movement control of the elevator (cables that when emitting a redstone signal cause the elevator to move up or down) must be respectively White: up, Orange: Down. And they must be connected to a bundled cable separate from the floors. 
  - The bundled Cables side is optional when installing the program 
  - If you have a monitor inside your elevator it is recommended to use it 3 blocks high and 2 blocks wide 
  - Having a monitor inside the elevator is optional at installation 
  - To redo the installation process if you have not yet completed it just restart the computer (control + T, control + R) If you have completed it just delete the file ElevatorCfg.lua 
  - After installation you can start the elevator control by running the program again or restarting the computer 
  - It is recommended to install the program with the name startup.lua so that it is executed when starting the elevator 
  - The elevator by default goes down to the first floor (Ground floor) when started 
  
# Installer
## Automatically downloads a github repository 
### Use environment:
  - (tested only on advanced computers)
  - Replace on the start of the file the two variables (AUTHOR and Repository) to the respective github author and repository name
