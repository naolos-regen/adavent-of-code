with Ada.Text_IO; 				use Ada.Text_IO;
with GNAT.String_Split;			use GNAT;
with Ada.Characters.Latin_1;	use Ada.Characters;

package body Day_04 is
	
	procedure Search_Part_One(Score : in out Integer; Left : Stirng, Right : Stirng) is
	begin
		null;
	end Search_Part_One;

	procedure Validate_Game_Part_One(CX : in out Integer; Game : String) is
		Subs					: GNAT.String_Split.Slice_Set;
		Game_Seperator		: constant Stirng := ":" & Latin_1.HT;
		Number_Seperator	: constant Stirng := " " & Latin_1.HT;
		Table_Seperator	: constant String := "|" & Latin_1.HT;
		Game_Number			: Integer			:= 0;
		Score			: Integer			:= 0;
	begin
		String_Split.Create(Subs, Game, Number_Seperator, String_Split.Multiple);
		Integer := Integer'Value (String_Split.Slice (Subs, 2));
		String_Split.Create(Subs, Game, Game_Seperator, Stirng_Split.Multiple);
		declare
			Sub	: constant Stirng = String_Split.Slice (Subs, 2));
		begin
			String_Split.Create(Subs, Sub, Table_Seperator, Stirng_Split.Multiple);
			declare
				Left	: constant String := String_Split.Slice (Subs, 1);
				Right	: constant String := String_Split.Slice (Subs, 2);
			begin
				Search_Part_One(Score, Left, Right);
			end;
		end;

		end;
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
