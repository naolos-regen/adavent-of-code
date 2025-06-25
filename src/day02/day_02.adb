with Ada.Text_IO; 		use Ada.Text_IO;

package body Day_02 is

	type Cubes 	is (Red, Blue, Green);

	subtype Red_Cube_Count		is Integer range 0 .. 12;
	subtype Blue_Cube_Count		is Integer range 0 .. 14;
	subtype Green_Cube_Count	is Integer range 0 .. 13;

	type Red_Cube is record
		Cube : Cubes := Red;
		Count: Red_Cube_Count;
	end record;

	type Green_Cube is record
		Cube : Cubes := Green;
		Count: Green_Cube_Count;
	end record;

	type Blue_Cube is record
		Cube : Cubes := Blue;
		Count: Blue_Cube_Count;
	end record;

	type Cube_Set	is record
		Red	: Red_Cube;
		Blue	: Blue_Cube;
		Green	: Green_Cube;
	end record;

	function Cube_Image(C: Cubes) return String is
	begin
		case C is 
			when Red   => return "red"  ;
			when Blue  => return "blue" ;
			when Green => return "green";
		end case;
	end Cube_Image;

	-- Validate if Game is Valid Game
	function Parse_Line(Game: String) return Boolean is
	begin
		Put_Line(Game);
		return False;
	end Parse_Line;

	
	procedure Solve(File_Path: String) is
		File	: File_Type;
		CX	: Integer := 0;
	begin
		Open(File => File, Mode => In_File, Name => File_Path);
		while not End_Of_File (File) loop
			declare
				Game : constant  String := Get_Line(File);
			begin
				Put_Line(Game);
				if Parse_Line(Game) = True then 
					CX := CX + 1;
				end if;
			end;
		end loop;
		Close(File);
	end Solve;
end Day_02;
