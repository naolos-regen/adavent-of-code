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

	procedure Validate_Game_Part_One(CX : in out Integer ; Game: String) is
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
	end Validate_Game_Part_One;

	procedure Validate_Game_Part_Two(CX : in out Integer; Game: String) is 
		Game_Subs	: GNAT.String_Split.Slice_Set;
		Set_Subs	: GNAT.String_Split.Slice_Set;
		Cube_Subs	: GNAT.String_Split.Slice_Set;
		Game_Seperator	: constant String	:= ":" & Latin_1.HT;
		Set_Seperator	: constant String	:= ";" & Latin_1.HT;
		Cube_Seperator	: constant String	:= "," & Latin_1.HT;
		Red_Max		: Integer		:= 0;
		Blue_Max	: Integer		:= 0;
		Green_Max	: Integer		:= 0;
		Game_ID		: Integer		:= 0;
	begin
		String_Split.Create (Game_Subs, Game, Game_Seperator, String_Split.Multiple);
		declare 
			Game_Sub	: constant String := String_Split.Slice(Game_Subs, 1);
			Sub		: constant String := String_Split.Slice(Game_Subs, 2);
		begin
			String_Split.Create (Game_Subs, Game_Sub, " ", String_Split.Multiple);
			Game_ID	:= Integer'Value (String_Split.Slice(Game_Subs, 2));
			String_Split.Create (Game_Subs, Sub, Set_Seperator, String_Split.Multiple);

			for I in 1 .. String_Split.Slice_Count (Game_Subs) loop
				String_Split.Create (Set_Subs, String_Split.Slice(Game_Subs, I), Cube_Seperator, String_Split.Multiple);
				for J in 1 .. String_Split.Slice_Count (Set_Subs) loop
					String_Split.Create (Cube_Subs, String_Split.Slice(Set_Subs, J), " ", String_Split.Multiple);
					declare
						Cube_Count 	: constant String  := String_Split.Slice(Cube_Subs, 2);
						Cube_Number	: constant Integer := Integer'Value (Cube_Count);
						Cube_Name	: constant String  := String_Split.Slice(Cube_Subs, 3);
					begin
						if Cube_Name = "red" then
							if Cube_Number > Red_Max then
								Red_Max := Cube_Number;
							end if;
						elsif Cube_Name = "blue" then
							if Cube_Number > Blue_Max then
								Blue_Max := Cube_Number;
							end if;
						elsif Cube_Name = "green" then
							if Cube_Number > Green_Max then
								Green_Max := Cube_Number;
							end if;
						end if;
					end;
				end loop;
			end loop;
			Game_ID := Red_Max * Blue_Max * Green_Max;
			CX	:= CX + Game_ID;
		end;
	end Validate_Game_Part_Two;

	procedure Solve(File_Path: String) is
		File		: File_Type;
		CX_PT_ONE	: Integer 	:= 0;
		CX_PT_TWO	: Integer	:= 0;
	begin
		Open(File => File, Mode => In_File, Name => File_Path);
		while not End_Of_File (File) loop
			declare
				Game : constant  String := Get_Line(File);
			begin
				Validate_Game_Part_One(CX_PT_ONE, Game);
				Validate_Game_Part_Two(CX_PT_TWO, Game);
			end;
		end loop;
		Put_Line("Part 1 Day 02: " & CX_PT_ONE'Image);
		Put_Line("Part 2 Day 02: " & CX_PT_TWO'Image);
		Close(File);
	end Solve;
end Day_02;
