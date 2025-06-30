with Ada.Text_IO;					use Ada.Text_IO;
with GNAT.String_Split;			use GNAT;
with Ada.Characters.Latin_1;	use Ada.Characters;

package body Day_04_P_2 is

	type Card_Number is new Integer range 0 .. 99;
	
	-- TODO: Adjust if needed
	type Left_Array is array (1 .. 10) of Card_Number;
	type Right_Array is array (1 .. 25) of Card_Number;

	type Card_Type is record
		Left_Numbers	: Left_Array;
		Right_Numbers	: Right_Array;
		Matches			: Integer := 0;
	end record;

	function Default_Card_Type return Card_Type is
		This : Card_Type;
	begin
		This.Left_Numbers  := (others => Card_Number'First);
		This.Right_Numbers := (others => Card_Number'First);
		return This;
	end Default_Card_Type;

	type Cards_Lines is array (1 .. 196) of Card_Type;

	procedure Combine_Left(Line : String, Numbers: in out Left_Array) is
		Subs : String_Split.Slice_Set;
	begin
		String_Split.Create(Subs, Line, " ", String_Split.Multiple);
		-- TODO: problem when indexing String_Split :'(
	end Combine_Left;

	procedure Combine_Right(Line : String, Numbers: in out Right_Array) is
		Subs : String_Split.Slice_Set;
	begin
		String_Split.Create(Subs, Line, " ", String_Split.Multiple);
		-- TODO: problem when indexing String_Split :-(
	end Combine_Right;

	procedure Parse(Cards: in out Card_Lines; Card : String) 
	is 
		Subs				: String_Split.Slice_Set;
		Card_Seperator : constant String := ":" & Latin_1.HT;
		LR_Seperator	: constant String := "|" & Latin_1.HT;
	begin
		-- TODO: Parsing Line to Cards array;
		String_Split.Create(Subs, Card, Card_Seperator, String_Split.Multiple);
		declare
			Sub			: constant String := String_Split.Slice (Subs, 2);
		begin
			String_Split.Create(Subs, Sub, LR_Seperator, String_Split.Multiple);
			declare
				Left		: constant String := String_Split.Slice (Subs, 1);
				Right		: constant String := String_Split.Slice (Subs, 2);
			begin
				Combine (Left,  Cards.Left_Numbers);
				Combine (Right, Cards.Right_Numbers);
			end;
		end;
	end Parse;


	procedure Solve(File_Path : String) is
		File : File_Type;
		Last : Integer;
		Cards	: Card_Lines;
	begin
		Open(File, In_File, File_Path);
		for I in Cards'Range loop
			Cards(I) := Default_Card_Type;
		end loop;

		while not End_Of_File(File) loop
			declare
				Card : constant String := Get_Line(File);
			begin
				Parse(Cards, Card);
			end;
		end loop;

		Close(File);
	end Solve_Part_Two;

end Day_04_P_2;
