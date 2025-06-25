with Ada.Text_IO; 		use Ada.Text_IO;
with Ada.Strings.Fixed;		use Ada.Strings.Fixed;
with Ada.Strings.Unbounded;	use Ada.Strings.Unbounded;

package body Day_02 is
	
	type Line_Array is array (Positive range <>) of Ada.Strings.Unbounded.Unbounded_String;
	type Line_Array_Access is access Line_Array;

	type Cubes is (Red, Blue, Green);
	type Cube_Counts is array (Cubes) of Integer;
	
	type Draw is array (Positive range <>) of Cube_Counts;
	type Draw_Access is access Draw;

	type Game is record
		Game_Index	: Integer;
		Draws		: Draw_Access;
	end record;
	type Game_Array is array (Positive range <>) of Game;
	type Game_Access is access Game_Array;
	
	function Parse_Color(S : String) return Cubes is
		No_Such_Color_Exception : exception;
	begin
		if S = "red" then
			return Red;
		elsif S = "blue" then
			return Blue;
		elsif S = "green" then
			return Green;
		else
			raise No_Such_Color_Exception;
		end if;
	end Parse_Color;

	function Parse_Cube_Count(S : String) return Cube_Counts is
		Count	: Cube_Counts := (others => 0);
		Parts	: constant Line_Array := Line_Array'(1 => To_Unbounded_String(S));
	begin
		for I in Parts'Range loop
			declare
				E	: constant String := Trim(To_String(Parts(I)), Side => Ada.Strings.Both);
				N	: Integer;
				C	: Cubes;
				Space	: constant Natural := Index(E, " ");
			begin
				N := Integer'Value(E(1 .. Space - 1));
				C := Parse_Color(Trim(E(Space + 1 .. E'Last), Side => Ada.Strings.Both));
				Count(C) := N;
			end;
		end loop;
		return  Count;
	end Parse_Cube_Count;

	function Split(S: String; Sep : Character) return Line_Array is
		Parts_Count	: Natural 	:= 1;
	begin
		for I in S'Range loop
			if S(I) = Sep then
				Parts_Count 	:= Parts_Count + 1;
			end if;
		end loop;

		declare
			Result 	: Line_Array	(1 .. Parts_Count);
			Index	: Natural	:= 1;
			Start	: Positive	:= S'First;
		begin
			for I in S'Range loop
				if S(I) = Sep then
					Result(Index) 	:= To_Unbounded_String(S(Start .. I - 1));
					Index 		:= Index + 1;
					Start 		:= I + 1;
				end if;
			end loop;

			Result(Index) := To_Unbounded_String(S(Start .. S'Last));
			return Result;
		end;

	end Split;

	
	procedure Solve(File_Path: String) is
	   Max_Games     : constant Integer := 100;
	   Parsed_Games  : Game_Access := new Game_Array(1 .. Max_Games);
	   Game_Count    : Integer := 0;
	   File          : File_Type;
	   Line          : String (1 .. 200);
	   Len           : Natural;
	begin
		Put_Line("Reading file: " & File_Path);
		Open(File => File, Mode => In_File, Name => File_Path);
		while not End_Of_File(File) loop
      			Get_Line(File, Line, Len);
      			declare
				L          : constant String := Line(1 .. Len);
				Colon      : constant Natural := Index(L, ":");
				Header     : constant String := L(1 .. Colon - 1);
				B	   : constant String := L(Colon + 1 .. L'Last);
				Draw_Parts : Line_Array := Split(B, ';');
				Game_Id    : constant Integer := Integer'Value(L(6 .. Colon - 1)); -- "Game N"
				Draws      : Draw_Access := new Draw(1 .. Draw_Parts'Length);
      			begin
				for I in Draw_Parts'Range loop
					declare
						Sub_Draws : Line_Array := Split(To_String(Draw_Parts(I)), ',');
						Sum       : Cube_Counts := (others => 0);
					begin
						for J in Sub_Draws'Range loop
							declare
								E     : constant String := Trim(To_String(Sub_Draws(J)), Side => Ada.Strings.Both);
								Space : constant Natural := Index(E, " ");
								N     : constant Integer := Integer'Value(E(1 .. Space - 1));
								C     : constant Cubes   := Parse_Color(Trim(E(Space + 1 .. E'Last), Side => Ada.Strings.Both));
							begin
								Sum(C) := N;
							end;
						end loop;
						Draws(I) := Sum;
					end;
				end loop;
				Game_Count := Game_Count + 1;
				Parsed_Games(Game_Count) := (Game_Index => Game_Id, Draws => Draws);
			end;
		end loop;
		Close(File);
		Put_Line("Part 1 Day 2:" & Integer'Image(Game_Count));
	end Solve;
end Day_02;
