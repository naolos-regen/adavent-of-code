with Ada.Text_IO; 		use Ada.Text_IO;
with GNAT.String_Split;		use GNAT;
with Ada.Characters.Latin_1;	use Ada.Characters;

package body Day_02 is

	-- Should be the last Function to solve the issue
	-- I : Integer := Integer'Value (To_String (T));
	function Is_Gamable(Number : String; Cube : String) return Boolean is
		Is_Gamable	: Boolean := True;
		Cube_Number	: constant Integer := Integer'Value (Number);
	begin
		if Cube = "red" then
			if Cube_Number not in 0 .. 12 then
				Is_Gamable := False;
			end if;
		end if;
		if Cube = "blue" then
			if Cube_Number not in 0 .. 14 then
				Is_Gamable := False;
			end if;
		end if;
		if Cube = "green" then
			if Cube_Number not in 0 .. 13 then
				Is_Gamable := False;
			end if;
		end if;
		return Is_Gamable;
	end Is_Gamable;

	function Evaluate_Cube(Cube_Sub : String) return Boolean is
		Subs		: GNAT.String_Split.Slice_Set;
		Seperator	: constant String	:= " " & Latin_1.HT;
		Boolean_Result	: Boolean		:= False;
	begin
		String_Split.Create (Subs, Cube_Sub, Seperator, String_Split.Multiple);
		declare 
			Count_Sub 	: constant String := String_Split.Slice (Subs, 2);
			Cube_Sub	: constant String := String_Split.Slice (Subs, 3);
		begin
			Boolean_Result := Is_Gamable(Count_Sub, Cube_Sub);
		end;
		return Boolean_Result;
	end Evaluate_Cube;

	function Validate_Set(Sub : String) return Boolean is 
		Cube_Subs	: GNAT.String_Split.Slice_Set;
		Cube_Seperator	: constant String 	:= "," & Latin_1.HT;
		Boolean_Result	: Boolean		:= True;
	begin
		String_Split.Create (Cube_Subs, Sub, Cube_Seperator, String_Split.Multiple);
		for I in 1 .. String_Split.Slice_Count (Cube_Subs) loop
			declare
				Cube_Sub : constant String := String_Split.Slice(Cube_Subs, I);
			begin
				Boolean_Result := Boolean_Result and Evaluate_Cube(Cube_Sub);
			end;
		end loop;
		return Boolean_Result;
	end Validate_Set;

	procedure Validate_Game(CX : in out Integer ; Game: String) is
		Game_Subs	: GNAT.String_Split.Slice_Set;
		Game_Number	: Integer		:= 0;
		Game_Seperator	: constant String 	:= ":" & Latin_1.HT;
		Boolean_Result	: Boolean 		:= True;
		Set_Seperator	: constant String 	:= ";" & Latin_1.HT;
		
	begin
		String_Split.Create (Game_Subs, Game, Game_Seperator, String_Split.Multiple);
		declare
			Sub	: constant String := String_Split.Slice(Game_Subs, 2);
			Game_Sub: constant String := String_Split.Slice(Game_Subs, 1);
		begin
			String_Split.Create (Game_Subs, Game_Sub, " ", String_Split.Multiple);
			Game_Number := Integer'Value (String_Split.Slice (Game_Subs, 2));
			String_Split.Create (Game_Subs, Sub, Set_Seperator, String_Split.Multiple);
			for I in 1 .. String_Split.Slice_Count (Game_Subs) loop
				declare 
					Set_Sub	: constant String := String_Split.Slice(Game_Subs, I);
				begin
					Boolean_Result := Boolean_Result and Validate_Set(Set_Sub);
				end;
			end loop;
		end;
		if Boolean_Result then
			CX := CX + Game_Number;
		end if;
	end Validate_Game;

	procedure Solve(File_Path: String) is
		File	: File_Type;
		CX	: Integer := 0;
	begin
		Open(File => File, Mode => In_File, Name => File_Path);
		while not End_Of_File (File) loop
			declare
				Game : constant  String := Get_Line(File);
			begin
				-- Put_Line(Game);
				Validate_Game(CX, Game);
			end;
		end loop;
		Put_Line("Part 1 Day 02: " & CX'Image);
		Close(File);
	end Solve;
end Day_02;
