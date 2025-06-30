with Ada.Text_IO; 				use Ada.Text_IO;
with GNAT.String_Split;			use GNAT;
with Ada.Characters.Latin_1;	use Ada.Characters;

package body Day_04 is
	
	procedure Search_Part_One(Score : in out Integer; Left, Right : String) is
		Left_Subs	: GNAT.String_Split.Slice_Set;
		Right_Subs	: GNAT.String_Split.Slice_Set;
		Seperator	: constant String := " " & Latin_1.HT;
	begin
		String_Split.Create(Left_Subs,  Left,  Seperator, String_Split.Multiple);
		String_Split.Create(Right_Subs, Right, Seperator, String_Split.Multiple);
		for I in 1 .. String_Split.Slice_Count (Left_Subs) loop
			declare
				cmp : constant String := String_Split.Slice (Left_Subs, I);
				Left_Cmp : Integer := 0;
			begin
				if cmp /= "" then
					Left_Cmp := Integer'Value (cmp);
					for J in 1 .. String_Split.Slice_Count (Right_Subs) loop
						declare
							r_cmp			: constant String := String_Split.Slice (Right_Subs, J);
							Right_Cmp	: Integer;
						begin
							if r_cmp /= "" then
								Right_Cmp := Integer'Value (r_cmp);
								if Left_Cmp = Right_Cmp then
									Score := Score + 1;
								end if;
							end if;
						end;
					end loop;
				end if;
			end;
		end loop;

	end Search_Part_One;

	procedure Validate_Game_Part_One(CX : in out Integer; Game : String) is
		Subs					: GNAT.String_Split.Slice_Set;
		Game_Seperator		: constant String := ":" & Latin_1.HT;
		Number_Seperator	: constant String := " " & Latin_1.HT;
		Table_Seperator	: constant String := "|" & Latin_1.HT;
		Game_Number			: Integer			:= 0;
		Score			: Integer			:= 0;
	begin 
		-- FROM HERE THIS PART CAN BE IGNORED
		String_Split.Create(Subs, Game, Game_Seperator, String_Split.Multiple);
		declare
			Card	: constant String := String_Split.Slice (Subs, 1);
		begin
			String_Split.Create(Subs, Card, Number_Seperator, String_Split.Multiple);
			Game_Number := Integer'Value (String_Split.Slice(Subs, 2));
		end;
		-- TILL HERE THIS PART CAN BE IGNORED
		String_Split.Create(Subs, Game, Game_Seperator, String_Split.Multiple);
		declare
			Sub	: constant String := String_Split.Slice (Subs, 2);
		begin
			String_Split.Create(Subs, Sub, Table_Seperator, String_Split.Multiple);
			declare
				Left	: constant String := String_Split.Slice (Subs, 1);
				Right	: constant String := String_Split.Slice (Subs, 2);
			begin
				Search_Part_One(Score, Left, Right);
			end;
		end;
		if Score > 0 then
		  CX	:= CX	+ (2 ** (Score));
		end if;
	end Validate_Game_Part_One;

	procedure Solve(File_Path : String) is
		File			: File_Type;
		CX_PT_ONE	: Integer	:= 0;
	begin
		Open(File, In_File, File_Path);
		while not End_Of_File (File) loop
			declare
				Game : constant String := Get_Line(File);
			begin
				Validate_Game_Part_One(CX_PT_ONE, Game);
			end;
		end loop;
		Put_Line("Part 1: " & CX_PT_ONE'Image);
	end Solve;
end Day_04;
