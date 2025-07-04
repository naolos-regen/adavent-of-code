with Ada.Text_IO;		use Ada.Text_IO;

package body Day_03 is

	subtype Index is Integer range 1 .. 140;
	type Array_Of_Chars is array (Index, Index) of Character;
	


	procedure Lookout(Arr: Array_Of_Chars) is 
	begin
		for I in Arr'Range (1) loop
			for J in Arr'Range (2) loop
				Put(Arr(J,I)'Image);
			end loop;
			New_Line;
		end loop;
	end Lookout;

	-- Lookout for adjacent to a symbol is every possibility of +1 0 -1 arranged in 2 options
	procedure Append(Arr: in out Array_Of_Chars; Line : String; I: Integer) is
		Idx : Index := Index(I);
	begin
		for J in Arr'Range (1) loop
			Arr(J, Idx) := Line(J);
		end loop;
	end Append;

	procedure Solve(File_Path: String) is
		File	: File_Type;
		Arr	: Array_Of_Chars;
		Index : Natural := 1;
	begin
		Open (File => File, Mode => In_File, Name => File_Path);
		while not End_Of_File (File) loop
			declare
				Engine	: constant String := Get_Line(File);
			begin
				Append(Arr, Engine, Index);
				Index := Index + 1;
			end;
		end loop;
		Lookout(Arr);

		Close (File);
	end Solve;
end Day_03;
