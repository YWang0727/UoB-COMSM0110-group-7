# COMSM0110 - Group 7 (2023)

## 1. Team

Team photo to be added

| Name             | Email                 |
| ---------------- | --------------------- |
| Xiao Yuan        | lq22159@bristol.ac.uk |
| Yue Wang         | pe22209@bristol.ac.uk |
| Arlo SUN         | xa22653@bristol.ac.uk |
| Ed Satterthwaite | es16268@bristol.ac.uk |
| Cedric Chen      | ud22762@bristol.ac.uk |

## 2. Introduction (5% ~250 words)

o Describe your game, what is based on, what makes it novel?

Game Background: The Earth's resources have been exhausted and the protagonist arrives on an alien planet to collect energy minerals. This planet is rich in mineral resources but is also full of danger. Our protagonist needs to survive under the pursuit of alien monsters and obtain as many resources as possible!
Game Type: Roguelike + Dungeon + Cave Exploration + Side-scrolling Shooter
Every map and its elements, including monsters, are randomly generated! Item drops are also completely random!

## 3. Requirements (15% ~750 words)

o Use case diagrams, user stories. Early stages design. Ideation process. How did you decide as a team what to develop?

Use case diagrams and user stories are kept in folder 'ReportMaterials' in gitub mainpage for your reference.

https://github.com/UoB-COMSM0110/2023-group-7/tree/main/ReportMaterials

For early stages, each member in the team brought up at least 2 desired games to develop . We discussed about a wide range of factors that which game we are going to build, for example, the possibilities of twists for each game, potential game users, a more original game , how it works (interactions between enermies and player) etc.

Finally we reached consencus of which game to develop as we have a rough ideas but more clear picture of our game . Initially we have a general aim for our game, for example, game background setting, space mission and exploring , various lanscapes (rooms), various enermies ,score system, items system etc .

## 4. Design (15% ~750 words)

o System architecture. Class diagrams, behavioural diagrams.

The game is based on MVC model to build. We worked and discussed as a team to decide what are the game mechanics , how the player might behave ( things that player does : exploring unknown areas , mining, using items to deal with various creatures etc.) , what should be displayed on the interface ( the way player communicate with game , HP system, score system , creatures AI etc.).

We illustrated them in class diagrams. Generally, we needed several basic classes to validate the game. Class for view & model & controller, class for random room , class for player, class for various creatures, class for items etc.

## 5. Implementation (15% ~750 words)

We follow the general game developement process to implement our game : planning -- pre-production -- production -- testing -- pre-launch -- release.

We have weekly meeting to summarize what we have done for the project, discussed current difficulties during development for own part, clarified ambiguities, brought up possible new features for games and added them in our process.

During the implementation of our game, we found below 3 main challenges :

### 5.1 Randomly generated map and elements:
The main problem we faced in that session was how to ensure that the randomly generated map was sensible, rules compliant and player moveable.

We therefore chose to use a pseudo-random generation approach. set the board size to 1160\*800, and made it 29\*20 blocks. Each room will have an unbreakable border of 1 block, with gaps in to let the player move to adjacent rooms. And also each room will be divided into 6 sections of 9*6 blocks. We designed a large number of different sections which can all fit together in any combination. When each room is generated, a random 6 sections will be chosen and used to build the random room. And rules had been added so that there would never have two identical sections in the same room.

We also preset the type of specific block in each section so that the location and probability of various blocks appearing is reasonable.In summary, we randomly select the sections to be joined together when generating the room, and then load the blocks for each corresponding position.

On randomly generating various other elements (such as props, etc.), we first scan the entire room to determine which locations make sense. The probability is then set to randomly generate locations to put props in.

### 5.2 Collision detection:
Collision detection is one of the most important aspects of our game. We are always looking for better ways of collision detection and keep it constantly updated.

In the beginning, basic collision detection was based on rectangular and rectangular collisions. At that stage, the position and size depended on the floats x, y, width, height and then, for ease of development, it was modified to be determined by the PVector location. We have rewritten the detect method to meet the collision detection of each type of object according to different needs.

For example, if a room in the game is made up of blocks based on matrix coordinates, our algorithm only needs to detect the walls around the object to reduce performance consumption. Also, the improved algorithm can match objects of arbitrary position and size. The effect of a moving object (e.g. player, enemy) being blocked by a wall is achieved by resetting the PVector location of the object and clearing the PVector velocity in the corresponding direction. If the object is blocked by a wall below, then the jump and fall states of the moving object are reset. Different strategies are used for collision detection for the player and the enemy, so that the enemy does not cross the boundary and cause a bug.

It is fair to say that we have spent considerable effort on collision detection and have achieved more than satisfactory results, which have greatly enhanced the gaming experience.

### 5.3 Performance effects：
We have spent a lot of time and effort on the presentation to make everything as perfect as possible, like a full-fledged game.

