# Day_02: Cube_Conundrum

## Part 1

**Input Example:**
```css
Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
```

**Task:**
- Max per game : 12 red cubes, 13 green cubes, 14 blue cubes.
- Meaning Game 1, 2, 5 are doable.
- Each Game set is seperated with ';'.
- Game 3,4 don't work, because one of the sets have too many cubes. 
- E.g.1: Game 3: set 1: 8 green, 6 blue, 20 red >= 12 red cubes
- E.g.2: Game 4: set 3: 3 green, 15 blue >= 14 blue cubes, 14 red >= 12 red cubes
- If every game per set have <= 12 red, <= 13 green, <= 14 blue in total, than it is playable.

