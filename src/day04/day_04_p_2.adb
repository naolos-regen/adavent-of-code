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

	type Cards_Lines is array (1 .. 196) of Card_Type;
	
	procedure Print_Cards(Cards : Cards_Lines) is
	begin
		for I in Cards'Range loop
			Put_Line("Card " & Integer'Image(I) & ":");

			Put(" Left: ");
			for J in Cards(I).Left_Numbers'Range loop
				Put(Card_Number'Image(Cards(I).Left_Numbers(J)) & ", ");
			end loop;
			New_Line;

			Put(" Right: ");
			for J in Cards(I).Right_Numbers'Range loop
				Put(Card_Number'Image(Cards(I).Right_Numbers(J)) & ", ");
			end loop;
			New_Line;

			Put_Line(" Matches: " & Integer'Image(Cards(I).Matches));
			New_Line;
		end loop;
	end Print_Cards;

	function Default_Card_Type return Card_Type is
		This : Card_Type;
	begin
		This.Left_Numbers  := (others => Card_Number'First);
		This.Right_Numbers := (others => Card_Number'First);
		return This;
	end Default_Card_Type;

	procedure Parse(Cards: in out Cards_Lines; Card : String) 
	is 
		Subs, L_Subs, R_Subs	: String_Split.Slice_Set;
		Card_Seperator : constant String		:= ":" & Latin_1.HT;
		LR_Seperator	: constant String		:= "|" & Latin_1.HT;
		L_Int_Index		: Positive := 1;
		R_Int_Index		: Positive := 1;
		Cards_Index		: Positive := 1;
	begin
		-- TODO: Parsing Line to Cards array;
	   String_Split.Create(Subs, Card, ":", String_Split.Multiple);
		declare
			dummy : constant String := String_Split.Slice(Subs, 1);
		begin
			String_Split.Create(Subs, dummy, " ", String_Split.Multiple);
			Cards_Index := Integer'Value(String_Split.Slice(Subs, 2));
		end;
		String_Split.Create(Subs, Card, Card_Seperator, String_Split.Multiple);
		declare
			Sub			: constant String := String_Split.Slice (Subs, 2);
		begin
			String_Split.Create(Subs, Sub, LR_Seperator, String_Split.Multiple);
			declare
				Left		: constant String := String_Split.Slice (Subs, 1);
				Right		: constant String := String_Split.Slice (Subs, 2);
			begin
				String_Split.Create(L_Subs, Left, " ", String_Split.Multiple);
				for I in 1 .. String_Split.Slice_Count (L_Subs) loop
					declare
						cmb : constant String := String_Split.Slice (L_Subs, I);
						val : Integer;
					begin
						if cmb /= "" then
							val := Integer'Value(cmb);
							Cards(Cards_Index).Left_Numbers(L_Int_Index) := Card_Number(val); 
							L_Int_Index := L_Int_Index + 1;
						end if; -- Something like that?
					end;
				end loop;
				String_Split.Create(R_Subs, Right, " ", String_Split.Multiple);
				for I in 1 .. String_Split.Slice_Count (R_Subs) loop
					declare
						cmb : constant String := String_Split.Slice (R_Subs, I);
						val : Integer;
					begin
						if cmb /= "" then
							val := Integer'Value(cmb);
							Cards(Cards_Index).Right_Numbers(R_Int_Index) := Card_Number(val);
							R_Int_Index := R_Int_Index + 1;
						end if; -- Something like that?
					end;
				end loop;
			end;
		end;
	end Parse;

	procedure Solve_Part_One(Cards: Cards_Lines) is
		Score	: Integer := 0;
		CX		: Integer := 0;
	begin
		-- Iterate through Left and then Right
		-- Find and add Score
		-- final Score is 2 ** Score - 1
		for I in Cards'Range loop
			for J in Cards(I).Left_Numbers'Range loop
				for K in Cards(I).Right_Numbers'Range loop
					if Cards(I).Left_Numbers(J) = Cards(I).Right_Numbers(K) then
						Score := Score + 1;
					end if;
				end loop;
			end loop;
		end loop;
		Put_Line(CX'Image);
	end Solve_Part_One;

	procedure Solve_Part_Two(Cards: Cards_Lines) is 
	begin
		null;
	end Solve_Part_Two;

	procedure Solve(File_Path : String) is
		File : File_Type;
		Last : Integer;
		Cards	: Cards_Lines;
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
		
		Print_Cards(Cards);
		Solve_Part_One(Cards);
		Solve_Part_Two(Cards);

		Close(File);
	end Solve;

end Day_04_P_2;
