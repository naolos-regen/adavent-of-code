with Ada.Text_IO; use Ada.Text_IO;

package body Day_02 is

	type Cubes is (Red, Blue, Green);

	type Cubes_Ammount is record 
		Cube : Cubes; 
		Ammount : Integer; 
	end record;

	type Game is record 
		Game_Index 	: Integer;
		Cube		: Cubes_Ammount;
	end record;

	type Games is array(Positive range <>) of Game;
	
	type Games_Access is access Games;

	function Parse return Integer is
		Games_Array	: Games_Access;
	begin
		return 0;
	end Parse;

	procedure Solve(File_Path: String) is
			
	begin
		Parse;
		Put_Line(File_Path);
		null;
	end Solve;
end Day_02;