In many cases, we have replaced single image effects with gifs, so that many of the effects are played in a continuous motion picture. By using the DecorationFactory, we can add both temporary and permanent gifs to the room, and set duration, speed, size and location of gifs by using different constructors. For example, when the player dies, the player does not suddenly fall, but has a complete set of movements. There are also different matching gifs for the player and the enemy in different states: for example, when the player or the enemy is attacked, there is a knockback effect; when the player is injured, there is an invincibility time as well as a blinking effect.

Another notable mention is our shooting system. We have used the PVector system instead of the traditional x, y and speed coordinate system. We used the PVector to make the weapon follow the rotation of the mouse position, as well as to ensure that the bullets are fired from the muzzle, again contributing to the hitting effect in the previous section.

## 6. Evaluation (15% ~750 words)

o One qualitative evaluation (your choice)

o One quantitative evaluation (of your choice)

o Description of how code was tested.

## 7. Process (15% ~750 words)

o Teamwork. How did you work together, what tools did you use? Did you have team roles? Reflection on how you worked together.

How did we work together?

We adopted a quite flexible and collaborative approach for game development. Generally, we have a weekly meeting in lab and on teams during holiday, to go through every aspect of the game development, we have one team member jotted down meeting notes each week and assign tasks to team member who is in charge for that in Jira. We posted our questions on teams to get instant feedback or to get support, or to fix bugs, and we committed our work to GitHub so everyone in team could see the changes and monitor our process to ensure our work hit the weekly schedule.

Here are some screenshots for how we collaborated as a team.

- Shared meeting notes
- Shared good ideas
- Shared public methods so others can make full use of the codes and avoid repetition
- Shared good software
- Helped to fix bugs
- Shared the change that might affect everyone’s development to keep everyone stay up to date
<br></br>
  <p align="center">
      <img src="./ReportMaterials/reportprocess/gamepropose.png" alt="Screenshot of proposing games to develops">
      <br>Screenshot of proposing games to develops
       <br></br>
      <img src="./ReportMaterials/reportprocess/meeting1.png" alt="Screenshot of meeting notes example - 1">
      <br> Screenshot of meeting notes example - 1
      <br></br>
      <img src="./ReportMaterials/reportprocess/meeting2.png" alt="Screenshot of meeting notes example - 2">
      <br>Screenshot of meeting notes example - 2
      <br></br>
      <img src="./ReportMaterials/reportprocess/goodsoftware.png" alt="Screenshot of sharing good software">
      <br>Screenshot of sharing good software
        <br></br>
      <br></br>
      <img src="./ReportMaterials/reportprocess/change.png" alt="Screenshot of sharing changes">
      <br>Screenshot of sharing changes
        <br></br>
      <img src="./ReportMaterials/reportprocess/goodideas.png" alt="Screenshot of sharing good ideas for generating maps for game">
      <br>Screenshot of sharing good ideas for generating maps for game
        <br></br>
      <img src="./ReportMaterials/reportprocess/fixbug.png" alt="Screenshot of helping to fix bug">  
      <br>Screenshot of helping to fix bug
        <br></br>
</p>
What software did we use?

Yes, we used various software introduced from the lecture.

- Teams: communication and meeting
- Jira: Assigned tasks and monitored our progress
- UML: Illustrated class diagrams
- Git & GitHub: for version control and committed staged work
- Photoshop: designed certain character in game
- Processing: wrote codes to build the game
  <br></br>

<p align="center">
    <img src="./ReportMaterials/reportprocess/jira.png" alt="Screenshot of using Jira to assign tasks and monitor progress">   
    <br>Screenshot of using Jira to assign tasks and monitor progress
</p>
  <br></br>
<br>Also please follow below link if you want to check how we collaborate in Jira.</br>
https://uob-group7.atlassian.net/jira/software/projects/GP/boards/1
<br></br>
Did you have team roles?

Yes, we divided the game into 5 parts at beginning of the project, so everyone can focus on his or her own part. Please find below table as how we assign the team role.

| Task                                | To do by |
| ----------------------------------- | -------- |
| Rooms & Room Factory                | Ed       |
| Menu & Setting & BGM                | Arlo     |
| Player, Basic props, Collision etc… | Xiao     |
| Items & Items Factory               | Yue      |
| Enemy & Enemy Factory               | Cedric   |

Meanwhile, apart from the game, there are some works have been done by different team members:

- kept tracking and pushing the progress to ensure delivery of the game
- jotted down meeting note and shared recap
- Assigned tasks regarding meeting
- Acted as user or found new user to play game and asked for feedback
- Reached out to internet for game design (player, enemies, items, gems & rocks etc..), as we wanted it our game in an extraterrestrial world setting
  <br></br>

## 8. Conclusion (10% ~500 words)

o Reflect on project as a whole. Lessons learned. Reflect on challenges. Future work.
