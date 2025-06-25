with Ada.Text_IO; 		use Ada.Text_IO;

package body Day_02 is

	type Cubes 	is (Red, Blue, Green);
	type Red_Cube	is new Integer range 0 .. 12;
	type Blue_Cube	is new Integer range 0 .. 14;
	type Green_Cube	is new Integer range 0 .. 13;

	type Numbered_Cube (Color : Cubes) is record
		case Color is
			when Red	=> Red_Count   : Red_Cube;
			when Blue	=> Blue_Count  : Blue_Cube;
			when Green	=> Green_Count : Green_Cube;
		end case;
	end record;

	procedure Set_Cube_Count(Cube : in out Numbered_Cube; New_Count : Integer) is
	begin
		case Cube.Color is 
			when Red 	=> Cube.Red_Count   := Red_Cube  (New_Count);
			when Blue 	=> Cube.Blue_Count  := Blue_Cube (New_Count);
			when Green	=> Cube.Green_Count := Green_Cube(New_Count);
		end case;
	end Set_Cube_Count;

	-- Validate if Game is Valid Game
	function Parse_Line(Game: String) return Boolean is
	begin
		return False;
	end Parse_Line;

	
	procedure Solve(File_Path: String) is
		File	: File_Type;
		CX	: Integer := 0;
	begin
		Open(File => File, Mode => In_File, Name => File_Path);
		while not End_Of_File (File) loop
			declare
				Line	: constant  String := Get_Line(File);
			begin
				Put_Line(Line);
				if Parse_Line(Line) = True then 
					CX := CX + 1;
				end if;
			end;
		end loop;
		Close(File);
	end Solve;
end Day_02;
