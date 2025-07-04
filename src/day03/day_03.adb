with Ada.Text_IO;		use Ada.Text_IO;

package body Day_03 is

	subtype Index is Integer range 1 .. 140;
	type Array_Of_Chars is array (Index, Index) of Character;
	Empty_Array : constant Array_Of_Chars := (others => (others => '.'));

	procedure Lookout(Arr: Array_Of_Chars; Sol: Array_Of_Chars) is 
	begin
		for I in Arr'Range (1) loop
			for J in Arr'Range (2) loop
				if Sol(J, I) = 'n' then
					if J + 1 in Index and I + 1 in Index then
						null;
					end if;
					if J - 1 in Index and I - 1 in Index then
						null;
					end if;
				end if;
			end loop;
		end loop;
	end Lookout;

	-- Lookout for adjacent to a symbol is every possibility of +1 0 -1 arranged in 2 options
	procedure Append(Arr, Sol: in out Array_Of_Chars; Line : String; I: Integer) is
		Idx : constant Index 	:= Index(I);
	begin
		for J in Arr'Range (1) loop
			Arr(J, Idx) := Line(J);
			if Line(J) in '0' .. '9' then
				Sol(J, Idx) := 'n';
			elsif Line(J) /= '.' then
				Sol(J, Idx) := 'a';
			end if;
		end loop;
	end Append;

	procedure Solve(File_Path: String) is
		File	: File_Type;
		Arr	: Array_Of_Chars := Empty_Array;
		Sol	: Array_Of_Chars := Empty_Array;
		Index : Natural := 1;
	begin
		Open (File => File, Mode => In_File, Name => File_Path);
		while not End_Of_File (File) loop
			declare
				Engine	: constant String := Get_Line(File);
			begin
				Append(Arr, Sol, Engine, Index);
				Index := Index + 1;
			end;
		end loop;
		Lookout(Arr, Sol);

		Close (File);
	end Solve;
end Day_03;
